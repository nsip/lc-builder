package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

	cu "github.com/nsip/curriculum-align"
	re "github.com/nsip/resource-align"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {

	cu.Init()
	re.Init("1323")

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/align", re.Align)
	e.GET("/curricalign", cu.Align)
	// duplicates for proxying with vue.js
	e.GET("/alignservice/align", re.Align)
	e.GET("/alignservice/curricalign", cu.Align)

	// Routes
	e.GET("/resourceSearch", search)
	e.GET("/alignservice/resourceSearch", search)

	e.Static("/", "public")

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}

// Handler
func search(c echo.Context) error {

	const endpoint = "https://api.cognitive.microsoft.com/bing/v7.0/search"
	token := "72754c1352f04b4f96f9a1b46d854257"
	searchTerm := c.QueryParam("searchTerms")

	req, err := http.NewRequest("GET", endpoint, nil)
	if err != nil {
		log.Println(err)
	}

	param := req.URL.Query()
	param.Add("q", searchTerm)
	req.URL.RawQuery = param.Encode()

	req.Header.Add("Ocp-Apim-Subscription-Key", token)

	client := new(http.Client)
	resp, err := client.Do(req)
	if err != nil {
		return err
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	ans := new(BingAnswer)
	err = json.Unmarshal(body, &ans)
	if err != nil {
		return err
	}

	return c.JSON(http.StatusOK, ans)
}
