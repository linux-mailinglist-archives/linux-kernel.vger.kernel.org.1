Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159AA26E392
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIQR3c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Sep 2020 13:29:32 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36266 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIQR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:27:44 -0400
X-Greylist: delayed 2484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:27:43 EDT
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id EA76B3B3CE0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 16:30:39 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E6D0F1BF217;
        Thu, 17 Sep 2020 16:30:02 +0000 (UTC)
Date:   Thu, 17 Sep 2020 18:30:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: mtk: avoid underflow in
 mtk_nfc_nand_chip_init()
Message-ID: <20200917183001.393245e8@xps13>
In-Reply-To: <20200916194045.6378-1-novikov@ispras.ru>
References: <20200916194045.6378-1-novikov@ispras.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeny,

Evgeny Novikov <novikov@ispras.ru> wrote on Wed, 16 Sep 2020 22:40:45
+0300:

> If of_get_property() will set nsels to negative values the driver may

Is this really a possible case?

Looking at the OF code, I don't think it can ever happen...

> allocate insufficient memory for chip. Moreover, there may be underflow
> for devm_kzalloc(). This can result in various bad consequences later.
> The patch causes mtk_nfc_nand_chip_init() to fail for negative values of
> nsels.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> ---
>  drivers/mtd/nand/raw/mtk_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
> index ad1b55dab211..df98a2eec240 100644
> --- a/drivers/mtd/nand/raw/mtk_nand.c
> +++ b/drivers/mtd/nand/raw/mtk_nand.c
> @@ -1376,7 +1376,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
>  		return -ENODEV;
>  
>  	nsels /= sizeof(u32);
> -	if (!nsels || nsels > MTK_NAND_MAX_NSELS) {
> +	if (nsels <= 0 || nsels > MTK_NAND_MAX_NSELS) {
>  		dev_err(dev, "invalid reg property size %d\n", nsels);
>  		return -EINVAL;
>  	}

Thanks,
Miquèl
