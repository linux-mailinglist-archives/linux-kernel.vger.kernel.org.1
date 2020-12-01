Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335962C9815
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLAHZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:25:45 -0500
Received: from mout01.posteo.de ([185.67.36.65]:58290 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbgLAHZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:25:45 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 522D516005C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:24:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606807485; bh=Jkl12RaWrQui0S68+6dFQ33RAEFiBwpNnZFv7Gk9lFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=UFq2oGUkT0L2F7beK0XEcNLO9i6PfRP2O7jV9S1XIAAMhcWutHwxpfoPuiGwKWd51
         YCET1EZm8phIQLTuDc5GrWRVrukXlNPSX1iRfXY5NJiFCKd87sr3Z4iE36YeJtKxUv
         cVI932BBIeUG6sWDO9NaShSXIsXuRTz+SHKr4qxTdVtdHPsdIIjjbDCNPReHHwz/lQ
         nfGjiw465ZOq6cSopc89D780+Q3kvWSievKhyatOhnI1RkKFqi4OAYlbDGoFak7rUf
         XSiWPuZ6WL22WJScY1rrnHV+jhQcmQlrEZgW1O8Zwf/udJB/sLntZycxi5JM68LMXM
         Hlk7wauH5f3Wg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClYWw00zlz6tmD;
        Tue,  1 Dec 2020 08:24:43 +0100 (CET)
Date:   Tue, 1 Dec 2020 08:24:38 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Backlund Thomas <tmb@iki.fi>
Cc:     Jonas Malaco <jonas@protocubo.io>, <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
Message-ID: <20201201082438.515bb23f@monster.powergraphx.local>
In-Reply-To: <6185cc04-da71-5b68-0bc8-931af6fa2dc9@iki.fi>
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
        <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
        <20201128113524.24f4f56f@monster.powergraphx.local>
        <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
        <s7R3iA2S9eDO5XZ9rdqzYCvN9eu2DaNKUQCmSn_4XxsrxD-93-gtY9DFGxbthP9CVsquOXoocwbZfwNKo7XLaQ==@protonmail.internalid>
        <20201130154915.760923fd@monster.powergraphx.local>
        <6185cc04-da71-5b68-0bc8-931af6fa2dc9@iki.fi>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 18:25:30 +0200
Backlund Thomas <tmb@iki.fi> wrote:

> Den 30.11.2020 kl. 16:49, skrev Wilken Gottwalt:
> > On Mon, 30 Nov 2020 14:43:44 +0200
> > Thomas Backlund <tmb@iki.fi> wrote:
> >
> >> Den 28.11.2020 kl. 12:35, skrev Wilken Gottwalt:
> >>> On Sat, 28 Nov 2020 02:37:38 -0300
> >>> Jonas Malaco <jonas@protocubo.io> wrote:
> >>>
> >>>> On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
> >>>> <wilken.gottwalt@posteo.net> wrote:
> >>>>> Adds support for another Corsair PSUs series: AX760i, AX860i, AX120=
0i,
> >>>>> AX1500i and AX1600i. The first 3 power supplies are supported throu=
gh
> >>>>> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> >>>>> converter especially made for the COM ports of these power supplies.
> >>>>> There are 3 known revisions of these adapters. The AX1500i power su=
pply
> >>>>> has revision 3 built into the case and AX1600i is the only one in t=
hat
> >>>>> series, which has an unique usb hid id like the RM/RX series.
> >>>> Can I ask what AXi power supplies were tested?
> >>>>
> >>>> I ask because, based on the user-space implementations I am aware of,
> >>>> the AXi dongle protocol appears to be different from the RMi/HXi ser=
ies.
> >>> I was not able to test this against the AX power supplies, they are r=
eally
> >>> hard to find (and are far to expensive). But I went through all these=
 tools
> >>> and stuck to the most common commands, which all 3 series support. No=
t every
> >>> series supports all commands (there also seem to be different firmwar=
es in
> >>> the micro-conrollers). But this is fine, some sensors will show up as=
 N/A.
> >>> Even my HX850i does not support all commands covered in this driver.
> >>>
> >> What kind of tests do you want / need ?
> >>
> >> I have an AX860i here.
> > Oh nice. Lets start with an usb info dump. Can you give me the full dum=
p of
> > lsusb -vd <device> of the Corsair USB dongle?
>=20
> $ lsusb=C2=A0 -vd=C2=A0 1b1c:1c00
>=20
> Bus 011 Device 005: ID 1b1c:1c00 Corsair Controller for Corsair Link
> Device Descriptor:
>  =C2=A0 bLength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18
>  =C2=A0 bDescriptorType=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>  =C2=A0 bcdUSB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.10
>  =C2=A0 bDeviceClass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0
>  =C2=A0 bDeviceSubClass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A0 bDeviceProtocol=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A0 bMaxPacketSize0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64
>  =C2=A0 idVendor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1b1c Corsair
>  =C2=A0 idProduct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1c00 Controller for Corsair Link
>  =C2=A0 bcdDevice=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.00
>  =C2=A0 iManufacturer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1 Silicon Labs
>  =C2=A0 iProduct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 Corsair Link TM USB Dongle
>  =C2=A0 iSerial=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 R7480347
>  =C2=A0 bNumConfigurations=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>  =C2=A0 Configuration Descriptor:
>  =C2=A0=C2=A0=C2=A0 bLength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9
>  =C2=A0=C2=A0=C2=A0 bDescriptorType=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2
>  =C2=A0=C2=A0=C2=A0 wTotalLength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00=
20
>  =C2=A0=C2=A0=C2=A0 bNumInterfaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1
>  =C2=A0=C2=A0=C2=A0 bConfigurationValue=C2=A0=C2=A0=C2=A0=C2=A0 1
>  =C2=A0=C2=A0=C2=A0 iConfiguration=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0 bmAttributes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x80
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Bus Powered)
>  =C2=A0=C2=A0=C2=A0 MaxPower=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100mA
>  =C2=A0=C2=A0=C2=A0 Interface Descriptor:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bLength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bDescriptorType=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterfaceNumber=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bAlternateSetting=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bNumEndpoints=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterfaceClass=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 255 Vendor Specific Class
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterfaceSubClass=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterfaceProtocol=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iInterface=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 Corsair Link TM USB Dong=
le
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Endpoint Descriptor:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bLength=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bDescriptorType=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bEndpointAddress=C2=A0=C2=A0=
=C2=A0=C2=A0 0x81=C2=A0 EP 1 IN
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmAttributes=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer Type=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bulk
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Synch Type=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 None
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Usage Type=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Data
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wMaxPacketSize=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0040=C2=A0 1x 64 bytes
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterval=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Endpoint Descriptor:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bLength=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bDescriptorType=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bEndpointAddress=C2=A0=C2=A0=
=C2=A0=C2=A0 0x01=C2=A0 EP 1 OUT
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmAttributes=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer Type=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bulk
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Synch Type=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 None
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Usage Type=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Data
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wMaxPacketSize=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0040=C2=A0 1x 64 bytes
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bInterval=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:=C2=A0=C2=A0=C2=A0=C2=A0 0x0000
>  =C2=A0 (Bus Powered)

Thank you. Hmm yeah, this dongle has no usb hid part. So this driver will n=
ot
work with this dongle for sure. I already have an idea how to support all 3
series, though it involves a lot of testing. I would provide a github repo
with tools and test kernel modules if you are interested. But I don't know
yet how long it will take, I work on other stuff which has a higher prio.

greetings,
Wilken

> --
>=20
> Thomas
>=20
>=20

