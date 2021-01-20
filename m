Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD32FD12B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbhATNMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:12:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbhATMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:30:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10KCT8Qn046086;
        Wed, 20 Jan 2021 06:29:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611145748;
        bh=FCU6nL+sxUW7VDNVPhVlbOjfkAkOKlUADidYLY/WIbU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=B5/xjmWq3G4pDNRmqpSZSl310yuyPr1FKcBiLDE6f2HmahDWB+VriIs1h21nC4f+k
         y2Q0Z9QlezDWu3i/9kdkA0t0fNwOZWCWqLKw+BRghIysai+q8YQ9uz5loRixcOgvRy
         rlgYpAQiKNIxEeajCLtJPfRTMlLb97ORTPGMP1pc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10KCT8cL090345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jan 2021 06:29:08 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 Jan 2021 06:29:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 Jan 2021 06:29:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10KCT7eQ039549;
        Wed, 20 Jan 2021 06:29:08 -0600
Date:   Wed, 20 Jan 2021 17:59:07 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Kavyasree.Kotagiri@microchip.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add Global Block Unlock command
Message-ID: <20210120122431.csvnwlb4ihqbuvoq@ti.com>
References: <20210120105411.254890-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210120105411.254890-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 20/01/21 12:54PM, Tudor Ambarus wrote:
> The Global Block Unlock command has different names depending
> on the manufacturer, but always the same command value: 0x98.
> Macronix's MX25U12835F names it Gang Block Unlock, Winbound's
> W25Q128FV names it Global Block Unlock and Microchip's
> SST26VF064B names it Global Block Protection Unlock.
> 
> Used in the Individual Block Protection mode, which is mutual

Nitpick: s/mutual/mutually/

> exclusive with the Block Protection mode (BP0-3).
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c  | 35 +++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h  |  1 +
>  include/linux/mtd/spi-nor.h |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 20df44b753da..cb275608cb7f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -853,6 +853,41 @@ int spi_nor_wait_till_ready(struct spi_nor *nor)
>  						    DEFAULT_READY_WAIT_JIFFIES);
>  }
>  
> +/**
> + * spi_nor_global_block_unlock() - Unlock Global Block Protection.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_global_block_unlock(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 1),

Set the buswidth to 0...

> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);

... and run the op through spi_nor_spimem_setup_op().

With this fixed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_GBULK,
> +						       NULL, 0);
> +	}
> +
> +	if (ret) {
> +		dev_dbg(nor->dev, "error %d on Global Block Unlock\n", ret);
> +		return ret;
> +	}
> +
> +	return spi_nor_wait_till_ready(nor);
> +}
> +
>  /**
>   * spi_nor_write_sr() - Write the Status Register.
>   * @nor:	pointer to 'struct spi_nor'.
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index d631ee299de3..eb26796db026 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -434,6 +434,7 @@ int spi_nor_write_disable(struct spi_nor *nor);
>  int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
>  int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
>  int spi_nor_wait_till_ready(struct spi_nor *nor);
> +int spi_nor_global_block_unlock(struct spi_nor *nor);
>  int spi_nor_lock_and_prep(struct spi_nor *nor);
>  void spi_nor_unlock_and_unprep(struct spi_nor *nor);
>  int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index d13958de6d8a..a0d572855444 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -53,6 +53,7 @@
>  #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
>  #define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
>  #define SPINOR_OP_SRST		0x99	/* Software Reset */
> +#define SPINOR_OP_GBULK		0x98    /* Global Block Unlock */
>  
>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */

-- 
Regards,
Pratyush Yadav
Texas Instruments India
