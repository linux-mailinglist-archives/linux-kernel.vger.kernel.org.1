Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AABF2A5DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 06:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgKDFyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 00:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgKDFyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 00:54:16 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5AC061A4D;
        Tue,  3 Nov 2020 21:54:15 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so11962721oih.8;
        Tue, 03 Nov 2020 21:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vgoLVhhaA9RImyzVtlTVPW2ie5SksXn/prK+ndDfPI0=;
        b=T5zQOTf71XbGgygPFNzVX2xFLWvXaZKQ0CYbHUzcTA1MxbIegNPm9glGt8Xw8mHj16
         xioohab65JkO5ycNNQyGW10QFGMdfHtHxl9htCbLOh/yy315p7EauEv59Sz5fMo33a6e
         qhqxjtcVzE2X+b/ml1nebmknYde165f7nVZ4BBHmzwwKG32z7diP5lVNDra7vgMf06fy
         RY3VcvYkxyAFf/G30I6wCvov+XLMfSUVRogFnvz3FDrc6McqeuaGMmlUxjPvSEF8lD9c
         nMpM6EjYJlihcAcqlN0ciHpd6kD9JE8w9+t+0BOaZDgdjOKw0JosOLduSNDJJg42Y1lk
         4SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vgoLVhhaA9RImyzVtlTVPW2ie5SksXn/prK+ndDfPI0=;
        b=C3LOMbtZAACm81tzYf534afH6e70BuB1J9TIlM0lI2bMqHaDaTmNx4eMDhB40Mq8bg
         u07kYsALp/Ko7OOmaBFTlsQ/Tq27sy6v4BSPIw8hfkp3UwzIrdCvqb+OV3Y7dEQnW4Tz
         4oaJh8EWRfsEzMLcL5iQkHPhrpKaaSPOvSsFoDInXhWg+q/3h6H5Z7Vz71uuudCxpOF0
         19Utt3Jl9roY/PqJV8Ca0/30wHQldGxiuEzn2lCEzwjibtLWHXLElrqrwrOubk0iKXrC
         t1S0VzL1mPRZ1+C1Gxz1P14nVtOq7t2hke1eDlb9QOlC/k2//KyRMIrdsipnBS4jiJf8
         QNHQ==
X-Gm-Message-State: AOAM531+ievJT8d+y/1dC/fQroJP813NvvL4onFDmxUZoqdaR6S0tjMp
        Xkp4A7Gp6jHCND1rhCIj3FP3zt8WeIg=
X-Google-Smtp-Source: ABdhPJx/gpasaGYOZqL/5jQ/jpnVtn8G9d9Ikcfjse1mC3ws9+InP9Z3Mw3QFxg29CqP7Fzi6x7N7g==
X-Received: by 2002:aca:af4a:: with SMTP id y71mr1600585oie.178.1604469254867;
        Tue, 03 Nov 2020 21:54:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m23sm285370otk.10.2020.11.03.21.54.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Nov 2020 21:54:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Nov 2020 21:54:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/3] hwmon: ltc2992: Add support
Message-ID: <20201104055413.GA124480@roeck-us.net>
References: <20201029094911.79173-1-alexandru.tachici@analog.com>
 <20201029094911.79173-2-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029094911.79173-2-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:49:09AM +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> LTC2992 is a rail-to-rail system monitor that
> measures current, voltage, and power of two supplies.
> 
> Two ADCs simultaneously measure each supply’s current.
> A third ADC monitors the input voltages and four
> auxiliary external voltages.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

High level comment: checkpatch finds a number of spelling errors.
Please fix.

> ---
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/ltc2992.rst |  51 +++
>  drivers/hwmon/Kconfig           |  11 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/ltc2992.c         | 735 ++++++++++++++++++++++++++++++++
>  5 files changed, 799 insertions(+)
>  create mode 100644 Documentation/hwmon/ltc2992.rst
>  create mode 100644 drivers/hwmon/ltc2992.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index e6b91ab12978..f759d70ae9fd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -104,6 +104,7 @@ Hardware Monitoring Kernel Drivers
>     ltc2947
>     ltc2978
>     ltc2990
> +   ltc2992
>     ltc3815
>     ltc4151
>     ltc4215
> diff --git a/Documentation/hwmon/ltc2992.rst b/Documentation/hwmon/ltc2992.rst
> new file mode 100644
> index 000000000000..1dd48ef9f655
> --- /dev/null
> +++ b/Documentation/hwmon/ltc2992.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver ltc2992
> +=====================
> +
> +Supported chips:
> +  * Linear Technology LTC2992
> +    Prefix: 'ltc2992'
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2992.pdf
> +
> +Author: Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Linear Technology LTC2992 power monitor.
> +
> +LTC2992 is is a rail-to-rail system monitor that measures current,
> +voltage, and power of two supplies.
> +
> +Two ADCs simultaneously measure each supply’s current. A third ADC monitors
> +the input voltages and four auxiliary external voltages.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Limits are read-write,
> +all other attributes are read-only.
> +
> +inX_input		Measured voltage.
> +inX_min			Minimum voltage.
> +inX_max			Maximum voltage.
> +inX_min_alarm		Voltage low alarm.
> +inX_max_alarm		Voltage high alarm.
> +inX_alarm		An overvoltage or undervoltage occured. Cleared on read.
> +
> +currX_input		Measured current.
> +currX_min		Minimum current.
> +currX_max		Maximum current.
> +currX_min_alarm		Current low alarm.
> +currX_max_alarm		Current high alarm.
> +currX_alarm		An overvoltage or undervoltage occured. Cleared on read.
> +
> +powerX_input		Measured power.
> +powerX_min		Minimum power.
> +powerX_max		Maximum power.
> +powerX_min_alarm	Power low alarm.
> +powerX_max_alarm	Power high alarm.
> +powerX_alarm		An overpower or underpower occured. Cleared on read.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a850e4f0e0bd..bf9e387270d6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -858,6 +858,17 @@ config SENSORS_LTC2990
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ltc2990.
>  
> +config SENSORS_LTC2992
> +	tristate "Linear Technology LTC2992"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Linear Technology LTC2992
> +	  I2C System Monitor. The LTC2992 measures current, voltage, and
> +	  power of two supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ltc2992.
> +
>  config SENSORS_LTC4151
>  	tristate "Linear Technology LTC4151"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 9db2903b61e5..d6172c4807c4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_SENSORS_LTC2947)	+= ltc2947-core.o
>  obj-$(CONFIG_SENSORS_LTC2947_I2C) += ltc2947-i2c.o
>  obj-$(CONFIG_SENSORS_LTC2947_SPI) += ltc2947-spi.o
>  obj-$(CONFIG_SENSORS_LTC2990)	+= ltc2990.o
> +obj-$(CONFIG_SENSORS_LTC2992)	+= ltc2992.o
>  obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
>  obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
>  obj-$(CONFIG_SENSORS_LTC4222)	+= ltc4222.o
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> new file mode 100644
> index 000000000000..940d92b4a1d0
> --- /dev/null
> +++ b/drivers/hwmon/ltc2992.c
> @@ -0,0 +1,735 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * LTC2992 - Dual Wide Range Power Monitor
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define LTC2992_CTRLB			0x01
> +#define LTC2992_FAULT1			0x03
> +#define LTC2992_POWER1			0x05
> +#define LTC2992_POWER1_MAX		0x08
> +#define LTC2992_POWER1_MIN		0x0B
> +#define LTC2992_POWER1_MAX_THRESH	0x0E
> +#define LTC2992_POWER1_MIN_THRESH	0x11
> +#define LTC2992_DSENSE1			0x14
> +#define LTC2992_DSENSE1_MAX		0x16
> +#define LTC2992_DSENSE1_MIN		0x18
> +#define LTC2992_DSENSE1_MAX_THRESH	0x1A
> +#define LTC2992_DSENSE1_MIN_THRESH	0x1C
> +#define LTC2992_SENSE1			0x1E
> +#define LTC2992_SENSE1_MAX		0x20
> +#define LTC2992_SENSE1_MIN		0x22
> +#define LTC2992_SENSE1_MAX_THRESH	0x24
> +#define LTC2992_SENSE1_MIN_THRESH	0x26
> +#define LTC2992_G1			0x28
> +#define LTC2992_G1_MAX			0x2A
> +#define LTC2992_G1_MIN			0x2C
> +#define LTC2992_G1_MAX_THRESH		0x2E
> +#define LTC2992_G1_MIN_THRESH		0x30
> +#define LTC2992_FAULT2			0x35
> +#define LTC2992_G2			0x5A
> +#define LTC2992_G2_MAX			0x5C
> +#define LTC2992_G2_MIN			0x5E
> +#define LTC2992_G2_MAX_THRESH		0x60
> +#define LTC2992_G2_MIN_THRESH		0x62
> +#define LTC2992_G3			0x64
> +#define LTC2992_G3_MAX			0x66
> +#define LTC2992_G3_MIN			0x68
> +#define LTC2992_G3_MAX_THRESH		0x6A
> +#define LTC2992_G3_MIN_THRESH		0x6C
> +#define LTC2992_G4			0x6E
> +#define LTC2992_G4_MAX			0x70
> +#define LTC2992_G4_MIN			0x72
> +#define LTC2992_G4_MAX_THRESH		0x74
> +#define LTC2992_G4_MIN_THRESH		0x76
> +#define LTC2992_FAULT3			0x92
> +
> +#define LTC2992_POWER(x)		(LTC2992_POWER1 + ((x) * 0x32))
> +#define LTC2992_POWER_MAX(x)		(LTC2992_POWER1_MAX + ((x) * 0x32))
> +#define LTC2992_POWER_MIN(x)		(LTC2992_POWER1_MIN + ((x) * 0x32))
> +#define LTC2992_POWER_MAX_THRESH(x)	(LTC2992_POWER1_MAX_THRESH + ((x) * 0x32))
> +#define LTC2992_POWER_MIN_THRESH(x)	(LTC2992_POWER1_MIN_THRESH + ((x) * 0x32))
> +#define LTC2992_DSENSE(x)		(LTC2992_DSENSE1 + ((x) * 0x32))
> +#define LTC2992_DSENSE_MAX(x)		(LTC2992_DSENSE1_MAX + ((x) * 0x32))
> +#define LTC2992_DSENSE_MIN(x)		(LTC2992_DSENSE1_MIN + ((x) * 0x32))
> +#define LTC2992_DSENSE_MAX_THRESH(x)	(LTC2992_DSENSE1_MAX_THRESH + ((x) * 0x32))
> +#define LTC2992_DSENSE_MIN_THRESH(x)	(LTC2992_DSENSE1_MIN_THRESH + ((x) * 0x32))
> +#define LTC2992_SENSE(x)		(LTC2992_SENSE1 + ((x) * 0x32))
> +#define LTC2992_SENSE_MAX(x)		(LTC2992_SENSE1_MAX + ((x) * 0x32))
> +#define LTC2992_SENSE_MIN(x)		(LTC2992_SENSE1_MIN + ((x) * 0x32))
> +#define LTC2992_SENSE_MAX_THRESH(x)	(LTC2992_SENSE1_MAX_THRESH + ((x) * 0x32))
> +#define LTC2992_SENSE_MIN_THRESH(x)	(LTC2992_SENSE1_MIN_THRESH + ((x) * 0x32))
> +#define LTC2992_POWER_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
> +#define LTC2992_SENSE_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
> +#define LTC2992_DSENSE_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
> +
> +/* FAULT1 FAULT2 registers common bitfields */
> +#define LTC2992_POWER_FAULT_MSK		GENMASK(7, 6)
> +#define LTC2992_DSENSE_FAULT_MSK	GENMASK(5, 4)
> +#define LTC2992_SENSE_FAULT_MSK		GENMASK(3, 2)
> +
> +/* FAULT1 bitfields */
> +#define LTC2992_GPIO1_FAULT_MSK		GENMASK(1, 0)
> +
> +/* FAULT2 bitfields */
> +#define LTC2992_GPIO2_FAULT_MSK		GENMASK(1, 0)
> +
> +/* FAULT3 bitfields */
> +#define LTC2992_GPIO3_FAULT_MSK		GENMASK(7, 6)
> +#define LTC2992_GPIO4_FAULT_MSK		GENMASK(5, 4)
> +
> +#define LTC2992_IADC_NANOV_LSB		12500
> +#define LTC2992_VADC_UV_LSB		25000
> +#define LTC2992_VADC_GPIO_UV_LSB	500
> +
> +struct ltc2992_state {
> +	struct i2c_client		*client;
> +	struct regmap			*regmap;
> +	u32				r_sense_uohm[2];
> +};
> +
> +struct ltc2992_gpio_regs {
> +	u8	data;
> +	u8	max;
> +	u8	min;
> +	u8	max_thresh;
> +	u8	min_thresh;
> +	u8	alarm;
> +	u8	alarm_msk;
> +};
> +
> +static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
> +	{
> +		.data = LTC2992_G1,
> +		.max = LTC2992_G1_MAX,
> +		.min = LTC2992_G1_MIN,
> +		.max_thresh = LTC2992_G1_MAX_THRESH,
> +		.min_thresh = LTC2992_G1_MIN_THRESH,
> +		.alarm = LTC2992_FAULT1,
> +		.alarm_msk = LTC2992_GPIO1_FAULT_MSK,
> +	},
> +	{
> +		.data = LTC2992_G2,
> +		.max = LTC2992_G2_MAX,
> +		.min = LTC2992_G2_MIN,
> +		.max_thresh = LTC2992_G2_MAX_THRESH,
> +		.min_thresh = LTC2992_G2_MIN_THRESH,
> +		.alarm = LTC2992_FAULT2,
> +		.alarm_msk = LTC2992_GPIO2_FAULT_MSK,
> +	},
> +	{
> +		.data = LTC2992_G3,
> +		.max = LTC2992_G3_MAX,
> +		.min = LTC2992_G3_MIN,
> +		.max_thresh = LTC2992_G3_MAX_THRESH,
> +		.min_thresh = LTC2992_G3_MIN_THRESH,
> +		.alarm = LTC2992_FAULT3,
> +		.alarm_msk = LTC2992_GPIO3_FAULT_MSK,
> +	},
> +	{
> +		.data = LTC2992_G4,
> +		.max = LTC2992_G4_MAX,
> +		.min = LTC2992_G4_MIN,
> +		.max_thresh = LTC2992_G4_MAX_THRESH,
> +		.min_thresh = LTC2992_G4_MIN_THRESH,
> +		.alarm = LTC2992_FAULT3,
> +		.alarm_msk = LTC2992_GPIO4_FAULT_MSK,
> +	},
> +};
> +
> +static int ltc2992_read_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len, u32 *val)
> +{

The return value is at most three bytes, and it is always 0 or positive.
That means it is really unnecessary to pass a pointer to the return
value. I would suggest to just return the value directly as int,
combined with the error.

> +	u8 regvals[4];
> +	int ret;
> +	int i;
> +
> +	ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = 0;
> +	for (i = 0; i < reg_len; i++)
> +		*val |= regvals[reg_len - i - 1] << (i * 8);
> +
> +	return 0;
> +}
> +
> +static int ltc2992_write_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len, u32 val)
> +{
> +	u8 regvals[4];
> +	int i;
> +
> +	for (i = 0; i < reg_len; i++)
> +		regvals[reg_len - i - 1] = (val >> (i * 8)) & 0xFF;
> +
> +	return regmap_bulk_write(st->regmap, addr, regvals, reg_len);
> +}
> +
> +static umode_t ltc2992_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> +				  int channel)
> +{
> +	const struct ltc2992_state *st = data;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_min:
> +		case hwmon_in_max:
> +		case hwmon_in_alarm:
> +			return 0444;
> +		case hwmon_in_min_alarm:
> +		case hwmon_in_max_alarm:
> +			return 0644;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_curr_min:
> +		case hwmon_curr_max:
> +		case hwmon_curr_alarm:
> +			if (st->r_sense_uohm[channel])
> +				return 0444;
> +			break;
> +		case hwmon_curr_min_alarm:
> +		case hwmon_curr_max_alarm:
> +			if (st->r_sense_uohm[channel])
> +				return 0644;
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +		case hwmon_power_min:
> +		case hwmon_power_max:
> +		case hwmon_power_alarm:
> +			if (st->r_sense_uohm[channel])
> +				return 0444;
> +			break;
> +		case hwmon_power_min_alarm:
> +		case hwmon_power_max_alarm:
> +			if (st->r_sense_uohm[channel])
> +				return 0644;
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltc2992_get_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long *val)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = ltc2992_read_reg(st, reg, 2, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg_val = reg_val >> 4;
> +	*val = DIV_ROUND_CLOSEST(reg_val * scale, 1000);
> +
> +	return 0;
> +}
> +
> +static int ltc2992_set_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long val)
> +{
> +	val = DIV_ROUND_CLOSEST(val * 1000, scale);
> +	val = val << 4;
> +
> +	return ltc2992_write_reg(st, reg, 2, val);
> +}
> +
> +static int ltc2992_read_gpio_alarm(struct ltc2992_state *st, int nr_gpio, long *val)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = ltc2992_read_reg(st, ltc2992_gpio_addr_map[nr_gpio].alarm, 1, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = !!(reg_val & ltc2992_gpio_addr_map[nr_gpio].alarm_msk);
> +
> +	reg_val &= ~ltc2992_gpio_addr_map[nr_gpio].alarm_msk;
> +	return ltc2992_write_reg(st, ltc2992_gpio_addr_map[nr_gpio].alarm, 1, reg_val);
> +}
> +
> +static int ltc2992_read_gpios_in(struct device *dev, u32 attr, int nr_gpio, long *val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].data;
> +		break;
> +	case hwmon_in_min:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].min;
> +		break;
> +	case hwmon_in_max:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].max;
> +		break;
> +	case hwmon_in_min_alarm:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].min_thresh;
> +		break;
> +	case hwmon_in_max_alarm:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].max_thresh;
> +		break;
> +	case hwmon_in_alarm:
> +		return ltc2992_read_gpio_alarm(st, nr_gpio, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_get_voltage(st, reg, LTC2992_VADC_GPIO_UV_LSB, val);
> +}
> +
> +static int ltc2992_read_in(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg_val;
> +	u32 reg;
> +	int ret;
> +
> +	if (channel > 1)
> +		return ltc2992_read_gpios_in(dev, attr, channel - 2, val);
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		reg = LTC2992_SENSE(channel);
> +		break;
> +	case hwmon_in_min:
> +		reg = LTC2992_SENSE_MIN(channel);
> +		break;
> +	case hwmon_in_max:
> +		reg = LTC2992_SENSE_MAX(channel);
> +		break;
> +	case hwmon_in_min_alarm:
> +		reg = LTC2992_SENSE_MIN_THRESH(channel);
> +		break;
> +	case hwmon_in_max_alarm:
> +		reg = LTC2992_SENSE_MAX_THRESH(channel);
> +		break;
> +	case hwmon_in_alarm:
> +		ret = ltc2992_read_reg(st, LTC2992_SENSE_FAULT(channel), 1, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = !!(reg_val & LTC2992_SENSE_FAULT_MSK);
> +
> +		reg_val &= ~LTC2992_SENSE_FAULT_MSK;
> +		return ltc2992_write_reg(st, LTC2992_SENSE_FAULT(channel), 1, reg_val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_get_voltage(st, reg, LTC2992_VADC_UV_LSB, val);
> +}
> +
> +static int ltc2992_get_current(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = ltc2992_read_reg(st, reg, 2, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg_val = reg_val >> 4;
> +	*val = DIV_ROUND_CLOSEST(reg_val * LTC2992_IADC_NANOV_LSB, st->r_sense_uohm[channel]);
> +
> +	return 0;
> +}
> +
> +static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, long val)
> +{
> +	u32 reg_val;
> +
> +	reg_val = DIV_ROUND_CLOSEST(val * st->r_sense_uohm[channel], LTC2992_IADC_NANOV_LSB);
> +	reg_val = reg_val << 4;
> +
> +	return ltc2992_write_reg(st, reg, 2, reg_val);
> +}
> +
> +static int ltc2992_read_curr(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg_val;
> +	u32 reg;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		reg = LTC2992_DSENSE(channel);
> +		break;
> +	case hwmon_curr_min:
> +		reg = LTC2992_DSENSE_MIN(channel);
> +		break;
> +	case hwmon_curr_max:
> +		reg = LTC2992_DSENSE_MAX(channel);
> +		break;

The datasheet is a bit vague what those registers report, but I
_think_ it is peak minimum and maximum data. If so, that should
be reported with currX_lowest and currX_highest. Resetting
those values should be done by writing into curr_reset_history
It looks like there is only one reset bit (CTRLB[3]). With that, you
can either implement all of {in,curr,power}_reset_history
and have each reset everything, or pick just one reset_history
attribute and document that it resets all lowest and highest
attributes.

> +	case hwmon_curr_min_alarm:
> +		reg = LTC2992_DSENSE_MIN_THRESH(channel);
> +		break;
> +	case hwmon_curr_max_alarm:
> +		reg = LTC2992_DSENSE_MAX_THRESH(channel);
> +		break;

This is wrong. The alarm attributes indicate that a limit has been exceeded.
However, LTC2992_DSENSE_MAX_THRESH() and LTC2992_DSENSE_MIN_THRESH()
point to limit registers. Those should be reported and set with
currX_min and currX_max.

> +	case hwmon_curr_alarm:
> +		ret = ltc2992_read_reg(st, LTC2992_DSENSE_FAULT(channel), 1, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = !!(reg_val & LTC2992_DSENSE_FAULT_MSK);
> +
This is also wrong. The chip reports min_alarm and max_alarm
separately, and thus only the min_alarm and max_alarm attributes
should be provided. curr_alarm should only be provided if
the chip does not separate alarm reasons.

The same problems apply to the power and voltage sensors.

> +		reg_val &= ~LTC2992_DSENSE_FAULT_MSK;
> +		return ltc2992_write_reg(st, LTC2992_DSENSE_FAULT(channel), 1, reg_val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_get_current(st, reg, channel, val);
> +}
> +
> +static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = ltc2992_read_reg(st, reg, 3, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = mul_u64_u32_div(reg_val, LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB,
> +			       st->r_sense_uohm[channel] * 1000);
> +
> +	return 0;
> +}
> +
> +static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, long val)
> +{
> +	u32 reg_val;
> +
> +	reg_val = mul_u64_u32_div(val, st->r_sense_uohm[channel] * 1000,
> +				  LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB);
> +
> +	return ltc2992_write_reg(st, reg, 3, reg_val);
> +}
> +
> +static int ltc2992_read_power(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg_val;
> +	u32 reg;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		reg = LTC2992_POWER(channel);
> +		break;
> +	case hwmon_power_min:
> +		reg = LTC2992_POWER_MIN(channel);
> +		break;
> +	case hwmon_power_max:
> +		reg = LTC2992_POWER_MAX(channel);
> +		break;
> +	case hwmon_power_min_alarm:
> +		reg = LTC2992_POWER_MIN_THRESH(channel);
> +		break;
> +	case hwmon_power_max_alarm:
> +		reg = LTC2992_POWER_MAX_THRESH(channel);
> +		break;
> +	case hwmon_power_alarm:
> +		ret = ltc2992_read_reg(st, LTC2992_POWER_FAULT(channel), 1, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = !!(reg_val & LTC2992_POWER_FAULT_MSK);
> +
> +		reg_val &= ~LTC2992_POWER_FAULT_MSK;
> +		return ltc2992_write_reg(st, LTC2992_POWER_FAULT(channel), 1, reg_val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_get_power(st, reg, channel, val);
> +}
> +
> +static int ltc2992_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			long *val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return ltc2992_read_in(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return ltc2992_read_curr(dev, attr, channel, val);
> +	case hwmon_power:
> +		return ltc2992_read_power(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ltc2992_write_curr(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg = 0;

Unnecessary initialization.

> +
> +	switch (attr) {
> +	case hwmon_curr_min_alarm:
> +		reg = LTC2992_DSENSE_MIN_THRESH(channel);
> +		break;
> +	case hwmon_curr_max_alarm:
> +		reg = LTC2992_DSENSE_MAX_THRESH(channel);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_set_current(st, reg, channel, val);
> +}
> +
> +static int ltc2992_write_gpios_in(struct device *dev, u32 attr, int nr_gpio, long val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	switch (attr) {
> +	case hwmon_in_min_alarm:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].min_thresh;
> +		break;
> +	case hwmon_in_max_alarm:
> +		reg = ltc2992_gpio_addr_map[nr_gpio].max_thresh;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_set_voltage(st, reg, LTC2992_VADC_GPIO_UV_LSB, val);
> +}
> +
> +static int ltc2992_write_in(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg = 0;
> +
> +	if (channel > 1)
> +		return ltc2992_write_gpios_in(dev, attr, channel - 2, val);
> +
> +	switch (attr) {
> +	case hwmon_curr_min_alarm:
> +		reg = LTC2992_SENSE_MIN_THRESH(channel);
> +		break;
> +	case hwmon_curr_max_alarm:
> +		reg = LTC2992_SENSE_MAX_THRESH(channel);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_set_voltage(st, reg, LTC2992_VADC_UV_LSB, val);
> +}
> +
> +static int ltc2992_write_power(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct ltc2992_state *st = dev_get_drvdata(dev);
> +	u32 reg = 0;
> +
> +	switch (attr) {
> +	case hwmon_power_min_alarm:
> +		reg = LTC2992_POWER_MIN_THRESH(channel);
> +		break;
> +	case hwmon_power_max_alarm:
> +		reg = LTC2992_POWER_MAX_THRESH(channel);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ltc2992_set_power(st, reg, channel, val);
> +}
> +
> +static int ltc2992_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			 long val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return ltc2992_write_in(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return ltc2992_write_curr(dev, attr, channel, val);
> +	case hwmon_power:
> +		return ltc2992_write_power(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops ltc2992_hwmon_ops = {
> +	.is_visible = ltc2992_is_visible,
> +	.read = ltc2992_read,
> +	.write = ltc2992_write,
> +};
> +
> +static const u32 ltc2992_in_config[] = {
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM |
> +	HWMON_I_MAX_ALARM | HWMON_I_ALARM,
> +	0
> +};
> +
> +static const struct hwmon_channel_info ltc2992_in = {
> +	.type = hwmon_in,
> +	.config = ltc2992_in_config,
> +};
> +
> +static const u32 ltc2992_curr_config[] = {
> +	HWMON_C_INPUT | HWMON_C_MIN | HWMON_C_MAX | HWMON_C_MIN_ALARM | HWMON_C_MAX_ALARM |
> +	HWMON_C_ALARM,
> +	HWMON_C_INPUT | HWMON_C_MIN | HWMON_C_MAX | HWMON_C_MIN_ALARM | HWMON_C_MAX_ALARM |
> +	HWMON_C_ALARM,
> +	0
> +};
> +
> +static const struct hwmon_channel_info ltc2992_curr = {
> +	.type = hwmon_curr,
> +	.config = ltc2992_curr_config,
> +};
> +
> +static const u32 ltc2992_power_config[] = {
> +	HWMON_P_INPUT | HWMON_P_MIN | HWMON_P_MAX | HWMON_P_MIN_ALARM | HWMON_P_MAX_ALARM |
> +	HWMON_P_ALARM,
> +	HWMON_P_INPUT | HWMON_P_MIN | HWMON_P_MAX | HWMON_P_MIN_ALARM | HWMON_P_MAX_ALARM |
> +	HWMON_P_ALARM,
> +	0
> +};
> +
> +static const struct hwmon_channel_info ltc2992_power = {
> +	.type = hwmon_power,
> +	.config = ltc2992_power_config,
> +};
> +
> +static const struct hwmon_channel_info *ltc2992_info[] = {
> +	&ltc2992_in,
> +	&ltc2992_curr,
> +	&ltc2992_power,
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info ltc2992_chip_info = {
> +	.ops = &ltc2992_hwmon_ops,
> +	.info = ltc2992_info,
> +};
> +
> +static const struct regmap_config ltc2992_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xE8,
> +};
> +
> +static int ltc2992_parse_dt(struct ltc2992_state *st)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *child;
> +	u32 addr;
> +	u32 val;
> +	int ret;
> +
> +	fwnode = dev_fwnode(&st->client->dev);

This is the only use of st->client. Just pass dev as parameter
instead.

> +
> +	fwnode_for_each_available_child_node(fwnode, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &addr);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (addr > 1)
> +			return -EINVAL;
> +
> +		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
> +		if (!ret)
> +			st->r_sense_uohm[addr] = val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltc2992_i2c_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *hwmon_dev;
> +	struct ltc2992_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->client = client;
> +	st->regmap = devm_regmap_init_i2c(client, &ltc2992_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ltc2992_parse_dt(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, client->name, st,
> +							 &ltc2992_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id ltc2992_of_match[] = {
> +	{ .compatible = "adi,ltc2992" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc2992_of_match);
> +
> +static const struct i2c_device_id ltc2992_i2c_id[] = {
> +	{"ltc2992", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc2992_i2c_id);
> +
> +static struct i2c_driver ltc2992_i2c_driver = {
> +	.driver = {
> +		.name = "ltc2992",
> +		.of_match_table = ltc2992_of_match,
> +	},
> +	.probe    = ltc2992_i2c_probe,

The probe function is being deprecated. Please use probe_new instead.

> +	.id_table = ltc2992_i2c_id,
> +};
> +
> +module_i2c_driver(ltc2992_i2c_driver);
> +
> +MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
> +MODULE_DESCRIPTION("Hwmon driver for Linear Technology 2992");
> +MODULE_LICENSE("Dual BSD/GPL");
