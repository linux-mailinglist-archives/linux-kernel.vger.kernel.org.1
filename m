Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BC22DD53
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGZIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 04:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZIj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:39:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A1620738;
        Sun, 26 Jul 2020 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595752765;
        bh=+QcmN2vHpotzbBW3lSoKNr6y+Q6VOd222+gkAIzbYag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Ck8P/L+hqE+tyBVJuUHRGOZ/6BMxxFMsTIlYPU0gTHbhN5U3BjhzoBTMnjjzk6vr
         3fq1HanURDrVtZrGVWHiIrZL4g5Vr81HamnlB0pzoSWDST1UWrVuh5BGGaM15Em42V
         jiMxjFj+QvKW+D10D1WsJB/4nKBlHCT5/lJ6CJ6E=
Date:   Sun, 26 Jul 2020 10:39:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
Message-ID: <20200726083922.GC448215@kroah.com>
References: <20200621224807.882184-1-paul@crapouillou.net>
 <20200721114101.GA1761915@kroah.com>
 <ELD1EQ.FQX2LQI01P702@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ELD1EQ.FQX2LQI01P702@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 07:51:14PM +0200, Paul Cercueil wrote:
> Hi Greg,
> 
> Le mar. 21 juil. 2020 à 13:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> a écrit :
> > On Mon, Jun 22, 2020 at 12:48:07AM +0200, Paul Cercueil wrote:
> > >  Register a power supply charger, if the Kconfig option
> > >  USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
> > >  the USB role is set to device or not.
> > > 
> > >  This is useful when the USB role is the only way to know if the
> > > device
> > >  is charging from USB. The API is the standard power supply charger
> > > API,
> > >  you get a /sys/class/power_supply/xxx/online node which tells you
> > > the
> > >  state of the charger.
> > > 
> > >  The sole purpose of this is to give userspace applications a way to
> > >  know whether or not the charger is plugged.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   drivers/usb/common/Kconfig         | 11 +++++++
> > >   drivers/usb/common/usb-conn-gpio.c | 47
> > > ++++++++++++++++++++++++++++++
> > >   2 files changed, 58 insertions(+)
> > > 
> > >  diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> > >  index d611477aae41..5405ae96c68f 100644
> > >  --- a/drivers/usb/common/Kconfig
> > >  +++ b/drivers/usb/common/Kconfig
> > >  @@ -49,3 +49,14 @@ config USB_CONN_GPIO
> > > 
> > >   	  To compile the driver as a module, choose M here: the module
> > > will
> > >   	  be called usb-conn-gpio.ko
> > >  +
> > >  +if USB_CONN_GPIO
> > >  +
> > >  +config USB_CONN_GPIO_CHARGER
> > >  +	bool "USB charger support"
> > >  +	select POWER_SUPPLY
> > >  +	help
> > >  +	  Register a charger with the power supply subsystem. This will
> > > allow
> > >  +	  userspace to know whether or not the device is charging from
> > > USB.
> > 
> > Why make this an option at all?  Why wouldn't we always want this here?
> > 
> > As this is a charger, exporting that information to userspace should
> > probably always happen, right?
> 
> I wanted to avoid the hardcoded dependency on CONFIG_POWER_SUPPLY.
> 
> I can very well make that non-optional.

As the whole reason for this driver is to be a power supply, make it
depend on the power supply core please.

thanks,

greg k-h
