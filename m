Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72912A5D13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgKDDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKDDVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:21:32 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31910C061A4D;
        Tue,  3 Nov 2020 19:21:31 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id k3so6215321otp.12;
        Tue, 03 Nov 2020 19:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HeVarH5yGAovOqFnBV42aLuM75y37aMiQX55ANuT+O0=;
        b=j/Ia4reoD8Thioz9NXvyndYIypg9iuM5tidBtlwUtjG5ICQZyr5FICysPYtfiDUF5q
         FTpHN7v1yq1Jlu4bLut0RyI+ODfDYaZ8aShwEtxUgJpRZ/nIb7PjXvab7FarS+e2VWqh
         OxW+h8ioxudTreo53HU6sARTh87zMblXBNly6FczNQZNleAVSvK7pAcrpDe135aKFe4O
         c/m+mkdQWnVkkjxpsYXLj/XqzmUOkcGhtdXFz1ycpcu1g7dEGCEUdRNFUU0hHy3RMPUQ
         kLluAHvihyxqPWnC3TuPNTByOBf/9+pIJSjxEfIUQeoN0/y1QSErqJ15o0NqW1XSME6m
         F2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HeVarH5yGAovOqFnBV42aLuM75y37aMiQX55ANuT+O0=;
        b=De4i+RuKOTpoOMMxxc5DTUe5N9obDPZdpOUcjKr1ioFHEiCK7BH35tJ9z0dxVsIBhA
         Rh74xsXp4iGhQxHcvLXftCQuxYzxweWBmGdaOEI579TDVLC5k3HwGQbWfkOLqZYdD3uG
         n1T1uI/fpuvGLBNV2xWnBrifpq1/18C5rwSJc4He7VF5NS0nrMJaru0ZE74mmc9orBC0
         OZpMRgFwF/MD9zndnbrsuEqZ3fh4YXOqqgHc59Wqmp/nf/IBn96roh5riPT1id6ckt0W
         TLCLyfGrn8SG2W76rMjfHD4XCN/YHn8AswxWeBrjd/cFUZgb5/himNMJZyrR8jcQuoEK
         vlDg==
X-Gm-Message-State: AOAM530OUSBtwZlk8LEN0551WtvAwV6dyRsO+88WoqTLcRJjPC6s+zu4
        XEN2zG6JAOlgiiK9SS6/5VnASyKGNIM=
X-Google-Smtp-Source: ABdhPJxPE/L8kj1hChHfhtXc1Xg1fit5UHDn3MXIlDtPkLa+kDdxj8clifPAm5wm/tSKI8in6qbYJQ==
X-Received: by 2002:a9d:39ca:: with SMTP id y68mr2391435otb.237.1604460088308;
        Tue, 03 Nov 2020 19:21:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm199170otq.69.2020.11.03.19.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 19:21:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6] hwmon:Driver for Delta power supplies Q54SJ108A2
To:     "xiao.mx.ma" <734056705@qq.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiao.mx.ma@deltaww.com, jiajia.feng@deltaww.com
References: <tencent_8E53A3B5A0BD227044009A0774F1E9FB6909@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f60efcc3-bbb6-c851-e72e-c532bf7e1a88@roeck-us.net>
Date:   Tue, 3 Nov 2020 19:21:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_8E53A3B5A0BD227044009A0774F1E9FB6909@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 5:36 PM, xiao.mx.ma wrote:
> From: "xiao.ma" <xiao.mx.ma@deltaww.com>
> 
> The <drivers/hwmon/pmbus/delta.c> provides a driver for Delta's modules.
> Currently supports Q54SJ108A2 series and other series will continue to be
> added in the future.
> 
> Signed-off-by: xiao.ma <xiao.mx.ma@deltaww.com>
> ---
> 
> Notes:
>     Patch v2 changelog:
>     	Add delta.rst in Documentation/hwmon.
>     	Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIES".
>     	Modify code: drop the excessive empty lines, correct the comment content, adjust indent, remove extra brackets.
>     Patch v3 changelog:
>     	Add delta.rst to Documentation/hwmon/index.rst.
>     	Tristate "DELTA_POWER_SUPPLIES" in Kconfig is changed to "Delta Power Supplies".
>     Patch v4 changelog:
>     	Correct the spelling "Temperature" in the delta.rst.
>     	Add Write_protect when write command VOUT_OV_FAULT_RESPONSE and IOUT_OC_FAULT_RESPONSE.
>     Patch v5 changelog:
>     	Add some non-standard attributes in sysfs system.
>     Patch v6 changelog:
>     	delta.c and delta.rst are renamed to q54sj108a2.c and q54sj108a2.rst.
>     	Add q54sj108a2 to index.rst.
>     	Tristate in Kconfig is changed to "Delta Power Supplies Q54SJ108A2".
>     	The non-standard attributes are added to debugfs.
> 
>  Documentation/hwmon/index.rst      |   1 +
>  Documentation/hwmon/q54sj108a2.rst |  52 +++
>  drivers/hwmon/pmbus/Kconfig        |   9 +
>  drivers/hwmon/pmbus/Makefile       |   1 +
>  drivers/hwmon/pmbus/q54sj108a2.c   | 488 +++++++++++++++++++++++++++++
>  5 files changed, 551 insertions(+)
>  create mode 100644 Documentation/hwmon/q54sj108a2.rst
>  create mode 100755 drivers/hwmon/pmbus/q54sj108a2.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b797db738225..4bb680b3c7ea 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -148,6 +148,7 @@ Hardware Monitoring Kernel Drivers
>     powr1220
>     pxe1610
>     pwm-fan
> +   q54sj108a2
>     raspberrypi-hwmon
>     sch5627
>     sch5636
> diff --git a/Documentation/hwmon/q54sj108a2.rst b/Documentation/hwmon/q54sj108a2.rst
> new file mode 100644
> index 000000000000..a575bdfa7c18
> --- /dev/null
> +++ b/Documentation/hwmon/q54sj108a2.rst
> @@ -0,0 +1,52 @@
> +Kernel driver q54sj108a2
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
> +    Xiao.ma <xiao.mx.ma@deltaww.com>
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
> +===================== ===== ==================================================
> +curr1_alarm           RO    Output current alarm
> +curr1_input           RO    Output current
> +curr1_label           RO    'iout1'
> +in1_alarm             RO    Input voltage alarm
> +in1_input             RO    Input voltage
> +in1_label             RO    'vin'
> +in2_alarm             RO    Output voltage alarm
> +in2_input             RO    Output voltage
> +in2_label             RO    'vout1'
> +temp1_alarm           RO    Temperature alarm
> +temp1_input           RO    Chip temperature
> +===================== ===== ==================================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a25faf69fce3..01de280820ee 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -229,6 +229,15 @@ config SENSORS_PXE1610
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pxe1610.
>  
> +config SENSORS_Q54SJ108A2
> +	tristate "Delta Power Supplies Q54SJ108A2"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta
> +	  Q54SJ108A2 series Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called q54sj108a2.
> +
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4c97ad0bd791..a50122cd455b 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
> +obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> new file mode 100755
> index 000000000000..b6c912373ff6
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
> + * Regulated Power Module
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
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
> +#define STORE_DEFAULT_ALL         0x11
> +#define ERASE_BLACKBOX_DATA       0xD1
> +#define READ_HISTORY_EVENT_NUMBER 0xD2
> +#define READ_HISTORY_EVENTS       0xE0
> +#define SET_HISTORY_EVENT_OFFSET  0xE1
> +#define PMBUS_CMD_FLASH_KEY_WRITE 0xEC
> +
> +enum chips {
> +	Q54SJ108A2
> +};
> +
> +enum {
> +	DELTA_DEBUGFS_OPERATION = 0,
> +	DELTA_DEBUGFS_CLEARFAULT,
> +	DELTA_DEBUGFS_WRITEPROTECT,
> +	DELTA_DEBUGFS_STOREDEFAULT,
> +	DELTA_DEBUGFS_VOOV_RESPONSE,
> +	DELTA_DEBUGFS_IOOC_RESPONSE,
> +	DELTA_DEBUGFS_PMBUS_VERSION,
> +	DELTA_DEBUGFS_MFR_ID,
> +	DELTA_DEBUGFS_MFR_MODEL,
> +	DELTA_DEBUGFS_MFR_REVISION,
> +	DELTA_DEBUGFS_MFR_LOCATION,
> +	DELTA_DEBUGFS_BLACKBOX_ERASE,
> +	DELTA_DEBUGFS_BLACKBOX_READ_OFFSET,
> +	DELTA_DEBUGFS_BLACKBOX_SET_OFFSET,
> +	DELTA_DEBUGFS_BLACKBOX_READ,
> +	DELTA_DEBUGFS_FLASH_KEY,
> +	DELTA_DEBUGFS_NUM_ENTRIES
> +};
> +
> +struct delta_data {
> +	enum chips chip;
> +	struct i2c_client *client;
> +
> +	int debugfs_entries[DELTA_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), struct delta_data, debugfs_entries[(y)])
> +
> +static struct pmbus_driver_info delta_info[] = {
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
> +static void char_to_char(const char *charin, char *charout, int charinsize)
> +{
> +	int i;
> +	char char_temp[2 * I2C_SMBUS_BLOCK_MAX + 1];
> +
> +	for (i = 0; i < charinsize; i++) {
> +		char_temp[i*2] = *(charin + i) & 0x0F;
> +		char_temp[i*2+1] = (*(charin + i) & 0xF0) >> 4;
> +	}
> +
> +	for (i = 0; i < (charinsize * 2); i++) {
> +		if ((char_temp[i] >= 0) && (char_temp[i] <= 9))
> +			*(charout + charinsize * 2 - 1 - i) = char_temp[i] + '0';
> +		else if ((char_temp[i] >= 0xA) && (char_temp[i] <= 0xF))
> +			*(charout + charinsize * 2 - 1 - i) = (char_temp[i] - 0xA) + 'A';
> +	}
> +}

Please use bin2hex() or similar.

> +
> +static ssize_t delta_debugfs_read(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct delta_data *psu = to_psu(idxp, idx);
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +
> +	switch (idx) {
> +	case DELTA_DEBUGFS_OPERATION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_WRITEPROTECT:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_WRITE_PROTECT);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_VOOV_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_IOOC_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_PMBUS_VERSION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_MFR_ID:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_ID, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case DELTA_DEBUGFS_MFR_MODEL:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_MODEL, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case DELTA_DEBUGFS_MFR_REVISION:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_REVISION, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case DELTA_DEBUGFS_MFR_LOCATION:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_LOCATION, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case DELTA_DEBUGFS_BLACKBOX_READ_OFFSET:
> +		rc = i2c_smbus_read_byte_data(psu->client, READ_HISTORY_EVENT_NUMBER);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case DELTA_DEBUGFS_BLACKBOX_READ:
> +		rc = i2c_smbus_read_block_data(psu->client, READ_HISTORY_EVENTS, data_char);
> +		if (rc < 0)
> +			return rc;
> +
> +		char_to_char(data_char, data, 32);
> +

That writes 64 bytes into a buffer of size I2C_SMBUS_BLOCK_MAX + 2 = 34.
That really makes me wonder what happens if it is actually executed.
Did you try ?

> +		rc = 64;
> +		break;
> +	case DELTA_DEBUGFS_FLASH_KEY:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_CMD_FLASH_KEY_WRITE, data_char);
> +		if (rc < 0)
> +			return rc;
> +
> +		char_to_char(data_char, data, 4);
> +
> +		rc = 8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +done:
> +	data[rc] = '\n';
> +	rc += 2;

Is that supposed to return the terminating '\0' ?

> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static int char_to_int(const char *buff)
> +{
> +	int i, index;
> +	int value = 0;
> +	const char *str;
> +
> +	if ((*buff == '0') && (*(buff+1) == 'x')) {
> +		index = 16;
> +		str = buff + 2;
> +	} else
> +		return -1;
> +
> +	for (i = 0; i < (strlen(str) - 1); i++) {
> +		if (*(str+i) >= '0' && *(str+i) <= '9')
> +			value = value * index + (*(str+i) - '0');
> +		else if (*(str+i) >= 'a' && *(str+i) <= 'f') {
> +			if (index == 16)
> +				value = value * index + (*(str+i) - 'a' + 10);
> +			else
> +				return -1;
> +		} else if (*(str+i) >= 'A' && *(str+i) <= 'F') {
> +			if (index == 16)
> +				value = value * index + (*(str+i) - 'A' + 10);
> +			else
> +				return -1;
> +		} else
> +			return -1;
> +	}
> +
> +	return value;
> +}
> +

Please use standard functions. I don't see the need to reinvent kstrtoint and friends.


> +static ssize_t delta_debugfs_write(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	u8 data;
> +	u8 flash_key[4];
> +	ssize_t rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct delta_data *psu = to_psu(idxp, idx);
> +
> +	rc = i2c_smbus_write_byte_data(psu->client, PMBUS_WRITE_PROTECT, 0);
> +	if (rc)
> +		return rc;
> +
> +	switch (idx) {
> +	case DELTA_DEBUGFS_OPERATION:
> +		data = char_to_int(buf);
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_OPERATION, data);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_CLEARFAULT:
> +		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_STOREDEFAULT:
> +		flash_key[0] = 0x7E;
> +		flash_key[1] = 0x15;
> +		flash_key[2] = 0xDC;
> +		flash_key[3] = 0x42;
> +		rc = i2c_smbus_write_block_data(psu->client, PMBUS_CMD_FLASH_KEY_WRITE, 4, flash_key);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte(psu->client, STORE_DEFAULT_ALL);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_VOOV_RESPONSE:
> +		data = char_to_int(buf);
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE, data);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_IOOC_RESPONSE:
> +		data = char_to_int(buf);
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE, data);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_BLACKBOX_ERASE:
> +		rc = i2c_smbus_write_byte(psu->client, ERASE_BLACKBOX_DATA);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	case DELTA_DEBUGFS_BLACKBOX_SET_OFFSET:
> +		data = char_to_int(buf);
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, SET_HISTORY_EVENT_OFFSET, data);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rc;

Unless I am missing something, this always returns 1. Why not just return 1 directly ?
And why not return 'count', as would be more common ?

> +}
> +
> +static const struct file_operations delta_fops = {
> +	.llseek = noop_llseek,
> +	.read = delta_debugfs_read,
> +	.write = delta_debugfs_write,
> +	.open = simple_open,
> +};
> +
> +static int delta_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct pmbus_driver_info *info;
> +	enum chips chip_id;
> +	int ret, i;
> +	struct dentry *debugfs;
> +	struct dentry *delta_dir;
> +	struct delta_data *psu;
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
> +	ret = pmbus_do_probe(client, id, &delta_info[chip_id]);
> +	if (ret)
> +		return ret;
> +
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;
> +
> +	psu->client = client;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +
> +	delta_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!delta_dir)
> +		return 0;
> +

Error checking of debugfs functions is discouraged. While that is arguable,
I keep getting follow-up patches to remove all such error checks. Please drop.

> +	for (i = 0; i < DELTA_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("operation", 0644, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_OPERATION],
> +			    &delta_fops);
> +	debugfs_create_file("clear_fault", 0200, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_CLEARFAULT],
> +			    &delta_fops);
> +	debugfs_create_file("write_protect", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_WRITEPROTECT],
> +			    &delta_fops);
> +	debugfs_create_file("store_default", 0200, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_STOREDEFAULT],
> +			    &delta_fops);
> +	debugfs_create_file("vo_ov_response", 0644, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_VOOV_RESPONSE],
> +			    &delta_fops);
> +	debugfs_create_file("io_oc_response", 0644, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_IOOC_RESPONSE],
> +			    &delta_fops);
> +	debugfs_create_file("pmbus_revision", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_PMBUS_VERSION],
> +			    &delta_fops);
> +	debugfs_create_file("mfr_id", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_MFR_ID],
> +			    &delta_fops);
> +	debugfs_create_file("mfr_model", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_MFR_MODEL],
> +			    &delta_fops);
> +	debugfs_create_file("mfr_revision", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_MFR_REVISION],
> +			    &delta_fops);
> +	debugfs_create_file("mfr_location", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_MFR_LOCATION],
> +			    &delta_fops);
> +	debugfs_create_file("blackbox_erase", 0200, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_BLACKBOX_ERASE],
> +			    &delta_fops);
> +	debugfs_create_file("blackbox_read_offset", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_BLACKBOX_READ_OFFSET],
> +			    &delta_fops);
> +	debugfs_create_file("blackbox_set_offset", 0200, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_BLACKBOX_SET_OFFSET],
> +			    &delta_fops);
> +	debugfs_create_file("blackbox_read", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_BLACKBOX_READ],
> +			    &delta_fops);
> +	debugfs_create_file("flash_key", 0444, delta_dir,
> +			    &psu->debugfs_entries[DELTA_DEBUGFS_FLASH_KEY],
> +			    &delta_fops);
> +	return 0;
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

New drivers are supposed to use the probe_new function.

> +	.remove = pmbus_do_remove,

No longer exists.

> +	.id_table = delta_id,
> +};
> +
> +module_i2c_driver(delta_driver);
> +
> +MODULE_AUTHOR("Xiao.Ma <xiao.mx.ma@deltaww.com>");
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 series modules");
> +MODULE_LICENSE("GPL");
> 

