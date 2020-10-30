Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446072A0C91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgJ3Rd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ3Rd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:33:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FCC0613CF;
        Fri, 30 Oct 2020 10:33:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n11so6267155ota.2;
        Fri, 30 Oct 2020 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecKG/mujTVt57xg+tB11tlxt1oyCXpmp5wDfaE/TdfE=;
        b=bFBmYpk5iYqC8bQx2fccXbhBlY7lWJdndmkZ33j7BBJRO4oMXealXTPFjE2iy6vCw5
         RMreowVmseXpWKCJlrqDhOpDdhyFGwGlEP2l9lE8CsyCSFzN2wUBuNgKuBGClsoi+rk8
         ZZn1LrQzxZYyNUxyVC+p7Z3y3R5xVhETXZJOh7VYHSEeXl9b2gseKCKzs6PvqKavkXPM
         L7Ptr43ASHRF3dpiSZD8kHU2mQz3xyjA0WsM7+UaTsbrzCnYTqVr4mYFj+/fEUGPwsHl
         7XtcgBE+py2dVm/pP8xkn1cgrxeTmUJ8J9pvxpURScE0UKrBlS2w1G5jphPykmnPa4W0
         3rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecKG/mujTVt57xg+tB11tlxt1oyCXpmp5wDfaE/TdfE=;
        b=LAeU9OAlYqpLsVNQElj7McMEnRPhXeDcSs2cHjKYXpeACJQkuUb7f9yOCuPDVbX4b4
         nd5FNt6zQ6gtOAM6VBCu2efS3zvktaJi47hPGu0BOK9ZJm55iMO9QoL4hLlgWC+enQxv
         vgm8yksuU9L/CbqomSKg7+/TQmROQjktMl1kv598G6iGzpcAnd90+2XoL74ID0RzRJQL
         EtPtg/JTYeZSmbtDkQqzRFUt+igeoxzcC9n4e0yRbY/bmfd+PyMJ6bdDDDsebyvA09bH
         Nv5btN29nG5oN/3fus97wzZQklKGYLRXUseYOLjQDrXeG58YeBwdf88QJrvHh8NYAeDQ
         O0Nw==
X-Gm-Message-State: AOAM533fa7WjdhO9dROuCUkSqGPOJxDwxAtawOjSSCxyo/ZA+/K68sdI
        K2gW8RXKTYb8OhOGJg+xmcQOy04quTI=
X-Google-Smtp-Source: ABdhPJz3+qk4AlHRti2G0qcznyXVdi+OMlI+acuwWVA1Zwft7dn1s6laSwzFWLcDFcGLKnID/VOtaQ==
X-Received: by 2002:a9d:7b59:: with SMTP id f25mr2479487oto.306.1604079205554;
        Fri, 30 Oct 2020 10:33:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f124sm1560286oia.27.2020.10.30.10.33.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Oct 2020 10:33:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Oct 2020 10:33:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [RESEND PATCH v3] hwmon: add Corsair PSU HID controller driver
Message-ID: <20201030173323.GA38219@roeck-us.net>
References: <20201030053831.GA4943@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030053831.GA4943@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 06:38:31AM +0100, Wilken Gottwalt wrote:
> The Corsair digital power supplies of the series RMi, HXi and AXi include
> a small micro-controller with a lot of sensors attached. The sensors can
> be accessed by an USB connector from the outside.
> 
> This micro-controller provides the data by a simple proprietary USB HID
> protocol. The data consist of temperatures, current and voltage levels,
> power usage, uptimes, fan speed and some more. It is also possible to
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
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

No need to resend. It is in my queue.

Guenter

> ---
> Changes in v3:
>   - changed the email addresses because of serious email provider problems
>   - fixed all multi-line comments
>   - simplifiend some more switches
>   - added more explanations about the values provied by the micro-controller
>   - cached the raw value delivered by the usb_cmd function
> Changes in v2:
>   - changed comments to hwmon style comments
>   - simplified some switches
>   - removed redundant code
>   - removed misuse of EIO
>   - changed a todo to a proper explanation
>   - changed debugfs init/remove code
>   - added 2 more HXi/RMi devices
>   - updated documentation
> ---
>  Documentation/hwmon/corsair-psu.rst |  82 ++++
>  Documentation/hwmon/index.rst       |   1 +
>  MAINTAINERS                         |   7 +
>  drivers/hwmon/Kconfig               |  13 +
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/corsair-psu.c         | 605 ++++++++++++++++++++++++++++
>  6 files changed, 709 insertions(+)
>  create mode 100644 Documentation/hwmon/corsair-psu.rst
>  create mode 100644 drivers/hwmon/corsair-psu.c
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> new file mode 100644
> index 000000000000..396b95c9a76a
> --- /dev/null
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver corsair-psu
> +=========================
> +
> +Supported devices:
> +
> +* Corsair Power Supplies
> +
> +  Corsair HX550i
> +
> +  Corsair HX650i
> +
> +  Corsair HX750i
> +
> +  Corsair HX850i
> +
> +  Corsair HX1000i
> +
> +  Corsair HX1200i
> +
> +  Corsair RM550i
> +
> +  Corsair RM650i
> +
> +  Corsair RM750i
> +
> +  Corsair RM850i
> +
> +  Corsair RM1000i
> +
> +Author: Wilken Gottwalt
> +
> +Description
> +-----------
> +
> +This driver implements the sysfs interface for the Corsair PSUs with a HID protocol
> +interface of the HXi and RMi series.
> +These power supplies provide access to a micro-controller with 2 attached
> +temperature sensors, 1 fan rpm sensor, 4 sensors for volt levels, 4 sensors for
> +power usage and 4 sensors for current levels and addtional non-sensor information
> +like uptimes.
> +
> +Sysfs entries
> +-------------
> +
> +=======================	========================================================
> +curr1_input		Total current usage
> +curr2_input		Current on the 12v psu rail
> +curr3_input		Current on the 5v psu rail
> +curr4_input		Current on the 3.3v psu rail
> +fan1_input		RPM of psu fan
> +in0_input		Voltage of the psu ac input
> +in1_input		Voltage of the 12v psu rail
> +in2_input		Voltage of the 5v psu rail
> +in3_input		Voltage of the 3.3 psu rail
> +power1_input		Total power usage
> +power2_input		Power usage of the 12v psu rail
> +power3_input		Power usage of the 5v psu rail
> +power4_input		Power usage of the 3.3v psu rail
> +temp1_input		Temperature of the psu vrm component
> +temp2_input		Temperature of the psu case
> +=======================	========================================================
> +
> +Usage Notes
> +-----------
> +
> +It is an USB HID device, so it is auto-detected and supports hot-swapping.
> +
> +Flickering values in the rail voltage levels can be an indicator for a failing
> +PSU. The driver also provides some additional useful values via debugfs, which
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
> index e6b91ab12978..408760d13813 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -49,6 +49,7 @@ Hardware Monitoring Kernel Drivers
>     bt1-pvt
>     coretemp
>     corsair-cpro
> +   corsair-psu
>     da9052
>     da9055
>     dell-smm-hwmon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..e1db1f6dd694 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4496,6 +4496,13 @@ L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hwmon/corsair-cpro.c
>  
> +CORSAIR-PSU HARDWARE MONITOR DRIVER
> +M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/corsair-psu.rst
> +F:	drivers/hwmon/corsair-psu.c
> +
>  COSA/SRP SYNC SERIAL DRIVER
>  M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
>  S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a850e4f0e0bd..9d600e0c5584 100644
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
> +	  Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
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
> index 9db2903b61e5..1083bbfac779 100644
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
> index 000000000000..e92d0376e7ac
> --- /dev/null
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * corsair-psu.c - Linux driver for Corsair power supplies with HID sensors interface
> + * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
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
> +static const char *const label_watts[] = {
> +	L_WATTS,
> +	L_WATTS_12V,
> +	L_WATTS_5V,
> +	L_WATTS_3_3V
> +};
> +
> +static const char *const label_volts[] = {
> +	L_IN_VOLTS,
> +	L_OUT_VOLTS_12V,
> +	L_OUT_VOLTS_5V,
> +	L_OUT_VOLTS_3_3V
> +};
> +
> +static const char *const label_amps[] = {
> +	L_IN_AMPS,
> +	L_AMPS_12V,
> +	L_AMPS_5V,
> +	L_AMPS_3_3V
> +};
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
> +static int corsairpsu_linear11_to_int(const int val)
> +{
> +	int exp = (val & 0xFFFF) >> 0x0B;
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
> +	/*
> +	 * at the start of the reply is an echo of the send command/length in the same order it
> +	 * was send, not every command is supported on every device class, if a command is not
> +	 * supported, the length value in the reply is okay, but the command value is set to 0
> +	 */
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
> +	/*
> +	 * PSU_CMD_INIT uses swapped length/command and expects 2 parameter bytes, this command
> +	 * actually generates a reply, but we don't need it
> +	 */
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
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = corsairpsu_usb_cmd(priv, 3, cmd, 0, data);
> +
> +cmd_fail:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, long *val)
> +{
> +	u8 data[REPLY_SIZE];
> +	long tmp;
> +	int ret;
> +
> +	ret = corsairpsu_request(priv, cmd, rail, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * the biggest value here comes from the uptime command and to exceed MAXINT total uptime
> +	 * needs to be about 68 years, the rest are u16 values and the biggest value coming out of
> +	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest psu
> +	 * supported (HX1200i)
> +	 */
> +	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> +	switch (cmd) {
> +	case PSU_CMD_IN_VOLTS:
> +	case PSU_CMD_IN_AMPS:
> +	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_AMPS:
> +	case PSU_CMD_TEMP0:
> +	case PSU_CMD_TEMP1:
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000;
> +		break;
> +	case PSU_CMD_FAN:
> +		/*
> +		 * this value is best guess, so the calculated value could be wrong, it is hard
> +		 * to ge the fan to spin in these semi-passive power supplies, which need a
> +		 * quite high load to do so
> +		 */
> +		*val = ((tmp & 0xFF) << 8) + ((tmp >> 8) & 0xFF);
> +		break;
> +	case PSU_CMD_RAIL_WATTS:
> +	case PSU_CMD_TOTAL_WATTS:
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000000;
> +		break;
> +	case PSU_CMD_TOTAL_UPTIME:
> +	case PSU_CMD_UPTIME:
> +		*val = tmp;
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
> +	int ret;
> +
> +	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> +		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> +					   val);
> +	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> +	} else if (type == hwmon_power && attr == hwmon_power_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
> +			break;
> +		case 1 ... 3:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else if (type == hwmon_in && attr == hwmon_in_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> +			break;
> +		case 1 ... 3:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
> +		switch (channel) {
> +		case 0:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> +			break;
> +		case 1 ... 3:
> +			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
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
> +	} else if (type == hwmon_power && attr == hwmon_power_label && channel < 4) {
> +		*str = label_watts[channel];
> +		return 0;
> +	} else if (type == hwmon_in && attr == hwmon_in_label && channel < 4) {
> +		*str = label_volts[channel];
> +		return 0;
> +	} else if (type == hwmon_curr && attr == hwmon_curr_label && channel < 4) {
> +		*str = label_amps[channel];
> +		return 0;
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
> +	long val;
> +	int ret;
> +
> +	ret = corsairpsu_get_value(priv, cmd, 0, &val);
> +	if (ret < 0) {
> +		seq_puts(seqf, "N/A\n");
> +		return;
> +	}
> +
> +	if (val > SECONDS_PER_DAY) {
> +		seq_printf(seqf, "%ld day(s), %02ld:%02ld:%02ld\n", val / SECONDS_PER_DAY,
> +			   val % SECONDS_PER_DAY / SECONDS_PER_HOUR, val % SECONDS_PER_HOUR / 60,
> +			   val % 60);
> +		return;
> +	}
> +
> +	seq_printf(seqf, "%02ld:%02ld:%02ld\n", val % SECONDS_PER_DAY / SECONDS_PER_HOUR,
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
> +#else
> +
> +static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
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
> +	debugfs_remove_recursive(priv->debugfs);
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
> +MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
> +MODULE_DESCRIPTION("Linux driver for Corsair power supplies with HID sensors interface");
> -- 
> 2.29.0
> 
