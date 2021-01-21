Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19E2FEEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbhAUPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbhAUPcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADAB223A1D;
        Thu, 21 Jan 2021 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611243081;
        bh=tBLsV1VNuegTHfS6+bEovqF+AKToDG2mT/Z3c56FLvk=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=Dz/0PK/HKOZWTiyTZ2IsVaYJSIZnW7BAiwOu2fYT5qwSV0GrrM5g0OM7NWTYDpNN2
         cr1BEuFAcNnqcuYnmBD0vBTNu4/YM3cYf894DKTA1jLgdvJWY9NWf2Fp6XY1O/gKHG
         6OLoaF/eHmhIiyQsdzIEy/FPRF9HAlNRNPcUYF71mJ4WVmlKxKJQHwQpuVUt2Euppu
         OZ9psP1/D3NpF+0/m+zHKa7wAK5bOC2sfLmoEsDdf+uovW2XlucEVgQekgwUGmvagy
         h7YeKzSpdDs42UfptB3svhqFgTsUAfz3Jm3hjoijVuhCXiQ3gJ+vGDTPktggXzOPaI
         NY3B50DOnUoEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210121151126.74627-1-bianpan2016@163.com>
References: <20210121151126.74627-1-bianpan2016@163.com>
From:   Antoine Tenart <atenart@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
To:     Pan Bian <bianpan2016@163.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] reset: berlin: Put parent device node on error path
Message-ID: <161124307799.3192.6156233333339423791@kwain.local>
Date:   Thu, 21 Jan 2021 16:31:18 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Quoting Pan Bian (2021-01-21 16:11:26)
> Put parent device node parent_np if there is no enough memory.
>=20
> Fixes: aed6f3cadc86 ("reset: berlin: convert to a platform driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/reset/reset-berlin.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
> index 371197bbd055..cae58e40f639 100644
> --- a/drivers/reset/reset-berlin.c
> +++ b/drivers/reset/reset-berlin.c
> @@ -72,8 +72,10 @@ static int berlin2_reset_probe(struct platform_device =
*pdev)
>         struct berlin_reset_priv *priv;
> =20
>         priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> +       if (!priv) {
> +               of_node_put(parent_np);
>                 return -ENOMEM;
> +       }

You could also move the of_get_parent() call here, to avoid having to
handle parent_np in an error path. That would improve maintainability
imho.

Thanks,
Antoine

>         priv->regmap =3D syscon_node_to_regmap(parent_np);
>         of_node_put(parent_np);
