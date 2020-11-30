Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184F2C89C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgK3Ql4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:41:56 -0500
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:58114 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgK3Qlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:41:55 -0500
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 11:41:54 EST
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Thomas Backlund <tmb@iki.fi>
CC:     Jonas Malaco <jonas@protocubo.io>, <linux-kernel@vger.kernel.org>,
        "Jean Delvare" <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
 <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
 <20201128113524.24f4f56f@monster.powergraphx.local>
 <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
 <s7R3iA2S9eDO5XZ9rdqzYCvN9eu2DaNKUQCmSn_4XxsrxD-93-gtY9DFGxbthP9CVsquOXoocwbZfwNKo7XLaQ==@protonmail.internalid>
 <20201130154915.760923fd@monster.powergraphx.local>
From:   Backlund Thomas <tmb@iki.fi>
Message-ID: <6185cc04-da71-5b68-0bc8-931af6fa2dc9@iki.fi>
Date:   Mon, 30 Nov 2020 18:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <20201130154915.760923fd@monster.powergraphx.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 30.11.2020 kl. 16:49, skrev Wilken Gottwalt:
> On Mon, 30 Nov 2020 14:43:44 +0200
> Thomas Backlund <tmb@iki.fi> wrote:
>
>> Den 28.11.2020 kl. 12:35, skrev Wilken Gottwalt:
>>> On Sat, 28 Nov 2020 02:37:38 -0300
>>> Jonas Malaco <jonas@protocubo.io> wrote:
>>>
>>>> On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
>>>> <wilken.gottwalt@posteo.net> wrote:
>>>>> Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
>>>>> AX1500i and AX1600i. The first 3 power supplies are supported through
>>>>> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
>>>>> converter especially made for the COM ports of these power supplies.
>>>>> There are 3 known revisions of these adapters. The AX1500i power supply
>>>>> has revision 3 built into the case and AX1600i is the only one in that
>>>>> series, which has an unique usb hid id like the RM/RX series.
>>>> Can I ask what AXi power supplies were tested?
>>>>
>>>> I ask because, based on the user-space implementations I am aware of,
>>>> the AXi dongle protocol appears to be different from the RMi/HXi series.
>>> I was not able to test this against the AX power supplies, they are really
>>> hard to find (and are far to expensive). But I went through all these tools
>>> and stuck to the most common commands, which all 3 series support. Not every
>>> series supports all commands (there also seem to be different firmwares in
>>> the micro-conrollers). But this is fine, some sensors will show up as N/A.
>>> Even my HX850i does not support all commands covered in this driver.
>>>
>> What kind of tests do you want / need ?
>>
>> I have an AX860i here.
> Oh nice. Lets start with an usb info dump. Can you give me the full dump of
> lsusb -vd <device> of the Corsair USB dongle?

$ lsusb  -vd  1b1c:1c00

Bus 011 Device 005: ID 1b1c:1c00 Corsair Controller for Corsair Link
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x1b1c Corsair
   idProduct          0x1c00 Controller for Corsair Link
   bcdDevice            1.00
   iManufacturer           1 Silicon Labs
   iProduct                2 Corsair Link TM USB Dongle
   iSerial                 3 R7480347
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength       0x0020
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              2 Corsair Link TM USB Dongle
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
   (Bus Powered)

--

Thomas


