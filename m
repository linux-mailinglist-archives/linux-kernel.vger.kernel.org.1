Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDEE2F6B77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbhANTsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:48:41 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:50774 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbhANTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:48:40 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 14:48:39 EST
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 8962018C011C;
        Thu, 14 Jan 2021 22:39:50 +0300 (MSK)
Received: from vla1-68d3ce55e22b.qloud-c.yandex.net (vla1-68d3ce55e22b.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3385:0:640:68d3:ce55])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 85040CF40002;
        Thu, 14 Jan 2021 22:39:50 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net (vla3-23c3b031fed5.qloud-c.yandex.net [2a02:6b8:c15:2582:0:640:23c3:b031])
        by vla1-68d3ce55e22b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id V1KbJSjY6B-doDKQJhK;
        Thu, 14 Jan 2021 22:39:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brighterdan.com; s=mail;
        t=1610653190; bh=xnAMj8oxVA7uToZzeLoL8rfnq1jFRysju2h0drLGuO4=;
        h=Subject:To:From:Date:Message-ID:Cc;
        b=UlKHR8SpWEV75IBg75yZE26/9MH2o2xXyzovCd4dN9aawMqYvkI9bGA805FZh8N7f
         BU8fSk6QRvPq2StVOmm6FBcNHX8ZRpAYK3/lddif5Dd17oGqcmuGkZ17G64HV8WzWL
         ZtgfR1uy6Yef/wCzwIhQdvFWkAJw8dKJODCKuC+Y=
Authentication-Results: vla1-68d3ce55e22b.qloud-c.yandex.net; dkim=pass header.i=@brighterdan.com
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id bgBVLx8IYD-dnIWVDB7;
        Thu, 14 Jan 2021 22:39:49 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Thu, 14 Jan 2021 19:39:45 +0000
From:   Daniel Santos <hello@brighterdan.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: USB Keyboard having problems to be detected
Message-ID: <20210114193945.1bfb6a67@torre.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/0NpbN0Hg800t7yuJD=pg78n"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/0NpbN0Hg800t7yuJD=pg78n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am using a ArchLinux distribution. `uname -a` gives me:

Linux torre 5.4.87-1-lts #1 SMP Wed, 06 Jan 2021 14:56:05 +0000 x86_64
GNU/Linux

So, some months ago, my USB Keyboard stopped being detected at
boot. I mean, eventually got detected, after the 9 seconds timeout and
this is a bit frustrating, since, 1. it is a keyboard, meaning that it
should not have any problem, and 2. I start typing immediately, only to
find how that my keystrokes are getting lost.

This did not happen when I started using ArchLinux, 2 years from now.
Also this did not happen like 5 months from now, imprecisely calculated.

Today, I took the time to look at the journal and this is what it has
to say about my issue:

jan 14 19:05:03 torre kernel: usb 1-5: device descriptor read/all,
error -110 jan 14 19:05:03 torre kernel: usb 1-5: new high-speed USB
device number 4 using ehci-pci 
(...) 
jan 14 19:05:14 torre kernel: usb 1-5: device descriptor read/all,
error -110 jan 14 19:05:14 torre kernel: usb usb1-port5: attempt power
cycle jan 14 19:05:14 torre kernel: usb 1-5: new high-speed USB device
number 5 using ehci-pci jan 14 19:05:19 torre kernel: usb 1-5: device
descriptor read/8, error -110 jan 14 19:05:19 torre kernel: usb 1-5:
New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.12
jan 14 19:05:19 torre kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=2 jan 14 19:05:19 torre kernel: usb 1-5:
SerialNumber: 324EC190 jan 14 19:05:21 torre kernel: usb 1-5: set
resolution quirk: cval->res = 384 jan 14 19:05:21 torre kernel: usb
6-3: new low-speed USB device number 2 using ohci-pci jan 14 19:05:22
torre kernel: usb 6-3: New USB device found, idVendor=0c45,
idProduct=8603, bcdDevice= 2.00 jan 14 19:05:22 torre kernel: usb 6-3:
New USB device strings: Mfr=1, Product=2, SerialNumber=0 jan 14
19:05:22 torre kernel: usb 6-3: Product: SI Gaming Keyboard jan 14
19:05:22 torre kernel: usb 6-3: Manufacturer: SONiX jan 14 19:05:22
torre kernel: input: SONiX SI Gaming Keyboard as
/devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.0/0003:0C45:8603.0003/input/input14
jan 14 19:05:22 torre kernel: hid-generic 0003:0C45:8603.0003:
input,hidraw2: USB HID v1.11 Keyboard [SONiX SI Gaming Keyboard] on
usb-0000:00:12.1-3/input0 jan 14 19:05:22 torre kernel: input: SONiX SI
Gaming Keyboard Consumer Control as
/devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.1/0003:0C45:8603.0004/input/input15
jan 14 19:05:22 torre kernel: input: SONiX SI Gaming Keyboard System
Control as
/devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.1/0003:0C45:8603.0004/input/input16
jan 14 19:05:22 torre kernel: hid-generic 0003:0C45:8603.0004:
input,hidraw3: USB HID v1.11 Device [SONiX SI Gaming Keyboard] on
usb-0000:00:12.1-3/input1 jan 14 19:05:22 torre systemd-logind[326]:
Watching system buttons on /dev/input/event15 (SONiX SI Gaming Keyboard
Consumer Control) jan 14 19:05:22 torre systemd-logind[326]: Watching
system buttons on /dev/input/event14 (SONiX SI Gaming Keyboard) jan 14
19:05:22 torre systemd-logind[326]: Watching system buttons on
/dev/input/event16 (SONiX SI Gaming Keyboard System Control) jan 14
19:05:22 torre kernel: videodev: Linux video capture interface: v2.00
jan 14 19:05:22 torre kernel: uvcvideo: Found UVC 1.00 device <unnamed>
(046d:0825) jan 14 19:05:22 torre kernel: input: UVC Camera (046d:0825)
as /devices/pci0000:00/0000:00:12.2/usb1/1-5/1-5:1.0/input/input17 jan
14 19:05:22 torre kernel: usbcore: registered new interface driver
uvcvideo jan 14 19:05:22 torre kernel: USB Video Class driver (1.1.1)

Hope someone can make my keyboard detect as soon as my Linux is booted.

Best regards,

Daniel Santos

--MP_/0NpbN0Hg800t7yuJD=pg78n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=keyboard-bug.txt

jan 14 19:05:03 torre kernel: usb 1-5: device descriptor read/all, error -110
jan 14 19:05:03 torre kernel: usb 1-5: new high-speed USB device number 4 using ehci-pci

(...)

jan 14 19:05:14 torre kernel: usb 1-5: device descriptor read/all, error -110
jan 14 19:05:14 torre kernel: usb usb1-port5: attempt power cycle
jan 14 19:05:14 torre kernel: usb 1-5: new high-speed USB device number 5 using ehci-pci
jan 14 19:05:19 torre kernel: usb 1-5: device descriptor read/8, error -110
jan 14 19:05:19 torre kernel: usb 1-5: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.12
jan 14 19:05:19 torre kernel: usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=2
jan 14 19:05:19 torre kernel: usb 1-5: SerialNumber: 324EC190
jan 14 19:05:21 torre kernel: usb 1-5: set resolution quirk: cval->res = 384
jan 14 19:05:21 torre kernel: usb 6-3: new low-speed USB device number 2 using ohci-pci
jan 14 19:05:22 torre kernel: usb 6-3: New USB device found, idVendor=0c45, idProduct=8603, bcdDevice= 2.00
jan 14 19:05:22 torre kernel: usb 6-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 14 19:05:22 torre kernel: usb 6-3: Product: SI Gaming Keyboard
jan 14 19:05:22 torre kernel: usb 6-3: Manufacturer: SONiX
jan 14 19:05:22 torre kernel: input: SONiX SI Gaming Keyboard as /devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.0/0003:0C45:8603.0003/input/input14
jan 14 19:05:22 torre kernel: hid-generic 0003:0C45:8603.0003: input,hidraw2: USB HID v1.11 Keyboard [SONiX SI Gaming Keyboard] on usb-0000:00:12.1-3/input0
jan 14 19:05:22 torre kernel: input: SONiX SI Gaming Keyboard Consumer Control as /devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.1/0003:0C45:8603.0004/input/input15
jan 14 19:05:22 torre kernel: input: SONiX SI Gaming Keyboard System Control as /devices/pci0000:00/0000:00:12.1/usb6/6-3/6-3:1.1/0003:0C45:8603.0004/input/input16
jan 14 19:05:22 torre kernel: hid-generic 0003:0C45:8603.0004: input,hidraw3: USB HID v1.11 Device [SONiX SI Gaming Keyboard] on usb-0000:00:12.1-3/input1
jan 14 19:05:22 torre systemd-logind[326]: Watching system buttons on /dev/input/event15 (SONiX SI Gaming Keyboard Consumer Control)
jan 14 19:05:22 torre systemd-logind[326]: Watching system buttons on /dev/input/event14 (SONiX SI Gaming Keyboard)
jan 14 19:05:22 torre systemd-logind[326]: Watching system buttons on /dev/input/event16 (SONiX SI Gaming Keyboard System Control)
jan 14 19:05:22 torre kernel: videodev: Linux video capture interface: v2.00
jan 14 19:05:22 torre kernel: uvcvideo: Found UVC 1.00 device <unnamed> (046d:0825)
jan 14 19:05:22 torre kernel: input: UVC Camera (046d:0825) as /devices/pci0000:00/0000:00:12.2/usb1/1-5/1-5:1.0/input/input17
jan 14 19:05:22 torre kernel: usbcore: registered new interface driver uvcvideo
jan 14 19:05:22 torre kernel: USB Video Class driver (1.1.1)

--MP_/0NpbN0Hg800t7yuJD=pg78n--
