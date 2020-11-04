NAV = require("Navigation")


local loc = {
    x = 5,
    y = 5,
    z = 0,
}
NAV.goTo(loc)

loc = {
    z = -1,
    x = 5,
    y = 5
}

NAV.goTo(loc)

loc = {
    z = 0,
    x = -5,
    y = -5
}
NAV.goTo(loc)

loc = {
    z = 0,
    x = 0,
    y = 0
}
NAV.goTo(loc)
