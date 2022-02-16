import matplotlib.pyplot as plt

for i in range(500000000):
    x = i
    arr = []
    while x != 1 and x != 0:

        if x % 2 == 0:
            x /= 2
        else:
            x *= 3
            x += 1

        if x < i and i % 100000 == 0:
            print(i)
            break


plt.show()
