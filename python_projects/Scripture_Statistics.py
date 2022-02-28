'''
Purpose of this is to prompt the user for a word or phrase then give back statistics on that word or phrase. 
Statistics such as: 
- number of times used (in a table) x 
- number of times used in each book of the standard works (bar graph)
- return a data frame with the verses that it is used 
- verse with the highest number of times word is used

Ideas: 
- let user choose how many words of something they want. Ex. if they want to put in 'Judge' and 'Judges'. 
    - it will prompt them for the number of words or phrases they want then do a while loop until it gets the proper number of response
- ask the user if they want to compare two words to see how many times it was used over another. 
    - would need a toggle if yes then call a function. 

Status: 
- get past dataframe error
- need to work on phrases
- test and make sure that comparison option works in every instance
- show visual for each chapter (like a facet_wrap)
'''

import pandas as pd 
import pyreadr # to read rds files 
import re # regular expression module 
import matplotlib.pyplot as pyplot


def main(): 

    scrip_text = pd.read_csv("gospel.csv")
    print(scrip_text)

    #########
    # scrip_text = pyreadr.read_r("gospel.rds")
    # data = pd.DataFrame(scrip_text, columns=scrip_text[0])
    #########
    print()
    print("This program allows you to see word counts in scripture, gives you the option to compare words or phrase.\n", 
    "Then will give you back a file with the verse and display graphs.")
    print()
    try: 
    # call the functions    
        option = comparison() 
        if option == 'yes': # if yes then call these functions plus comparison else call only certain functions. 
            number = match_number()
            match_list = get_word(number)
            # comparison functions
            comparison_number = comparison_match_number()
            comparison_match_list = comparison_get_word(comparison_number)

            match_object, comparison_object = create_object(match_list, comparison_match_list)
            data, comparison_data = get_count(scrip_text, match_object, comparison_object)
            data_test(data, comparison = comparison_data)
            # create_graphs(data, comparison = comparison_data)

        else: 
            number = match_number()
            match_list = get_word(number)
            match_object = create_object(match_list)
            test = get_count(scrip_text, match_object)
            data_test(test, comparison = False)
            # create_graphs(data, comparison = False)

    except RuntimeError as run_err: 
        print(run_err)


def comparison():
    valid = False  
    while valid == False: 
        try: 
            option = input('Would you like to compare words or phrases, "yes" or "no"? ')
            option = option.lower()
            if option == 'yes' or option == 'no': 
                valid = True 
            else: 
                valid = False 
                print(f'{option} is invalid. Enter "yes" or "no" ')
        except ValueError as val_err: 
            print(val_err)
            print(f'{option} is invalid. Enter "yes" or "no."')
        # not sure what to put here exactly. 

    return option

def match_number():
    '''
    ask user to for how many words they want to input.  
    '''
    valid = False 
    while valid == False: 
        try:
            match_number = int(input("How many words do you want to input (ex. 1)? "))
            valid = True 
        except ValueError as val_err: 
            # not sure what to put in there. A time error or value error
            print(val_err)
            print("Enter only a number such as '1' or '2'.")

    return match_number

def comparison_match_number():
    '''
    ask user to for how many words they want to input to compare. 
    '''
    valid = False 
    while valid == False: 
        try: 
            comparison_match_number = int(input("How many words or phrase, for comparison, do you want to input  (ex. 1)? "))
            valid = True 
        except ValueError as val_err: 
            # not sure what to put in there. A time error or value error
            print(val_err)
            print("Enter only a number such as '1' or '2'.")

    return comparison_match_number

def get_word(word_count): 
    ''' 
    prompt the user for word or phrase depending on how many times they specified.
    Takes the input and inserts into a blank list.
    '''
    # need to make sure who is a character 
    # will this work having the try statement on the outside on a nested while loop in a for loop. 
    match_list = []
    valid = False
    duration = 0 
    for duration in range(word_count):
        try: 
            while valid == False:
                word = input("What word or phrase would you like to get statistics on? ")
                user_input = str(word)
                match_list.append(user_input)
                duration += 1 
                if duration == word_count: 
                    valid = True
            # if duration == word_count: 
        except ValueError as val_err: 
            print()
            print(val_err)
            print(f"{word} is invalid. It must contain only words.")
    print(match_list)
    return match_list

def comparison_get_word(word_count): 
    ''' 
    prompt the user for word or phrase depending on how many times they specified.
    Takes the input and inserts into a blank list.
    '''
    # need to make sure who is a character 
    # will this work having the try statement on the outside on a nested while loop in a for loop. 
    comparison_match_list = []
    valid = False
    duration = 0 
    for duration in range(word_count):
        while valid == False:
            try: # not sure if I even need a try statement 
                word = input("What word or phrase, for comparison, would you like to get statistics on? ")
                # parse text for a number or other character
                comparison_match_list.append(word)
                duration += 1 
                if duration == word_count: 
                    valid = True 
            except ValueError as val_err: 
                print()
                print(val_err)
                print(f"{word} is invalid. It must contain only words.")
    print(comparison_match_list)

    return comparison_match_list

def create_object(word, comparison_word = None): 
    ''' 
    takes word or phrase from get_word and creates an object that will be used to parse the text
    Uses regex to clean up text: 
        periods
        numbers 
        parenthesis 
    '''
    # Need to get the word capitalized and non-capitazlized. 

    new_list = []
    for i in word: 
        i = i.strip() # trimming the white space before and after
        i = re.sub('\.', '', i) # replaces '.' with an empty string
        i = re.sub('[0-9]+', '', i) # replaces digits with an empty string.  
        i = re.sub('[(+*)]', '', i) # replaces + * ()
        # new_list.append(i)
        match = i 
        if len(word) > 1: # join words to one string sperated by | If length is greater than 1
            new_list.append(i)
            match = "|".join(new_list)
            print(match)
       

    # doing the work on the comparison word
    if comparison_word != None: 
        comparison_new_list = []
        for c in comparison_word: 
            c.strip() # trimming the white space before and after
            c = re.sub('\.', '', c)
            c = re.sub('[0-9]+', '', c) # replaces digits with an empty string.  
            c = re.sub('[(+*)]', '', c) # replaces + * ()
            comparison = c 
            if len(comparison_word) > 1: # joins words and seperates by | statement
                comparison_new_list.append(c)
                comparison = "|".join(comparison_new_list)
        # print(comparison)
        # print("|".join(comparison))

    if comparison_word != None: 
        return match, comparison 
    else: 
        return match
    

def get_count(data, string, comparison_string = None):
    '''
    parse the text
    parameter - word or phrase from get_word 
    Adds onto the dataframe columns for counts of word or phrase in verse
    Creates a table 
    '''
    if comparison_string == None: 
        data['match count'] = data['scripture_text'].str.count(string, re.I) 
        word_count = data['match count'].sum()
        # print(data['match count'].sum())

        # creating table 
        table = {'Word(s)':[string],
                'Count':word_count
        }
        df = pd.DataFrame(table, columns=['Word(s)', 'Count'], index =['Word:'] )
        print(df)
    else: 
        # for the string 
        data['match count'] = data['scripture_text'].str.count(string, re.I) 
        word_count = data['match count'].sum()
        # for the match_string
        data['comparison count'] = data['scripture_text'].str.count(comparison_string, re.I)
        comp_word_count = data['comparison count'].sum()

        comparison_data = data

        # creating table 

        table = {'Word(s)':[string, comparison_string], 
                'Count':[word_count, comp_word_count] 
                }
        df = pd.DataFrame(table, columns=['Word(s)', 'Count'], index=['Word:', 'Comparison:'])
        print(df)

    if comparison_string != None: 
        return df, comparison_data
    else: 
        return df 

def data_test(data, comparison = False): 
    ''' 
    Filter to only the needed columns and create a csv file with those verses. 

    Return a data frame with the verses that reference this word. 
    ''' 
    
    if comparison == False: 
        data = data[['volume_title', 'book_title', 'scripture_text', 'chapter_number', 'verse_number', 'match_count', 'volume_lds_url']]
    else: 
        data = data[['volume_title', 'book_title', 'scripture_text', 'chapter_number', 'verse_number', 'match_count', 'comparison count', 'volume_lds_url']]
    # add column with count of word or phrase 
    # filter down to only those verse with the word or phrase for the users benefit
        # need to create a csv file. 
    print(data)

    return data

def create_graphs(data, comparison = False):
    '''
    number of times used in each book of the standard works (bar graph)
    '''
    # get bar graph for the count 
    if comparison == False: 
        group_data = data.group_by('volume_title').aggregate(volume_count = ('match_count', 'sum'))

        # creating graph 

        group_data.plot(kind='bar', y='volume_count', title = 'Word Count by Volume')

        pyplot.show()
        pyplot.tight_layout()
    else: 
        group_data = data.group_by('volume_title').aggregate(volume_count = ('match_count', 'sum'))
        comp_group_data = comparison.group_by('volume_title').aggregate(volume_count = ('comparison count', 'sum'))

        # creating graphs
        group_data.plot(kind='bar', y='volume_count', title = 'Word Count by Volume')
        comp_group_data.plot(kind='bar', y='volume_count', title = 'Word Count by Volume')

        pyplot.show()
        pyplot.tight_layout()

    pass 

def highest_verse_count(data):
    '''
    verse with the highest number of times word is used.
    '''
    pass

if __name__ == "__main__": 
    main()