import os
import random
import time
from datetime import datetime, timezone, timedelta


CMD = '''git filter-branch -f --env-filter \\
    \'if [ $GIT_COMMIT = {hash} ]
    then{export}
    fi\''''

DATE = '''export GIT_AUTHOR_DATE="{date}"
        export GIT_COMMITTER_DATE="{date}"'''

NAME = '''export GIT_AUTHOR_NAME="{name}"
        export GIT_COMMITTER_NAME="{name}"'''

EMAIL = '''export GIT_AUTHOR_EMAIL="{email}"
        export GIT_COMMITTER_EMAIL="{email}"'''


def strTimeProp(start, end, prop, frmt):
    stime = time.mktime(time.strptime(start, frmt))
    etime = time.mktime(time.strptime(end, frmt))
    ptime = stime + prop * (etime - stime)
    return int(ptime)


def formatDateList(mylist, frmtA='%Y-%m-%d %H:%M:%S', frmtB="%a %b %d %H:%M %Y %z"):
    return [datetime.strptime(x, '%Y-%m-%d %H:%M:%S').astimezone(timezone(timedelta(hours=+8))).strftime("%a %b %d %H:%M %Y %z") for x in mylist]


def randomDateList(start, end, n, frmt='%Y-%m-%d %H:%M:%S'):
    return [time.strftime(frmt, time.localtime(strTimeProp(start, end, random.random(), frmt))) for _ in range(n)]


def getRandomDateList(start, end, lenth):
    mylist = randomDateList(start, end, lenth)
    mylist = sorted(mylist, reverse=True)
    return formatDateList(mylist)


def main(default, git_hash, is_execute):
    if git_hash == []:
        os.system(
            'git log --pretty=format:"%H" > gitlogEc971d5b54aa973826103e303a96a3c19d0d914c')
        git_hash = open('gitlogEc971d5b54aa973826103e303a96a3c19d0d914c', 'r')\
            .read()\
            .split('\n')

    dates = getRandomDateList(default['start'], default['end'], len(git_hash)) if 'start' in default and 'end' in default else []

    for i, h in enumerate(git_hash):
        export = '\n\t{DATE}\n\t{NAME}\n\t{EMAIL}'.format(
                DATE=('' if dates == [] else DATE.format(date=dates[i])),
                NAME=(NAME.format(name=default['name']) if 'name' in default else ''),
                EMAIL=(EMAIL.format(email=default['email']) if 'email' in default else ''),
        )

        if export != '':
            if is_execute:
                os.system(CMD.format(
                    hash=h,
                    export=export,
                ))
            else:
                print(CMD.format(
                    hash=h,
                    export=export,
                ))
    os.system('rm gitlogEc971d5b54aa973826103e303a96a3c19d0d914c')


if __name__ == '__main__':
    default = {
        # 'name': '',
        # 'email': '',
        # 'start': '2010-02-02 00:00:00',
        # 'end': '2019-05-15 00:00:00',
    }

    git_hash = []

    main(default, git_hash, is_execute=False)
