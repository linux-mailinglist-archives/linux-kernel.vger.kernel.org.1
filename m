Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5122DDE4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgGZKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 06:08:04 -0400
Received: from crapouillou.net ([89.234.176.41]:58438 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595758081; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0am6mgWKJUe1ExZDcOfKfY6QiInZYPDwzJPLj426EnY=;
        b=ov/dhIGvakvPQkaPLEtYNTCL4S+VjUTnOKMwhuKypvPjsF0yPyZ+pnFrh9tBuXVNBGLnVz
        Uct87AEAKEgDMPOCBJy1+U0s6ti+lkKsDfY6NGm56OsgQlNy5jp1tNq+IHQqSxnAfO7SAc
        buNvKjIFbjfKTXmeK/hN6M3sdEzjy0o=
Date:   Sun, 26 Jul 2020 12:07:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4TM2EQ.P9PDF9VIY9MA1@crapouillou.net>
In-Reply-To: <20200726083922.GC448215@kroah.com>
References: <20200621224807.882184-1-paul@crapouillou.net>
        <20200721114101.GA1761915@kroah.com> <ELD1EQ.FQX2LQI01P702@crapouillou.net>
        <20200726083922.GC448215@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 26 juil. 2020 =E0 10:39, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> a =E9crit :
> On Sat, Jul 25, 2020 at 07:51:14PM +0200, Paul Cercueil wrote:
>>  Hi Greg,
>>=20
>>  Le mar. 21 juil. 2020 =E0 13:41, Greg Kroah-Hartman
>>  <gregkh@linuxfoundation.org> a =E9crit :
>>  > On Mon, Jun 22, 2020 at 12:48:07AM +0200, Paul Cercueil wrote:
>>  > >  Register a power supply charger, if the Kconfig option
>>  > >  USB_CONN_GPIO_CHARGER is set, whose online state depends on=20
>> whether
>>  > >  the USB role is set to device or not.
>>  > >
>>  > >  This is useful when the USB role is the only way to know if the
>>  > > device
>>  > >  is charging from USB. The API is the standard power supply=20
>> charger
>>  > > API,
>>  > >  you get a /sys/class/power_supply/xxx/online node which tells=20
>> you
>>  > > the
>>  > >  state of the charger.
>>  > >
>>  > >  The sole purpose of this is to give userspace applications a=20
>> way to
>>  > >  know whether or not the charger is plugged.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  ---
>>  > >   drivers/usb/common/Kconfig         | 11 +++++++
>>  > >   drivers/usb/common/usb-conn-gpio.c | 47
>>  > > ++++++++++++++++++++++++++++++
>>  > >   2 files changed, 58 insertions(+)
>>  > >
>>  > >  diff --git a/drivers/usb/common/Kconfig=20
>> b/drivers/usb/common/Kconfig
>>  > >  index d611477aae41..5405ae96c68f 100644
>>  > >  --- a/drivers/usb/common/Kconfig
>>  > >  +++ b/drivers/usb/common/Kconfig
>>  > >  @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>>  > >
>>  > >   	  To compile the driver as a module, choose M here: the=20
>> module
>>  > > will
>>  > >   	  be called usb-conn-gpio.ko
>>  > >  +
>>  > >  +if USB_CONN_GPIO
>>  > >  +
>>  > >  +config USB_CONN_GPIO_CHARGER
>>  > >  +	bool "USB charger support"
>>  > >  +	select POWER_SUPPLY
>>  > >  +	help
>>  > >  +	  Register a charger with the power supply subsystem. This=20
>> will
>>  > > allow
>>  > >  +	  userspace to know whether or not the device is charging=20
>> from
>>  > > USB.
>>  >
>>  > Why make this an option at all?  Why wouldn't we always want this=20
>> here?
>>  >
>>  > As this is a charger, exporting that information to userspace=20
>> should
>>  > probably always happen, right?
>>=20
>>  I wanted to avoid the hardcoded dependency on CONFIG_POWER_SUPPLY.
>>=20
>>  I can very well make that non-optional.
>=20
> As the whole reason for this driver is to be a power supply, make it
> depend on the power supply core please.

It's the whole reason of my patch, not of the driver itself, whose=20
purpose is to report the USB role (device, host, unconnected).

-Paul


