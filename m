Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4352FDAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbhATU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbhATN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:56:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43671C061798
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:54:48 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CDD3922727;
        Wed, 20 Jan 2021 14:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611150885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cl0hy++h0E1NlJAISb8N0+U8zEIekjiaQOS7rsZtXGQ=;
        b=VAV7i0Sz2RnF0v400l1Pq+NCHtsyuImEgVDPflySCo7gND5vdQIBiayV423j7i8z/BFGsV
        ml4c7vhKA/syIRvhm3qVFZb6s+kQpwpvePmd/JX3DFhq8gBUvTR4t++gxMk5BlMCXoEYl5
        al664btMcPHHyNg08ZGQ9PNr29ZT7ek=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 14:54:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     vigneshr@ti.com, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Add Global Block Unlock command
In-Reply-To: <20210120131914.277363-1-tudor.ambarus@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <cc3d9962bb7afc39ca972dadebd7465b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-20 14:19, schrieb Tudor Ambarus:
> The Global Block Unlock command has different names depending
> on the manufacturer, but always the same command value: 0x98.
> Macronix's MX25U12835F names it Gang Block Unlock, Winbound's

Winbond

> W25Q128FV names it Global Block Unlock and Microchip's
> SST26VF064B names it Global Block Protection Unlock.
> 
> Used in the Individual Block Protection mode, which is mutually
> exclusive with the Block Protection mode (BP0-3).
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>

-michael

> ---
> v2:
> - s/mutual/mutually/
> - set the GBULK cmd buswidth to 0 and call spi_nor_spimem_setup_op()
> to update the it, because the op can can be issued in QPI mode as well.
> - add Pratyush's R-b tag
> 
>  drivers/mtd/spi-nor/core.c  | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h  |  1 +
>  include/linux/mtd/spi-nor.h |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 20df44b753da..e82732dd31e1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -853,6 +853,43 @@ int spi_nor_wait_till_ready(struct spi_nor *nor)
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
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
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
>  /* 4-byte address opcodes - used on Spansion and some Macronix 
> flashes. */
>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
