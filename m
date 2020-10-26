Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0E2990F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783820AbgJZPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:25:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37568 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783812AbgJZPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:25:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id f7so10857590oib.4;
        Mon, 26 Oct 2020 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L3pKsGThwoyzY49Hn2bFt1gCrWCvgTkv+X2DgLqaiAQ=;
        b=GsLujnEIqwCLn9voXRW/vKkQeGFX1trw8/uB5jZ51vQ0syXBaKapRKcaUz3KAnX9yo
         FePSxv+7tHGmPpXiaPhFnuyRDdM8n4pAnERlf5+rVBCUItjnnB5Dsnf4fgWLpFaEzy1a
         wTbBeUVZuRw6NF7kQHFGIq6SOwCBLply1MwS7druCwoT+qwivU+X1ezaht7J4K5gBTtu
         GIxmlfKuVnWURq9gEK3PIIbe/yH63T9c3exeSvJ2Ciarcdk2n8u8Jb1F4RMAmxJRAgrj
         AAVc7CQ9fOyzBaTKm7WM8vW7p0qZKMJu60oWQJiThQDA6bvtz5ccjT1GKAueidFxHv4D
         NESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=L3pKsGThwoyzY49Hn2bFt1gCrWCvgTkv+X2DgLqaiAQ=;
        b=V07bRGGhvmjzxM2Csc8V0TufLBOsJXsNe2OCT977jTpoT9W46AM8pqB+FBqhECOt+l
         PTlWMKBwrT6r4W7tpkTol1KKch+gacRKzYrDiGKsHU2v8cvE0PJ345mHCeI9qsuPLbMg
         5L4TyWWHNuzkh31j0ewlfxlwfx9gcUPy+C0HeNj2BZP00s+WvC5ShRQ/gHakMGRyMUnp
         tzpvmUJrpVl2V43z/08YiUGdwWKYgm/zmBt6bFpVkyYUFOY/dE7eyPK9INcPXQUtxcO5
         Eipqqmc2f7moSBDAbYFn6a+M71/FI3QfVdW+BKDIcE87Fy5+QQjD0wzSOpfrl4w0uaT0
         nijQ==
X-Gm-Message-State: AOAM533ODVYdPEntWX9RuWHravYDGU29kRFlI7w2qE2NHiXmMuJNR0Ow
        w5Fvlxq+VzCTC3BljYm2qv0g/xSInmI=
X-Google-Smtp-Source: ABdhPJw0g7ZWDA5Pe4LO/JClUZ41uHkJ16h145sxtiSNUOcFpX5jRNzvkUW/2a3B5VcOQow+rwyYNQ==
X-Received: by 2002:aca:5347:: with SMTP id h68mr12983027oib.161.1603725917484;
        Mon, 26 Oct 2020 08:25:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 105sm3643394otf.52.2020.10.26.08.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 08:25:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 08:25:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add Corsair PSU HID controller driver
Message-ID: <20201026152515.GA55313@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 07:08:07AM +0100, Wilken Gottwalt wrote:
> The Corsair digital power supplies of the series RMi, HXi and AXi
> include a small micro-controller with a lot of sensors attached. It can
> be accessed by an USB connector from the outside.
> 
> This micro-controller provides its data by a simple proprietary USB HID
> protocol. The data provided are temperatures, current and voltage levels,
> power used, uptimes, fan speed and a lot more. It is also possible to
> configure the PSU (fan mode, mono/multi-rail, over current protection).
> 
> This driver provides access to the sensors/statistics of the RMi and HXi
> series power supplies. It does not support configuring these devices,
> because there would be many ways to misconfigure or even damage the PSU.
> 
> This patch adds:
> - hwmon driver corsair-psu
> - hwmon documentation
> - updates MAINTAINERS
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> ---
> Changes in v2:
> 	- changed comments to hwmon style comments

This is not "hwmon style". Please read and follow
Documentation/process/coding-style.rst.

> 	- simplified some switches
> 	- removed redundant code
> 	- removed misuse of EIO
> 	- changed a todo to a proper explanation
> 	- changed debugfs, which
> +do not fit into the hwmon class.
> +
> +Debugfs entries
> +---------------
> +
> +=======================	========================================================
> +uptime			Current uptime of the psu
> +uptime_total		Total uptime of the psu
> +vendor			Vendor name of the psu
> +product			Product name of the psu
> +=======================	========================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 750d3a975d82..b2a8a47f742a 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -48,6 +48,7 @@ Hardware Monitoring Kernel Drivers
>     bt1-pvt
>     coretemp
>     corsair-cpro
> +   corsair-psu
>     da9052
>     da9055
>     dell-smm-hwmon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 867157311dc8..d1a4e54b21ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4478,6 +4478,13 @@ L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hwmon/corsair-cpro.c
>  
> +CORSAIR-PSU HARDWARE MONITOR DRIVER
> +M:	Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/corsair-psu.rst
> +F:	drivers/hwmon/corsair-psu.c
> +
>  COSA/SRP SYNC SERIAL DRIVER
>  M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
>  S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8dc28b26916e..2a38963f0cc6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -449,6 +449,19 @@ config SENSORS_CORSAIR_CPRO
>  	  This driver can also be built as a module. If so, the module
>  	  will be called corsair-cpro.
>  
> +config SENSORS_CORSAIR_PSU
> +	tristate "Corsair PSU HID controller"
> +	depends on HID
> +	help
> +	  If you say yes here you get support for Corsair PSUs with a HID
> +	  interface.
> +	  Currently this driver supports the (RM/HX)550, (RM/HX)650i,
> +	  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
> +	  by Corsair.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called corsair-psu.
> +
>  config SENSORS_DRIVETEMP
>  	tristate "Hard disk drives with temperature sensors"
>  	depends on SCSI && ATA
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index a8f4b35b136b..2651bcc7ae5f 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
>  obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
> +obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> new file mode 100644
> index 000000000000..53c92197011d
> --- /dev/null
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -0,0 +1,631 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * corsair-psu.c - Linux driver for Corsair power supplies with HID sensors interface
> + * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/debugfs.h>
> +#include <linux/errno.h>
> +#include <linux/hid.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/*
> + * Corsair protocol for PSUs
> + *
> + * message size = 64 bytes (request and response, little endian)
> + * request:
> + *	[length][command][param0][param1][paramX]...
> + * reply:
> + *	[echo of length][echo of command][data0][data1][dataX]...
> + *
> + *	- commands are byte sized opcodes
> + *	- length is the sum of all bytes of the commands/params
> + *	- the micro-controller of most of these PSUs support concatenation in the request and reply,
> + *	  but it is better to not rely on this (it is also hard to parse)
> + *	- the driver uses raw events to be accessible from userspace (though this is not really
> + *	  supported, it is just there for convenience, may be removed in the future)
> + *	- a reply always start with the length and command in the same order the request used it
> + *	- length of the reply data is specific to the command used
> + *	- some of the commands work on a rail and can be switched to a specific rail (0 = 12v,
> + *	  1 = 5v, 2 = 3.3v)
> + *	- the format of the init command 0xFE is swapped length/command bytes
> + *	- parameter bytes amount and values are specific to the command (rail setting is the only
> + *	  for now that uses non-zero values)
> + *	- there are much more commands, especially for configuring the device, but they are not
> + *	  supported because a wrong command/length can lockup the micro-controller
> + *	- the driver supports debugfs for values not fitting into the hwmon class
> + *	- not every device class (HXi, RMi or AXi) supports all commands
> + *	- it is a pure sensors reading driver (will not support configuring)
> + */
> +
> +#define DRIVER_NAME		"corsair-psu"
> +
> +#define REPLY_SIZE		16 /* max length of a reply to a single command */
> +#define CMD_BUFFER_SIZE		64
> +#define CMD_TIMEOUT_MS		250
> +#define SECONDS_PER_HOUR	(60 * 60)
> +#define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
> +
> +#define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
> +#define PSU_CMD_IN_VOLTS	0x88 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_IN_AMPS		0x89
> +#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
> +#define PSU_CMD_RAIL_AMPS	0x8C
> +#define PSU_CMD_TEMP0		0x8D
> +#define PSU_CMD_TEMP1		0x8E
> +#define PSU_CMD_FAN		0x90
> +#define PSU_CMD_RAIL_WATTS	0x96
> +#define PSU_CMD_VEND_STR	0x99
> +#define PSU_CMD_PROD_STR	0x9A
> +#define PSU_CMD_TOTAL_WATTS	0xEE
> +#define PSU_CMD_TOTAL_UPTIME	0xD1
> +#define PSU_CMD_UPTIME		0xD2
> +#define PSU_CMD_INIT		0xFE
> +
> +#define L_IN_VOLTS		"v_in"
> +#define L_OUT_VOLTS_12V		"v_out +12v"
> +#define L_OUT_VOLTS_5V		"v_out +5v"
> +#define L_OUT_VOLTS_3_3V	"v_out +3.3v"
> +#define L_IN_AMPS		"curr in"
> +#define L_AMPS_12V		"curr +12v"
> +#define L_AMPS_5V		"curr +5v"
> +#define L_AMPS_3_3V		"curr +3.3v"
> +#define L_FAN			"psu fan"
> +#define L_TEMP0			"vrm temp"
> +#define L_TEMP1			"case temp"
> +#define L_WATTS			"power total"
> +#define L_WATTS_12V		"power +12v"
> +#define L_WATTS_5V		"power +5v"
> +#define L_WATTS_3_3V		"power +3.3v"
> +
> +struct corsairpsu_data {
> +	struct hid_device *hdev;
> +	struct device *hwmon_dev;
> +	struct dentry *debugfs;
> +	struct completion wait_completion;
> +	struct mutex lock; /* for locking access to cmd_buffer */
> +	u8 *cmd_buffer;
> +	char vendor[REPLY_SIZE];
> +	char product[REPLY_SIZE];
> +};
> +
> +/* some values are SMBus LINEAR11 data which need a conversion */
> +static int corsairpsu_linear11_to_int(const u16 val)
> +{
> +	int exp = val >> 0x0B;
> +	int mant = val & 0x7FF;
> +	int i;
> +
> +	if (exp > 0x0F)
> +		exp -= 0x20;
> +	if (mant > 0x3FF)
> +		mant -= 0x800;
> +	if ((mant & 0x01) == 1)
> +		++mant;
> +	if (exp < 0) {
> +		for (i = 0; i < -exp; ++i)
> +			mant /= 2;
> +	} else {
> +		for (i = 0; i < exp; ++i)
> +			mant *= 2;
> +	}
> +
> +	return mant;
> +}
> +
> +static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
> +{
> +	unsigned long time;
> +	int ret;
> +
> +	memset(priv->cmd_buffer, 0, CMD_BUFFER_SIZE);
> +	priv->cmd_buffer[0] = p0;
> +	priv->cmd_buffer[1] = p1;
> +	priv->cmd_buffer[2] = p2;
> +
> +	reinit_completion(&priv->wait_completion);
> +
> +	ret = hid_hw_output_report(priv->hdev, priv->cmd_buffer, CMD_BUFFER_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	time = wait_for_completion_timeout(&priv->wait_completion,
> +					   msecs_to_jiffies(CMD_TIMEOUT_MS));
> +	if (!time)
> +		return -ETIMEDOUT;
> +
> +	/* at the start of the reply is an echo of the send command/length in the same order it	*/
> +	/* was send, not every command is supported on every device class, if a command is not	*/
> +	/* supported, the length value in the reply is okay, but the command value is set to 0	*/

Please read and follow Documentation/process/coding-style.rst
for multi-line comments.

> +	if (p0 != priv->cmd_buffer[0] || p1 != priv->cmd_buffer[1])
> +		return -EOPNOTSUPP;
> +
> +	if (data)
> +		memcpy(data, priv->cmd_buffer + 2, REPLY_SIZE);
> +
> +	return 0;
> +}
> +
> +static int corsairpsu_init(struct corsairpsu_data *priv)
> +{
> +	/* PSU_CMD_INIT uses swapped length/command and expects 2 parameter bytes, this command */
> +	/* actually generates a reply, but we don't need it					*/
> +
> +	return corsairpsu_usb_cmd(priv, PSU_CMD_INIT, 3, 0, NULL);
> +}
> +
> +static int corsairpsu_fwinfo(struct corsairpsu_data *priv)
> +{
> +	int ret;
> +
> +	ret = corsairpsu_usb_cmd(priv, 3, PSU_CMD_VEND_STR, 0, priv->vendor);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = corsairpsu_usb_cmd(priv, 3, PSU_CMD_PROD_STR, 0, priv->product);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, void *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	switch (cmd) {
> +	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_AMPS:
> +	case PSU_CMD_RAIL_WATTS:
> +		ret = corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
> +		if (ret < 0)
> +			goto cmd_fail;
> +		fallthrough;
> +	default:
> +		ret = corsairpsu_usb_cmd(priv, 3, cmd, 0, data);
> +		break;
> +	}
		...
		break;
	default:
		break;
	}

	ret = corsairpsu_usb_cmd(priv, 3, cmd, 0, data);

> +
> +cmd_fail:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, u32 *val)
> +{
> +	u8 data[REPLY_SIZE];
> +	int ret;
> +
> +	ret = corsairpsu_request(priv, cmd, rail, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (cmd) {
> +	case PSU_CMD_IN_VOLTS:
> +	case PSU_CMD_IN_AMPS:
> +	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_AMPS:
> +	case PSU_CMD_TEMP0:
> +	case PSU_CMD_TEMP1:
> +		*val = (data[1] << 8) + data[0];

Please use a local variable to cache the raw value.

> +		*val = corsairpsu_linear11_to_int(*val) * 1000;

Something is wrong here. val is a pointer to u32.
corsairpsu_linear11_to_int(), however, returns an int.
The implementation of corsairpsu_linear11_to_int() suggests
that the value can be negative. Either it can be negative
and needs to be returned as such, or it can't and
corsairpsu_linear11_to_int() should only return unsigned
values.

Also, this can overflow: corsairpsu_linear11_to_int()
can return a value larger that (MAXINT / 1000).

> +		break;
> +	case PSU_CMD_FAN:
> +		/* this value is best guess, so the calculated value could be wrong, it is hard */
> +		/* to ge the fan to spin in these semi-passive power supplies, which need a	*/
> +		/* quite high load to do so							*/
> +		*val = (data[0] << 8) + data[1];
> +		break;
> +	case PSU_CMD_RAIL_WATTS:
> +	case PSU_CMD_TOTAL_WATTS:
> +		*val = (data[1] << 8) + data[0];

Same here.

> +		*val = corsairpsu_linear11_to_int(*val) * 1000000;

Same problems as above, and overflow is even more likely.

> +		break;
> +	case PSU_CMD_TOTAL_UPTIME:
> +	case PSU_CMD_UPTIME:
> +		*val = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
> +					       u32 attr, int channel)
> +{
> +	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
> +		return 0444;
> +	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
> +		return 0444;
> +	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
> +		return 0444;
> +	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
> +		return 0444;
> +	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				     int channel, long *val)
> +{
> +	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> +	u32 tmp;
> +	int ret;
> +
> +	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> +		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> +					   &tmp);
> +	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, &tmp);
> +	} else if (type == hwmon_power && attr == hwmon_power_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, &tmp);
> +			break;
> +		case 1:
> +		case 2:
> +		case 3:

What is the problem with the following ?

		case 1...3:

> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, &tmp);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else if (type == hwmon_in && attr == hwmon_in_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, &tmp);
> +			break;
> +		case 1:
> +		case 2:
> +		case 3:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, &tmp);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, &tmp);
> +			break;
> +		case 1:
> +		case 2:
> +		case 3:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, &tmp);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +	*val = tmp;
> +
> +	return 0;
> +}
> +
> +static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum hwmon_sensor_types type,
> +					    u32 attr, int channel, const char **str)
> +{
> +	if (type == hwmon_temp && attr == hwmon_temp_label) {
> +		*str = channel ? L_TEMP1 : L_TEMP0;
> +		return 0;
> +	} else if (type == hwmon_fan && attr == hwmon_fan_label) {
> +		*str = L_FAN;
> +		return 0;
> +	} else if (type == hwmon_power && attr == hwmon_power_label) {
> +		switch (channel) {
> +		case 0:
> +			*str = L_WATTS;
> +			return 0;
> +		case 1:
> +			*str = L_WATTS_12V;
> +			return 0;
> +		case 2:
> +			*str = L_WATTS_5V;
> +			return 0;
> +		case 3:
> +			*str = L_WATTS_3_3V;
> +			return 0;
> +		default:
> +			break;
> +		}

Just a thought for those:

		const char *watts[] = { L_WATTS, L_WATTS_12V, L_WATTS_5V, L_WATTS_3_3V };

		*str = watts[channel];
		return 0;

> +	} else if (type == hwmon_in && attr == hwmon_in_label) {
> +		switch (channel) {
> +		case 0:
> +			*str = L_IN_VOLTS;
> +			return 0;
> +		case 1:
> +			*str = L_OUT_VOLTS_12V;
> +			return 0;
> +		case 2:
> +			*str = L_OUT_VOLTS_5V;
> +			return 0;
> +		case 3:
> +			*str = L_OUT_VOLTS_3_3V;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	} else if (type == hwmon_curr && attr == hwmon_curr_label) {
> +		switch (channel) {
> +		case 0:
> +			*str = L_IN_AMPS;
> +			return 0;
> +		case 1:
> +			*str = L_AMPS_12V;
> +			return 0;
> +		case 2:
> +			*str = L_AMPS_5V;
> +			return 0;
> +		case 3:
> +			*str = L_AMPS_3_3V;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops corsairpsu_hwmon_ops = {
> +	.is_visible	= corsairpsu_hwmon_ops_is_visible,
> +	.read		= corsairpsu_hwmon_ops_read,
> +	.read_string	= corsairpsu_hwmon_ops_read_string,
> +};
> +
> +static const struct hwmon_channel_info *corsairpsu_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info corsairpsu_chip_info = {
> +	.ops	= &corsairpsu_hwmon_ops,
> +	.info	= corsairpsu_info,
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static void print_uptime(struct seq_file *seqf, u8 cmd)
> +{
> +	struct corsairpsu_data *priv = seqf->private;
> +	u32 val;
> +	int ret;
> +
> +	ret = corsairpsu_get_value(priv, cmd, 0, &val);
> +	if (ret < 0) {
> +		seq_puts(seqf, "N/A\n");
> +		return;
> +	}
> +
> +	if (val > SECONDS_PER_DAY) {
> +		seq_printf(seqf, "%d day(s), %02d:%02d:%02d\n", val / SECONDS_PER_DAY,
> +			   val % SECONDS_PER_DAY / SECONDS_PER_HOUR, val % SECONDS_PER_HOUR / 60,
> +			   val % 60);
> +		return;
> +	}
> +
> +	seq_printf(seqf, "%02d:%02d:%02d\n", val % SECONDS_PER_DAY / SECONDS_PER_HOUR,
> +		   val % SECONDS_PER_HOUR / 60, val % 60);
> +}
> +
> +static int uptime_show(struct seq_file *seqf, void *unused)
> +{
> +	print_uptime(seqf, PSU_CMD_UPTIME);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(uptime);
> +
> +static int uptime_total_show(struct seq_file *seqf, void *unused)
> +{
> +	print_uptime(seqf, PSU_CMD_TOTAL_UPTIME);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(uptime_total);
> +
> +static int vendor_show(struct seq_file *seqf, void *unused)
> +{
> +	struct corsairpsu_data *priv = seqf->private;
> +
> +	seq_printf(seqf, "%s\n", priv->vendor);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(vendor);
> +
> +static int product_show(struct seq_file *seqf, void *unused)
> +{
> +	struct corsairpsu_data *priv = seqf->private;
> +
> +	seq_printf(seqf, "%s\n", priv->product);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(product);
> +
> +static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
> +{
> +	char name[32];
> +
> +	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
> +
> +	priv->debugfs = debugfs_create_dir(name, NULL);
> +	debugfs_create_file("uptime", 0444, priv->debugfs, priv, &uptime_fops);
> +	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
> +	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
> +	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
> +}
> +
> +static void corsairpsu_debugfs_remove(struct corsairpsu_data *priv)
> +{
> +	debugfs_remove_recursive(priv->debugfs);
> +}

If debugfs is not enabled, debugfs_remove_recursive() is a dummy.
That means it can be called unconditionally from the remove function,
and corsairpsu_debugfs_remove() is unnecessary.

> +
> +#else
> +
> +static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
> +{
> +}
> +
> +static void corsairpsu_debugfs_remove(struct corsairpsu_data *priv)
> +{
> +}
> +
> +#endif
> +
> +static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	struct corsairpsu_data *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&hdev->dev, sizeof(struct corsairpsu_data), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->cmd_buffer = devm_kmalloc(&hdev->dev, CMD_BUFFER_SIZE, GFP_KERNEL);
> +	if (!priv->cmd_buffer)
> +		return -ENOMEM;
> +
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret)
> +		goto fail_and_stop;
> +
> +	priv->hdev = hdev;
> +	hid_set_drvdata(hdev, priv);
> +	mutex_init(&priv->lock);
> +	init_completion(&priv->wait_completion);
> +
> +	hid_device_io_start(hdev);
> +
> +	ret = corsairpsu_init(priv);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	ret = corsairpsu_fwinfo(priv);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
> +							  &corsairpsu_chip_info, 0);
> +
> +	if (IS_ERR(priv->hwmon_dev)) {
> +		ret = PTR_ERR(priv->hwmon_dev);
> +		goto fail_and_close;
> +	}
> +
> +	corsairpsu_debugfs_init(priv);
> +
> +	return 0;
> +
> +fail_and_close:
> +	hid_hw_close(hdev);
> +fail_and_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}
> +
> +static void corsairpsu_remove(struct hid_device *hdev)
> +{
> +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> +
> +	corsairpsu_debugfs_remove(priv);
> +	hwmon_device_unregister(priv->hwmon_dev);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> +				int size)
> +{
> +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> +
> +	if (completion_done(&priv->wait_completion))
> +		return 0;
> +
> +	memcpy(priv->cmd_buffer, data, min(CMD_BUFFER_SIZE, size));
> +	complete(&priv->wait_completion);
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id corsairpsu_idtable[] = {
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
> +
> +static struct hid_driver corsairpsu_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= corsairpsu_idtable,
> +	.probe		= corsairpsu_probe,
> +	.remove		= corsairpsu_remove,
> +	.raw_event	= corsairpsu_raw_event,
> +};
> +module_hid_driver(corsairpsu_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@mailbox.org>");
> +MODULE_DESCRIPTION("Linux driver for Corsair power supplies with HID sensors interface");
> -- 
> 2.29.0
> 
