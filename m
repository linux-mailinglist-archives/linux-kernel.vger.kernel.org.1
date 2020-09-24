Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DEB2766BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgIXDGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgIXDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:06:15 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919FC0613CE;
        Wed, 23 Sep 2020 20:06:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i17so2131873oig.10;
        Wed, 23 Sep 2020 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKvj7PNebl1pwBbwjLcg7LPGpeU6dsk0+5GMEfBC318=;
        b=JWaEvSIiN96ozuP3NNvNGwmtRbWIxA4zv+874uiIaMd1APXl4FKLyXkNxqocyWyLtV
         0/v5dF4HZBd2x+AZhS2zs8fL2Mzc7g47ooV4IRMUj4cuR8N/qizHSCjWMmjx2GQ5d5iO
         s3ZITO23GXrMYC9X/La+S9ASex6RoEZuTcXft390eIvPOfEHTkO712n6PJbuEkT8GFtG
         XlepVxXgJ5wu3iLsXaMlLH1E9sf5/RoVg1cxfrbyu6YAd3aHlDtwuQIbhL1To++8z+jr
         2m8atr2qXRx/5D1g4AU/QzezcbtaR/Tw8a5wPLGZqZd61mZ6ol2Dy+OIBnxeW/KOAMVX
         xMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKvj7PNebl1pwBbwjLcg7LPGpeU6dsk0+5GMEfBC318=;
        b=K+S0gbacj6D9mnFC0VVwKbV/0jE9sFLmJemG4r5jRneySGOa1IatME4uskGnv4EUWS
         j0y8jHRYYVCxPy7/1JHHtVtZbqdJaUXyJceJYTRo2sOLMebJaA97+yOyPq6Py1cCaZiL
         jdeDDnRM0ke9X7CM9zVrhWt3ZKa7f7xTYjiJ1RDJI1CJbiPP+sVuVzNmBByw2oohSZlw
         vPLMnkvDqN4VReETgM9o9qdjM96H/42gavdM5gq9lfQjsFdW4mP/xeG/53NpzBQAEiEI
         nqFIVVJoT2xhhRO10K4mf8KeqRaJD81s/I4YAWtNZeKaRv7FwMQbpC5bv8WCUbAVc+Oi
         34lw==
X-Gm-Message-State: AOAM531oTZIiB6U/gkJ9EG79AoclDIJajT9TagN3ckiy2BllNptf87ry
        4FJwOx48B7pRmNZt+kyw8xI=
X-Google-Smtp-Source: ABdhPJwyxAOickP+q55D641vL7DUS+nsCA4A+2R9NqLAGpYfJFbJakLh46Vl639n+yjwi9ZepKO4ww==
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr1446898oid.110.1600916774336;
        Wed, 23 Sep 2020 20:06:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17sm504731oth.73.2020.09.23.20.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 20:06:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Sep 2020 20:06:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "xiao.mx.ma" <734056705@qq.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
Subject: Re: [PATCH v4] hwmon:Driver for Delta power supplies
Message-ID: <20200924030612.GA224951@roeck-us.net>
References: <tencent_72114122A1CD54BA37F47AB40ED140D0F208@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_72114122A1CD54BA37F47AB40ED140D0F208@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:48:05AM +0100, xiao.mx.ma wrote:
> From: Delta <xiao.mx.ma@deltaww.com>
> 
> The <drivers/hwmon/pmbus/delta.c> provides a driver for Delta's modules.
> Currently supports Q54SJ108A2 series and other series will continue to be
> added in the future. And some customize functions such as R/W blackbox and
> bootloader will be added in next revision.
> 
> Signed-off-by: Delta <xiao.mx.ma@deltaww.com>
> 
> --Patch v2 changelog:
> 	Add delta.rst in Documentation/hwmon.
> 	Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIES".
> 	Modify code: drop the excessive empty lines, correct the comment
> content, adjust indent, remove extra brackets.
> --Patch v3 changelog:
> 	Add delta.rst to Documentation/hwmon/index.rst.
> 	Tristate "DELTA_POWER_SUPPLIES" in Kconfig is changed to "Delta
> Power Supplies".
> --Patch v4 changelog:
> 	Correct the spelling 'Temperature' in the delta.rst.
> 	Add Write_protect when write command VOUT_OV_FAULT_RESPONSE and
> IOUT_OC_FAULT_RESPONSE.
> ---

Change log goes here (after ---)

>  Documentation/hwmon/delta.rst |  52 ++++++++++++
>  Documentation/hwmon/index.rst |   1 +
>  drivers/hwmon/pmbus/Kconfig   |   9 ++
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/delta.c   | 153 ++++++++++++++++++++++++++++++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 Documentation/hwmon/delta.rst
>  create mode 100644 drivers/hwmon/pmbus/delta.c
> 
> diff --git a/Documentation/hwmon/delta.rst b/Documentation/hwmon/delta.rst
> new file mode 100644
> index 000000000000..225cc9ddfa00
> --- /dev/null
> +++ b/Documentation/hwmon/delta.rst
> @@ -0,0 +1,52 @@
> +Kernel driver delta
> +=====================
> +
> +Supported chips:
> +
> +  * DELTA Q54SJ108A2NCAH, Q54SJ108A2NCDH, Q54SJ108A2NCPG, Q54SJ108A2NCPH
> +
> +    Prefix: 'Q54SJ108A2'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://filecenter.delta-china.com.cn/products/download/01/0102/datasheet/DS_Q54SJ108A2.pdf
> +
> +Authors:
> +    Delta <xiao.mx.ma@deltaww.com>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for DELTA Q54SJ108A2NCAH, Q54SJ108A2NCDH, 
> +Q54SJ108A2NCPG, and Q54SJ108A2NCPH 1/4 Brick DC/DC Regulated Power Module 
> +with PMBus support.
> +
> +The driver is a client driver to the core PMBus driver.
> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +
> +Sysfs entries
> +-------------
> +
> +=================== ===== =======================================================
> +curr1_alarm         RO    Output current alarm
> +curr1_input         RO    Output current
> +curr1_label         RO    'iout1'
> +in1_alarm           RO    Input voltage alarm
> +in1_input           RO    Input voltage
> +in1_label           RO    'vin'
> +in2_alarm           RO    Output voltage alarm
> +in2_input           RO    Output voltage
> +in2_label           RO    'vout1'
> +temp1_alarm         RO    Temperature alarm
> +temp1_input         RO    Chip temperature
> +=================== ===== =======================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 750d3a975d82..31c51545df72 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -51,6 +51,7 @@ Hardware Monitoring Kernel Drivers
>     da9052
>     da9055
>     dell-smm-hwmon
> +   delta
>     dme1737
>     drivetemp
>     ds1621
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index e35db489b76f..9b1863bfa946 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -44,6 +44,15 @@ config SENSORS_BEL_PFE
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called bel-pfe.
> +	  
> +config SENSORS_DELTA
> +	tristate "Delta Power Supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta
> +	  Q54SJ108A2 series Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called delta.
>  
>  config SENSORS_IBM_CFFPS
>  	tristate "IBM Common Form Factor Power Supply"
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index c4b15db996ad..8957f5337002 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> +obj-$(CONFIG_SENSORS_DELTA)	+= delta.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> diff --git a/drivers/hwmon/pmbus/delta.c b/drivers/hwmon/pmbus/delta.c
> new file mode 100644
> index 000000000000..22e08325194d
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/delta.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
> + * Regulated Power Module
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>
> +#include <linux/util_macros.h>
> +#include "pmbus.h"
> +
> +enum chips {
> +	Q54SJ108A2
> +};
> +
> +static int delta_write_word_data(struct i2c_client *client, int page, int reg,
> +			       u16 word)
> +{
> +	u8 value;
> +	u8 ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_OV_FAULT_RESPONSE:
> +	case PMBUS_IOUT_OC_FAULT_RESPONSE:
> +		value = 0;
> +		ret = pmbus_write_byte_data(client, page, PMBUS_WRITE_PROTECT, value);
> +		value = (u8)word;
> +		return pmbus_write_byte_data(client, page, reg, value);
> +	default:
> +		return -ENODATA;
> +	}
> +}

This function is pointless. Neither PMBUS_VOUT_OV_FAULT_RESPONSE nor
PMBUS_IOUT_OC_FAULT_RESPONSE is written by the PMBus core.
Also, even if it was used, the commands are byte commands,
and write_work_data would never be called to issue those commands.

Guenter

> +
> +static const struct pmbus_driver_info delta_info[] = {
> +	[Q54SJ108A2] = {
> +		.pages = 1,
> +		.write_word_data = delta_write_word_data,
> +
> +		/* Source : Delta Q54SJ108A2 */
> +		.format[PSC_TEMPERATURE] = linear,
> +		.format[PSC_VOLTAGE_IN] = linear,
> +		.format[PSC_CURRENT_OUT] = linear,
> +
> +		.func[0] = PMBUS_HAVE_VIN |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_INPUT,
> +	},
> +};
> +
> +static int delta_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct pmbus_driver_info *info;
> +	enum chips chip_id;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	if (client->dev.of_node)
> +		chip_id = (enum chips)of_device_get_match_data(dev);
> +	else
> +		chip_id = id->driver_data;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> +		return ret;
> +	}
> +	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The chips support reading PMBUS_MFR_MODEL.
> +	 */
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read Manufacturer Model\n");
> +		return ret;
> +	}
> +	if (ret != 14 || strncmp(buf, "Q54SJ108A2", 10)) {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_REVISION, buf);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read Manufacturer Revision\n");
> +		return ret;
> +	}
> +	if (ret != 4 || buf[0] != 'S') {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memcpy(info, &delta_info[chip_id], sizeof(*info));
> +
> +	return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct i2c_device_id delta_id[] = {
> +	{ "Q54SJ108A2", Q54SJ108A2 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, delta_id);
> +
> +static const struct of_device_id delta_of_match[] = {
> +	{ .compatible = "delta,Q54SJ108A2", .data = (void *)Q54SJ108A2 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, delta_of_match);
> +
> +static struct i2c_driver delta_driver = {
> +	.driver = {
> +		.name = "Q54SJ108A2",
> +		.of_match_table = delta_of_match,
> +	},
> +	.probe = delta_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = delta_id,
> +};
> +
> +module_i2c_driver(delta_driver);
> +
> +MODULE_AUTHOR("Delta <xiao.mx.ma@deltaww.com>");
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 series modules");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
