package main

import (
	"net/http"

	cu "github.com/nsip/curriculum-align"
	re "github.com/nsip/resource-align"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {

	cu.Init()
	re.Init()

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/align", re.Align)
	e.GET("/curricalign", cu.Align)

	// Routes
	e.GET("/hello", hello)

	e.Static("/", "public")

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}

// Handler
func hello(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, World!")
}
