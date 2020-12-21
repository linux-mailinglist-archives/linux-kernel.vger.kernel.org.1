Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6A2DFF25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLUSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLUSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:01:54 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B1FC0613D3;
        Mon, 21 Dec 2020 10:01:14 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x13so9569093oto.8;
        Mon, 21 Dec 2020 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9A8NIKHznXcUlQ9tUe4gNzw4i9zKGiRMs7kWED5ZRY=;
        b=Jd1PrS8zSstbRmLwkNaM92RvJbfNkd23ckVslsqPAZ6/AZRDkJUxsBUmfZgxMAyLqP
         TEjvKxhl5EcQJ7Dv+hcH0uO9jHoVfZ3meqR0igxkknT96vFUnoy93hGinTyd4SLpCqN3
         TkXyOqfYdRxzEnNG0RDLk1f6xdWPEnQkxyPhFpHfpXp5LRQvQadjJGRVeA4/eNSpY6iH
         D+n9/wqNDNM2Dm/WIJr21+lz1HR5GmlactvK2TaD/EmKn6qyBvtlIt7EuUQWt51pErZN
         a5juenb/LTa90c0x2hz8EV7SsLi32BkmW6qkh/TKLn9tubuG5JpcWj2y8g+MR+LzWD5T
         ZN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y9A8NIKHznXcUlQ9tUe4gNzw4i9zKGiRMs7kWED5ZRY=;
        b=ndsBx9GUPi6h8GE2zu587stZX3aIXu7CNbkvXLH2tq9AgWAiatQD/WSzc2xuix+4WP
         IfXZQ9lfVEOVtNJ1fwJE3BBvMNO3wI0d8juvFXfvx6AGCnElgZXNlxcgDsmY7aIt/MvW
         g1OG0wduUnASiofPYaCC5nrOSo4Roo+BVxYFuqEelwzMAp/sNNd4u1st3V0urUCQWO80
         QxVe1mR4AN5auIPYh64LIdCNsnlfdeI3tNFQEdgZkAoCmzqjdJ6ZvOVk1LOcXib1KhO7
         hfmXzcr3Pn+sU4aLowhGyjoSF/twdytj7CUl7cd/ZdFss/4jlO0OSpTKMI5/sW5mzllu
         n5UQ==
X-Gm-Message-State: AOAM531bRDiAgGSbZyA75I+22NvVmfZyVp3+FidaOCigT0JJyQNCAAvh
        cmlo6AtXczg1r+aVbMxB9pNFRX72mjs=
X-Google-Smtp-Source: ABdhPJx9/oIpkyvRIFIN8v9hGfmuDK9sljz6L0H0SHAErC98bUoJWDqpctVjkj0T/jdAxMmc4UGD3Q==
X-Received: by 2002:a05:6830:1e7a:: with SMTP id m26mr12857534otr.78.1608567992054;
        Mon, 21 Dec 2020 08:26:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm3888946otj.67.2020.12.21.08.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:26:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: add Texas Instruments TPS23861 driver
To:     Robert Marko <robert.marko@sartura.hr>, jdelvare@suse.com,
        robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>
References: <20201219191121.85142-1-robert.marko@sartura.hr>
 <20201219191121.85142-2-robert.marko@sartura.hr>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dc019655-aead-847c-3221-15f8e2e629ee@roeck-us.net>
Date:   Mon, 21 Dec 2020 08:26:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201219191121.85142-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/20 11:11 AM, Robert Marko wrote:
> Add basic monitoring support as well as port on/off control for Texas
> Instruments TPS23861 PoE PSE IC.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes in v2:
> * Convert to devm_hwmon_device_register_with_info()
> * Change license
> 
>  drivers/hwmon/Kconfig    |  11 +
>  drivers/hwmon/Makefile   |   1 +
>  drivers/hwmon/tps23861.c | 538 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 550 insertions(+)
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
> index 000000000000..2bb804ccdc8e
> --- /dev/null
> +++ b/drivers/hwmon/tps23861.c
> @@ -0,0 +1,538 @@
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
> +#define POE_PLUS				0x40
> +
> +#define DETECT_CLASS_RESTART		0x18
> +#define POWER_ENABLE			0x19
> +
> +#define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
> +#define VOLTAGE_LSB			3662 /* 3.662 mV */
> +#define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
> +#define CURRENT_LSB_255			62260 /* 62.260 uA */
> +#define CURRENT_LSB_250			61039 /* 61.039 uA */
> +
> +struct tps23861_data {
> +	struct regmap *regmap;
> +	u32 shunt_resistor;
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
> +	if (channel < 4) {
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
> +static int tps23861_calculate_power(struct tps23861_data *data, int channel,
> +				    long *val)
> +{
> +	long voltage, current_ma;
> +	int err;
> +
> +	err = tps23861_read_voltage(data, channel, &voltage);
> +	if (err < 0)
> +		return err;
> +
> +	err = tps23861_read_current(data, channel, &current_ma);
> +	if (err < 0)
> +		return err;
> +

It is not the responsibility of the kernel to calculate power values.
This can and should be done in userspace. Kenrel power attributes are
only appropriate if reported by the hardware.

> +	*val = voltage * current_ma;
> +
> +	return 0;
> +}
> +
> +static umode_t tps23861_is_visible(const void *data, enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;

default: missing. Same below.

> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_label:
> +			return 0444;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_curr_label:
> +			return 0444;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +		case hwmon_power_label:
> +			return 0444;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
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
> +			return -EINVAL;

			return -EOPNOTSUPP;

same below.

> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			err = tps23861_read_voltage(data, channel, val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			err = tps23861_read_current(data, channel, val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			err = tps23861_calculate_power(data, channel, val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
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
> +	case hwmon_power:
> +		*str = tps23861_port_label[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *tps23861_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops tps23861_hwmon_ops = {
> +	.is_visible = tps23861_is_visible,
> +	.read = tps23861_read,
> +	.read_string = tps23861_read_string,
> +};
> +
> +static const struct hwmon_chip_info tps23861_chip_info = {
> +	.ops = &tps23861_hwmon_ops,
> +	.info = tps23861_info,
> +};
> +
> +static ssize_t tps23861_port_status_show(struct device *dev,
> +					 struct device_attribute *da,
> +					 char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	char *detect_status, *class_status;
> +	unsigned int regval;
> +	u8 class, detect;
> +
> +	regmap_read(data->regmap, attr->index, &regval);
> +	detect = FIELD_GET(PORT_STATUS_DETECT_MASK, regval);
> +	class = FIELD_GET(PORT_STATUS_CLASS_MASK, regval);
> +
> +	switch (detect) {
> +	case PORT_DETECT_UNKNOWN:
> +		detect_status = "Unknown device";
> +		break;
> +	case PORT_DETECT_SHORT:
> +		detect_status = "Short circuit detected";
> +		break;
> +	case PORT_DETECT_RESISTANCE_LOW:
> +		detect_status = "Too low resistance detected";
> +		break;
> +	case PORT_DETECT_RESISTANCE_OK:
> +		detect_status = "Valid resistance detected";
> +		break;
> +	case PORT_DETECT_RESISTANCE_HIGH:
> +		detect_status = "Too high resistance detected";
> +		break;
> +	case PORT_DETECT_OPEN_CIRCUIT:
> +		detect_status = "Open circuit detected";
> +		break;
> +	case PORT_DETECT_MOSFET_FAULT:
> +		detect_status = "MOSFET fault detected";
> +		break;
> +	case PORT_DETECT_LEGACY:
> +		detect_status = "Legacy device detected";
> +		break;
> +	case PORT_DETECT_CAPACITANCE_INVALID_BEYOND:
> +		detect_status = "Invalid capacitance, beyond clamp voltage";
> +		break;
> +	case PORT_DETECT_CAPACITANCE_INVALID_DELTA:
> +		detect_status = "Invalid capacitance, insufficient voltage delta";
> +		break;
> +	case PORT_DETECT_CAPACITANCE_OUT_OF_RANGE:
> +		detect_status = "Valid capacitance, outside of legacy range";
> +		break;
> +	case PORT_DETECT_RESERVED:
> +	case PORT_DETECT_RESERVED_2:
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (class) {
> +	case PORT_CLASS_UNKNOWN:
> +		class_status = "Unknown class";
> +		break;
> +	case PORT_CLASS_RESERVED:
> +	case PORT_CLASS_0:
> +		class_status = "Class 0";
> +		break;
> +	case PORT_CLASS_1:
> +		class_status = "Class 1";
> +		break;
> +	case PORT_CLASS_2:
> +		class_status = "Class 2";
> +		break;
> +	case PORT_CLASS_3:
> +		class_status = "Class 3";
> +		break;
> +	case PORT_CLASS_4:
> +		class_status = "Class 4";
> +		break;
> +	case PORT_CLASS_OVERCURRENT:
> +		class_status = "Overcurrent";
> +		break;
> +	case PORT_CLASS_MISMATCH:
> +		class_status = "Class mismatch";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%s, %s\n", detect_status, class_status);
> +}
> +
> +static ssize_t tps23861_poe_plus_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	char *ports[4];
> +	unsigned int regval;
> +	int i;
> +
> +	regmap_read(data->regmap, attr->index, &regval);
> +
> +	for (i = 0; i < 4; i++) {
> +		if (BIT(i + 4) & regval)
> +			ports[i] = "Yes";
> +		else
> +			ports[i] = "No";
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "Port 1: %s\nPort 2: %s\nPort 3: %s\nPort 4: %s\n",
> +			ports[0], ports[1], ports[2], ports[3]);
> +}
> +
> +static ssize_t tps23861_port_disable_store(struct device *dev,
> +					   struct device_attribute *da,
> +					   const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	unsigned int regval, port;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &port);
> +	if (ret < 0)
> +		return ret;
> +
> +	regmap_read(data->regmap, attr->index, &regval);
> +	regval |= BIT(port + 3);
> +	regmap_write(data->regmap, attr->index, regval);
> +
> +	return count;
> +}
> +
> +static ssize_t tps23861_port_enable_store(struct device *dev,
> +					  struct device_attribute *da,
> +					  const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct tps23861_data *data = dev_get_drvdata(dev);
> +	unsigned int regval, port;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &port);
> +	if (ret < 0)
> +		return ret;
> +
> +	regmap_read(data->regmap, attr->index, &regval);
> +	regval |= BIT(port - 1);
> +	regval |= BIT(port + 3);
> +	regmap_write(data->regmap, attr->index, regval);
> +
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(port1_status, tps23861_port_status, PORT_1_STATUS);
> +static SENSOR_DEVICE_ATTR_RO(port2_status, tps23861_port_status, PORT_2_STATUS);
> +static SENSOR_DEVICE_ATTR_RO(port3_status, tps23861_port_status, PORT_3_STATUS);
> +static SENSOR_DEVICE_ATTR_RO(port4_status, tps23861_port_status, PORT_4_STATUS);
> +static SENSOR_DEVICE_ATTR_RO(poe_plus_status, tps23861_poe_plus, POE_PLUS);

sysfs files are supposed to return simple values. If the above is desired/needed,
I would suggest to implement debugfs attributes.

> +static SENSOR_DEVICE_ATTR_WO(port_disable, tps23861_port_disable, POWER_ENABLE);
> +static SENSOR_DEVICE_ATTR_WO(port_enable, tps23861_port_enable, DETECT_CLASS_RESTART);
> +

We already have standard enable attributes. Please use those.
Also, a separate 'disable' attribute is unnecessary.

> +static struct attribute *tps23861_attrs[] = {
> +	&sensor_dev_attr_port1_status.dev_attr.attr,
> +	&sensor_dev_attr_port2_status.dev_attr.attr,
> +	&sensor_dev_attr_port3_status.dev_attr.attr,
> +	&sensor_dev_attr_port4_status.dev_attr.attr,
> +	&sensor_dev_attr_poe_plus_status.dev_attr.attr,
> +	&sensor_dev_attr_port_disable.dev_attr.attr,
> +	&sensor_dev_attr_port_enable.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group tps23861_group = {
> +	.attrs = tps23861_attrs,
> +};
> +__ATTRIBUTE_GROUPS(tps23861);
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
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 data, &tps23861_chip_info,
> +							 tps23861_groups);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
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
> 

