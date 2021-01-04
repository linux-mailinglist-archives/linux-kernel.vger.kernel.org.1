Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91752E9702
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhADOSc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 09:18:32 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57357 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbhADOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:18:32 -0500
X-Originating-IP: 90.89.98.255
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AA3D42000C;
        Mon,  4 Jan 2021 14:17:47 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:17:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 1/1] mtd: spinand: add support for Foresee FS35ND01G
Message-ID: <20210104151746.21cdde24@xps13>
In-Reply-To: <20201229055059.2255021-2-daniel@0x0f.com>
References: <20201229055059.2255021-1-daniel@0x0f.com>
        <20201229055059.2255021-2-daniel@0x0f.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Tue, 29 Dec 2020 14:50:59
+0900:

> Add support for the Foresee FS35ND01G manufactured by Longsys.

Thanks for contributing this back!

Perhaps giving the link of the datasheet here makes sense.

> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/mtd/nand/spi/Makefile  |  2 +-
>  drivers/mtd/nand/spi/core.c    |  1 +
>  drivers/mtd/nand/spi/longsys.c | 45 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |  1 +
>  4 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/longsys.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 9662b9c1d5a9..1d6819022e43 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
> +spinand-objs := core.o gigadevice.o longsys.o macronix.o micron.o paragon.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8ea545bb924d..bdc9cd45d232 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -856,6 +856,7 @@ static const struct nand_ops spinand_ops = {
>  
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&gigadevice_spinand_manufacturer,
> +	&longsys_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
> new file mode 100644
> index 000000000000..f18271f8e9d2
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/longsys.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Daniel Palmer <daniel@thingy.jp>
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_LONGSYS		0xcd

Nitpick: I personally prefer uppercase hex numbers.

> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static const struct spinand_info longsys_spinand_table[] = {
> +	SPINAND_INFO("FS35ND01G",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xea, 0x11),

Ditto

> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),

This device probably supports more variants (especially dual/quad
ones) but I guess it's not a problem to not have them here right now.

> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(NULL,
> +				     NULL)),

You should define the ->ecc and ->free hooks of the
mtd_ooblayout_ops structure and point to it here. It defines the free
OOB bytes and bytes used by the on-die ECC engine. You should find this
in the datasheet. You may look at other manufacturer drivers for
examples of how it should be implemented. It is the way to tell the
upper layers that eg. "byte 2 to 17 are ECC bytes, 18 until the end are
free to use".

> +};
> +
> +static const struct spinand_manufacturer_ops longsys_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer longsys_spinand_manufacturer = {
> +	.id = SPINAND_MFR_LONGSYS,
> +	.name = "Longsys",
> +	.chips = longsys_spinand_table,
> +	.nchips = ARRAY_SIZE(longsys_spinand_table),
> +	.ops = &longsys_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6bb92f26833e..8651e63a2f8a 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -239,6 +239,7 @@ struct spinand_manufacturer {
>  
>  /* SPI NAND manufacturers */
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
> +extern const struct spinand_manufacturer longsys_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;

Looks fine otherwise :)

Thanks,
Miquèl
