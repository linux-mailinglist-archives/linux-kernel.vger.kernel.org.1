Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B8E2A2AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKBMpT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 07:45:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57709 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:45:19 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CCA71E0014;
        Mon,  2 Nov 2020 12:44:45 +0000 (UTC)
Date:   Mon, 2 Nov 2020 13:44:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Jian Zhang <jzhang@ti.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 19/23] mtd: nand: raw: omap2: Fix a bunch of kernel-doc
 misdemeanours
Message-ID: <20201102134444.29696598@xps13>
In-Reply-To: <20201102115406.1074327-20-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201102115406.1074327-20-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:54:02
+0000:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/omap2.c:191: warning: Function parameter or member 'info' not described in 'omap_prefetch_enable'
>  drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'cs' not described in 'omap_prefetch_reset'
>  drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'info' not described in 'omap_prefetch_reset'
>  drivers/mtd/nand/raw/omap2.c:946: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc'
>  drivers/mtd/nand/raw/omap2.c:946: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc'
>  drivers/mtd/nand/raw/omap2.c:1017: warning: Function parameter or member 'chip' not described in 'omap_dev_ready'
>  drivers/mtd/nand/raw/omap2.c:1017: warning: Excess function parameter 'mtd' description in 'omap_dev_ready'
>  drivers/mtd/nand/raw/omap2.c:1036: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1036: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1142: warning: Function parameter or member 'ecc_calc' not described in '_omap_calculate_ecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1142: warning: Excess function parameter 'ecc_code' description in '_omap_calculate_ecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1270: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_sw'
>  drivers/mtd/nand/raw/omap2.c:1270: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_sw'
>  drivers/mtd/nand/raw/omap2.c:1284: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_multi'
>  drivers/mtd/nand/raw/omap2.c:1284: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_multi'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'info' not described in 'is_elm_present'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'elm_node' not described in 'is_elm_present'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Excess function parameter 'omap_nand_info' description in 'is_elm_present'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Jian Zhang <jzhang@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/nand/raw/omap2.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
[...]

> @@ -1130,7 +1131,7 @@ static u8  bch8_polynomial[] = {0xef, 0x51,
0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
>   * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
>   * @mtd:	MTD device structure
>   * @dat:	The pointer to data on which ecc is computed
> - * @ecc_code:	The ecc_code buffer
> + * @ecc_calc:	The ecc_code buffer
>   * @i:		The sector number (for a multi sector page)
>   *
>   * Support calculating of BCH4/8/16 ECC vectors for one sector
> @@ -1258,7 +1259,7 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
>   * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
>   * @chip:	NAND chip object
>   * @dat:	The pointer to data on which ecc is computed
> - * @ecc_code:	The ecc_code buffer
> + * @ecc_calc:	The ecc_code buffer

Could you please use as description:
"Buffer storing the calculated ECC bytes"

>   *
>   * Support calculating of BCH4/8/16 ECC vectors for one sector. This is used
>   * when SW based correction is required as ECC is required for one sector
> @@ -1274,7 +1275,7 @@ static int omap_calculate_ecc_bch_sw(struct nand_chip *chip,
>   * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
>   * @mtd:	MTD device structure
>   * @dat:	The pointer to data on which ecc is computed
> - * @ecc_code:	The ecc_code buffer
> + * @ecc_calc:	The ecc_code buffer

Ditto

>   *
>   * Support calculating of BCH4/8/16 ecc vectors for the entire page in one go.
>   */
> @@ -1673,7 +1674,8 @@ static int omap_read_page_bch(struct nand_chip *chip, uint8_t *buf,
>  
>  /**
>   * is_elm_present - checks for presence of ELM module by scanning DT nodes
> - * @omap_nand_info: NAND device structure containing platform data
> + * @info: NAND device structure containing platform data
> + * @elm_node: ELM's DT node
>   */
>  static bool is_elm_present(struct omap_nand_info *info,
>  			   struct device_node *elm_node)

Thanks,
Miquèl
