package main

import (
	"strconv"

	"github.com/gin-gonic/gin"
)

var PORT = 8080

func main() {
	router := gin.Default()

	router.GET("/music", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"music": "Half a person",
		})
	})

	router.Run(":" + strconv.Itoa(PORT))
}
