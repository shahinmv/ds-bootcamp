from mrjob.job import MRJob
import csv

class MRMaxMinVote(MRJob):
    def mapper(self, _, line):
        data = csv.reader([line])

        for row in data:
            yield row[0], int(row[2])

    def reducer(self, key, values):
        min_vote = next(values)
        max_vote = min_vote
        for item in values:
            min_vote = min(item, min_vote)
            max_vote = max(item, max_vote)
        yield key, (min_vote, max_vote)
    
if __name__ == '__main__':
    MRMaxMinVote.run()