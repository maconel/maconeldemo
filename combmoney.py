moneyTypes = (1, 2, 5, 10)
dist = 200
resultCount = 0

def comb(existMoneyList):
    total = sum(existMoneyList)
    for i in moneyTypes:
        if len(existMoneyList) > 0 and existMoneyList[-1] > i:
            continue

        if total + i > dist:
            continue
        elif total + i == dist:
            newL = existMoneyList[:]
            newL.append(i)
            result(newL)
        else:
            newL = existMoneyList[:]
            newL.append(i)
            comb(newL)

def sum(l):
    v = 0
    for i in l:
        v += i
    return v

def result(l):
    global resultCount
    resultCount += 1
    print sum(l), '=', l

comb([])
print resultCount
