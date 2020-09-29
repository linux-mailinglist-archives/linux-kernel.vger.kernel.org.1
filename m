Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453C327CE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgI2NIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:08:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgI2NIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:08:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TD8gOU014639;
        Tue, 29 Sep 2020 08:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601384922;
        bh=RLGW+YFIRVUBvC5l28tX8bJsGKwv4jqEcGYCjkq2IFw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p5V7gkCSfgKohSXSEosrHGboPtUvYy+TBjs3Jv56Mb+8/tiYDdMyojAZi5t0cjG8Y
         GKcLN62ZIJ+DeotJu5DhNsUJbNZr1o1IOF7p2oEV/ExRI1btO59NHuxAzKcyWwyDQn
         eUO0F/I9MEwTpIc+F41J6OysuyTnt1uHrPRDxTko=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TD8gM8101901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 08:08:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 08:08:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 08:08:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TD8e22128959;
        Tue, 29 Sep 2020 08:08:41 -0500
Date:   Tue, 29 Sep 2020 18:38:40 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 11/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Message-ID: <20200929130838.4hfa2y3qoxissdus@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-12-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916124418.833-12-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 06:14PM, Pratyush Yadav wrote:
> Perform a Soft Reset on shutdown on flashes that support it so that the
> flash can be reset to its initial state and any configurations made by
> spi-nor (given that they're only done in volatile registers) will be
> reset. This will hand back the flash in pristine state for any further
> operations on it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c  | 41 +++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 6ee93544d72f..853dfa02f0de 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -40,6 +40,9 @@
>  
>  #define SPI_NOR_MAX_ADDR_WIDTH	4
>  
> +#define SPI_NOR_SRST_SLEEP_MIN 200
> +#define SPI_NOR_SRST_SLEEP_MAX 400
> +
>  /**
>   * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
>   *			   extension type.
> @@ -3174,6 +3177,41 @@ static int spi_nor_init(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +static void spi_nor_soft_reset(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	int ret;
> +
> +	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 8),

The buswidth used here should be 1 instead of 8. It makes no difference 
in practice because the call to spi_nor_spimem_setup_op() immediately 
after will over-write it to the correct value anyway, but let's follow 
the style followed throughout the rest of the codebase. Will fix in the 
next version.

> +			SPI_MEM_OP_NO_DUMMY,
> +			SPI_MEM_OP_NO_ADDR,
> +			SPI_MEM_OP_NO_DATA);
> +	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret) {
> +		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		return;
> +	}
> +
> +	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 8),

Same here.

> +			SPI_MEM_OP_NO_DUMMY,
> +			SPI_MEM_OP_NO_ADDR,
> +			SPI_MEM_OP_NO_DATA);
> +	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret) {
> +		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		return;
> +	}
> +
> +	/*
> +	 * Software Reset is not instant, and the delay varies from flash to
> +	 * flash. Looking at a few flashes, most range somewhere below 100
> +	 * microseconds. So, sleep for a range of 200-400 us.
> +	 */
> +	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
> +}
> +
>  /* mtd resume handler */
>  static void spi_nor_resume(struct mtd_info *mtd)
>  {

-- 
Regards,
Pratyush Yadav
Texas Instruments India
