Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE1BBA27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD1Joc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 05:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbgD1Job (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:44:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B41C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:44:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so23879115wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3mcyPkmkSjp8xknBLNut0i1kfVwselHpxf7tv2G9+mM=;
        b=YN2LC5sHwCPT19OUZGQ3rgL8YE5RRQGgil8uEnG5ftD32j99vFyiYXX3toG5rKNnhM
         j+ROJYXR2TI0OW08EngGm3HUfanV+GXHSTykhfbqPGZ8/S42txuxgrr1Jg2jSAzxuDk3
         5yxuH3GhvC3WP10fICP0+NdNhDG77gcw67ukw4ZW2ED5OJ6+sYreJH1H08R9sJbDAsyp
         IW+/1+7YYqZ1MWfrTNG2jcMAbZeZQEymLAxj7khFvMbOjE0BSwdi/GqO/GE+cQnr2y/i
         QYzYuKMQqb6+n8Yn/c40ZyQxyo0gj1KaN0OVpBCLqkw1Gz13FKi9x8UynriqoUViP2Hn
         3cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3mcyPkmkSjp8xknBLNut0i1kfVwselHpxf7tv2G9+mM=;
        b=ATjaGu4rtbM9f/drvHcAJiRC7d5XG9Y+a+7qDbeWYYCI4aorItsa32LEehIYlaJD0p
         JFiQmr0D/w1+0sj5qapm0ZvwOBFJHiO2d06gNN3TmyRVR7xnDMFSkH2xX7sf7N/JRlLQ
         7HeIZOMhYj1sesVDnTcX3QO1OnXthKJNxqpjM/Ea0jiPmDqRhDSIGzimHLui8Wv4XPTG
         9a0t6xov/Q5DzoXFZZZC5QEQIfpHZ9Y1u+qOHOFWxfK8nhl0tMfWUs67r9MIvSH9B8+2
         wQX9KiKGMp7gMb2UlQVsFoEFgA8mO8O/JTnsRIyxkahRby6wxwo6EL2dirpe6Jc3Oqn0
         tDQg==
X-Gm-Message-State: AGi0PuYA2V3g0U8BH4izml+vSHCkh4U7JP2ExTDCkTwX49ALFUUQ/wMX
        oN3T43w980kFV5WSPmq5VbZxJQ==
X-Google-Smtp-Source: APiQypKLgmQ2n7wZ3d9TonUyoZIvK9+bkQjkSaH63/xloWSWL8SoeyzDZnsfCjkYJq7NJL+Y4rs7CA==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr30460277wrj.320.1588067069901;
        Tue, 28 Apr 2020 02:44:29 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id i129sm2718198wmi.20.2020.04.28.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:44:29 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:44:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 2/3] mfd: add Gateworks System Controller core driver
Message-ID: <20200428094426.GL3559@dell>
References: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
 <1585341214-25285-3-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585341214-25285-3-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Tim Harvey wrote:

> The Gateworks System Controller (GSC) is an I2C slave controller
> implemented with an MSP430 micro-controller whose firmware embeds the
> following features:
>  - I/O expander (16 GPIO's) using PCA955x protocol
>  - Real Time Clock using DS1672 protocol
>  - User EEPROM using AT24 protocol
>  - HWMON using custom protocol
>  - Interrupt controller with tamper detect, user pushbotton
>  - Watchdog controller capable of full board power-cycle
>  - Power Control capable of full board power-cycle
> 
> see http://trac.gateworks.com/wiki/gsc for more details
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v8:
> - whitespace fixes
> - describe sub-devices in Kconfig
> - add error print for invalid command
> - update copyright
> - use devm_of_platform_populate
> - use probe_new
> - move hwmon's regmap init to hwmon
> 
> v7:
> - remove irq from private data struct
> 
> v6:
> - remove duplicate signature and fix commit log
> 
> v5:
> - simplify powerdown function
> 
> v4:
> - remove hwmon max reg check/define
> - fix powerdown function
> 
> v3:
> - rename gsc->gateworks-gsc
> - remove uncecessary include for linux/mfd/core.h
> - upercase I2C in comments
> - remove i2c debug
> - remove uncecessary comments
> - don't use KBUILD_MODNAME for name
> - remove unnecessary v1/v2/v3 tracking
> - unregister hwmon i2c adapter on remove
> 
> v2:
> - change license comment block style
> - remove COMPILE_TEST (Randy)
> - fixed whitespace issues
> - replaced a printk with dev_err
> ---
>  MAINTAINERS                 |   8 ++
>  drivers/mfd/Kconfig         |  10 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/gateworks-gsc.c | 288 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/gsc.h     |  73 +++++++++++
>  5 files changed, 380 insertions(+)
>  create mode 100644 drivers/mfd/gateworks-gsc.c
>  create mode 100644 include/linux/mfd/gsc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56765f5..bb79b60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6839,6 +6839,14 @@ F:	tools/testing/selftests/futex/
>  F:	tools/perf/bench/futex*
>  F:	Documentation/*futex*
>  
> +GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
> +M:	Tim Harvey <tharvey@gateworks.com>
> +M:	Robert Jones <rjones@gateworks.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +F:	drivers/mfd/gateworks-gsc.c
> +F:	include/linux/mfd/gsc.h
> +
>  GCC PLUGINS
>  M:	Kees Cook <keescook@chromium.org>
>  R:	Emese Revfy <re.emese@gmail.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4209008..d84725a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -407,6 +407,16 @@ config MFD_EXYNOS_LPASS
>  	  Select this option to enable support for Samsung Exynos Low Power
>  	  Audio Subsystem.
>  
> +config MFD_GATEWORKS_GSC
> +	tristate "Gateworks System Controller"
> +	depends on (I2C && OF)
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Enable support for the Gateworks System Controller found
> +	  on Gateworks Single Board Computers.

Please expand on the help section some more.  What is the purpose of
the device?  What sub-devices make up the GSC?  What does this device
driver offer/provide?

>  config MFD_MC13XXX
>  	tristate
>  	depends on (SPI_MASTER || I2C)
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index aed99f0..c82b442 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
>  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
> +obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
>  
>  obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
>  obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
> diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
> new file mode 100644
> index 00000000..020e1e1
> --- /dev/null
> +++ b/drivers/mfd/gateworks-gsc.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Gateworks System Controller (GSC) is a multi-function
> + * device designed for use in Gateworks Single Board Computers.
> + * The control interface is I2C, with an interrupt. The device supports
> + * system functions such as pushbutton monitoring, multiple ADC's for
> + * voltage and temperature, fan controller, and watchdog monitor.

Looks like good information for the help.

> + * Copyright (C) 2020 Gateworks Corporation
> + */

Nit: '\n' here.

> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/gsc.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The GSC suffers from an errata where occasionally during
> + * ADC cycles the chip can NAK I2C transactions. To ensure we have reliable
> + * register access we place retries around register access.
> + */
> +#define I2C_RETRIES	3
> +
> +static int gsc_regmap_regwrite(void *context, unsigned int reg,
> +			       unsigned int val)
> +{
> +	struct i2c_client *client = context;
> +	int retry, ret;
> +
> +	for (retry = 0; retry < I2C_RETRIES; retry++) {
> +		ret = i2c_smbus_write_byte_data(client, reg, val);
> +		/*
> +		 * -EAGAIN returned when the i2c host controller is busy
> +		 * -EIO returned when i2c device is busy
> +		 */
> +		if (ret != -EAGAIN && ret != -EIO)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gsc_regmap_regread(void *context, unsigned int reg,
> +			      unsigned int *val)
> +{
> +	struct i2c_client *client = context;
> +	int retry, ret;
> +
> +	for (retry = 0; retry < I2C_RETRIES; retry++) {
> +		ret = i2c_smbus_read_byte_data(client, reg);
> +		/*
> +		 * -EAGAIN returned when the i2c host controller is busy
> +		 * -EIO returned when i2c device is busy
> +		 */
> +		if (ret != -EAGAIN && ret != -EIO)
> +			break;
> +	}
> +	*val = ret & 0xff;
> +
> +	return 0;
> +}
> +
> +/*
> + * gsc_powerdown - API to use GSC to power down board for a specific time
> + *
> + * secs - number of seconds to remain powered off
> + */
> +static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
> +{
> +	int ret;
> +	unsigned char regs[4];
> +
> +	dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
> +		 secs);
> +
> +	regs[0] = secs & 0xff;
> +	regs[1] = (secs >> 8) & 0xff;
> +	regs[2] = (secs >> 16) & 0xff;
> +	regs[3] = (secs >> 24) & 0xff;

Would put_unaligned_{b,l}e32() make sense here?

> +	ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
> +	if (ret)
> +		return ret;
> +
> +	regs[0] = 1 << GSC_CTRL_1_LATCH_SLEEP_ADD;

BIT()

Why does this value need to be loaded into a variable?

> +	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
> +	if (ret)
> +		return ret;
> +
> +	regs[0] = (1 << GSC_CTRL_1_ACTIVATE_SLEEP) |
> +		(1 << GSC_CTRL_1_SLEEP_ENABLE);

BIT()

> +	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
> +
> +	return ret;
> +}
> +
> +static ssize_t gsc_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(dev);
> +	const char *name = attr->attr.name;
> +	int rz = 0;
> +
> +	if (strcasecmp(name, "fw_version") == 0)
> +		rz = sprintf(buf, "%d\n", gsc->fwver);
> +	else if (strcasecmp(name, "fw_crc") == 0)
> +		rz = sprintf(buf, "0x%04x\n", gsc->fwcrc);
> +	else
> +		dev_err(dev, "invalid command: '%s'\n", name);
> +
> +	return rz;
> +}
> +
> +static ssize_t gsc_store(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(dev);
> +	const char *name = attr->attr.name;
> +	long value;
> +
> +	if (strcasecmp(name, "powerdown") == 0) {
> +		if (kstrtol(buf, 0, &value) == 0)
> +			gsc_powerdown(gsc, value);
> +	} else {
> +		dev_err(dev, "invalid command: '%s\n", name);
> +	}
> +
> +	return count;
> +}
> +
> +static struct device_attribute attr_fwver =
> +	__ATTR(fw_version, 0440, gsc_show, NULL);
> +static struct device_attribute attr_fwcrc =
> +	__ATTR(fw_crc, 0440, gsc_show, NULL);
> +static struct device_attribute attr_pwrdown =
> +	__ATTR(powerdown, 0220, NULL, gsc_store);
> +
> +static struct attribute *gsc_attrs[] = {
> +	&attr_fwver.attr,
> +	&attr_fwcrc.attr,
> +	&attr_pwrdown.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = gsc_attrs,
> +};
> +
> +static const struct of_device_id gsc_of_match[] = {
> +	{ .compatible = "gw,gsc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gsc_of_match);
> +
> +static const struct regmap_config gsc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_NONE,
> +	.max_register = 0xf,

Nicer if this was defined as part of an enum of registers I think.

> +};
> +
> +static const struct regmap_irq gsc_irqs[] = {
> +	REGMAP_IRQ_REG(GSC_IRQ_PB, 0, BIT(GSC_IRQ_PB)),
> +	REGMAP_IRQ_REG(GSC_IRQ_KEY_ERASED, 0, BIT(GSC_IRQ_KEY_ERASED)),
> +	REGMAP_IRQ_REG(GSC_IRQ_EEPROM_WP, 0, BIT(GSC_IRQ_EEPROM_WP)),
> +	REGMAP_IRQ_REG(GSC_IRQ_RESV, 0, BIT(GSC_IRQ_RESV)),
> +	REGMAP_IRQ_REG(GSC_IRQ_GPIO, 0, BIT(GSC_IRQ_GPIO)),
> +	REGMAP_IRQ_REG(GSC_IRQ_TAMPER, 0, BIT(GSC_IRQ_TAMPER)),
> +	REGMAP_IRQ_REG(GSC_IRQ_WDT_TIMEOUT, 0, BIT(GSC_IRQ_WDT_TIMEOUT)),
> +	REGMAP_IRQ_REG(GSC_IRQ_SWITCH_HOLD, 0, BIT(GSC_IRQ_SWITCH_HOLD)),
> +};
> +
> +static const struct regmap_irq_chip gsc_irq_chip = {
> +	.name = "gateworks-gsc",
> +	.irqs = gsc_irqs,
> +	.num_irqs = ARRAY_SIZE(gsc_irqs),
> +	.num_regs = 1,
> +	.status_base = GSC_IRQ_STATUS,
> +	.mask_base = GSC_IRQ_ENABLE,
> +	.mask_invert = true,
> +	.ack_base = GSC_IRQ_STATUS,
> +	.ack_invert = true,
> +};
> +
> +static int gsc_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct gsc_dev *gsc;
> +	int ret;
> +	unsigned int reg;
> +
> +	gsc = devm_kzalloc(dev, sizeof(*gsc), GFP_KERNEL);
> +	if (!gsc)
> +		return -ENOMEM;
> +
> +	gsc->dev = &client->dev;
> +	gsc->i2c = client;
> +	i2c_set_clientdata(client, gsc);
> +
> +	gsc->bus.reg_write = gsc_regmap_regwrite;
> +	gsc->bus.reg_read = gsc_regmap_regread;

Why do you need to store these in ddata?

> +	gsc->regmap = devm_regmap_init(dev, &gsc->bus, client,
> +				       &gsc_regmap_config);
> +	if (IS_ERR(gsc->regmap))
> +		return PTR_ERR(gsc->regmap);
> +
> +	if (regmap_read(gsc->regmap, GSC_FW_VER, &reg))
> +		return -EIO;
> +	gsc->fwver = reg;
> +
> +	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
> +	gsc->fwcrc = reg;
> +	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
> +	gsc->fwcrc |= reg << 8;
> +
> +	gsc->i2c_hwmon = i2c_new_dummy_device(client->adapter, GSC_HWMON);
> +	if (!gsc->i2c_hwmon) {
> +		dev_err(dev, "Failed to allocate I2C device for HWMON\n");
> +		return -ENODEV;
> +	}
> +	i2c_set_clientdata(gsc->i2c_hwmon, gsc);

You already have this set.

Just 'get' it from client->dev.parent (or whatever it is).

> +	ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0,
> +				       &gsc_irq_chip, &gsc->irq_chip_data);
> +	if (ret)
> +		goto err_regmap;
> +
> +	dev_info(dev, "Gateworks System Controller v%d: fw 0x%04x\n",
> +		 gsc->fwver, gsc->fwcrc);
> +
> +	ret = sysfs_create_group(&dev->kobj, &attr_group);
> +	if (ret)
> +		dev_err(dev, "failed to create sysfs attrs\n");
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		goto err_sysfs;
> +
> +	return 0;
> +
> +err_sysfs:
> +	sysfs_remove_group(&dev->kobj, &attr_group);
> +err_regmap:
> +	i2c_unregister_device(gsc->i2c_hwmon);

If you use devm_* you can omit this line.

> +	return ret;
> +}
> +
> +static int gsc_remove(struct i2c_client *client)
> +{
> +	struct gsc_dev *gsc = i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&client->dev.kobj, &attr_group);
> +	i2c_unregister_device(gsc->i2c_hwmon);

If you use devm_* you can omit this line.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id gsc_id_table[] = {
> +	{"gsc", GSC_MISC },

Space after the '{'.

> +	{ /* sentinel */ }

No need for this comment.

> +};
> +MODULE_DEVICE_TABLE(i2c, gsc_id_table);
> +
> +static struct i2c_driver gsc_driver = {
> +	.driver = {
> +		.name	= "gateworks-gsc",
> +		.of_match_table = gsc_of_match,
> +	},
> +	.id_table	= gsc_id_table,
> +	.probe_new	= gsc_probe,
> +	.remove		= gsc_remove,
> +};
> +

Nit: Superfluous '\n'.

> +module_i2c_driver(gsc_driver);
> +
> +MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
> +MODULE_DESCRIPTION("I2C Core interface for GSC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/gsc.h b/include/linux/mfd/gsc.h
> new file mode 100644
> index 00000000..fc33647
> --- /dev/null
> +++ b/include/linux/mfd/gsc.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2020 Gateworks Corporation
> + */
> +#ifndef __LINUX_MFD_GSC_H_
> +#define __LINUX_MFD_GSC_H_
> +
> +#include <linux/regmap.h>
> +
> +/* Device Addresses */
> +#define GSC_MISC	0x20
> +#define GSC_UPDATE	0x21
> +#define GSC_GPIO	0x23
> +#define GSC_HWMON	0x29
> +#define GSC_EEPROM0	0x50
> +#define GSC_EEPROM1	0x51
> +#define GSC_EEPROM2	0x52
> +#define GSC_EEPROM3	0x53
> +#define GSC_RTC		0x68
> +
> +/* Register offsets */
> +#define GSC_CTRL_0	0x00
> +#define GSC_CTRL_1	0x01
> +#define GSC_TIME	0x02
> +#define GSC_TIME_ADD	0x06
> +#define GSC_IRQ_STATUS	0x0A
> +#define GSC_IRQ_ENABLE	0x0B
> +#define GSC_FW_CRC	0x0C
> +#define GSC_FW_VER	0x0E
> +#define GSC_WP		0x0F
> +
> +/* Bit definitions */
> +#define GSC_CTRL_0_PB_HARD_RESET	0
> +#define GSC_CTRL_0_PB_CLEAR_SECURE_KEY	1
> +#define GSC_CTRL_0_PB_SOFT_POWER_DOWN	2
> +#define GSC_CTRL_0_PB_BOOT_ALTERNATE	3
> +#define GSC_CTRL_0_PERFORM_CRC		4
> +#define GSC_CTRL_0_TAMPER_DETECT	5
> +#define GSC_CTRL_0_SWITCH_HOLD		6
> +
> +#define GSC_CTRL_1_SLEEP_ENABLE		0
> +#define GSC_CTRL_1_ACTIVATE_SLEEP	1
> +#define GSC_CTRL_1_LATCH_SLEEP_ADD	2
> +#define GSC_CTRL_1_SLEEP_NOWAKEPB	3
> +#define GSC_CTRL_1_WDT_TIME		4
> +#define GSC_CTRL_1_WDT_ENABLE		5
> +#define GSC_CTRL_1_SWITCH_BOOT_ENABLE	6
> +#define GSC_CTRL_1_SWITCH_BOOT_CLEAR	7
> +
> +#define GSC_IRQ_PB			0
> +#define GSC_IRQ_KEY_ERASED		1
> +#define GSC_IRQ_EEPROM_WP		2
> +#define GSC_IRQ_RESV			3
> +#define GSC_IRQ_GPIO			4
> +#define GSC_IRQ_TAMPER			5
> +#define GSC_IRQ_WDT_TIMEOUT		6
> +#define GSC_IRQ_SWITCH_HOLD		7
> +
> +struct gsc_dev {
> +	struct device *dev;
> +
> +	struct i2c_client *i2c;		/* 0x20: interrupt controller, WDT */
> +	struct i2c_client *i2c_hwmon;	/* 0x29: hwmon, fan controller */
> +
> +	struct regmap *regmap;
> +	struct regmap_bus bus;
> +	struct regmap_irq_chip_data *irq_chip_data;

What is this used by?

> +
> +	unsigned int fwver;
> +	unsigned short fwcrc;
> +};

Please ensure all of these properties are used outside of .probe().

If they're not, please remove them.

> +#endif /* __LINUX_MFD_GSC_H_ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
