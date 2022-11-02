package me.nathanfallet.makth.playground

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform