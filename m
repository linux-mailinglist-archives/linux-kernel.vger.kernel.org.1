Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B62A6BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgKDRou convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Nov 2020 12:44:50 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56937 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKDRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:44:50 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 42C8F1BF206;
        Wed,  4 Nov 2020 17:44:45 +0000 (UTC)
Date:   Wed, 4 Nov 2020 18:44:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, juliensu@mxic.com.tw,
        gch981213@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: macronix: Add support for MX35LFxGE4AD
Message-ID: <20201104184444.3fd2d52d@xps13>
In-Reply-To: <1604490442-9052-1-git-send-email-ycllin@mxic.com.tw>
References: <1604490442-9052-1-git-send-email-ycllin@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YouChing,

YouChing Lin <ycllin@mxic.com.tw> wrote on Wed,  4 Nov 2020 19:47:22
+0800:

> The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
> SLC NAND flash device (with on-die ECC).
> 
> Validated by read, erase, read back, write, read back and nandtest
> on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
> (drivers/spi/spi-mxic.c).
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/macronix.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index 8e801e4..4f7f954 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -119,6 +119,26 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
> +	SPINAND_INFO("MX35LF2GE4AD",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0 /*SPINAND_HAS_QE_BIT*/,

What is the purpose of this comment? Shouldn't get rid of it and just
keep '0' if the QE bit is not supported?

> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
> +	SPINAND_INFO("MX35LF4GE4AD",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
> +		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0 /*SPINAND_HAS_QE_BIT*/,

Ditto

> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
>  	SPINAND_INFO("MX31LF1GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),

Thanks,
Miquèl
