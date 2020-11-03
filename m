Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC52A48E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgKCPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgKCPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:03:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F9C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:03:15 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0CC8D1F456FD;
        Tue,  3 Nov 2020 15:03:13 +0000 (GMT)
Date:   Tue, 3 Nov 2020 16:03:09 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spinand: micron: add support for MT29F2G01AAAED
Message-ID: <20201103160309.772f3538@collabora.com>
In-Reply-To: <20201103145901.29372-1-nthirumalesha7@gmail.com>
References: <20201103145901.29372-1-nthirumalesha7@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Nov 2020 22:59:01 +0800
Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote:

> The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
> ECC
> 
> Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> ---
> 
> v5: As per the review comments, the changes were reverted to the v2,
> except the MT29F2G01AAAED device related (including the review comments)

I don't think that's what Miquel suggested, especially not for the
{write,update,write}_cache_variants helpers.

> 
> v4: Split patch into two parts,
>     1. Generalise the oob structure name & function names as show in v3
>     2. Add support for MT29F2G01AAAED device
>        a. Add oob section check in micron_ooblayout_free function
>        b. Rename mt29f2g01aaaed_* to generic name micron_4_*
> 
> v3: As per the review comments,
>      1. Renamed read_cache_variants as quadio_read_cache_variants,
> write_cache_variants as
>       x4_write_cache_variants/x1_write_cache_variants,
> update_cache_variants as
>       x4_update_cache_variants/x1_update_cache_variants,
> read_cache_variants as x4_read_cache_variants
>      2. Renamed micron_8_ooblayout as micron_grouped_ooblayout &
> mt29f2g01aaaed_ooblayout as
>       micron_interleaved_ooblayout
>      3. Generalized page size based oob section check in
> mt29f2g01aaaed_ooblayout_ecc function
>       and separate case check for two bytes BBM reserved in
> mt29f2g01aaaed_ooblayout_free function
>      4. Removed mt29f2g01aaaed_ecc_get_status function &
> MICRON_STATUS_ECC_1TO4_BITFLIPS
> 
> v2: Removed SPINAND_SELECT_TARGET as per the comments & fixed typo
> errors
> 
> v1: Add support for Micron SPI Nand device MT29F2G01AAAED
> 
>  drivers/mtd/nand/spi/micron.c | 64 +++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 5d370cfcdaaa..0b1e48d5c9d4 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -44,6 +44,19 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> +/* Micron  MT29F2G01AAAED Device */
> +static SPINAND_OP_VARIANTS(micron_4_read_cache_variants,
> +			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(micron_4_write_cache_variants,
> +			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(micron_4_update_cache_variants,
> +			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
>  static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -74,6 +87,47 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
>  	.free = micron_8_ooblayout_free,
>  };
>  
> +static int micron_4_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +
> +	if (section >= spinand->base.memorg.pagesize /
> +			mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	region->offset = (section * 16) + 8;
> +	region->length = 8;
> +
> +	return 0;
> +}
> +
> +static int micron_4_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +
> +	if (section >= spinand->base.memorg.pagesize /
> +			mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset = 16 * section;
> +		region->length = 8;
> +	} else {
> +		/* section 0 has two bytes reserved for the BBM */
> +		region->offset = 2;
> +		region->length = 6;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops micron_4_ooblayout = {
> +	.ecc = micron_4_ooblayout_ecc,
> +	.free = micron_4_ooblayout_free,
> +};
> +
>  static int micron_select_target(struct spinand_device *spinand,
>  				unsigned int target)
>  {
> @@ -217,6 +271,16 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
> +	/* M69A 2Gb 3.3V */
> +	SPINAND_INFO("MT29F2G01AAAED",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&micron_4_read_cache_variants,
> +					      &micron_4_write_cache_variants,
> +					      &micron_4_update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&micron_4_ooblayout, NULL)),
>  };
>  
>  static int micron_spinand_init(struct spinand_device *spinand)

