# Yummyer API

URL: https://yummuer-api.herokuapp.com/

### Endpoints

#### /v1/places

Allows searching for places near provided location
Query parameters:

`search[query]` - search term
`search[location]` - your location (zip code, address)

`search[latitude]` & `search[longitude]` - alternative way of setting location


Example request:

https://yummuer-api.herokuapp.com//v1/places?search[query]=jalapenos&search[location]=NYC

Example response:

```
{
  "data": [
    {
      "id": "_sTaigaHcK8Pb1e-IcgGzw",
      "type": "found_place",
      "attributes": {
        "name": "Jalapeños",
        "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg",
        "location": "5714 5th Ave, Sunset Park, NY 11220",
        "rating": 4
      }
    },
    {
      "id": "8ptywurhx5lYbXB0TmjMFQ",
      "type": "found_place",
      "attributes": {
        "name": "Jalapeno King",
        "image_url": "https://s3-media3.fl.yelpcdn.com/bphoto/XirAwxDU0HGXY1am0198vA/o.jpg",
        "location": "719 5th Ave, Brooklyn, NY 11215",
        "rating": 4
      }
    },
    ...
  ],
  "meta": {
    "total": 9400
  },
  "links": {
    "self": "http://localhost:3000/v1/places?limit=20&location=NYC&offset=0&query=jalapenos",
    "next": "http://localhost:3000/v1/places?limit=20&location=NYC&offset=20&query=jalapenos"
  }
}

```
