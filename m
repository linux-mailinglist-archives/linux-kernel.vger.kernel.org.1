Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71292E7B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgL3Qpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3Qpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:45:35 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CBC061799;
        Wed, 30 Dec 2020 08:44:55 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j12so15797387ota.7;
        Wed, 30 Dec 2020 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8HqR4na7m/sZYN4wzF+DSzloLNBXrkqVJfAC6jP0wU0=;
        b=iExn5MTJIYU0ggepHP6rsthAFdP1PtJjHIpv2I+qkCr5BPjkSvlyg2pH/JvkxBn4Sc
         3Aju0xbROjWWO0xfVhYxMnWYpRFNBh4/FAZUQ4+PhY1f4s3e5zJegWTmiaTH4/XIjVir
         /ep+xXexz3m03RDO4b8kkYVVFJCyIX7Rjt/lfJ68epNJq2HfhvOYAIoJpCHM7DwJRfUL
         QkxVe875kYQ23SOHDA1eHQuSADL5v8ZWw+bmrgYLzNN59R9ZLsKbK7udrWVZ6ZgTfT6u
         U9jMi1Ed6dyyycJGJ7NYgpDpntlDY5AhE7MVBHHzP4Px7EXJv1PW4kwbDXOMO0CXj2NE
         WUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8HqR4na7m/sZYN4wzF+DSzloLNBXrkqVJfAC6jP0wU0=;
        b=In8wN6T2diqO//Qz/KWlKWEratO0t85Awrkv4a1Zl3m5ZVv4cMSCTaLcKj0QJjZBab
         Aqu3Ol4UkbiOUjlC6CNMBUCCHTYsgX8rI2r6Z9NgnFaKA+yQmA7PK7U4QwplYkGl53JK
         yAXw0VTLK5/yh28YGUbovSgZFtZr9+S5x+uoh7WDO5NEC/LBaCiSCiDXSmvJOBd0fuLM
         ugaueD3HMSz267ItvXwPrftAiQeuT94JhgEw1Yt1e6PHZC6D9TRGuzMBLhMnm52im55+
         ZsvjAmvxdJ8bs3uXiOmOGQjy6rQW6ntCntOUSbmN0XBdcqeUJym62z1HR+1lKF1ylX+i
         czCA==
X-Gm-Message-State: AOAM532HoHGMMZJKJwF3ttidMQxdTVU1k4IlVjKuiO852UCVTnMW8B3J
        JUcQ1fflgWyXqUniH0EsyRYdl+OW1ks=
X-Google-Smtp-Source: ABdhPJzA0yUOJePAEt01JaB66nlndXyzQmksl3px0XVhm6pPyDH/DV5hBBLMwJhyJ7bgY8vXCnejiQ==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr38089414ots.151.1609346694338;
        Wed, 30 Dec 2020 08:44:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r13sm10752596oti.49.2020.12.30.08.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 08:44:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Dec 2020 08:44:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v3 2/3] hwmon: add Texas Instruments TPS23861 driver
Message-ID: <20201230164452.GA103852@roeck-us.net>
References: <20201222143012.1618807-1-robert.marko@sartura.hr>
 <20201222143012.1618807-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222143012.1618807-2-robert.marko@sartura.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 03:30:11PM +0100, Robert Marko wrote:
> Add basic monitoring support as well as port on/off control for Texas
> Instruments TPS23861 PoE PSE IC.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes in v3:
> * Leave only standard values in hwmon hwmon
> * Drop custom sysfs entries
> * Use debugfs to provide non standard debug information
> * Add temperature label
> * Use hwmon_in_enable to enable/disable ports
> 
> Changes in v2:
> * Convert to devm_hwmon_device_register_with_info()
> * Change license
> 
>  drivers/hwmon/Kconfig    |  11 +
>  drivers/hwmon/Makefile   |   1 +
>  drivers/hwmon/tps23861.c | 603 +++++++++++++++++++++++++++++++++++++++

Driver documentation (Documentation/hwmon/tps23861) is missing.

>  3 files changed, 615 insertions(+)
>  create mode 100644 drivers/hwmon/tps23861.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a850e4f0e0bd..3368ecfa7a9c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1102,6 +1102,17 @@ config SENSORS_TC654
>  	  This driver can also be built as a module. If so, the module
>  	  will be called tc654.
>  
> +config SENSORS_TPS23861
> +	tristate "Texas Instruments TPS23861 PoE PSE"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  TPS23861 802.3at PoE PSE chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps23861.
> +
>  config SENSORS_MENF21BMC_HWMON
>  	tristate "MEN 14F021P00 BMC Hardware Monitoring"
>  	depends on MFD_MENF21BMC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 9db2903b61e5..7493e9d5dc43 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
> +obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
>  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>  obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> new file mode 100644
> index 000000000000..a321e4700f48
> --- /dev/null
> +++ b/drivers/hwmon/tps23861.c
> @@ -0,0 +1,603 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Sartura Ltd.
> + *
> + * Driver for the TI TPS23861 PoE PSE.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#define TEMPERATURE			0x2c
> +#define INPUT_VOLTAGE_LSB		0x2e
> +#define INPUT_VOLTAGE_MSB		0x2f
> +#define PORT_1_CURRENT_LSB		0x30
> +#define PORT_1_CURRENT_MSB		0x31
> +#define PORT_1_VOLTAGE_LSB		0x32
> +#define PORT_1_VOLTAGE_MSB		0x33
> +#define PORT_2_CURRENT_LSB		0x34
> +#define PORT_2_CURRENT_MSB		0x35
> +#define PORT_2_VOLTAGE_LSB		0x36
> +#define PORT_2_VOLTAGE_MSB		0x37
> +#define PORT_3_CURRENT_LSB		0x38
> +#define PORT_3_CURRENT_MSB		0x39
> +#define PORT_3_VOLTAGE_LSB		0x3a
> +#define PORT_3_VOLTAGE_MSB		0x3b
> +#define PORT_4_CURRENT_LSB		0x3c
> +#define PORT_4_CURRENT_MSB		0x3d
> +#define PORT_4_VOLTAGE_LSB		0x3e
> +#define PORT_4_VOLTAGE_MSB		0x3f
> +#define PORT_N_CURRENT_LSB_OFFSET	0x04
> +#define PORT_N_VOLTAGE_LSB_OFFSET	0x04
> +#define VOLTAGE_CURRENT_MASK		GENMASK(13, 0)
> +#define PORT_1_RESISTANCE_LSB		0x60
> +#define PORT_1_RESISTANCE_MSB		0x61
> +#define PORT_2_RESISTANCE_LSB		0x62
> +#define PORT_2_RESISTANCE_MSB		0x63
> +#define PORT_3_RESISTANCE_LSB		0x64
> +#define PORT_3_RESISTANCE_MSB		0x65
> +#define PORT_4_RESISTANCE_LSB		0x66
> +#define PORT_4_RESISTANCE_MSB		0x67
> +#define PORT_N_RESISTANCE_LSB_OFFSET	0x02
> +#define PORT_RESISTANCE_MASK		GENMASK(13, 0)
> +#define PORT_RESISTANCE_RSN_MASK	GENMASK(15, 14)
> +#define PORT_RESISTANCE_RSN_OTHER	0
> +#define PORT_RESISTANCE_RSN_LOW		1
> +#define PORT_RESISTANCE_RSN_OPEN	2
> +#define PORT_RESISTANCE_RSN_SHORT	3
> +#define PORT_1_STATUS			0x0c
> +#define PORT_2_STATUS			0x0d
> +#define PORT_3_STATUS			0x0e
> +#define PORT_4_STATUS			0x0f
> +#define PORT_STATUS_CLASS_MASK		GENMASK(7, 4)
> +#define PORT_STATUS_DETECT_MASK		GENMASK(3, 0)
> +#define PORT_CLASS_UNKNOWN		0
> +#define PORT_CLASS_1			1
> +#define PORT_CLASS_2			2
> +#define PORT_CLASS_3			3
> +#define PORT_CLASS_4			4
> +#define PORT_CLASS_RESERVED		5
> +#define PORT_CLASS_0			6
> +#define PORT_CLASS_OVERCURRENT		7
> +#define PORT_CLASS_MISMATCH		8
> +#define PORT_DETECT_UNKNOWN		0
> +#define PORT_DETECT_SHORT		1
> +#define PORT_DETECT_RESERVED		2
> +#define PORT_DETECT_RESISTANCE_LOW	3
> +#define PORT_DETECT_RESISTANCE_OK	4
> +#define PORT_DETECT_RESISTANCE_HIGH	5
> +#define PORT_DETECT_OPEN_CIRCUIT	6
> +#define PORT_DETECT_RESERVED_2		7
> +#define PORT_DETECT_MOSFET_FAULT	8
> +#define PORT_DETECT_LEGACY		9
> +/* Measurment beyond clamp voltage */
> +#define PORT_DETECT_CAPACITANCE_INVALID_BEYOND	10
> +/* Insufficient voltage delta */
> +#define PORT_DETECT_CAPACITANCE_INVALID_DELTA	11
> +#define PORT_DETECT_CAPACITANCE_OUT_OF_RANGE	12
> +#define POE_PLUS			0x40
> +#define OPERATING_MODE			0x12
> +#define OPERATING_MODE_OFF		0
> +#define OPERATING_MODE_MANUAL		1
> +#define OPERATING_MODE_SEMI		2
> +#define OPERATING_MODE_AUTO		3
> +#define OPERATING_MODE_PORT_1_MASK	GENMASK(1, 0)
> +#define OPERATING_MODE_PORT_2_MASK	GENMASK(3, 2)
> +#define OPERATING_MODE_PORT_3_MASK	GENMASK(5, 4)
> +#define OPERATING_MODE_PORT_4_MASK	GENMASK(7, 6)
> +
> +#define DETECT_CLASS_RESTART		0x18
> +#define POWER_ENABLE			0x19
> +#define TPS23861_NUM_PORTS		4
> +
> +#define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
> +#define VOLTAGE_LSB			3662 /* 3.662 mV */
> +#define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
> +#define CURRENT_LSB_255			62260 /* 62.260 uA */
> +#define CURRENT_LSB_250			61039 /* 61.039 uA */
> +#define RESISTANCE_LSB			110966 /* 11.0966 Ohm*/
> +#define RESISTANCE_LSB_LOW		157216 /* 15.7216 Ohm*/
> +
> +struct tps23861_data {
> +	struct regmap *regmap;
> +	u32 shunt_resistor;
> +	struct i2c_client *client;
> +	struct dentry *debugfs_dir;
> +};
> +
> +static struct regmap_config tps23861_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int tps23861_read_temp(struct tps23861_data *data, long *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err = regmap_read(data->regmap, TEMPERATURE, &regval);
> +	if (err < 0)
> +		return err;
> +
> +	*val = (regval * TEMPERATURE_LSB) - 20000;
> +
> +	return 0;
> +}
> +
> +static int tps23861_read_voltage(struct tps23861_data *data, int channel,
> +				 long *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	if (channel < TPS23861_NUM_PORTS) {
> +		err = regmap_bulk_read(data->regmap,
> +				       PORT_1_VOLTAGE_LSB + channel * PORT_N_VOLTAGE_LSB_OFFSET,
> +				       &regval, 2);
> +	} else {
> +		err = regmap_bulk_read(data->regmap,
> +				       INPUT_VOLTAGE_LSB,
> +				       &regval, 2);
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	*val = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * VOLTAGE_LSB) / 1000;
> +
> +	return 0;
> +}
> +
> +static int tps23861_read_current(struct tps23861_data *data, int channel,
> +				 long *val)
> +{
> +	unsigned int current_lsb;
> +	unsigned int regval;
> +	int err;
> +
> +	if (data->shunt_resistor == SHUNT_RESISTOR_DEFAULT)
> +		current_lsb = CURRENT_LSB_255;
> +	else
> +		current_lsb = CURRENT_LSB_250;
> +
> +	err = regmap_bulk_read(data->regmap,
> +			       PORT_1_CURRENT_LSB + channel * PORT_N_CURRENT_LSB_OFFSET,
> +			       &regval, 2);
> +	if (err < 0)
> +		return err;
> +
> +	*val = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * current_lsb) / 1000000;
> +
> +	return 0;
> +}
> +
> +static int tps23861_port_disable(struct tps23861_data *data, int channel)
> +{
> +	unsigned int regval = 0;
> +	int err;
> +
> +	regval |= BIT(channel + 4);
> +	err = regmap_write(data->regmap, POWER_ENABLE, regval);
> +
> +	return err;
> +}
> +
> +static int tps23861_port_enable(struct tps23861_data *data, int channel)
> +{
> +	unsigned int regval = 0;
> +	int err;
> +
> +	regval |= BIT(channel);
> +	regval |= BIT(channel + 4);
> +	err = regmap_write(data->regmap, DETECT_CLASS_RESTART, regval);
> +
> +	return err;
> +}
> +
> +static umode_t tps23861_is_visible(const void *data, enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_label:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_label:
> +			return 0444;
> +		case hwmon_in_enable:
> +			return 0200;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_curr_label:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int tps23861_write(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long val)
> +{
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	int err;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_enable:
> +			if (val == 0)
> +				err = tps23861_port_disable(data, channel);
> +			else if (val == 1)
> +				err = tps23861_port_enable(data, channel);
> +			else
> +				err = -EINVAL;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return err;
> +}
> +
> +static int tps23861_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	int err;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			err = tps23861_read_temp(data, val);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			err = tps23861_read_voltage(data, channel, val);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			err = tps23861_read_current(data, channel, val);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return err;
> +}
> +
> +static const char * const tps23861_port_label[] = {
> +	"Port1",
> +	"Port2",
> +	"Port3",
> +	"Port4",
> +	"Input",
> +};
> +
> +static int tps23861_read_string(struct device *dev,
> +				enum hwmon_sensor_types type,
> +				u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +	case hwmon_curr:
> +		*str = tps23861_port_label[channel];
> +		break;
> +	case hwmon_temp:
> +		*str = "Die";
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *tps23861_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops tps23861_hwmon_ops = {
> +	.is_visible = tps23861_is_visible,
> +	.write = tps23861_write,
> +	.read = tps23861_read,
> +	.read_string = tps23861_read_string,
> +};
> +
> +static const struct hwmon_chip_info tps23861_chip_info = {
> +	.ops = &tps23861_hwmon_ops,
> +	.info = tps23861_info,
> +};
> +
> +static char *tps23861_port_operating_mode(struct tps23861_data *data, int port)
> +{
> +	unsigned int regval;
> +	int mode;
> +
> +	regmap_read(data->regmap, OPERATING_MODE, &regval);
> +
> +	switch (port) {
> +	case 1:
> +		mode = FIELD_GET(OPERATING_MODE_PORT_1_MASK, regval);
> +		break;
> +	case 2:
> +		mode = FIELD_GET(OPERATING_MODE_PORT_2_MASK, regval);
> +		break;
> +	case 3:
> +		mode = FIELD_GET(OPERATING_MODE_PORT_3_MASK, regval);
> +		break;
> +	case 4:
> +		mode = FIELD_GET(OPERATING_MODE_PORT_4_MASK, regval);
> +		break;
> +	default:
> +		mode = -EINVAL;
> +	}
> +
> +	switch (mode) {
> +	case OPERATING_MODE_OFF:
> +		return "Off";
> +	case OPERATING_MODE_MANUAL:
> +		return "Manual";
> +	case OPERATING_MODE_SEMI:
> +		return "Semi-Auto";
> +	case OPERATING_MODE_AUTO:
> +		return "Auto";
> +	default:
> +		return "Invalid";
> +	}
> +}
> +
> +static char *tps23861_port_detect_status(struct tps23861_data *data, int port)
> +{
> +	unsigned int regval;
> +
> +	regmap_read(data->regmap,
> +		    PORT_1_STATUS + (port - 1),
> +		    &regval);
> +
> +	switch (FIELD_GET(PORT_STATUS_DETECT_MASK, regval)) {
> +	case PORT_DETECT_UNKNOWN:
> +		return "Unknown device";
> +	case PORT_DETECT_SHORT:
> +		return "Short circuit";
> +	case PORT_DETECT_RESISTANCE_LOW:
> +		return "Too low resistance";
> +	case PORT_DETECT_RESISTANCE_OK:
> +		return "Valid resistance";
> +	case PORT_DETECT_RESISTANCE_HIGH:
> +		return "Too high resistance";
> +	case PORT_DETECT_OPEN_CIRCUIT:
> +		return "Open circuit";
> +	case PORT_DETECT_MOSFET_FAULT:
> +		return "MOSFET fault";
> +	case PORT_DETECT_LEGACY:
> +		return "Legacy device";
> +	case PORT_DETECT_CAPACITANCE_INVALID_BEYOND:
> +		return "Invalid capacitance, beyond clamp voltage";
> +	case PORT_DETECT_CAPACITANCE_INVALID_DELTA:
> +		return "Invalid capacitance, insufficient voltage delta";
> +	case PORT_DETECT_CAPACITANCE_OUT_OF_RANGE:
> +		return "Valid capacitance, outside of legacy range";
> +	case PORT_DETECT_RESERVED:
> +	case PORT_DETECT_RESERVED_2:
> +	default:
> +		return "Invalid";
> +	}
> +}
> +
> +static char *tps23861_port_class_status(struct tps23861_data *data, int port)
> +{
> +	unsigned int regval;
> +
> +	regmap_read(data->regmap,
> +		    PORT_1_STATUS + (port - 1),
> +		    &regval);
> +
> +	switch (FIELD_GET(PORT_STATUS_CLASS_MASK, regval)) {
> +	case PORT_CLASS_UNKNOWN:
> +		return "Unknown";
> +	case PORT_CLASS_RESERVED:
> +	case PORT_CLASS_0:
> +		return "0";
> +	case PORT_CLASS_1:
> +		return "1";
> +	case PORT_CLASS_2:
> +		return "2";
> +	case PORT_CLASS_3:
> +		return "3";
> +	case PORT_CLASS_4:
> +		return "4";
> +	case PORT_CLASS_OVERCURRENT:
> +		return "Overcurrent";
> +	case PORT_CLASS_MISMATCH:
> +		return "Mismatch";
> +	default:
> +		return "Invalid";
> +	}
> +}
> +
> +static char *tps23861_port_poe_plus_status(struct tps23861_data *data, int port)
> +{
> +	unsigned int regval;
> +
> +	regmap_read(data->regmap, POE_PLUS, &regval);
> +
> +	if (BIT(port + 3) & regval)
> +		return "Yes";
> +	else
> +		return "No";
> +}
> +
> +static int tps23861_port_resistance(struct tps23861_data *data, int port)
> +{
> +	u16 regval;
> +
> +	regmap_bulk_read(data->regmap,
> +			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * (port - 1),
> +			 &regval,
> +			 2);
> +
> +	switch (FIELD_GET(PORT_RESISTANCE_RSN_MASK, regval)) {
> +	case PORT_RESISTANCE_RSN_OTHER:
> +		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB) / 10000;
> +	case PORT_RESISTANCE_RSN_LOW:
> +		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB_LOW) / 10000;
> +	case PORT_RESISTANCE_RSN_SHORT:
> +	case PORT_RESISTANCE_RSN_OPEN:
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int tps23861_port_status_show(struct seq_file *s, void *data)
> +{
> +	struct tps23861_data *priv = s->private;
> +	int i;
> +
> +	for (i = 1; i < TPS23861_NUM_PORTS + 1; i++) {
> +		seq_printf(s, "Port: \t\t%d\n", i);
> +		seq_printf(s, "Operating mode: %s\n", tps23861_port_operating_mode(priv, i));
> +		seq_printf(s, "Detected: \t%s\n", tps23861_port_detect_status(priv, i));
> +		seq_printf(s, "Class: \t\t%s\n", tps23861_port_class_status(priv, i));
> +		seq_printf(s, "PoE Plus: \t%s\n", tps23861_port_poe_plus_status(priv, i));
> +		seq_printf(s, "Resistance: \t%d\n", tps23861_port_resistance(priv, i));
> +		seq_putc(s, '\n');
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tps23861_port_status);
> +
> +static void tps23861_init_debugfs(struct tps23861_data *data)
> +{
> +	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
> +	if (!data->debugfs_dir)
> +		return;

Unecessary (and wrongh) error check. debugfs_create_dir() returns an
ERR_PTR() on error, not NULL. debugfs_create_file() checks for that
error condition, so the check here is unencessary.

> +
> +	debugfs_create_file("port_status",
> +			    0400,
> +			    data->debugfs_dir,
> +			    data,
> +			    &tps23861_port_status_fops);
> +}
> +
> +static int tps23861_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tps23861_data *data;
> +	struct device *hwmon_dev;
> +	u32 shunt_resistor;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	i2c_set_clientdata(client, data);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tps23861_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "shunt-resistor-micro-ohms", &shunt_resistor) < 0)
> +		data->shunt_resistor = shunt_resistor;
> +	else
> +		data->shunt_resistor = SHUNT_RESISTOR_DEFAULT;
> +

The error condition is wrong; of_property_read_u32() never returns
a negative value. Per documentation:

"Returns true if the property exists false otherwise"

> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 data, &tps23861_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	tps23861_init_debugfs(data);
> +
> +	return 0;
> +}
> +
> +static int tps23861_remove(struct i2c_client *client)
> +{
> +	struct tps23861_data *data = i2c_get_clientdata(client);
> +
> +	debugfs_remove_recursive(data->debugfs_dir);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused tps23861_of_match[] = {
> +	{ .compatible = "ti,tps23861", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tps23861_of_match);
> +
> +static struct i2c_driver tps23861_driver = {
> +	.probe_new		= tps23861_probe,
> +	.remove			= tps23861_remove,
> +	.driver = {
> +		.name		= "tps23861",
> +		.of_match_table	= of_match_ptr(tps23861_of_match),
> +	},
> +};
> +module_i2c_driver(tps23861_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> +MODULE_DESCRIPTION("TI TPS23861 PoE PSE");
