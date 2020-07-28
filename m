Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7D230AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgG1MwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:52:17 -0400
Received: from crapouillou.net ([89.234.176.41]:43760 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgG1MwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595940734; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUBlVQzxg2rxddx4x1YBc0M4mlh02cv2yVV0AJhXcdo=;
        b=Oa69vmEyqdbx5c3A77jbOVpPgT7Uk5MtRVP9QmdxpYITmCqOIo6mSfeovt/u370jZ7pefu
        el+7Pay8F5us5SIN/IQ2glPekYNP4S/nZ43uPnSCGKEXwhmiETZ8b9f92QeE15uAVFFKPp
        OR/cuEYi2svqd9wguZmA1P6cbtSA/tA=
Date:   Tue, 28 Jul 2020 14:52:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] memory: jz4780_nemc: Only request IO memory the driver
 will use
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Message-Id: <RQJ6EQ.X0RPEZHBGXEN1@crapouillou.net>
In-Reply-To: <20200728092150.GA4437@kozik-lap>
References: <20200727162034.12334-1-paul@crapouillou.net>
        <20200728092150.GA4437@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 28 juil. 2020 =E0 11:21, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> On Mon, Jul 27, 2020 at 06:20:34PM +0200, Paul Cercueil wrote:
>>  The driver only uses the registers up to offset 0x54. Since the=20
>> EFUSE
>>  registers are in the middle of the NEMC registers, we only request
>>  the registers we will use for now - that way the EFUSE driver can
>>  probe too.
>>=20
>>  Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/memory/jz4780-nemc.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/memory/jz4780-nemc.c=20
>> b/drivers/memory/jz4780-nemc.c
>>  index b232ed279fc3..647267ea8c63 100644
>>  --- a/drivers/memory/jz4780-nemc.c
>>  +++ b/drivers/memory/jz4780-nemc.c
>>  @@ -8,6 +8,7 @@
>>=20
>>   #include <linux/clk.h>
>>   #include <linux/init.h>
>>  +#include <linux/io.h>
>>   #include <linux/math64.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>  @@ -288,7 +289,19 @@ static int jz4780_nemc_probe(struct=20
>> platform_device *pdev)
>>   	nemc->dev =3D dev;
>>=20
>>   	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  -	nemc->base =3D devm_ioremap_resource(dev, res);
>>  +
>>  +	/*
>>  +	 * The driver only uses the registers up to offset 0x54. Since=20
>> the EFUSE
>>  +	 * registers are in the middle of the NEMC registers, we only=20
>> request
>>  +	 * the registers we will use for now - that way the EFUSE driver=20
>> can
>>  +	 * probe too.
>>  +	 */
>>  +	if (!devm_request_mem_region(dev, res->start, 0x54,=20
>> dev_name(dev))) {
>>  +		dev_err(dev, "unable to request I/O memory region\n");
>>  +		return -EBUSY;
>>  +	}
>>  +
>>  +	nemc->base =3D devm_ioremap(dev, res->start, resource_size(res));
>=20
> Shouldn't you map only 0x54 size as well?

I can do that.

Cheers,
-Paul


