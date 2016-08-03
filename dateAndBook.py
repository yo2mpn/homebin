#!/usr/bin/env python3

import argparse, logging, re
from dateAndY import (date_and_y, match_date_and_y, gen_list, 
        str_to_float_list, gen_date_y_graph)

logging.basicConfig(level=logging.DEBUG, 
                format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)
logging.debug('Start of program')

msg = '''
(O< .: Collect books I have read and the dates I finished reading them from my
(/)_   daily logfile and write to a new logfile.
'''

dailyLog = "/home/dwa/share/log/daily.log"
bookLog = "/home/dwa/share/log/dateAndBook.log"
date_regex = "^20[0-9][0-9]-\d\d-\d\d"
book_regex = "^[A-Z]"

parser = argparse.ArgumentParser(description=msg, 
        formatter_class=argparse.RawTextHelpFormatter)
args = parser.parse_args()

def book_cleanup(logfile):
    '''Remove tags'''
    with open(logfile, 'r') as f:
        searchLines = f.readlines()
    with open(logfile, 'w') as f:
        book = re.compile(r'^(#book\s#read\s)([A-Z])')
        for line in searchLines:
            # Remove tags
            if book.search(line) != None:
                mo = book.search(line)
                line = re.sub(r'^#book\s#read\s', str(mo.group(2)[2:]), line)
                f.write(line)
            else:
                f.write(line)

if __name__ == '__main__':
    # Search for dates and books and output to bookLog
    date_and_y(dailyLog, bookLog, date_regex, '^#book.*')
    book_cleanup(bookLog)
    # Match date with corresponding book or remove dates with no matches
    match_date_and_y(bookLog, date_regex, book_regex)
    logging.debug('End of program')