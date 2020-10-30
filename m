Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14CC2A0690
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgJ3Nge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 09:36:34 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60917 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJ3Ngd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:36:33 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B132B200006;
        Fri, 30 Oct 2020 13:36:28 +0000 (UTC)
Date:   Fri, 30 Oct 2020 14:36:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2] mtd: rawnand: stm32_fmc2: fix broken ECC
Message-ID: <20201030143627.1a910cbc@xps13>
In-Reply-To: <1604064819-26861-1-git-send-email-christophe.kerello@st.com>
References: <1604064819-26861-1-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 30 Oct
2020 14:33:39 +0100:

> Since commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user
> input parsing bits"), ECC are broken in FMC2 driver in case of
> nand-ecc-step-size and nand-ecc-strength are not set in the device tree.
> To avoid this issue, the default settings are now set in
> stm32_fmc2_nfc_attach_chip function.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Fixes: d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
> ---
> Changes in v2:
>  - move default ECC settings in stm32_fmc2_nfc_attach_chip function.
> 
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index b31a581..550bda4 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1708,6 +1708,13 @@ static int stm32_fmc2_nfc_attach_chip(struct nand_chip *chip)
>  		return -EINVAL;
>  	}
>  
> +	/* Default ECC settings in case they are not set in the device tree */
> +	if (!chip->ecc.size)
> +		chip->ecc.size = FMC2_ECC_STEP_SIZE;
> +
> +	if (!chip->ecc.strength)
> +		chip->ecc.strength = FMC2_ECC_BCH8;
> +
>  	ret = nand_ecc_choose_conf(chip, &stm32_fmc2_nfc_ecc_caps,
>  				   mtd->oobsize - FMC2_BBM_LEN);
>  	if (ret) {
> @@ -1727,8 +1734,7 @@ static int stm32_fmc2_nfc_attach_chip(struct nand_chip *chip)
>  
>  	mtd_set_ooblayout(mtd, &stm32_fmc2_nfc_ooblayout_ops);
>  
> -	if (chip->options & NAND_BUSWIDTH_16)
> -		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
> +	stm32_fmc2_nfc_setup(chip);
>  
>  	return 0;
>  }
> @@ -1952,11 +1958,6 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>  	chip->options |= NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE |
>  			 NAND_USES_DMA;
>  
> -	/* Default ECC settings */
> -	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
> -	chip->ecc.size = FMC2_ECC_STEP_SIZE;
> -	chip->ecc.strength = FMC2_ECC_BCH8;
> -
>  	/* Scan to find existence of the device */
>  	ret = nand_scan(chip, nand->ncs);
>  	if (ret)

This overall looks very good to me, thanks for this update!

Cheers,
Miquèl
