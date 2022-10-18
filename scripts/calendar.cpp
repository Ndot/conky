#include <iostream>
#include <time.h>
#include <string>

// These markers surround some strings to be parsed
// by conky. Normally this is used to set colors for conky.
std::string BEFORE_TODAY;
std::string AFTER_TODAY;

std::string BEGIN_DAYS_BEFORE_TODAY;
std::string END_DAYS_BEFORE_TODAY;

std::string BEGIN_DAYS_AFTER_TODAY;
std::string END_DAYS_AFTER_TODAY;

std::string BEGIN_WEEKDAY;
std::string END_WEEKDAY;

std::string BEGIN_WEEKEND;
std::string END_WEEKEND;

std::string mark = "%";

struct SurroundingText
{
    std::string before, after;
};

/**
 * Parse arguments.
 *
 * You can pass text to surround parts off the calender.
 * eg. For day 12 if you pass "-t hello % world" the output around
 * the day will be "...10 11 hello 12 world 13 14..." by default
 * the mark is %.
 *
 * Options:
 *
 * -t -> Today.
 * -b -> Days before today.
 * -a -> Days after today.
 * -w -> Week days.
 * -W -> Weekends.
 * -m -> Mark.
 * -v -> Makes the calender vertical.
 */
struct Options
{
    std::string t, b, a, w, W, m;
    bool        v = false;
};


SurroundingText getSurroundingText(std::string& str)
{
    auto            index = str.find(mark);
    SurroundingText surroundingText;

    // If we dont find the mark by default we do nothing.
    if (index == std::string::npos) return surroundingText;

    surroundingText.before = str.substr(0, index);
    surroundingText.after  = str.substr(index + (mark.size()));

    return surroundingText;
}




int main(int argc, const char* argv[])
{
    time_t now = time(nullptr);
    tm*    tm  = localtime(&now);

    int  today            = tm->tm_mday;
    int  month            = tm->tm_mon + 1;
    int  year             = tm->tm_year + 1900;
    int  weekDay          = tm->tm_wday;
    bool isLeapYear       = false;
    int  totalDaysInMonth = 31;

    // Parse options.
    Options options;

    for (int i = 0; i < argc; i++)
    {
        if (argv[i][0] == '-')
        {
            switch (argv[i][1])
            {
                case 't': options.t = argv[i + 1]; break;
                case 'b': options.b = argv[i + 1]; break;
                case 'a': options.a = argv[i + 1]; break;
                case 'w': options.w = argv[i + 1]; break;
                case 'W': options.W = argv[i + 1]; break;
                case 'm': options.m = argv[i + 1]; break;
                case 'v': options.v = true; break;
                default: break;
            }
        }
    }

    mark = options.m == "" ? mark : options.m;

    BEFORE_TODAY = getSurroundingText(options.t).before;
    AFTER_TODAY  = getSurroundingText(options.t).after;

    BEGIN_DAYS_BEFORE_TODAY = getSurroundingText(options.b).before;
    END_DAYS_BEFORE_TODAY   = getSurroundingText(options.b).after;

    BEGIN_DAYS_AFTER_TODAY = getSurroundingText(options.a).before;
    END_DAYS_AFTER_TODAY   = getSurroundingText(options.a).after;

    BEGIN_WEEKDAY = getSurroundingText(options.w).before;
    END_WEEKDAY   = getSurroundingText(options.w).before;

    BEGIN_WEEKEND = getSurroundingText(options.W).before;
    END_WEEKEND   = getSurroundingText(options.W).after;

    /**
     * Leap years and why we need them - BBC News
     * https://www.youtube.com/watch?v=gvuz0BVy5TM
     *
     */
    if (year % 400 == 0)
        isLeapYear = true;
    else if (year % 4 == 0 && year % 100 != 0)
        isLeapYear = true;

    // Adjust the total days in a month.
    if (month == 2)
        totalDaysInMonth = isLeapYear ? 29 : 28;
    else if (month == 11 || month == 4 || month == 6 || month == 9)
        totalDaysInMonth = 30;


    ////////////////////////////////////////
    // Section: Week names output string. //
    ////////////////////////////////////////

    std::string weekDaysOutput[31];
    const char* weedDays[] = { "MO", "TU", "WE", "TH", "FR", "SA", "SU" };

    /**
     * Find the week day of the first day of the month.
     *
     *
     * (7 - (today % 7):
     * (today % 7) return how many days from the last block of 7. Since we want
     * the days to next block instead of the previous we subtract 7.
     *
     * weekDay + 1:
     * Now that we know how many days to the next block of 7 we know how many days
     * we need to add to the week day, but remember this will return the week day
     * at day zero but we want day 1 so we add 1.
     *
     * % 7:
     * Because the final result may yield a number bigger than 7 we need to apply
     * the modulo of 7 to final result.
     *
     * */
    int firstWeekDay = ((7 - (today % 7)) + weekDay + 1) % 7;


    for (int i = 0; i < totalDaysInMonth; i++)
    {
        int indice = (i + firstWeekDay - 1) % 7;

        if (indice > 4)
        {
            weekDaysOutput[i] = BEGIN_WEEKEND + weedDays[indice] + END_WEEKEND;
        }
        else
        {
            weekDaysOutput[i] = BEGIN_WEEKDAY + weedDays[indice] + END_WEEKDAY;
        }
    }



    //////////////////////////////////
    // Section: Days output string. //
    //////////////////////////////////

    std::string daysOutput[31];

    // clang-format off
    const char* days[] = { 
      "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", 
      "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", 
      "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" };
    // clang-format on

    // Days before today.
    // daysOutput[0] = BEGIN_DAYS_BEFORE_TODAY;

    for (int i = 0; i < today - 1; i++)
    {
        daysOutput[i].append(BEGIN_DAYS_BEFORE_TODAY + days[i] + END_DAYS_BEFORE_TODAY);
    }

    // Today.
    daysOutput[today - 1] = BEFORE_TODAY + days[today - 1] + AFTER_TODAY;

    // Days after today.
    for (int i = today; i < totalDaysInMonth; i++)
    {
        daysOutput[i] = BEGIN_DAYS_AFTER_TODAY + days[i] + END_DAYS_AFTER_TODAY;
    }

    // daysOutput[totalDaysInMonth - 1].append();



    //////////////////////////////////
    // Section: Print final output. //
    //////////////////////////////////
    if (options.v)
    {
        for (int i = 0; i < totalDaysInMonth; i++)
        {
            std::cout << weekDaysOutput[i] << " ";
            std::cout << daysOutput[i] << " ";
            std::cout << "\n";
        }
    }
    else
    {
        for (int i = 0; i < totalDaysInMonth; i++)
        {
            std::cout << weekDaysOutput[i] << " ";
        }

        std::cout << "\n";
        for (int i = 0; i < totalDaysInMonth; i++)
        {
            std::cout << daysOutput[i] << " ";
        }
    }

    return 0;
}