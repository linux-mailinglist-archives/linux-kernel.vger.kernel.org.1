Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC922D915
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGYRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 13:51:25 -0400
Received: from crapouillou.net ([89.234.176.41]:43594 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgGYRvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595699483; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDXp85cVUViAOOwKXsmkJ5iDxjTqMkt0yFwxndtb3EU=;
        b=sojbDqR2XsNQ8EMZ2verxPIz3Yc8YrReJ7uETDe/dxavlMxfTEl5BC0vRJpSV0+YOhMecx
        7nSugwHa544xwjorKgeY8DPhPBByX7xdCphx9ltnvVxPh8EAG9XI2YzgNnW+aZa+VEhuQD
        xawpWPkbgZirc1J/+TL15XZzOpqHeYE=
Date:   Sat, 25 Jul 2020 19:51:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ELD1EQ.FQX2LQI01P702@crapouillou.net>
In-Reply-To: <20200721114101.GA1761915@kroah.com>
References: <20200621224807.882184-1-paul@crapouillou.net>
        <20200721114101.GA1761915@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Le mar. 21 juil. 2020 =E0 13:41, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> a =E9crit :
> On Mon, Jun 22, 2020 at 12:48:07AM +0200, Paul Cercueil wrote:
>>  Register a power supply charger, if the Kconfig option
>>  USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
>>  the USB role is set to device or not.
>>=20
>>  This is useful when the USB role is the only way to know if the=20
>> device
>>  is charging from USB. The API is the standard power supply charger=20
>> API,
>>  you get a /sys/class/power_supply/xxx/online node which tells you=20
>> the
>>  state of the charger.
>>=20
>>  The sole purpose of this is to give userspace applications a way to
>>  know whether or not the charger is plugged.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/usb/common/Kconfig         | 11 +++++++
>>   drivers/usb/common/usb-conn-gpio.c | 47=20
>> ++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>=20
>>  diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
>>  index d611477aae41..5405ae96c68f 100644
>>  --- a/drivers/usb/common/Kconfig
>>  +++ b/drivers/usb/common/Kconfig
>>  @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>>=20
>>   	  To compile the driver as a module, choose M here: the module=20
>> will
>>   	  be called usb-conn-gpio.ko
>>  +
>>  +if USB_CONN_GPIO
>>  +
>>  +config USB_CONN_GPIO_CHARGER
>>  +	bool "USB charger support"
>>  +	select POWER_SUPPLY
>>  +	help
>>  +	  Register a charger with the power supply subsystem. This will=20
>> allow
>>  +	  userspace to know whether or not the device is charging from=20
>> USB.
>=20
> Why make this an option at all?  Why wouldn't we always want this=20
> here?
>=20
> As this is a charger, exporting that information to userspace should
> probably always happen, right?

I wanted to avoid the hardcoded dependency on CONFIG_POWER_SUPPLY.

I can very well make that non-optional.

Cheers,
-Paul

> thanks,
>=20
> greg k-h


