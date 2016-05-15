# Kiosk
An example of how to switch between apps on the AppleTV

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](./LICENSE.txt)

You can create Kiosk style applications on the AppleTV that will periodically switch between them. This example shows you
how to do that.

## Installation

Just copy the Kiosk.swift file into your project. Optionally, also copy the KioskSettings.bundle and rename to Settings.bundle unless you already have a Settings.bundle
in your application. In the latter case, just merge in the contents of the root.plist into your settings bundle's plist.

## Overview

Switching between apps on the AppleTV is possible and there is a very simple mechanism. Using the `UIApplication.openURL` method, an app can launch another app. In order to support this fully, each app must know about the app that it should launch, and also it should provide a URL scheme for itself so it can be launched. This Kiosk.swift file also provides a timer to perform this automatically. The `KioskExample` folder contains two different apps that will launch each other and serves as a simple example.

When an app first launches another, the user is prompted to allow/disallow this launch. So when testing, you have to manually accept this prompt once for each launch, but the subsequent launches will happen without any user interaction.

## Settings

The included settings bundle contains the basic settings for making this work. You can also just hardcode these details into your apps.

## Info.plist

Pay particular attention to the Info.plist settings in each of the example apps. They both declare their own scheme so they can be launched, and optionally provide a list of schemes they will launch themselves. Note that for AppStore apps, the latter is required.
