Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7D2E9875
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhADP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbhADP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:26:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27B7B207BC;
        Mon,  4 Jan 2021 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609773928;
        bh=yGZo+0+EBf8vIpw++LBrT1NrSOVQ3B7cXjNdPOb0/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9nDbj1/Dtg66BxObDB6GDf0j8aJgDHnVT3xsdf3Ed1jiRinbgUrUrnXz9KlgB0no
         rsXSyMcEyqFwaW4LV52/60UtiwDi7GJDM48UbLvoTFhKZQILbyfFp+meyJPkhwySFH
         nCIThbLXQ5JWDCC5FIN8kOGFmsN63cJqqvBpd8p6HJp/v6ewsMU7F7Z8o/eVK37u4P
         9y7ziABUa39KNj4HAyBesa3sWeqYU6JypQaPZS034O6z2pZDFoZx3AIJPNJJlroLew
         WMwVWPDeoFjaXuZ5YHHFDW8eIo/qFOJW95uVFFXS8pXz1fMMD4G9BCWXxfg37Kk0md
         CBfvN5CcoTZAw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kwRjY-0000hW-Vw; Mon, 04 Jan 2021 16:25:25 +0100
Date:   Mon, 4 Jan 2021 16:25:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add LongSung M5710 module support
Message-ID: <X/MzZAB9jN507p74@hovoldconsulting.com>
References: <20201227031716.1343300-1-daniel@0x0f.com>
 <X/LuvBdeLVKyZkvO@hovoldconsulting.com>
 <CAFr9PX=xr=xRaT18VN5ELDF=WBO+YqohC4Rvdg-TJNDXr3OqgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PX=xr=xRaT18VN5ELDF=WBO+YqohC4Rvdg-TJNDXr3OqgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 11:29:39PM +0900, Daniel Palmer wrote:
> Hi Johan,
> 
> On Mon, 4 Jan 2021 at 19:32, Johan Hovold <johan@kernel.org> wrote:
> 
> > Also, would you mind posting the "lsusb -v" output for this device for
> > reference?
> 
> The lsusb from busybox on this system doesn't support the -v option it seems.
> Here is the output from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2df3 ProdID=9d03 Rev= 1.00
> S:  Manufacturer=Marvell
> S:  Product=Mobile Composite Device Bus
> S:  SerialNumber=<snip>
> C:* #Ifs= 5 Cfg#= 1 Atr=c0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
> E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> I can rebuild my rootfs with the usbutils lsusb tomorrow when I have
> physical access to it again if needed.

That's ok, the above will do just fine.

It looks like we must not try to bind to the first two interfaces
however:

	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */

> >Do you know what each interface is used for?
> 
> The second tty responds to AT commands. The others don't do anything so far.
> The hardware documentation doesn't say much aside that there is a usb interface.

Ok, thanks. I'll apply this one with the above change now.

Johan
