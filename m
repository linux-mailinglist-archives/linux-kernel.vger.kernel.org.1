Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB442C4576
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgKYQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgKYQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:42:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:42:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so2736290wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PQUtq6hJSimzE8WZfFkzN1SUUldm6vjz6Pr4ps943Rg=;
        b=G0r4vcyGA0EADIUIVnlxBU3FG7vSxOZe2ohRsL+YRGpu6jwTAaggTzl8ON3sB3vjo/
         brEONCLCHIiE831Ggbcc3TfCBUwLkt9Jt7zrQLFQTpA+e/NFYQDhXNS1b9z29DXBJW0m
         f3jIgBsuj1VXhj9JU+Y6d0uNpY63J9O58AT1vyVngp9UNJ1MQR8c2FRQcOvmVf2kfto5
         IudCnFd9sj6HTDsDi0sXyeRFTT4FR/59kc98mwEaFlfT456R7WCTzpzsuajUM8naE9yi
         6sJovlBjGw3AsODAzeh8qCgeFYQNq6P8kFBc+wz3uV0rk8QD6kgDAXhBMXl01lHm2Unu
         dP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PQUtq6hJSimzE8WZfFkzN1SUUldm6vjz6Pr4ps943Rg=;
        b=HPDixvwDr/JOiO50ug3dbeLqZfjiKK5NEXvzw0DSixEvA0ldritDUh+8QkqfzP5BAV
         tosldunmuQ5Pv2eiDZ46DoPE4Sgs0HnJDugt4EejqF3Lm3IgJ1iF3M1GBGu7A/TMx7Av
         kKHQS3gRRN6kuIiqqp4VJyXs+KZszxdXCVRPnHsaZ7Crde9NFzenLWUpXCoJajFweOME
         NyF33vXGwUmXkDii51LBDSkPpLSX0x/ehMxdFob9FoqJ6OjjZMLNy2xlNUeeiodooQwB
         L7KayDkxtrZtD6vmVqylL+0rukYPmGe+zCfT8gFzBNBCCM+5mwbTDa4sCIWefT8wO2o+
         jAHg==
X-Gm-Message-State: AOAM532ajK1Z6eqCoeKwRwSJXi/KuD41uY/jLqrssGKcYpPTgwqt7VMs
        6XfCNBc2aIjkzRw971iVKHy/Yg==
X-Google-Smtp-Source: ABdhPJwzCQ2/SBqweNKUbNBEynyRrfzSvQXTurR2zrrkddkpICdEfNVFIwzxB8Ep/o0QAIrmHE8R9Q==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr4990739wmi.118.1606322530077;
        Wed, 25 Nov 2020 08:42:10 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id e14sm5546412wrm.84.2020.11.25.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:42:09 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:42:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD
 core
Message-ID: <20201125164207.GD4716@dell>
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds support Richtek RT4831 MFD core.
> RT4831 includes backlight and DSV part that can provode display panel
> for postive and negative voltage and WLED driving.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/mfd/Kconfig       |  11 +++++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/mfd/rt4831-core.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13..a22f002 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1088,6 +1088,17 @@ config MFD_RDC321X
>  	  southbridge which provides access to GPIOs and Watchdog using the
>  	  southbridge PCI device configuration space.
>  
> +config MFD_RT4831
> +	tristate "Richtek RT4831 WLED and DSV IC"

Please expand on WLED and DSV.

This is documentation and should leave nothing to the imagination.

> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This enables support for the Richtek RT4831.
> +	  RT4831 includes WLED driver and DisplayBias voltage(+/-) regulator.
> +	  It's common used to provide the display power and to drive the
> +	  display backlight WLED.

Please don't line-wrap unnecessarily.

Please re-work the last sentence, as it doesn't quite make sense.

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
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
> diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> new file mode 100644
> index 00000000..5342959
> --- /dev/null
> +++ b/drivers/mfd/rt4831-core.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0+

No copyright?

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
> +
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
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	enable = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(enable)) {
> +		dev_err(&client->dev, "Failed to get chip enable gpio\n");

"Failed to get 'enable' GPIO chip"

> +		return PTR_ERR(enable);
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to init regmap\n");

"initialise"

> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = regmap_read(regmap, RT4831_REG_REVISION, &val);
> +	if (ret) {
> +		dev_err(&client->dev, "Fail to get version id\n");

"Failed to get H/W revision"

> +		return ret;
> +	}
> +
> +	if ((val & RT4831_VID_MASK) != RICHTEK_VID) {
> +		dev_err(&client->dev, "VID not matched, val = 0x%02x\n", val);
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
> +	/* Make sure all off before module removal */

"Disable all <thing your disabling> are disabled before ..."

> +	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> +}
> +
> +static void rt4831_shutdown(struct i2c_client *client)
> +{
> +	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> +
> +	/* Make sure all off before machine shutdown */

As above.

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
