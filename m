Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451C82DC1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLPONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLPOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:13:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:12:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so2491351wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbkhV7953m43b4fxi/DIYL/7q/Vv6JLSKCbvVuoSHUs=;
        b=W3BiChlSF/jv+fIgtl36pw4eIpjgEPhr6kWqVLUwY9ZjLMbdQn0YTfFIZhKzmYoxH/
         8ec3JjHzV0UpuJznO2hRFEUkQmRnw9B+TT9U+YqP+xF/k3Eqnw5EeBuF+7Cup8++Urps
         UygzvEadLmh8P8CxSwtvU4IiimMmbQDLGNruzrk4c7X5ZRrocjudX7Q8xpdjZ7KT3SXc
         65nL1I6goNDrK3iUQOVtqlNIWa+MaVqpKV9c/kouX5UFq60Pv1LbL1952bbXRGCN6JEP
         BkqlZqDSAiV8SQK6q2YAm/KjKOUma9bytzwL1E+CakdWl2SQ7Bs9jMvzQ6nRxfdvzbxh
         1XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbkhV7953m43b4fxi/DIYL/7q/Vv6JLSKCbvVuoSHUs=;
        b=KEIzZrHKbUE0IZf5AcHwlwXhQvfNJNLwJCn/xg0MoqL/CUKhnJmEbLi2WtUCVtCy+/
         g9xyoeWXfJ2t4rATmTTcRprZUUCozpB5voIw1Nkv0VhynOcD8cG7/c6jlcaG+NvqBsHP
         0SsV+wq4goQVAu5zHfN+KUR9Bs0XmFHF3odmYL4sa5FFcHyJU+8HIFaDJ+liLI4rofuW
         rLy0FSIS2vyN4+6zKzeiqW98Mxx0CiK5Q7K9HRMuVwnp7QGMmnEgq4EoQ6ftvVG+ncuS
         dyg8Bs/uPwUU+VQrT6kdB3gqzff18UP9wL6FYaJcvWwSkjfATZzIfBEAbZp2f+Sf/tgY
         KqXA==
X-Gm-Message-State: AOAM531cXmS+rhH5efB/cAHa4kxCSuR8bHOwpUbwRvq308OZ00lC38JL
        Z56OIWLrZSKg1rOeh5dZe7aWjA==
X-Google-Smtp-Source: ABdhPJymz7i0u9+Dcjrcxi1+FgcDjJyPk77qvtP4sIxXgmF7ZbWwO2UnRgWHZBIi1Mr62n3tOdjzSQ==
X-Received: by 2002:a1c:99d7:: with SMTP id b206mr3656673wme.12.1608127935961;
        Wed, 16 Dec 2020 06:12:15 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id k1sm3381479wrn.46.2020.12.16.06.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:12:15 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:12:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mfd: rt4831: Adds support for Richtek RT4831 MFD
 core
Message-ID: <20201216141213.GE207743@dell>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Dec 2020, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This adds support Richtek RT4831 MFD core. It includes four channel WLED driver

Drop mentions of MFD.  Just core driver will do.

> and Display Bias Voltage outputs.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v2
> - Refine Kconfig descriptions.
> - Add copyright.
> - Refine error logs in probe.
> - Refine comment lines in remove and shutdown.
> ---
>  drivers/mfd/Kconfig       |  10 ++++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rt4831-core.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 drivers/mfd/rt4831-core.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13..dfb2640 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1088,6 +1088,16 @@ config MFD_RDC321X
>  	  southbridge which provides access to GPIOs and Watchdog using the
>  	  southbridge PCI device configuration space.
>  
> +config MFD_RT4831
> +	tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This enables support for the Richtek RT4831 that includes 4 channel
> +	  WLED driving and Display Bias Voltage. It's commonly used to provide
> +	  power to the LCD display and LCD backlight.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 1780019..4108141 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
> +obj-$(CONFIG_MFD_RT4831)	+= rt4831-core.o

Why is this called -core ...

>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o

... and this isn't?

>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
> diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> new file mode 100644
> index 00000000..f837c06
> --- /dev/null
> +++ b/drivers/mfd/rt4831-core.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2020 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define RT4831_REG_REVISION	0x01
> +#define RT4831_REG_ENABLE	0x08
> +#define RT4831_REG_I2CPROT	0x15
> +
> +#define RICHTEK_VID		0x03
> +#define RT4831_VID_MASK		GENMASK(1, 0)
> +#define RT4831_RESET_MASK	BIT(7)
> +#define RT4831_I2CSAFETMR_MASK	BIT(0)
> +
> +static const struct mfd_cell rt4831_subdevs[] = {
> +	OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831-backlight"),
> +	MFD_CELL_NAME("rt4831-regulator")
> +};

Just a little note about these helpers.  I'm planning on unifying the
names pretty soon.  So if you have to rebase, please watch out for the
rename.

Essentially OF_MFD_CELL() will soon become MFD_CELL_OF().

> +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg >= RT4831_REG_REVISION && reg <= RT4831_REG_I2CPROT)
> +		return true;
> +	return false;
> +}
> +
> +static const struct regmap_config rt4831_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT4831_REG_I2CPROT,
> +
> +	.readable_reg = rt4831_is_accessible_reg,
> +	.writeable_reg = rt4831_is_accessible_reg,
> +};
> +
> +static int rt4831_probe(struct i2c_client *client)
> +{
> +	struct gpio_desc *enable;

My preference would be "enable_gpio" to ensure it's easily
identifiable further on.

> +	struct regmap *regmap;
> +	unsigned int val;

'val' is not a great name for a variable that is used for a specific
purpose.  How about 'revision'?

> +	int ret;
> +
> +	enable = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(enable)) {
> +		dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> +		return PTR_ERR(enable);
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> + 
> +	ret = regmap_read(regmap, RT4831_REG_REVISION, &val);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get H/W revision\n");
> +		return ret;
> +	}
> +
> +	if ((val & RT4831_VID_MASK) != RICHTEK_VID) {

What does VID stand for here?

The fact that I have to ask probably means it should be changed.

Variant ID perhaps?  If so, call the define 'VARIANT_ID'.

> +		dev_err(&client->dev, "VID not matched, val = 0x%02x\n", val);

Using variable names means nothing to the user.

"revision:  0x%02x" ?

> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Used to prevent the abnormal shutdown.
> +	 * If SCL/SDA both keep low for one second to reset HW.
> +	 */
> +	ret = regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2CSAFETMR_MASK,
> +				 RT4831_I2CSAFETMR_MASK);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to enable I2C safety timer\n");
> +		return ret;
> +	}
> +
> +	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt4831_subdevs,
> +				    ARRAY_SIZE(rt4831_subdevs), NULL, 0, NULL);
> +}
> +
> +static int rt4831_remove(struct i2c_client *client)
> +{
> +	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> +
> +	/* Disable WLED and DSV outputs */
> +	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> +}
> +
> +static void rt4831_shutdown(struct i2c_client *client)
> +{
> +	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> +
> +	/* Disable WLED and DSV outputs */
> +	regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> +}
> +
> +static const struct of_device_id __maybe_unused rt4831_of_match[] = {
> +	{ .compatible = "richtek,rt4831", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> +
> +static struct i2c_driver rt4831_driver = {
> +	.driver = {
> +		.name = "rt4831",
> +		.of_match_table = of_match_ptr(rt4831_of_match),

The trend is to not use of_match_ptr() anymore, as these devices can
not be instantiated using ACPI.

> +	},
> +	.probe_new = rt4831_probe,
> +	.remove = rt4831_remove,
> +	.shutdown = rt4831_shutdown,
> +};
> +module_i2c_driver(rt4831_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
