Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED651BAB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgD0Rrx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Apr 2020 13:47:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40615 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgD0Rrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:47:52 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 94DDD20005;
        Mon, 27 Apr 2020 17:47:48 +0000 (UTC)
Date:   Mon, 27 Apr 2020 19:47:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 04/12] mtd: rawnand: stm32_fmc2: manage all errors
 cases at probe time
Message-ID: <20200427194747.224a2402@xps13>
In-Reply-To: <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
2020 17:57:28 +0200:

> This patch defers its probe when the expected reset control is not
> yet ready. This patch also handles properly all errors cases at probe
> time.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index b6d45cd..0a96797 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1967,7 +1967,11 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  	}
>  
>  	rstc = devm_reset_control_get(dev, NULL);
> -	if (!IS_ERR(rstc)) {
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
> +		if (ret == -EPROBE_DEFER)
> +			goto err_clk_disable;
> +	} else {
>  		reset_control_assert(rstc);
>  		reset_control_deassert(rstc);
>  	}
> @@ -1975,7 +1979,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  	/* DMA setup */
>  	ret = stm32_fmc2_dma_setup(fmc2);
>  	if (ret)
> -		return ret;
> +		goto err_dma_setup;
>  
>  	/* FMC2 init routine */
>  	stm32_fmc2_init(fmc2);
> @@ -1997,7 +2001,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  	/* Scan to find existence of the device */
>  	ret = nand_scan(chip, nand->ncs);
>  	if (ret)
> -		goto err_scan;
> +		goto err_dma_setup;
>  
>  	ret = mtd_device_register(mtd, NULL, 0);
>  	if (ret)
> @@ -2010,7 +2014,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  err_device_register:
>  	nand_cleanup(chip);
>  
> -err_scan:
> +err_dma_setup:
>  	if (fmc2->dma_ecc_ch)
>  		dma_release_channel(fmc2->dma_ecc_ch);
>  	if (fmc2->dma_tx_ch)
> @@ -2021,6 +2025,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  	sg_free_table(&fmc2->dma_data_sg);
>  	sg_free_table(&fmc2->dma_ecc_sg);
>  
> +err_clk_disable:
>  	clk_disable_unprepare(fmc2->clk);
>  
>  	return ret;

I didn't spot it during my earlier reviews but I really prefer using
labels explaining what you do than having the same name of the function
which failed. This way you don't have to rework the error path when
you handle an additional error.

So, would you mind doing this in two steps:

1/
Replace

    err_scan:

with, eg.

    release_dma_objs:

2/
Add a

    goto release_dma_objs;

in *_dma_setup() error path, and define and use a

    release_clk

label like you already do.


Thanks,
Miquèl
