Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133632BC691
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgKVPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 10:48:47 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:44061 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbgKVPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:48:46 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 1A689BA7CC637
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 08:48:44 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id grbXkFnIhh41lgrbXkK3kJ; Sun, 22 Nov 2020 08:48:44 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=FoUrAVjq c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=iyzGlLGqAAAA:8
 a=h0ABR8M4AAAA:8 a=lRFQor0vbwcgk8EDy10A:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=KUY6m_o_WN0hX3XauQzx:22 a=IAbmOp1NCR458IescZAd:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gOpNz4+cw9nujAwiex51wiFu+nd3vm45kFPg2jHnsCg=; b=D2DdBOn2Q/pTHH8Frp1vrMVHj3
        0p+NpXu6yBCY8CZ3/o3l+d+HKncD91vUjaLq556ptFoMlA06Rl83yP1hLVGMKtFvHx+94D8/rewAQ
        KEQq2W8KkWU3nzQaHzFBeXSoi9bX90wTPW2VjCxL49rKODJ+MIZlk9aajZ8Sg4xUJ/RDlfb2JsWSd
        ef2AjHOQb1fzurOTkaNpAfYvxMhyEYxFTdgPMH834aejx7I2jzR9kbSCIpLW6uXGK352yeyvUuhhh
        0YMyv/qj2f1H/nFSl6kouaB0CKnrgLey2eNQqAA30IihmQIrcuERiLp47StDQciljvoBe/0b5vvQR
        pa2qa3og==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45266 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgrbX-003YAv-22; Sun, 22 Nov 2020 15:48:43 +0000
Date:   Sun, 22 Nov 2020 07:48:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "xiao.ma" <max701@126.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
Subject: Re: [PATCH v8] hwmon:Driver for Delta power supplies Q54SJ108A2
Message-ID: <20201122154842.GA121590@roeck-us.net>
References: <20201109065636.4092-1-max701@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109065636.4092-1-max701@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgrbX-003YAv-22
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:45266
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 22
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 08:56:36PM -1000, xiao.ma wrote:
> From: "xiao.ma" <xiao.mx.ma@deltaww.com>
> 
> The driver supports Q54SJ108A2 series modules of Delta.
> Standard attributes are in the sysfs, and other attributes are in the debugfs.
> 
> Signed-off-by: xiao.ma <xiao.mx.ma@deltaww.com>

Please fix all checkpatch errors and warnings before resubmitting.
Additional comments below.

Guenter

> ---
> 
> Notes:
>     Patch v2 changelog:
>     	Add delta.rst in Documentation/hwmon.
>     	Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIED".
>     	Modify code: drop the excessive empty lines, correct the comment content, adjust indent, remove extra brackets.
>     Patch v3 changelog:
>     	Add delta.rst to Documentation/hwmon/index.rst.
>     	Tristate "DELTA_POWER_SUPPLES" in Kconfig is changed to "Delta Power Supplies".
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
>     Patch v8 changelog:
>     	Use kstrtou8_from_user instead of hex2bin.
>     	Remove included head files which are not used.
>     	Done label in debugfs_read fuction is deleted.
>     	Change email to send the patch.
> 
>  Documentation/hwmon/index.rst      |   1 +
>  Documentation/hwmon/q54sj108a2.rst |  52 ++++
>  drivers/hwmon/pmbus/Kconfig        |   9 +
>  drivers/hwmon/pmbus/Makefile       |   1 +
>  drivers/hwmon/pmbus/q54sj108a2.c   | 422 +++++++++++++++++++++++++++++
>  5 files changed, 485 insertions(+)
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
> index 000000000000..f25a5c8c2a2b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
> + * Regulated Power Module
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
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
> +		break;
> +	case Q54SJ108A2_DEBUGFS_WRITEPROTECT:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_WRITE_PROTECT);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		break;
> +	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		break;
> +	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		break;
> +	case Q54SJ108A2_DEBUGFS_PMBUS_VERSION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		break;
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
> +		break;
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
> +	struct q54sj108a2_data *psu = to_psu(idxp, idx);
> +
> +	rc = i2c_smbus_write_byte_data(psu->client, PMBUS_WRITE_PROTECT, 0);
> +	if (rc)
> +		return rc;
> +
> +	switch (idx) {
> +	case Q54SJ108A2_DEBUGFS_OPERATION:
> +		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_OPERATION, dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_CLEARFAULT:
> +		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> +		if (rc < 0)
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
> +		if (rc < 0)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
> +		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE, dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
> +		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE, dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE:
> +		rc = i2c_smbus_write_byte(psu->client, ERASE_BLACKBOX_DATA);
> +		if (rc < 0)
> +			return rc;
> +
> +		break;
> +	case Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET:
> +		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client, SET_HISTORY_EVENT_OFFSET, dst_data);
> +		if (rc < 0)
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

As reported by 0-day, this doesn't work. It needs a cast to unsigned long,
or a double cast, such as
		chip_id = (enum chips)(unsigned long)of_device_get_match_data(dev);

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
> +	ret = pmbus_do_probe(client, &q54sj108a2_id[chip_id], &q54sj108a2_info[chip_id]);

The parameters for this function have changed. Please rebase your patch.

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
