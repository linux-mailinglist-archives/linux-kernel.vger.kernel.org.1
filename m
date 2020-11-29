Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0972C7941
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgK2NBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:01:35 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:37080 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgK2NBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:01:33 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 49E221E0752
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 06:00:51 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jMJukbfK6DlydjMJukPh8h; Sun, 29 Nov 2020 06:00:51 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=CakmGojl c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=uChsZFC9AAAA:8
 a=qhdNSoG_AAAA:20 a=GrnRVDYTAAAA:20 a=JqzNDTabAAAA:20 a=g0Ye9DNAAAAA:20
 a=xU5ysBwKYxMgY_8FHgoA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=ULtXvzFHYWHLyBAuiDia:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dOl0f0KY2eXQ8huON5Y4Es28wpAnNvF1rGO5voPURCE=; b=JFRTomqPdgjfj5iHIYayFEkx/W
        RNrQFORpE3J7qMumFZiGcKBgAIZw3XhnQLYIjYHumZFT+nd4ZoxK8n/ub9FIMpDQ8zZL7dzQ4p7sT
        G9uLkC4Qc5X6lj/Zoz4K18N6PLCuStu6SXnUUy4ZWRB2zaljUHfuJltpVk7C8sX8qJLwBaFnsEDAf
        mrmDpHTls96+txO6F9XTq+WdQDx3jzqyzRTLP2HYMXoGDRopG/tHXECbPjnpcuIY9JG19Hiz47cGq
        QoOwBFq7FYyz1QGMzHjO8jZV9bnmFc8HSb4PsqtLmf5DntgyLMYX+C4M5Eki0dEYJxiwsARBl1ARw
        SQxi6h4g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51298 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjMJu-000dlF-5O; Sun, 29 Nov 2020 13:00:50 +0000
Date:   Sun, 29 Nov 2020 05:00:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Jonas Malaco <jonas@protocubo.io>, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
Message-ID: <20201129130049.GB120875@roeck-us.net>
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
 <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
 <20201128113524.24f4f56f@monster.powergraphx.local>
 <CANS_-EPK75zrVRtBKxO-00RZD-XWrixJD8DH1_d=80rbazXQng@mail.gmail.com>
 <20201129073618.082c2291@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129073618.082c2291@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjMJu-000dlF-5O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:51298
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 07:36:18AM +0100, Wilken Gottwalt wrote:
> On Sat, 28 Nov 2020 17:21:40 -0300
> Jonas Malaco <jonas@protocubo.io> wrote:
> 
> > On Sat, Nov 28, 2020 at 7:35 AM Wilken Gottwalt
> > <wilken.gottwalt@posteo.net> wrote:
> > >
> > > On Sat, 28 Nov 2020 02:37:38 -0300
> > > Jonas Malaco <jonas@protocubo.io> wrote:
> > >
> > > > On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
> > > > <wilken.gottwalt@posteo.net> wrote:
> > > > >
> > > > > Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
> > > > > AX1500i and AX1600i. The first 3 power supplies are supported through
> > > > > the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> > > > > converter especially made for the COM ports of these power supplies.
> > > > > There are 3 known revisions of these adapters. The AX1500i power supply
> > > > > has revision 3 built into the case and AX1600i is the only one in that
> > > > > series, which has an unique usb hid id like the RM/RX series.
> > > >
> > > > Can I ask what AXi power supplies were tested?
> > > >
> > > > I ask because, based on the user-space implementations I am aware of,
> > > > the AXi dongle protocol appears to be different from the RMi/HXi series.
> > >
> > > I was not able to test this against the AX power supplies, they are really
> > > hard to find (and are far to expensive). But I went through all these tools
> > > and stuck to the most common commands, which all 3 series support. Not every
> > > series supports all commands (there also seem to be different firmwares in
> > > the micro-conrollers). But this is fine, some sensors will show up as N/A.
> > > Even my HX850i does not support all commands covered in this driver.
> > 
> > I think the similarities come from all using wrappers over the PMBus
> > interface to the voltage controller.  But I am not sure the wrapping
> > protocols are identical.
> > 
> > For example, cpsumon shows significantly more things going on during a
> > read than what is needed for the RMi/HXi series.[1]
> > 
> > [1] https://github.com/ka87/cpsumon/blob/fd639684d7f9/libcpsumon/src/cpsumon.c#L213-L231
> > 
> > 
> > >
> > > > AXi dongle:
> > > >  - https://github.com/ka87/cpsumon
> > >
> > > This tool made me to consider including the AX series, because it uses some
> > > of the same commands on the AX760i, AX860i, AX1200i and AX1500i. But it is
> > > a usb-serial tool only. But it was nice to know, that the commands are mostly
> > > the same. I left out all the commands for configuring, PCIe power rails,
> > > efficiency and others which do not really belong into hwmon.
> > >
> > > > RMi/HXi:
> > > >  - https://github.com/jonasmalacofilho/liquidctl
> > > >  - https://github.com/audiohacked/OpenCorsairLink
> > >
> > > This tool made me include the AX series, because it uses the rmi protocol
> > > component for the rmi driver (RM/HX series) and the corsair dongles.
> > 
> > The corsairlink_driver_dongle has no implementations for reading sensor
> > data (compare that with the corsairlink_driver_rmi).[2][3]  There is
> > also no code that actually tries to read (write) from (to) the device
> > using that dongle driver.[4]
> > 
> > I also looked at a few of the issues, and all of the ones I read
> > mentioned AXi support being under development, and the hypothesis of the
> > AXi series being compatible with the RMi/HXi code still remaining to be
> > confirmed.
> > 
> > [2] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/drivers/dongle.c#L33-L39
> > [3] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/drivers/rmi.c#L33-L57
> > [4] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/main.c#L106
> > 
> > 
> > >
> > > >  - https://github.com/notaz/corsairmi
> > >
> > > This one covers only some HX/RM PSUs, but is uses the rawhid access which
> > > made me looking up the actual usb chips/bridges Corsair uses.
> > >
> > > >
> > > > One additional concern is that the non-HID AXi dongles may only have bulk
> > > > USB endpoints, and this is a HID driver.[1]
> > >
> > > You are right, in the case of the dongles it could be different. But I did
> > > some research on Corsair usb driven devices and they really like to stick to
> > > the cp210x, which is an usb hid bridge. The commit
> > > b9326057a3d8447f5d2e74a7b521ccf21add2ec0 actually covers two Corsair USB
> > > dongles as a cp210x device. So it is very likely that all Corsair PSUs with
> > > such an interface/dongle use usb hid. But I'm completely open to get proven
> > > wrong. Actually I really would like to see this tested by people who have
> > > access to the more rare devices.
> > 
> > I could be wrong (and I am sorry for the noise if that is the case), but
> > as far as I can see the cp210x does not create a HID device.
> 
> No no, this is fine. It really helps if some more people are looking into this.
> I wish I had access to at least one of the later models (AX1500i/AX1600i), I
> make mistakes from time to time. And it really doesn't help that Corsair changes
> single devices in the same product line by firmware update. The AX1600i seems to
> be the only one, which uses exactly the same protocol like the RM/HX series, but
> is missing the actual usb hid part. But there seems to be a firmware where the
> usb hid part was available for a short time. So, what to do? Remove the AXi part
> completely or keep only the AX1600i?
> 
> Guenter, what would you suggest?
> 
I'd suggest to remove it completely, and explain the reason. Anything else will
just create trouble with people demanding to know why their power supply is not
supported even though it is listed as supported. And, believe me, you don't want
to be on the receiving side of those complaints. The Internet is much less
friendly nowadays than it used to be.

Guenter

> > Thanks again,
> > Jonas
> > 
> > 
> > >
> > > > Thanks,
> > > > Jonas
> > > >
> > > > [1] https://github.com/ka87/cpsumon/issues/4
> > >
> > > Yes ... that one. The last revision of the dongle could indeed be a problem.
> > > But I'm not really sure what is described here. The last commenter is actually
> > > the one who provided the cp210x patch mentioned up there. The problem here is,
> > > the AX1500i has both connectors, USB and that other one. I call it the other
> > > one because it is the only PSU where it is labeled I2C COMM instead of COMM
> > > only. But at the same time this tools uses the same commands for this PSU.
> > >
> > > So, only some real hardware tests will show.
> > >
> > > Greetings,
> > > Wilken
> > >
> > > > >
> > > > > The patch also changes the usb hid ids to use upper case letters to be
> > > > > consistent with the rest of the hex numbers in the driver and updates
> > > > > the hwmon documentation.
> > > > >
> > > > > This patch adds:
> > > > > - hwmon/corsair-psu documentation update
> > > > > - corsair-psu driver update
> > > > >
> > > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > > > ---
> > > > >  Documentation/hwmon/corsair-psu.rst | 10 +++++++++
> > > > >  drivers/hwmon/Kconfig               |  7 +++---
> > > > >  drivers/hwmon/corsair-psu.c         | 33 +++++++++++++++++++----------
> > > > >  3 files changed, 36 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> > > > > index 396b95c9a76a..6227e9046d73 100644
> > > > > --- a/Documentation/hwmon/corsair-psu.rst
> > > > > +++ b/Documentation/hwmon/corsair-psu.rst
> > > > > @@ -7,6 +7,16 @@ Supported devices:
> > > > >
> > > > >  * Corsair Power Supplies
> > > > >
> > > > > +  Corsair AX760i (by Corsair Link USB Dongle)
> > > > > +
> > > > > +  Corsair AX860i (by Corsair Link USB Dongle)
> > > > > +
> > > > > +  Corsair AX1200i (by Corsair Link USB Dongle)
> > > > > +
> > > > > +  Corsair AX1500i (by builtin Corsair Link USB Dongle)
> > > > > +
> > > > > +  Corsair AX1600i
> > > > > +
> > > > >    Corsair HX550i
> > > > >
> > > > >    Corsair HX650i
> > > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > > index 716df51edc87..3c059fc23cd6 100644
> > > > > --- a/drivers/hwmon/Kconfig
> > > > > +++ b/drivers/hwmon/Kconfig
> > > > > @@ -453,11 +453,12 @@ config SENSORS_CORSAIR_PSU
> > > > >         tristate "Corsair PSU HID controller"
> > > > >         depends on HID
> > > > >         help
> > > > > -         If you say yes here you get support for Corsair PSUs with a HID
> > > > > +         If you say yes here you get support for Corsair PSUs with an USB HID
> > > > >           interface.
> > > > >           Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
> > > > > -         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
> > > > > -         by Corsair.
> > > > > +         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i, HX1200i and AX1600i power
> > > > > +         supplies by Corsair. The AX760i, AX860i, AX1200i and AX1500i
> > > > > +         power supplies are supported through the Corsair Link USB Dongle.
> > > > >
> > > > >           This driver can also be built as a module. If so, the module
> > > > >           will be called corsair-psu.
> > > > > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > > > > index 99494056f4bd..0146dda3e2c3 100644
> > > > > --- a/drivers/hwmon/corsair-psu.c
> > > > > +++ b/drivers/hwmon/corsair-psu.c
> > > > > @@ -571,17 +571,28 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct
> > > > > hid_report *repo }
> > > > >
> > > > >  static const struct hid_device_id corsairpsu_idtable[] = {
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> > > > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> > > > > +       /*
> > > > > +        * The Corsair USB/COM Dongles appear in at least 3 different revisions, where rev 1
> > > > > and 2
> > > > > +        * are commonly used with the AX760i, AX860i and AX1200i, while rev3 is rarely seen
> > > > > with
> > > > > +        * these PSUs. Rev3 is also build into the AX1500i, while the AX1600i is the first
> > > > > PSU of
> > > > > +        * this series which has an unique usb hid id. Though, the actual device name is
> > > > > part of
> > > > > +        * the HID message protocol, so it doesn't matter which dongle is connected.
> > > > > +        */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair Link USB/COM Dongle rev1 */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C01) }, /* Corsair Link USB/COM Dongle rev2 */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair Link USB/COM Dongle rev3 (AX1500i) */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C03) }, /* Corsair HX550i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C04) }, /* Corsair HX650i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C05) }, /* Corsair HX750i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C06) }, /* Corsair HX850i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C07) }, /* Corsair HX1000i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C08) }, /* Corsair HX1200i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C09) }, /* Corsair RM550i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0A) }, /* Corsair RM650i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0B) }, /* Corsair RM750i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0C) }, /* Corsair RM850i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0D) }, /* Corsair RM1000i */
> > > > > +       { HID_USB_DEVICE(0x1B1C, 0x1C11) }, /* Corsair AX1600i */
> > > > >         { },
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
> > > > > --
> > > > > 2.29.2
> > > > >
> > >
> 
