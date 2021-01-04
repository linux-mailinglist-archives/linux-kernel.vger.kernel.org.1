Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE92E9227
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbhADIte convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 03:49:34 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54095 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbhADItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:49:33 -0500
X-Originating-IP: 90.89.98.255
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EF2E3240010;
        Mon,  4 Jan 2021 08:48:50 +0000 (UTC)
Date:   Mon, 4 Jan 2021 09:48:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: intel: remove broken code
Message-ID: <20210104094849.1850c993@xps13>
In-Reply-To: <20201217221148.2877318-1-martin.blumenstingl@googlemail.com>
References: <20201217221148.2877318-1-martin.blumenstingl@googlemail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Thu,
17 Dec 2020 23:11:48 +0100:

> Drop the check for mtd->name as it's executed while the mtd variable is
> always NULL. If some MTD name is needed then it should be validated by
> the MTD core.
> 
> While here, also drop the NULL assignment to the mtd variable as it's
> overwritten later on anyways and the NULL value is never read.
> 
> Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> I found this by looking at the new driver. This patch is compile-tested
> only.
> 
> 
>  drivers/mtd/nand/raw/intel-nand-controller.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
> index fdb112e8a90d..398de6ec68d7 100644
> --- a/drivers/mtd/nand/raw/intel-nand-controller.c
> +++ b/drivers/mtd/nand/raw/intel-nand-controller.c
> @@ -579,7 +579,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ebu_nand_controller *ebu_host;
>  	struct nand_chip *nand;
> -	struct mtd_info *mtd = NULL;
> +	struct mtd_info *mtd;
>  	struct resource *res;
>  	char *resname;
>  	int ret;
> @@ -647,10 +647,6 @@ static int ebu_nand_probe(struct platform_device *pdev)
>  	       ebu_host->ebu + EBU_ADDR_SEL(cs));
>  
>  	nand_set_flash_node(&ebu_host->chip, dev->of_node);
> -	if (!mtd->name) {
> -		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
> -		return -EINVAL;
> -	}

This is valid code, it's best to use a label = "my-storage"; property
in your NAND DT node. Then mtd->name will be updated by
nand_set_flash_node().

Thanks,
Miquèl
