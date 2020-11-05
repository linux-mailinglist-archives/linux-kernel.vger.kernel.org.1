Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A472A82A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgKEPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:51:49 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B28C0613CF;
        Thu,  5 Nov 2020 07:51:48 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m13so2120381oih.8;
        Thu, 05 Nov 2020 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zVDBpA4pJP6gyCV2Lu6Ba2zQAg/I5af95fNgot9wSQs=;
        b=oRWzBa+UDIpufaKKi/PbO/KQU87a4c4Riwdd2/ZuVBj41iKTXE9VLDlx5qHMIdT5H+
         6dKFZPcaPx5Bnb8AvRWooNL23bp1+rgdnW8hzksOvoxbufzNXP8iyw54I2nLfBGVylgp
         /fSey4Atum9up1qstzvIx7CwAV/OUGli6SBlmrqExr63zLELH2759IiQyptu26jFpliO
         vwRooPjjDd9ZWi+w3HXshtlBQXQk1d3f10m3PJArsCtNSlU+oAsvnm/O69FwGt8QYBHd
         DtaMxzlaJzY3LiOzbbqcGaYxLde4eoEKSTriPkPdWy1YNIhSl7RSDV9KdIBz/N9StVj9
         I3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zVDBpA4pJP6gyCV2Lu6Ba2zQAg/I5af95fNgot9wSQs=;
        b=iP6zwQDucdM+y7wl/kSl6L0txxCFXFwD5GG0NQG6vTMOyXdS5WrLmRhSf8fGglU5Xz
         ScpMxTEg3jXQC+rWX1ve7VBBidtCj+YaJJS8KWqUQPlZwpwOZbwS1T1Hpv/MQoV+hZU8
         HoSSJzDqYST7P4yuamVnzqeebtDomypYjdaSQRrZGWrnJURKNrmlSAnKwfXYEQ7epLIa
         FY+XqKRKV1pYLrQgUmL6UPKyia+XjyJ+BCTE5GCpeCFM692o0MRrO47Mr5jGhlziopFu
         89c5QzKZPvsVwz+c4CZLDh/Hg4sMl72hOH+oXwrUux9Ay7denx+aGSdKZctufRa7tPdn
         HRyQ==
X-Gm-Message-State: AOAM531xus1xrVDpUdWxogmIxEYS16fUZDCutz0r6vWkESryg60KHMen
        yHbcwsMkAOOhpQoYQ+T+HE70qLSaZ1c=
X-Google-Smtp-Source: ABdhPJxozVe0v4z9I3pTjauJZV2nTfTTfOyRs/kgQnb5Ba0ULRgg5kF35xCFN8XuFQ0gtxYCKM4//Q==
X-Received: by 2002:aca:ef56:: with SMTP id n83mr40144oih.30.1604591508186;
        Thu, 05 Nov 2020 07:51:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w70sm445330oiw.29.2020.11.05.07.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 07:51:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7] hwmon:Driver for Delta power supplies Q54SJ108A2
To:     "xiao.mx.ma" <734056705@qq.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
References: <tencent_7B0E2D4FB415F442C4AC487FB38AEE193D06@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bf745a0b-e69d-dfdc-c7cd-27defd8906fe@roeck-us.net>
Date:   Thu, 5 Nov 2020 07:51:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_7B0E2D4FB415F442C4AC487FB38AEE193D06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 1:35 AM, xiao.mx.ma wrote:
> From: "xiao.ma" <xiao.mx.ma@deltaww.com>
> 
> The <drivers/hwmon/pmbus/q54sj108a2.c> provides a driver for Delta's modules.

"This driver supports ..." or similar is sufficient. We don't need a reference
to the file name in the commit message.

> Currently supports Q54SJ108A2 series and other series will continue to be
> added in the future.
> 
> Signed-off-by: xiao.ma <xiao.mx.ma@deltaww.com>

I still can't figure out why your patches don't make it to any mailing lists.
Are you sending them encoded ? I see the patch is really sent from

From: "xiao.mx.ma" <734056705@qq.com>

No idea if that is the reason. Is that Fom address rejected for some reason ?

Either case, you'll need to send your patch in a way that it is listed in patchwork,
and received by mailing lists. I won't be able to accept it otherwise.

> ---
> 
> Notes:
>     Patch v2 changelog:
>     	Add delta.rst in Documentation/hwmon.
>     	Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIED".
>     	Modify code: drop the excessive empty lines, correct the comment content, adjust indent, remove extra brackets.
>     Patch v3 changelog:
>     	Add delta.rst to Documentation/hwmon/index.rst.
>     	Tristate "DELTA_POWER_SUPPLIES" in Kconfig is changed to "Delta Power Supplies".
>     Patch v4 changelog:
>     	Correct the spelling "Temperature" in the delta.rst.
>     	Add Write_protect when write command VOUT_OV_RESPONSE and IOUT_OC_FAULT_RESPONSE.
>     Patch v5 changelog:
>     	Add some non-standard attributes in sysfs system.
>     Patch v6 changelog:
>     	delta.c and delta.rst are renamed to q54sj108a2.c and q54sj108a2.rst.
>     	Add q54sj108a2 to index.rst.
>     	Tristate in Kconfig is changed to "Delta Power Supplies Q54SJ108A2".
>     	The non-standard attributes are added to debugfs.
>     Patch v7 changelog:
>     	Use standard fuctions bin2hex and hex2bin.
>     	The return of debugfs write is changed to count.
>     	Drop the error checking of debugfs functions.
>     	Use probe_new fuction.
>     	Remove the .remove fuction.
> 
>  Documentation/hwmon/index.rst      |   1 +
>  Documentation/hwmon/q54sj108a2.rst |  52 ++++
>  drivers/hwmon/pmbus/Kconfig        |   9 +
>  drivers/hwmon/pmbus/Makefile       |   1 +
>  drivers/hwmon/pmbus/q54sj108a2.c   | 437 +++++++++++++++++++++++++++++
>  5 files changed, 500 insertions(+)
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
> index 000000000000..8ab322347015
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
> + * Regulated Power Module
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +#include <linux/bits.h>

Is this include needed ?

> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>

What is this include needed for ?

> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

No mutexes used by this driver.

> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>
> +#include <linux/util_macros.h>

I can't see any functions used from this include.

Please make sure that the include files are indeed all needed.

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
> +	Q54SJ108A2_DEBUGFS_OPERATION = 0,
> +	Q54SJ108A2_DEBUGFS_CLEARFAULT,
> +	Q54SJ108A2_DEBUGFS_WRITEPROTECT,
> +	Q54SJ108A2_DEBUGFS_STOREDEFAULT,
> +	Q54SJ108A2_DEBUGFS_VOOV_RESPONSE,
> +	Q54SJ108A2_DEBUGFS_IOOC_RESPONSE,
> +	Q54SJ108A2_DEBUGFS_PMBUS_VERSION,
> +	Q54SJ108A2_DEBUGFS_MFR_ID,
> +	Q54SJ108A2_DEBUGFS_MFR_MODEL,
> +	Q54SJ108A2_DEBUGFS_MFR_REVISION,
> +	Q54SJ108A2_DEBUGFS_MFR_LOCATION,
> +	Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE,
> +	Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET,
> +	Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET,
> +	Q54SJ108A2_DEBUGFS_BLACKBOX_READ,
> +	Q54SJ108A2_DEBUGFS_FLASH_KEY,
> +	Q54SJ108A2_DEBUGFS_NUM_ENTRIES
> +};
> +
> +struct q54sj108a2_data {
> +	enum chips chip;
> +	struct i2c_client *client;
> +
> +	int debugfs_entries[Q54SJ108A2_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), struct q54sj108a2_data, debugfs_entries[(y)])
> +
> +static struct pmbus_driver_info q54sj108a2_info[] = {
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
> +static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct q54sj108a2_data *psu = to_psu(idxp, idx);
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +	char *res;
> +
> +	switch (idx) {
> +	case Q54SJ108A2_DEBUGFS_OPERATION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case Q54SJ108A2_DEBUGFS_WRITEPROTECT:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_WRITE_PROTECT);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case Q54SJ108A2_DEBUGFS_PMBUS_VERSION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
> +	case Q54SJ108A2_DEBUGFS_MFR_ID:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_ID, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case Q54SJ108A2_DEBUGFS_MFR_MODEL:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_MODEL, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case Q54SJ108A2_DEBUGFS_MFR_REVISION:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_REVISION, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case Q54SJ108A2_DEBUGFS_MFR_LOCATION:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_LOCATION, data);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET:
> +		rc = i2c_smbus_read_byte_data(psu->client, READ_HISTORY_EVENT_NUMBER);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;

The 'done' label is unnecessary.

> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_READ:
> +		rc = i2c_smbus_read_block_data(psu->client, READ_HISTORY_EVENTS, data);
> +		if (rc < 0)
> +			return rc;
> +
> +		res = bin2hex(data, data_char, 32);
> +		rc = res - data;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_FLASH_KEY:
> +		rc = i2c_smbus_read_block_data(psu->client, PMBUS_CMD_FLASH_KEY_WRITE, data);
> +		if (rc < 0)
> +			return rc;
> +
> +		res = bin2hex(data, data_char, 4);
> +		rc = res - data;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +done:
> +	data[rc] = '\n';
> +	rc += 2;
> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	u8 flash_key[4];
> +	u8 dst_data;
> +	ssize_t rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	int res;
> +	struct q54sj108a2_data *psu = to_psu(idxp, idx);
> +
> +	rc = i2c_smbus_write_byte_data(psu->client, PMBUS_WRITE_PROTECT, 0);
> +	if (rc)
> +		return rc;
> +
> +	switch (idx) {
> +	case Q54SJ108A2_DEBUGFS_OPERATION:
> +		res = hex2bin(&dst_data, buf, 1);
> +		if (res != 0)
> +			return res;
> +

I don't see the point of the 'res' variable (in addition to rc).
It should just be
		rc = ...
		if (rc)
			return rc;

Also, using hex2bin for a 1-byte conversion is not what it is supposed
to be used for, and it is confusing. It is supposed to be used for buffer
conversions, not for 1-byte conversions. What is the problem with kstrtoint()
or, if you don't want to use that, kstrtou8() ?

> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_OPERATION, dst_data);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_CLEARFAULT:
> +		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_STOREDEFAULT:
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

You are using
		if (rc)
and
		if (rc < 0)
and
		if (res != 0)

Please make the code consistent.

> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
> +		res = hex2bin(&dst_data, buf, 1);
> +		if (res != 0)
> +			return res;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE, dst_data);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
> +		res = hex2bin(&dst_data, buf, 1);
> +		if (res != 0)
> +			return res;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE, dst_data);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE:
> +		rc = i2c_smbus_write_byte(psu->client, ERASE_BLACKBOX_DATA);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET:
> +		res = hex2bin(&dst_data, buf, 1);
> +		if (res != 0)
> +			return res;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, SET_HISTORY_EVENT_OFFSET, dst_data);
> +		if (rc)
> +			return rc;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations q54sj108a2_fops = {
> +	.llseek = noop_llseek,
> +	.read = q54sj108a2_debugfs_read,
> +	.write = q54sj108a2_debugfs_write,
> +	.open = simple_open,
> +};
> +
> +static const struct i2c_device_id q54sj108a2_id[] = {
> +	{ "Q54SJ108A2", Q54SJ108A2 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, q54sj108a2_id);
> +
> +static int q54sj108a2_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct pmbus_driver_info *info;
> +	enum chips chip_id;
> +	int ret, i;
> +	struct dentry *debugfs;
> +	struct dentry *q54sj108a2_dir;
> +	struct q54sj108a2_data *psu;
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
> +		chip_id = i2c_match_id(q54sj108a2_id, client)->driver_data;
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
info isn't used anywhere and thus pointless.

> +	ret = pmbus_do_probe(client, &q54sj108a2_id[chip_id], &q54sj108a2_info[chip_id]);
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
> +
> +	q54sj108a2_dir = debugfs_create_dir(client->name, debugfs);
> +
> +	for (i = 0; i < Q54SJ108A2_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("operation", 0644, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_OPERATION],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("clear_fault", 0200, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_CLEARFAULT],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("write_protect", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_WRITEPROTECT],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("store_default", 0200, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_STOREDEFAULT],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("vo_ov_response", 0644, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_VOOV_RESPONSE],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("io_oc_response", 0644, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_IOOC_RESPONSE],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("pmbus_revision", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_PMBUS_VERSION],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("mfr_id", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_ID],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("mfr_model", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_MODEL],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("mfr_revision", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_REVISION],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("mfr_location", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_LOCATION],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("blackbox_erase", 0200, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("blackbox_read_offset", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("blackbox_set_offset", 0200, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("blackbox_read", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_READ],
> +			    &q54sj108a2_fops);
> +	debugfs_create_file("flash_key", 0444, q54sj108a2_dir,
> +			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_FLASH_KEY],
> +			    &q54sj108a2_fops);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id q54sj108a2_of_match[] = {
> +	{ .compatible = "delta,Q54SJ108A2", .data = (void *)Q54SJ108A2 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, q54sj108a2_of_match);
> +
> +static struct i2c_driver q54sj108a2_driver = {
> +	.driver = {
> +		.name = "Q54SJ108A2",
> +		.of_match_table = q54sj108a2_of_match,
> +	},
> +	.probe_new = q54sj108a2_probe,
> +	.id_table = q54sj108a2_id,
> +};
> +
> +module_i2c_driver(q54sj108a2_driver);
> +
> +MODULE_AUTHOR("Xiao.Ma <xiao.mx.ma@deltaww.com>");
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 series modules");
> +MODULE_LICENSE("GPL");
> 

