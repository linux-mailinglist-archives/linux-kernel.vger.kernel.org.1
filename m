Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C782E9259
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhADJJH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 04:09:07 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52977 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhADJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:09:06 -0500
X-Originating-IP: 90.89.98.255
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4F7661BF215;
        Mon,  4 Jan 2021 09:08:20 +0000 (UTC)
Date:   Mon, 4 Jan 2021 10:08:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ian Goegebuer <goegebuer@google.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        "Ronald G . Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one
 or more colons
Message-ID: <20210104100819.1d623425@xps13>
In-Reply-To: <20201223215630.1917891-1-goegebuer@google.com>
References: <1887c783-7a80-a71c-949f-c07c83c2d0fe@ti.com>
        <20201223215630.1917891-1-goegebuer@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ian, 

Ian Goegebuer <goegebuer@google.com> wrote on Wed, 23 Dec 2020 13:56:30
-0800:

> On Intel platforms, the usable SPI area is located several
> MiB in from the start, to leave room for descriptors and
> the Management Engine binary. Further, not all the remaining
> space can be used, as the last 16 MiB contains firmware.
> 
> To make the SPI usable for mtdblock and other devices,
> it is necessary to enable command line partitions so the
> middle usable region can be specified.
> 
> Add a part_probes array which includes only "cmdelineparts",
> and change to mtd_device_parse_register to use this part_probes.

The commit title seem to be taken from another patch and does not
match the below change. Or am I missing something?

> Signed-off-by: "Ronald G. Minnich" <rminnich@google.com>
> Signed-off-by: Ian Goegebuer <goegebuer@google.com>
> ---
>  drivers/mtd/spi-nor/controllers/intel-spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> index b54a56a68100..9de38851c411 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> @@ -903,6 +903,8 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
>  	.erase = intel_spi_erase,
>  };
>  
> +static const char * const part_probes[] = { "cmdlinepart", NULL };
> +
>  struct intel_spi *intel_spi_probe(struct device *dev,
>  	struct resource *mem, const struct intel_spi_boardinfo *info)
>  {
> @@ -950,7 +952,8 @@ struct intel_spi *intel_spi_probe(struct device *dev,
>  	if (!ispi->writeable || !writeable)
>  		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
>  
> -	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
> +	ret = mtd_device_parse_register(&ispi->nor.mtd, part_probes,
> +					NULL, &part, 1);
>  	if (ret)
>  		return ERR_PTR(ret);
>  

Thanks,
Miquèl
