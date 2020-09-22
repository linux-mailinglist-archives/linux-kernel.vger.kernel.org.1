Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291227453B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIVP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:27:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AADC061755;
        Tue, 22 Sep 2020 08:27:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so15969306otb.12;
        Tue, 22 Sep 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BI627p62OWQwyNKrbSRMN0qffjUGip2dZnnQT2CiP/s=;
        b=S93Yi8QHrJB1YSHk9DJ7gJ8JG3lsfCANyzH2MxQVMODqattBPRM1gxUVudINQ9Ggal
         49cF/w/HOP4R3+PIv6X2LNAQVA0EvvGB7a+tpoXv1MkYf/Llz8GXt9t3QII1XibFiVce
         KYmQ5QyHFOYveWGV/qLlcnk5Mb35mfQMW23KvRd7ovIGlu9qk0ki712v7X0RtafmfY8U
         4udVzXp7ogwjMYwra+qTs9JryLxg+m6vVuvAoczc73B/KqRH8PocTpF90vMKke0OLhhO
         +LO15Kqs1QmzhkjjQ3SPrnjQp+EADj4+pYh6Nq650vEi9RftSZ7ZoB5zcHZSNl3phFHv
         5TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BI627p62OWQwyNKrbSRMN0qffjUGip2dZnnQT2CiP/s=;
        b=rU5FrF5oHskq+RPTFI9Z4hvUzS7a46XQB0fLeTPV8cSHc03ahcdnuqsaBI3zYVjC+w
         9ZE2MMyNhvYfoBxLjKJI2sLaiG4pxx2gKiYOWu2Xq0W3IjwwLcK4ASQXeWC9nVVTE8Ng
         BxSeEQhHAzc1UEPE3FfXTis2zqxUIegVlMN/gnaDOIYmexSJFIwHnNrSoG9FNg2lcn6p
         am4vmGAWZXCGssN0XxwkanNBh40eeRfbBnh5Ql99Ou6Zt1HWB00hBwvxEZBhmmfqa39L
         WiEzOXLY5yxKJ3C1BcPfbBQEvc8uN0S3Ba/8dhmmDY+oX50AE3MvY4bzRIvz+DthiRTW
         iDlQ==
X-Gm-Message-State: AOAM5316zEnj0kQkiz99NkF+Ih+UqdCOB2effgKdAuHlVfxHwv67Nnkt
        JwyrmL7qYgfkZa7PhkOeEoBI1HXe/qM=
X-Google-Smtp-Source: ABdhPJyDgWc0pvXA+GOiwWKulf4Ie4rj/hS2VCIQqJSO1LyPdfwDzU01jyHQmER7cnJL7yrDPdAlCg==
X-Received: by 2002:a9d:6d95:: with SMTP id x21mr3266435otp.339.1600788442793;
        Tue, 22 Sep 2020 08:27:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65sm728444otj.75.2020.09.22.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:27:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] hwmon:Driver for Delta power supplies
To:     "xiao.mx.ma" <734056705@qq.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiao.mx.ma@deltaww.com, jiajia.feng@deltaww.com
References: <tencent_78BA37F4D7B463D105D008111D222ECD7608@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <52e346dc-d85d-0a50-9f8e-a564a6c5f601@roeck-us.net>
Date:   Tue, 22 Sep 2020 08:27:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_78BA37F4D7B463D105D008111D222ECD7608@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 1:37 AM, xiao.mx.ma wrote:
> From: Delta <xiao.mx.ma@deltaww.com>
> 
> The <drivers/hwmon/pmbus/delta.c> provides a driver for Delta's modules.
> Currently supports Q54SJ108A2 series and other series will continue to be
> added in the future.
> 
> Signed-off-by: Delta <xiao.mx.ma@deltaww.com>
> 
> Add delta.rst to Documentation/hwmon/index.rst.
> Tristate "DELTA_POWER_SUPPLIES" in Kconfig is changed to "Delta Power
> Supplies".

Nit: This should go after '---', and you should list the v2 changes as well.

Now that I can actually look at the code, I wonder if the driver is even needed.
Adding something like
        {"q54Sj108a2", (kernel_ulong_t)&pmbus_info_one},
(or uppercase, if you prefer) to drivers/hwmon/pmbus/pmbus.c should accomplish
the same. Can you explain ? If the separate driver is indeed needed, that
explanation will have to be in the commit description for reference.

Thanks,
Guenter

> ---
>  Documentation/hwmon/delta.rst |  52 +++++++++++++
>  Documentation/hwmon/index.rst |   1 +
>  drivers/hwmon/pmbus/Kconfig   |   9 +++
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/delta.c   | 136 ++++++++++++++++++++++++++++++++++
>  5 files changed, 199 insertions(+)
>  create mode 100644 Documentation/hwmon/delta.rst
>  create mode 100644 drivers/hwmon/pmbus/delta.c
> 
> diff --git a/Documentation/hwmon/delta.rst b/Documentation/hwmon/delta.rst
> new file mode 100644
> index 000000000000..ee63b3b9b86d
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
> +temp1_alarm         RO    Temeperature alarm

Nit: Temperature

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
> index 000000000000..9fea3a3c460a
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/delta.c
> @@ -0,0 +1,136 @@
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
> +static const struct pmbus_driver_info delta_info[] = {
> +	[Q54SJ108A2] = {
> +		.pages = 1,
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
> +
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
> 

