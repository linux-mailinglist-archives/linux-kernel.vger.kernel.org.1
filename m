Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20123E353
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 22:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHFUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 16:55:15 -0400
Received: from crapouillou.net ([89.234.176.41]:35280 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgHFUzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596747312; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBFRdiJpx6gDDqGjzCQG6RaWnse1sSSLfX/Lv9JDZeI=;
        b=T6jTH60Y6CtWnBhropJA1Y8XhgnMQnsAb98TDZ/ObOsbPAP9D/AEIX1HaO7IafjXxAxnS8
        YpNOyl4H3cmD8LFDWPQVkkOAQN3UxOsw/5QomVhHixmIKs3Wsu7mwcDKbwgJZzUem6hhPP
        fk8hq1CEzIGVvO5AXFTAtNN9WvXjfCA=
Date:   Wed, 05 Aug 2020 02:04:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] memory: jz4780_nemc: Fix an error pointer vs NULL check
 in probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-Id: <MJDKEQ.BWLP6TXTA14J1@crapouillou.net>
In-Reply-To: <20200803143607.GC346925@mwanda>
References: <20200803143607.GC346925@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 3 ao=FBt 2020 =E0 17:36, Dan Carpenter <dan.carpenter@oracle.com>=20
a =E9crit :
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.  This bug could lead to an Oops during probe.
>=20
> Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the=20
> driver will use")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thanks!
-Paul

> ---
>  drivers/memory/jz4780-nemc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/memory/jz4780-nemc.c=20
> b/drivers/memory/jz4780-nemc.c
> index 3ec5cb0fce1e..608ae925e641 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -304,9 +304,9 @@ static int jz4780_nemc_probe(struct=20
> platform_device *pdev)
>  	}
>=20
>  	nemc->base =3D devm_ioremap(dev, res->start, NEMC_REG_LEN);
> -	if (IS_ERR(nemc->base)) {
> +	if (!nemc->base) {
>  		dev_err(dev, "failed to get I/O memory\n");
> -		return PTR_ERR(nemc->base);
> +		return -ENOMEM;
>  	}
>=20
>  	writel(0, nemc->base + NEMC_NFCSR);
> --
> 2.27.0
>=20


