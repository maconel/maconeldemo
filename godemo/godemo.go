package main
import "fmt"

func main() {
	result := 0
	for i:=1; i<10; i++ {
		if i%2 == 0 {
			result -= fact(i)
		} else {
			result += fact(i)
		}
		fmt.Printf("%d!=%d, r=%d\n", i, fact(i), result)
	}
}

func fact(n int) int {
	result := 1
	for i:=1; i<=n; i++ {
		result *= i
	}
	return result
}
