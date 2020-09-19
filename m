Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D7270ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 07:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISFaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 01:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISFaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 01:30:14 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C76CC0613CE;
        Fri, 18 Sep 2020 22:30:14 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id h8so1960792ooc.12;
        Fri, 18 Sep 2020 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HoeorOWX1QeE2vU05chSSb43sZB4wWvlZYxeZjX0FNA=;
        b=DKoNu0GeqDB+xkvg8oIq6h9x93tz6CS9FSfdBvGXGQHyL6BFMotrmNorsvuK3qPPZR
         5/wQFuG/ckTEIY/9vdbdwmzH1FDP3TLbS2QCfFf6V94cB+DoA2VIs5ziAwMNvpkB0GLI
         1oXUFmKQ3z9cgywt03O/4/7feDevQlFIhQcVJgMBiSBHd3qhhzxNx5CXYMn35eWv3STv
         IOY026crr02DTHdw02RDvRyB1w5FI2vGe+n+N/kYXYrmvB8ccvDerL7IThjvfunvFLqe
         ordPGEWpIaZpqYkh61prWLAVnbN+KcHPGfMc6R0efMjXTX+mU8DzL16FYjyHhjayTYkv
         ZloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HoeorOWX1QeE2vU05chSSb43sZB4wWvlZYxeZjX0FNA=;
        b=a8vtBLeqhXWg9orxPMejL0fRnb1Y5CYXHsCge/QGhatL6o5ptFANkKIMe3mg3DANtT
         C/AGSvvdjZzjtNKc7w0BATR1z2edWjjLE7QzJPn87CifvcXefIicMAEs8wZbevDFz/Ps
         PfhZsgx/NYcNEcUcK8BCNcabhAZD0lOdgZL8w7K8705mfWwyzw+L7poBt4NV7yKik3yp
         k4Bh3+1aSsoklkeY8vjnJFNzWu5oh6MQS6R+aAyvd/HW9//VvPDYS69ChUr5kMstxfz8
         Jtjy5qPN1MN1/KpA+ilLz79Lo2fOTZjvcEH8vOcSY1CrlL9gEVBeR33Cslfk/B9EDqwu
         AXfg==
X-Gm-Message-State: AOAM53344GBDmTsAJ48hSydKmcE7rwIRj5Pl/+PPQY4km5uH9lim2vzR
        4cxns5+w19lLIELQ7BIW4z4=
X-Google-Smtp-Source: ABdhPJzwc9LsqwaKaj0N/5xfWwVCOmw/drjr8xIsohUvyEL9oFIl+OHLvGVqCWMXaDHkenwQ2J1Xww==
X-Received: by 2002:a4a:bb05:: with SMTP id f5mr26556368oop.5.1600493413270;
        Fri, 18 Sep 2020 22:30:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c34sm4062745otb.69.2020.09.18.22.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 22:30:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon:Driver for Delta power supplies
To:     "xiao.mx.ma" <734056705@qq.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiao.mx.ma@deltaww.com, jiajia.feng@deltaww.com
References: <tencent_DCB41AD18DD01711F62248CD7CBAC7F48A08@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9556d739-9f0d-5bcd-7a5d-f042468bfc42@roeck-us.net>
Date:   Fri, 18 Sep 2020 22:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_DCB41AD18DD01711F62248CD7CBAC7F48A08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 12:18 AM, xiao.mx.ma wrote:
> Add delta.rst in Documentation/hwmon
> Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIES"
> Modify code: drop the excessive empty lines, correct the comment content,
> adjust indent, remove extra brackets.
> 
Description goes here.

> Signed-off-by: xiao.mx.ma <734056705@qq.com>
> ---

Change log goes here.

Other than that, this is a patch on top of the previous patch.
Please combine the two patches into one.

>  Documentation/hwmon/delta.rst |  52 ++++++++++

delta.rst needs to be added to Documentation/hwmon/index.rst.

>  drivers/hwmon/pmbus/Kconfig   |   2 +-
>  drivers/hwmon/pmbus/delta.c   | 172 ++++++++--------------------------
>  3 files changed, 90 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/hwmon/delta.rst
> 
> diff --git a/Documentation/hwmon/delta.rst b/Documentation/hwmon/delta.rst
> new file mode 100644
> index 000000000000..790701d310e3
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
> +    xiao.mx.ma <734056705@qq.com>
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
> +temp1_input         RO    Chip temperature
> +=================== ===== =======================================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a9468be10d7e..b03311340add 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -46,7 +46,7 @@ config SENSORS_BEL_PFE
>  	  be called bel-pfe.
>  
>  config SENSORS_DELTA
> -	tristate "DELTA"
> +	tristate "DELTA_POWER_SUPPLIES"

This can be some text.

>  	help
>  	  If you say yes here you get hardware monitoring support for Delta Power Supplies.
>  
> diff --git a/drivers/hwmon/pmbus/delta.c b/drivers/hwmon/pmbus/delta.c
> index 090429881c45..04f09767921c 100644
> --- a/drivers/hwmon/pmbus/delta.c
> +++ b/drivers/hwmon/pmbus/delta.c
> @@ -1,234 +1,136 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -
>  /*
> - * Driver for Q54SJ108A2, Q50SN12050, and Q50SN12072 Integrated, Step-Down
> - * Switching Regulators
> + * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
> + * Regulated Power Module
>   *
>   * Copyright 2020 Delta LLC.
>   */
>  
> -
>  #include <linux/bits.h>
> -
>  #include <linux/err.h>
> -
>  #include <linux/i2c.h>
> -
>  #include <linux/init.h>
> -
>  #include <linux/kernel.h>
> -
>  #include <linux/module.h>
> -
>  #include <linux/mutex.h>
> -
>  #include <linux/of_device.h>
> -
>  #include <linux/pmbus.h>
> -
>  #include <linux/util_macros.h>
> -
>  #include "pmbus.h"
>  
>  enum chips {
> -
>  	Q54SJ108A2
>  };
>  
>  static const struct pmbus_driver_info delta_info[] = {
> -
> -[Q54SJ108A2] = {
> -
> -.pages = 1,
> -
> -/* Source : Delta Q54SJ108A2 */
> -
> -.format[PSC_TEMPERATURE] = linear,
> -
> -.format[PSC_VOLTAGE_IN] = linear,
> -
> -.format[PSC_CURRENT_OUT] = linear,
> -
> -
> -.func[0] = PMBUS_HAVE_VIN |
> -
> -PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> -
> -PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> -
> -PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> -
> -PMBUS_HAVE_STATUS_INPUT,
> -
> -},
> -
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
>  };
>  
>  
>  
>  static int delta_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> -
>  	struct device *dev = &client->dev;
> -
>  	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> -
>  	struct pmbus_driver_info *info;
> -
>  	enum chips chip_id;
> -
>  	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter,
> -
> -		I2C_FUNC_SMBUS_BYTE_DATA |
> -
> -		I2C_FUNC_SMBUS_WORD_DATA |
> -
> -		I2C_FUNC_SMBUS_BLOCK_DATA))
> -
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_BLOCK_DATA))
>  		return -ENODEV;
>  
>  	if (client->dev.of_node)
> -
>  		chip_id = (enum chips)of_device_get_match_data(dev);
> -
>  	else
> -
>  		chip_id = id->driver_data;
>  
>  	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> -
>  	if (ret < 0) {
> -
>  		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> -
>  		return ret;
> -
>  	}
> -
> -	if (ret != 5 || strncmp((buf), "DELTA", 5)) {
> -
> +	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
>  		buf[ret] = '\0';
> -
>  		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
> -
>  		return -ENODEV;
> -
>  	}
>  
> -/*
> - * The chips support reading PMBUS_MFR_MODEL.
> - */
> -
> +	/*
> +	 * The chips support reading PMBUS_MFR_MODEL.
> +	 */
>  	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> -
>  	if (ret < 0) {
> -
>  		dev_err(dev, "Failed to read Manufacturer Model\n");
> -
>  		return ret;
> -
>  	}
> -
> -	if (ret != 14 || strncmp((buf), "Q54SJ108A2", 10)) {
> -
> +	if (ret != 14 || strncmp(buf, "Q54SJ108A2", 10)) {
>  		buf[ret] = '\0';
> -
>  		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
> -
>  		return -ENODEV;
> -
>  	}
>  
>  	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_REVISION, buf);
> -
>  	if (ret < 0) {
> -
>  		dev_err(dev, "Failed to read Manufacturer Revision\n");
> -
>  		return ret;
> -
>  	}
> -
>  	if (ret != 4 || buf[0] != 'S') {
> -
>  		buf[ret] = '\0';
> -
>  		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
> -
>  		return -ENODEV;
> -
>  	}
>  
>  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> -
>  	if (!info)
> -
>  		return -ENOMEM;
>  
>  	memcpy(info, &delta_info[chip_id], sizeof(*info));
>  
>  	return pmbus_do_probe(client, id, info);
> -
>  }
>  
> -
> -
>  static const struct i2c_device_id delta_id[] = {
> -
> -{ "Q54SJ108A2", Q54SJ108A2 },
> -
> -{ },
> -
> +	{ "Q54SJ108A2", Q54SJ108A2 },
> +	{ },
>  };
>  
> -
> -
>  MODULE_DEVICE_TABLE(i2c, delta_id);
>  
> -
> -
>  static const struct of_device_id delta_of_match[] = {
> -
> -{ .compatible = "delta,Q54SJ108A2", .data = (void *)Q54SJ108A2 },
> -
> -{ },
> -
> +	{ .compatible = "delta,Q54SJ108A2", .data = (void *)Q54SJ108A2 },
> +	{ },
>  };
>  
> -
> -
>  MODULE_DEVICE_TABLE(of, delta_of_match);
>  
> -
> -
>  static struct i2c_driver delta_driver = {
> -
> -.driver = {
> -
> -.name = "Q54SJ108A2",
> -
> -.of_match_table = delta_of_match,
> -
> -},
> -
> -.probe = delta_probe,
> -
> -.remove = pmbus_do_remove,
> -
> -.id_table = delta_id,
> -
> +	.driver = {
> +		.name = "Q54SJ108A2",
> +		.of_match_table = delta_of_match,
> +	},
> +	.probe = delta_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = delta_id,
>  };
>  
> -
> -
>  module_i2c_driver(delta_driver);
>  
> -
> -
> -MODULE_AUTHOR("Delta <734056705@qq.com>");
> -
> -MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2NCAH / Q54SJ108A2NCDH / Q54SJ108A2NCPG / Q54SJ108A2NCPH");
> -
> +MODULE_AUTHOR("xiao.mx.ma <734056705@qq.com>");
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 series modules");
>  MODULE_LICENSE("GPL");
> 

