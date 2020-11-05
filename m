Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857F12A77A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKEG7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Nov 2020 01:59:05 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47441 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgKEG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:59:04 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E9264E000A;
        Thu,  5 Nov 2020 06:58:59 +0000 (UTC)
Date:   Thu, 5 Nov 2020 07:58:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: macronix: Add support for MX35LFxGE4AD
Message-ID: <20201105075858.404bae3b@xps13>
In-Reply-To: <1604540593-9829-1-git-send-email-ycllin@mxic.com.tw>
References: <1604540593-9829-1-git-send-email-ycllin@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YouChing,

YouChing Lin <ycllin@mxic.com.tw> wrote on Thu,  5 Nov 2020 09:43:13
+0800:

> The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
> SLC NAND flash device (with on-die ECC).
> 
> Validated by read, erase, read back, write, read back and nandtest
> on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
> (drivers/spi/spi-mxic.c).
> 
> v2: Removed the unnecessary "/*SPINAND_HAS_QE_BIT*/" as per the comments.
> 
> v1: Add support for MX35LFxGE4AD

You cannot put the changelog here. Everything you write above the three
dashes will be part of the final commit message and we don't want this
to appear.

> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
> ---

V2: ...
v1: ...

should be located here

>  drivers/mtd/nand/spi/macronix.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index 8e801e4..3786b1b 100644
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
> +		     0,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
> +	SPINAND_INFO("MX35LF4GE4AD",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
> +		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
>  	SPINAND_INFO("MX31LF1GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),

Thanks,
Miquèl
