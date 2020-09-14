Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE672688A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgINJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:40:55 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41527 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:40:53 -0400
X-Originating-IP: 103.82.80.9
Received: from localhost (unknown [103.82.80.9])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6539C20002;
        Mon, 14 Sep 2020 09:40:47 +0000 (UTC)
Date:   Mon, 14 Sep 2020 15:10:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jungseung Lee <js07.lee@samsung.com>
Subject: Re: [PATCH v2 1/4] mtd: spi-nor: cleanup common code
Message-ID: <20200914094046.tccoc54n7e36zzyr@yadavpratyush.com>
References: <20200911222634.31804-1-michael@walle.cc>
 <20200911222634.31804-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911222634.31804-2-michael@walle.cc>
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

*sigh* This patch will cause a _lot_ of conflicts with my series [0]. It 
should hopefully go in the next merge window so maybe you can rebase on 
top of it? Dunno.

On 12/09/20 12:26AM, Michael Walle wrote:
> Introduce a spi_nor_simple_cmd() function which executes a SPI command
> with no additional argument bits. This function is then used to simplify
> many other functions.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c | 295 +++++++++++--------------------------
>  1 file changed, 84 insertions(+), 211 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3f76eb391719..b06b160a5c9c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -210,6 +210,72 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  	return nor->controller_ops->write(nor, to, len, buf);
>  }
>  

Comments on the spi_nor_simple_cmd* functions are assuming my series 
lands before yours.

> +/**
> + * spi_nor_simple_cmd() - send command byte
> + * @nor:	pointer to 'struct spi_nor'.
> + * @cmd:	command code
> + *
> + * Return: 0 on success, -errno otherwise
> + */
> +static int spi_nor_simple_cmd(struct spi_nor *nor, u8 cmd)
> +{
> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
> +					  SPI_MEM_OP_NO_ADDR,
> +					  SPI_MEM_OP_NO_DUMMY,
> +					  SPI_MEM_OP_NO_DATA);

You need to add a call to spi_nor_spimem_setup_op() here. See [1].

> +
> +	if (nor->spimem)
> +		return spi_mem_exec_op(nor->spimem, &op);
> +	else
> +		return nor->controller_ops->write_reg(nor, cmd, NULL, 0);

Use spi_nor_write_reg(). See [2].

> +}
> +
> +/**
> + * spi_nor_simple_cmd_dout() - send command byte and data
> + * @nor:	pointer to 'struct spi_nor'.
> + * @cmd:	command code
> + * @data:	pointer to the data to be send, must be DMA-capable
> + * @len:	length of the data
> + *
> + * Return: 0 on success, -errno otherwise
> + */
> +static int spi_nor_simple_cmd_dout(struct spi_nor *nor, u8 cmd, const u8 *data,
> +				   size_t len)
> +{
> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
> +					  SPI_MEM_OP_NO_ADDR,
> +					  SPI_MEM_OP_NO_DUMMY,
> +					  SPI_MEM_OP_DATA_OUT(len, data, 1));

You need to add a call to spi_nor_spimem_setup_op() here. See [1].

> +
> +	if (nor->spimem)
> +		return spi_mem_exec_op(nor->spimem, &op);
> +	else
> +		return nor->controller_ops->write_reg(nor, cmd, data, len);

Use spi_nor_write_reg(). See [2].

> +}
> +
> +/**
> + * spi_nor_simple_cmd_din() - send command byte and receive data
> + * @nor:	pointer to 'struct spi_nor'.
> + * @cmd:	command code
> + * @data:	pointer to the receive buffer, must be DMA-capable
> + * @len:	length of the data to be received
> + *
> + * Return: 0 on success, -errno otherwise
> + */
> +static int spi_nor_simple_cmd_din(struct spi_nor *nor, u8 cmd, u8 *data,
> +				  size_t len)
> +{
> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
> +					  SPI_MEM_OP_NO_ADDR,
> +					  SPI_MEM_OP_NO_DUMMY,
> +					  SPI_MEM_OP_DATA_IN(len, data, 1));
> +

You need to add a call to spi_nor_spimem_setup_op() here. See [1].

> +	if (nor->spimem)
> +		return spi_mem_exec_op(nor->spimem, &op);
> +	else
> +		return nor->controller_ops->read_reg(nor, cmd, data, len);

Use spi_nor_read_reg(). See [2].

> +}
> +
>  /**
>   * spi_nor_write_enable() - Set write enable latch with Write Enable command.
>   * @nor:	pointer to 'struct spi_nor'.

> @@ -280,19 +322,7 @@ static int spi_nor_read_sr(struct spi_nor *nor, 
> u8 *sr)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
> -						    sr, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDSR, sr, 1);

NACK! xSPI compliant flashes like Cypress S28HS512T can use address and 
dummy bytes for Read SR/SR2 (and I don't have an example in mind but 
likely FSR too) commands in 8D-8D-8D mode. See [3].

>  	if (ret)
>  		dev_dbg(nor->dev, "error %d reading SR\n", ret);
>  
> @@ -311,19 +341,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
> -						    fsr, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDFSR, fsr, 1);

Same.

>  	if (ret)
>  		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
>  
> @@ -343,18 +361,7 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, cr, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDCR, cr, 1);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d reading CR\n", ret);
>  
> @@ -371,26 +378,10 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>   */
>  int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  {
> +	u8 cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
> -						  SPINOR_OP_EN4B :
> -						  SPINOR_OP_EX4B,
> -						  1),
> -				  SPI_MEM_OP_NO_ADDR,
> -				  SPI_MEM_OP_NO_DUMMY,
> -				  SPI_MEM_OP_NO_DATA);
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor,
> -						     enable ? SPINOR_OP_EN4B :
> -							      SPINOR_OP_EX4B,
> -						     NULL, 0);
> -	}
> -
> +	ret = spi_nor_simple_cmd(nor, cmd);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
>  
> @@ -412,19 +403,7 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  
>  	nor->bouncebuf[0] = enable << 7;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
> -						     nor->bouncebuf, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
>  
> @@ -444,19 +423,7 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  
>  	nor->bouncebuf[0] = ear;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
> -						     nor->bouncebuf, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
>  
> @@ -475,19 +442,7 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
> -						    sr, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_XRDSR, sr, 1);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
>  
> @@ -520,19 +475,7 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
> -						     NULL, 0);
> -	}
> -
> +	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CLSR);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
>  }
> @@ -584,19 +527,7 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
> -						     NULL, 0);
> -	}
> -
> +	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CLFSR);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
>  }
> @@ -728,19 +659,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>  	if (ret)
>  		return ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> -						     sr, len);
> -	}
> -
> +	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WRSR, sr, len);
>  	if (ret) {
>  		dev_dbg(nor->dev, "error %d writing SR\n", ret);
>  		return ret;
> @@ -930,19 +849,7 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  	if (ret)
>  		return ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
> -						     sr2, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WRSR2, sr2, 1);
>  	if (ret) {
>  		dev_dbg(nor->dev, "error %d writing SR2\n", ret);
>  		return ret;
> @@ -964,19 +871,7 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>  {
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
> -						    sr2, 1);
> -	}
> -
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDSR2, sr2, 1);

Same.

>  	if (ret)
>  		dev_dbg(nor->dev, "error %d reading SR2\n", ret);
>  
> @@ -995,19 +890,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
>  
>  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
> -						     NULL, 0);
> -	}
> -
> +	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CHIP_ERASE);
>  	if (ret)
>  		dev_dbg(nor->dev, "error %d erasing chip\n", ret);
>  
> @@ -2064,18 +1947,8 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  	unsigned int i;
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> -						    SPI_NOR_MAX_ID_LEN);
> -	}
> +	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDID, id,
> +				     SPI_NOR_MAX_ID_LEN);

Same here but as of now SPI NOR does not read flash ID in 8D mode so 
this is OK for now I think.

>  	if (ret) {
>  		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
>  		return ERR_PTR(ret);

[0] https://lore.kernel.org/linux-mtd/20200903171313.18741-1-p.yadav@ti.com/
[1] https://lore.kernel.org/linux-mtd/20200903171313.18741-4-p.yadav@ti.com/
[2] https://lore.kernel.org/linux-mtd/20200903171313.18741-2-p.yadav@ti.com/
[3] https://lore.kernel.org/linux-mtd/20200903171313.18741-7-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
