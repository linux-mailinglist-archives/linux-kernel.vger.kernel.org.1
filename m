Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF72A67DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgKDPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgKDPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:38:49 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C6C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:38:49 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so2787964wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B81fQ5xHaQ/yrMSa1yDIBHJseRR/8A0pHv9OArYo8cU=;
        b=wLzmKttuLo18fcXHfeCevLhrM1Pyh0Gu9tRhzivyTZs25wjTpa4zPDGh5k7v2lh4Fq
         NCofbJADTQb95FxFTO2zlFjxMtk+x7aRpi2PmBIeIkjSu1kubu0Jf1oFLWDvJvOuMosp
         PQBXzxI0oZghuk2Slk5F/WjhjvxEliLQjTzIkl8qK8soKNn9Nh4NXdhBHKbJiPv4tAQl
         sQsIyHTbLynCYzjW6NQ2BY2QyoJdYZ8kYCC2/DDrji1WrLe1H2Z27DgOCaTanNHgAjVt
         4XiD7wFKpea399ERBvoQTNR0d9hUCiqGI101/AKGsd9uOcZdo9VpeRa3j83urLZ2F5CE
         TV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B81fQ5xHaQ/yrMSa1yDIBHJseRR/8A0pHv9OArYo8cU=;
        b=AOx/dGD4RVfq1fOeZbAmUWkwTIDfOHbKska3e0q/eetfF2w6UWh/OLysSDa4U1tlN5
         hOMn5e94ZOwxpmffL+Tur1eMN502NelVP44bDOOIU0RYTSqsaGwyrHJbgFmyLT/u2nuf
         Aa4CRQQLNL+6QySJ/e6jfeqKDHjK+11MWfsnbuYemNzgGzxkTiA7+d1Rn6QIefBn7DLJ
         n9fSsaWj0d0mVvTvS00DqBp6P5vDbX18KpRspW6uKLcqGLbcNKKV1TFpu3pzBQjAE5F4
         c7N/YSmg4Jq3VS+I8VqwndsnytLgzY3lTJrlHtyDaNWXasJfCSl8jLUAL5QAEX6ZL94w
         Nxdg==
X-Gm-Message-State: AOAM530y9OyK2VpFdD7hB0kfEKQQjuDEllZGguYEyjKv9XrdLaiC0Fif
        DpOoRLryYyNTPaS7y9xFUev5TQ==
X-Google-Smtp-Source: ABdhPJwERh/SC3WoDOujs22lTdCpF33cv6JBegP3w6PqQpsREVN62NQow5YWY9qDcQaoLWm/J79wqA==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr5417896wmc.32.1604504327738;
        Wed, 04 Nov 2020 07:38:47 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v67sm2783592wma.17.2020.11.04.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:38:46 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:38:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 10/10] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20201104153845.GN4488@dell>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600770019-11585-11-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600770019-11585-11-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Merge different sub-devices I2C read/write functions into one Regmap,
> because PMIC and LDO part need CRC bits for access protection.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig       |   1 +
>  drivers/mfd/mt6360-core.c | 224 ++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 190 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df083..1dfe446 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -913,6 +913,7 @@ config MFD_MT6360
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> +	select CRC8
>  	depends on I2C
>  	help
>  	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 075b466..2ec9559 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -62,6 +62,18 @@ struct mt6360_ddata {
>  
>  #define MT6360_CRC8_POLYNOMIAL		0x7
>  
> +#define MT6360_CRC_I2C_ADDR_SIZE	1
> +#define MT6360_CRC_REG_ADDR_SIZE	1
> +/* prealloca read size = i2c device addr + i2c reg addr + val ... + crc8 */
> +#define MT6360_ALLOC_READ_SIZE(_size)	(_size + 3)
> +/* prealloca write size = i2c device addr + i2c reg addr + val ... + crc8 + dummy byte */
> +#define MT6360_ALLOC_WRITE_SIZE(_size)	(_size + 4)
> +#define MT6360_CRC_PREDATA_OFFSET	(MT6360_CRC_I2C_ADDR_SIZE + MT6360_CRC_REG_ADDR_SIZE)
> +#define MT6360_CRC_CRC8_SIZE		1
> +#define MT6360_CRC_DUMMY_BYTE_SIZE	1
> +#define MT6360_REGMAP_REG_BYTE_SIZE	2
> +#define I2C_ADDR_XLATE_8BIT(_addr, _rw)	(((_addr & 0x7F) << 1) + _rw)
> +
>  /* reg 0 -> 0 ~ 7 */
>  #define MT6360_CHG_TREG_EVT		4
>  #define MT6360_CHG_AICR_EVT		5
> @@ -266,12 +278,6 @@ static const struct regmap_irq_chip mt6360_irq_chip = {
>  	.use_ack = true,
>  };
>  
> -static const struct regmap_config mt6360_pmu_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = MT6360_PMU_MAXREG,
> -};
> -
>  static const struct resource mt6360_adc_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
>  };
> @@ -334,7 +340,7 @@ static const struct mfd_cell mt6360_devs[] = {
>  	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>  		    NULL, 0, 0, "mediatek,mt6360-led"),
>  	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-regulator"),
> +		    NULL, 0, 0, NULL),
>  	OF_MFD_CELL("mt6360-tcpc", NULL,
>  		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
> @@ -349,7 +355,7 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
>  		return ret;
>  
>  	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
> -		dev_err(&client->dev, "Device not supported\n");
> +		dev_err(ddata->dev, "Device not supported\n");

This seems like an unrelated change.

>  		return -ENODEV;
>  	}
>  
> @@ -358,11 +364,161 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
>  	return 0;
>  }
>  
> -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> -	MT6360_PMU_SLAVEID,
> +static const unsigned short mt6360_slave_addrs[MT6360_SLAVE_MAX] = {

Unrelated change.

> +	MT6360_TCPC_SLAVEID,
>  	MT6360_PMIC_SLAVEID,
>  	MT6360_LDO_SLAVEID,
> -	MT6360_TCPC_SLAVEID,
> +	MT6360_PMU_SLAVEID,
> +};
> +
> +static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
> +{
> +	/* Address is already in encoded [5:0] */
> +	*addr &= MT6360_ADDRESS_MASK;
> +
> +	switch (rw_size) {
> +	case 1:
> +		*addr |= MT6360_DATA_SIZE_1_BYTE;
> +		break;
> +	case 2:
> +		*addr |= MT6360_DATA_SIZE_2_BYTES;
> +		break;
> +	case 3:
> +		*addr |= MT6360_DATA_SIZE_3_BYTES;
> +		break;
> +	case 4:
> +		*addr |= MT6360_DATA_SIZE_4_BYTES;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
> +			      void *val, size_t val_size)
> +{
> +	struct mt6360_ddata *ddata = context;
> +	u8 bank = *(u8 *)reg;
> +	u8 reg_addr = *(u8 *)(reg + 1);
> +	struct i2c_client *i2c = ddata->i2c[bank];
> +	bool crc_needed = false;
> +	u8 *buf;
> +	int buf_len = MT6360_ALLOC_READ_SIZE(val_size);
> +	int read_size = val_size;
> +	u8 crc;
> +	int ret;
> +
> +	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
> +		crc_needed = true;
> +		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
> +		if (ret < 0)
> +			return ret;
> +		read_size += MT6360_CRC_CRC8_SIZE;
> +	}
> +
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_READ);
> +	buf[1] = reg_addr;
> +
> +	ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size,
> +					    buf + MT6360_CRC_PREDATA_OFFSET);
> +	if (ret < 0)
> +		goto out;
> +	else if (ret != read_size) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (crc_needed) {
> +		crc = crc8(ddata->crc8_tbl, buf, val_size + MT6360_CRC_PREDATA_OFFSET, 0);
> +		if (crc != buf[val_size + MT6360_CRC_PREDATA_OFFSET]) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +	}
> +
> +	memcpy(val, buf + MT6360_CRC_PREDATA_OFFSET, val_size);
> +out:
> +	kfree(buf);
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
> +{
> +	struct mt6360_ddata *ddata = context;
> +	u8 bank = *(u8 *)val;
> +	u8 reg_addr = *(u8 *)(val + 1);
> +	struct i2c_client *i2c = ddata->i2c[bank];
> +	bool crc_needed = false;
> +	u8 *buf;
> +	int buf_len = MT6360_ALLOC_WRITE_SIZE(val_size);
> +	int write_size = val_size - MT6360_REGMAP_REG_BYTE_SIZE;
> +	int ret;
> +
> +	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
> +		crc_needed = true;
> +		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size - MT6360_REGMAP_REG_BYTE_SIZE);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_WRITE);
> +	buf[1] = reg_addr;
> +	memcpy(buf + MT6360_CRC_PREDATA_OFFSET, val + MT6360_REGMAP_REG_BYTE_SIZE, write_size);
> +
> +	if (crc_needed) {
> +		buf[val_size] = crc8(ddata->crc8_tbl, buf, val_size, 0);
> +		write_size += (MT6360_CRC_CRC8_SIZE + MT6360_CRC_DUMMY_BYTE_SIZE);
> +	}
> +
> +	ret = i2c_smbus_write_i2c_block_data(i2c, reg_addr, write_size,
> +					     buf + MT6360_CRC_PREDATA_OFFSET);
> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct regmap_bus mt6360_regmap_bus = {
> +	.read		= mt6360_regmap_read,
> +	.write		= mt6360_regmap_write,
> +
> +	/* Due to PMIC and LDO CRC access size limit */
> +	.max_raw_read	= 4,
> +	.max_raw_write	= 4,
> +};
> +
> +static bool mt6360_is_readwrite_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MT6360_REG_TCPCSTART ... MT6360_REG_TCPCEND:
> +		fallthrough;
> +	case MT6360_REG_PMICSTART ... MT6360_REG_PMICEND:
> +		fallthrough;
> +	case MT6360_REG_LDOSTART ... MT6360_REG_LDOEND:
> +		fallthrough;
> +	case MT6360_REG_PMUSTART ... MT6360_REG_PMUEND:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config mt6360_regmap_config = {
> +	.reg_bits		= 16,
> +	.val_bits		= 8,
> +	.reg_format_endian	= REGMAP_ENDIAN_BIG,
> +	.max_register		= MT6360_REG_PMUEND,
> +	.writeable_reg		= mt6360_is_readwrite_reg,
> +	.readable_reg		= mt6360_is_readwrite_reg,
>  };
>  
>  static int mt6360_probe(struct i2c_client *client)
> @@ -375,9 +531,23 @@ static int mt6360_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	ddata->dev = &client->dev;
> -	i2c_set_clientdata(client, ddata);

Why aren't you saving the client data anymore?

> -	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
> +	for (i = 0; i < MT6360_SLAVE_MAX - 1; i++) {
> +		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
> +							  client->adapter,
> +							  mt6360_slave_addrs[i]);
> +		if (IS_ERR(ddata->i2c[i])) {
> +			dev_err(&client->dev,
> +				"Failed to get new dummy I2C device for address 0x%x",
> +				mt6360_slave_addrs[i]);
> +			return PTR_ERR(ddata->i2c[i]);
> +		}
> +	}
> +	ddata->i2c[MT6360_SLAVE_MAX - 1] = client;
> +
> +	crc8_populate_msb(ddata->crc8_tbl, MT6360_CRC8_POLYNOMIAL);
> +	ddata->regmap = devm_regmap_init(ddata->dev, &mt6360_regmap_bus, ddata,
> +					 &mt6360_regmap_config);
>  	if (IS_ERR(ddata->regmap)) {
>  		dev_err(&client->dev, "Failed to register regmap\n");
>  		return PTR_ERR(ddata->regmap);
> @@ -387,34 +557,18 @@ static int mt6360_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
> -				       0, 0, &mt6360_irq_chip,
> -				       &ddata->irq_data);
> +	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq, 0, 0,
> +				       &mt6360_irq_chip, &ddata->irq_data);

Unrelated change?

>  	if (ret) {
>  		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
>  		return ret;
>  	}
>  
> -	ddata->i2c[0] = client;
> -	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
> -		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
> -							client->adapter,
> -							mt6360_slave_addr[i]);
> -		if (IS_ERR(ddata->i2c[i])) {
> -			dev_err(&client->dev,
> -				"Failed to get new dummy I2C device for address 0x%x",
> -				mt6360_slave_addr[i]);
> -			return PTR_ERR(ddata->i2c[i]);
> -		}
> -		i2c_set_clientdata(ddata->i2c[i], ddata);
> -	}
> -

> -	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> -				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
> -				   0, regmap_irq_get_domain(ddata->irq_data));
> +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, mt6360_devs,
> +				   ARRAY_SIZE(mt6360_devs), NULL, 0,
> +				   regmap_irq_get_domain(ddata->irq_data));

Unrelated change?

>  	if (ret) {
> -		dev_err(&client->dev,
> -			"Failed to register subordinate devices\n");
> +		dev_err(&client->dev, "Failed to register subordinate devices\n");

Unrelated change?

You should remove all of these from this patch when you re-spin.

>  		return ret;
>  	}
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
