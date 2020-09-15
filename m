Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD026A0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIOIQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 04:16:26 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59533 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgIOIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:14:04 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9BC46FF805;
        Tue, 15 Sep 2020 08:13:22 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:13:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mtd: spinand: micron: Generalize the function
 and structure names
Message-ID: <20200915101321.1afa5033@xps13>
In-Reply-To: <20200913161533.10655-2-nthirumalesha7@gmail.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
        <20200913161533.10655-2-nthirumalesha7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirumalesha,

Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote on Mon, 14
Sep 2020 00:15:32 +0800:

> Rename the oob structure and read/write/update function names to
> a generic names
> 
> Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 80 +++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 5d370cfcdaaa..d1b1073d1a55 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -28,7 +28,7 @@
>  
>  #define MICRON_SELECT_DIE(x)	((x) << 6)
>  
> -static SPINAND_OP_VARIANTS(read_cache_variants,
> +static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> @@ -36,11 +36,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>  
> -static SPINAND_OP_VARIANTS(write_cache_variants,
> +static SPINAND_OP_VARIANTS(x4_write_cache_variants,

Why quadio_read and x4_write? I don't get the logic.

>  		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(true, 0, NULL, 0));
>  
> -static SPINAND_OP_VARIANTS(update_cache_variants,
> +static SPINAND_OP_VARIANTS(x4_update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> @@ -69,7 +69,7 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
>  	return 0;
>  }
>  
> -static const struct mtd_ooblayout_ops micron_8_ooblayout = {
> +static const struct mtd_ooblayout_ops micron_grouped_ooblayout = {

Is this necessary? What does "grouped" means? Should we rename all
functions with _8_ in it to make sense?

>  	.ecc = micron_8_ooblayout_ecc,
>  	.free = micron_8_ooblayout_free,
>  };
> @@ -120,55 +120,55 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M79A 2Gb 1.8V */
>  	SPINAND_INFO("MT29F2G01ABBGD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M78A 1Gb 3.3V */
>  	SPINAND_INFO("MT29F1G01ABAFD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M78A 1Gb 1.8V */
>  	SPINAND_INFO("MT29F1G01ABAFD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M79A 4Gb 3.3V */
>  	SPINAND_INFO("MT29F4G01ADAGD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
>  	/* M70A 4Gb 3.3V */
> @@ -176,33 +176,33 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M70A 4Gb 1.8V */
>  	SPINAND_INFO("MT29F4G01ABBFD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M70A 8Gb 3.3V */
>  	SPINAND_INFO("MT29F8G01ADAFD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
>  	/* M70A 8Gb 1.8V */
> @@ -210,11 +210,11 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
>  };

Thanks,
Miquèl
