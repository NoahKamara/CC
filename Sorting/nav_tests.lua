NAV = require("Navigation")


local loc = {
    x = 0,
    y = 0,
    z = 0,
}
NAV.goTo(loc)

loc = {
    z = -1,
    x = 2,
    y = 2
}

NAV.goTo(loc)

loc = {
    z = 0,
    x = 2,
    y = 2
}
NAV.goTo(loc)

loc = {
    z = 0,
    x = 0,
    y = 0
}
NAV.goTo(loc)
