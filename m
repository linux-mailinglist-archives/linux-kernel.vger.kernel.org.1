Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9C290D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgJPVll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgJPVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:41:41 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67EC061755;
        Fri, 16 Oct 2020 14:41:40 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l85so4086516oih.10;
        Fri, 16 Oct 2020 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rFeHEEwY1SIhJC+cwYuB9+pLoczvZz85izTNZs4NhDE=;
        b=V0pWwOP3HBBlcFIqLc1evkU0ggUXghUZtm07U4BlS7Z/e0ro9G89ttDEHqqkUFGotW
         PQScyVQu3MtTRDJ6RTCs4faDN4frUJBszU05UpdOutbiElX4CN8bPxLsxHZEGsbA84if
         TASDsYXvZ4HeE1zt/jeE4rE7O/S++yt05bJak/QaSnsUn5KGqUNYq559216VmV1UfOqd
         hJqikQvq1G7zbwwL7ECvjYB6Pxg894RwsYPctr3dM1EwCng3WR0tOt14YJzSRPpYGI+9
         qftge19dsupash3sgHv/OSM6KZoTirPuTqk/EtUJkynEgES3Lf+YBQNOXfbDHrJw7LM9
         hgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rFeHEEwY1SIhJC+cwYuB9+pLoczvZz85izTNZs4NhDE=;
        b=oOUl2NcBZr7H/5wjkR3DtEsK66zhmfxVmb9pPHd78yfObzLmJQmkrBh3jPQLTGwBUU
         LF62ICxmiWW35ni39KHpTuUTqtFj4dm3MdEo9sEbmE+ENxCFQBYnvmCSF/kgnElt6jOS
         gXxqSpfOXAnnL6TDsqcYLCriJNAWzBuCsrPiofjoxwP3AB4ccs/3Z54jaDIAYo8rySVX
         iW9+0K+N5EhYv5LS6jq9uNJMkymC+PRjgxamXc4i8w82zBX1DgVqdnJHakp9lOn8zui6
         W0AnFj69/ff9aCbq9+BfTdu2BHhYhEZE0qvl4fI2NihJsVlb5U8idPsyqBpN/hijc79S
         27Sw==
X-Gm-Message-State: AOAM531FvPL3KM09Cxgb549ZZL1rwzKBrXjoO0C/woTd/UnEyUNliLQI
        XiIjbx1KiPz76BEwsDh+k8E=
X-Google-Smtp-Source: ABdhPJzSFwSUYTzqdAfOoZPY/y/MVawVSEIGeZhW1Karjeqk4E1cWbtZNYDtMP1cjBDPfOnM1sN3PQ==
X-Received: by 2002:aca:cd8b:: with SMTP id d133mr4021565oig.136.1602884499015;
        Fri, 16 Oct 2020 14:41:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e36sm1309618otb.13.2020.10.16.14.41.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Oct 2020 14:41:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 16 Oct 2020 14:41:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "xiao.mx.ma" <734056705@qq.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
Subject: Re: [PATCH] hwmon:Driver for Delta power supplies
Message-ID: <20201016214137.GA110790@roeck-us.net>
References: <tencent_87CD11BA28F4C0B49ED115D057112E229A08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_87CD11BA28F4C0B49ED115D057112E229A08@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 06:54:55AM +0100, xiao.mx.ma wrote:
> From: Delta <xiao.mx.ma@deltaww.com>
> 
> The <drivers/hwmon/pmbus/delta.c> provides a driver for Delta's modules.
> Currently supports Q54SN108A2 series and other series will continue to be
> added in the future.
> 
> Signed-off-by: Delta <xiao.mx.ma@deltaww.com>

The submitter has to be a person, not a company name.

I don't know how this happened, but the patch is not visible on patchwork.

I am not happy that this is submitted as new driver. It should be (at least)
v5. Actually, looking into my e-mail archive, it is really v7.
Each version is pretty much completely different and suggests something
else that is unacceptable. More on that below.

Please version your patches in the future, and provide change logs.
Also please check why your patches don't make it into patchwork.

Guenter

> ---
>  Documentation/hwmon/delta.rst |  77 ++++++
>  Documentation/hwmon/index.rst |   1 +
>  drivers/hwmon/pmbus/Kconfig   |   9 +
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/delta.c   | 448 ++++++++++++++++++++++++++++++++++
>  5 files changed, 536 insertions(+)
>  create mode 100644 Documentation/hwmon/delta.rst
>  create mode 100755 drivers/hwmon/pmbus/delta.c
> 
> diff --git a/Documentation/hwmon/delta.rst b/Documentation/hwmon/delta.rst
> new file mode 100644
> index 000000000000..daccb31ca222
> --- /dev/null
> +++ b/Documentation/hwmon/delta.rst
> @@ -0,0 +1,77 @@
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
> +operation             RW/RO Turn on or off the product according CONTROL pin.
> +			     Please see datasheet for details. Read-only if the
> +			     chip is write protected; read-write otherwise.
> +clear_fault           WO    clear alarm. Write-only if the chip is not write
> +			     protected.
> +write_protect         RW    write protect control
> +store_default         WO    store data to chip. Write-only if the chip is not
> +			     write protected.
> +vo_ovfault_response   RW/RO The response when after vout ovp. Read-only if the
> +			     chip is write protected; read-write otherwise.
> +io_ocfault_response   RW/RO The response when after iout ocp. Read-only if the
> +			     chip is write protected; read-write otherwise.
> +status_cml            RW/RO Cml status.Read-only if the chip is write protected;
> +			     read-write otherwise.
> +pmbus_revision        RO    Pmbus revision
> +mfr_id                RO    Manufacturer name
> +mfr_model             RO    Product model name
> +mfr_revision          RO    Firmware revision
> +mfr_location          RO    Place of product
> +erase_blackbox        WO    Erase a blackbox. Write-only if the chip is not
> +                            write protected.
> +read_event_num        RO    Index of blackbox
> +read_blackbox         RO    Read a blackbox
> +set_event_num         WO    Set the index of blackbox
> +flash_key             RW/RO Flash key to unlock Flash.

The non-standard attributes are not acceptable. For other PMBus drivers, we have
used debugfs to provide similar functionality. Please use the same mechanism.

The writeable attributes are not acceptable, not even as debugfs files.
Operation should be handled via the regulator subsystem, and most of the
other parameters should only be set during the manufacturing process.
I am very concerned about letting users set any of those.

The only exception might be blackbox related commands, but those are
not hwmon related and should reside in debugfs as well.

> +===================== ===== ==================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 77a1ae975037..e601367cb935 100644
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
> index e35db489b76f..47e58aeec482 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -45,6 +45,15 @@ config SENSORS_BEL_PFE
>  	  This driver can also be built as a module. If so, the module will
>  	  be called bel-pfe.
>  
> +config SENSORS_DELTA
> +	tristate "Delta Power Supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta
> +	  Q54SJ108A2 series Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called delta.
> +
>  config SENSORS_IBM_CFFPS
>  	tristate "IBM Common Form Factor Power Supply"
>  	depends on LEDS_CLASS
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
> new file mode 100755
> index 000000000000..c5f6533a3c2e
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/delta.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Q54SJ108A2 series Integrated, Step-Down
> + * Switching Regulators
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/hwmon-sysfs.h>
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
> +enum delta_index {
> +	operation,
> +	clear_fault,
> +	write_protect,
> +	store_default,
> +	vo_ovfault_response,
> +	io_ocfault_response,
> +	status_cml,
> +	pmbus_revision,
> +	mfr_id,
> +	mfr_model,
> +	mfr_revision,
> +	mfr_location,
> +	erase_blackbox,
> +	read_event_num,
> +	read_blackbox,
> +	set_event_num,
> +	flash_key,
> +	num_regs,
> +};
> +
> +static const u8 delta_regs[num_regs] = {
> +	[operation] = PMBUS_OPERATION,
> +	[clear_fault] = PMBUS_CLEAR_FAULTS,
> +	[write_protect] = PMBUS_WRITE_PROTECT,
> +	[store_default] = STORE_DEFAULT_ALL,
> +	[vo_ovfault_response] = PMBUS_VOUT_OV_FAULT_RESPONSE,
> +	[io_ocfault_response] = PMBUS_IOUT_OC_FAULT_RESPONSE,
> +	[status_cml] = PMBUS_STATUS_CML,
> +	[pmbus_revision] = PMBUS_REVISION,
> +	[mfr_id] = PMBUS_MFR_ID,
> +	[mfr_model] = PMBUS_MFR_MODEL,
> +	[mfr_revision] = PMBUS_MFR_REVISION,
> +	[mfr_location] = PMBUS_MFR_LOCATION,
> +	[erase_blackbox] = ERASE_BLACKBOX_DATA,
> +	[read_blackbox] = READ_HISTORY_EVENTS,
> +	[read_event_num] = READ_HISTORY_EVENT_NUMBER,
> +	[set_event_num] = SET_HISTORY_EVENT_OFFSET,
> +	[flash_key] = PMBUS_CMD_FLASH_KEY_WRITE,
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
> +
> +static ssize_t delta_byte_show(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +	rc = i2c_smbus_read_byte_data(client, reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	return snprintf(buf, PAGE_SIZE, "%02x\n", rc);
> +}
> +
> +static ssize_t delta_string_show(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	char *p;
> +	char data[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +	rc = i2c_smbus_read_block_data(client, reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* filled with printable characters, ending with # */
> +	p = memscan(data, '#', rc);
> +	*p = '\0';
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", data);
> +}
> +
> +static ssize_t delta_blackbox_show(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	char *p;
> +	char data[I2C_SMBUS_BLOCK_MAX + 1];
> +	char data_char[2 * I2C_SMBUS_BLOCK_MAX + 1];
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +	rc = i2c_smbus_read_block_data(client, reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	char_to_char(data, data_char, rc);
> +
> +	/* filled with printable characters, ending with # */
> +	p = memscan(data_char, '#', 64);
> +	*p = '\0';
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", data_char);
> +}
> +
> +static ssize_t delta_flashkey_show(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	char *p;
> +	char data[I2C_SMBUS_BLOCK_MAX + 1];
> +	char data_char[2 * I2C_SMBUS_BLOCK_MAX + 1];
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +	rc = i2c_smbus_read_block_data(client, reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != 4)
> +		return -EPROTO;
> +
> +	char_to_char((data+1), data_char, (rc));
> +
> +	/* filled with printable characters, ending with # */
> +	p = memscan(data_char, '#', 8);
> +	*p = '\0';
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", data_char);
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
> +	} else {
> +		index = 10;
> +		str = buff;
> +	}
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
> +static ssize_t delta_sendbyte_store(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	u8 reg;
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +
> +	rc = i2c_smbus_write_byte(client, reg);
> +	if (rc < 0)
> +		return rc;
> +	return count;
> +}
> +
> +static ssize_t delta_byte_store(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	u8 reg;
> +	int value;
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +
> +	value = char_to_int(buf);
> +
> +	rc = i2c_smbus_write_byte_data(client, reg, (u8)value);
> +	if (rc < 0)
> +		return rc;
> +	return count;
> +}
> +
> +static ssize_t delta_flashkey_store(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	u8 reg;
> +	u8 value[4];
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = delta_regs[attr->index];
> +
> +	if (sysfs_streq("A5A5A5A5", buf)) {
> +		value[0] = 0xA5;
> +		value[1] = 0xA5;
> +		value[2] = 0xA5;
> +		value[3] = 0xA5;
> +		rc = i2c_smbus_write_block_data(client, reg, 4, value);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	} else if (sysfs_streq("7E15DC42", buf)) {
> +		value[0] = 0x7E;
> +		value[1] = 0x15;
> +		value[2] = 0xDC;
> +		value[3] = 0x42;
> +		rc = i2c_smbus_write_block_data(client, reg, 4, value);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RW(operation, delta_byte, operation);
> +static SENSOR_DEVICE_ATTR_WO(clear_fault, delta_sendbyte, clear_fault);
> +static SENSOR_DEVICE_ATTR_RW(write_protect, delta_byte, write_protect);
> +static SENSOR_DEVICE_ATTR_WO(store_default, delta_sendbyte, store_default);
> +static SENSOR_DEVICE_ATTR_RW(vo_ovfault_response, delta_byte, vo_ovfault_response);
> +static SENSOR_DEVICE_ATTR_RW(io_ocfault_response, delta_byte, io_ocfault_response);
> +static SENSOR_DEVICE_ATTR_RW(status_cml, delta_byte, status_cml);
> +static SENSOR_DEVICE_ATTR_RO(pmbus_revision, delta_byte, pmbus_revision);
> +static SENSOR_DEVICE_ATTR_RO(mfr_id, delta_string, mfr_id);
> +static SENSOR_DEVICE_ATTR_RO(mfr_model, delta_string, mfr_model);
> +static SENSOR_DEVICE_ATTR_RO(mfr_revision, delta_string, mfr_revision);
> +static SENSOR_DEVICE_ATTR_RO(mfr_location, delta_string, mfr_location);
> +static SENSOR_DEVICE_ATTR_WO(erase_blackbox, delta_sendbyte, erase_blackbox);
> +static SENSOR_DEVICE_ATTR_RO(read_blackbox, delta_blackbox, read_blackbox);
> +static SENSOR_DEVICE_ATTR_RO(read_event_num, delta_byte, read_event_num);
> +static SENSOR_DEVICE_ATTR_WO(set_event_num, delta_byte, set_event_num);
> +static SENSOR_DEVICE_ATTR_RW(flash_key, delta_flashkey, flash_key);
> +
> +static struct attribute *delta_attrs[] = {
> +	&sensor_dev_attr_operation.dev_attr.attr,
> +	&sensor_dev_attr_clear_fault.dev_attr.attr,
> +	&sensor_dev_attr_write_protect.dev_attr.attr,
> +	&sensor_dev_attr_store_default.dev_attr.attr,
> +	&sensor_dev_attr_vo_ovfault_response.dev_attr.attr,
> +	&sensor_dev_attr_io_ocfault_response.dev_attr.attr,
> +	&sensor_dev_attr_status_cml.dev_attr.attr,
> +	&sensor_dev_attr_pmbus_revision.dev_attr.attr,
> +	&sensor_dev_attr_mfr_id.dev_attr.attr,
> +	&sensor_dev_attr_mfr_model.dev_attr.attr,
> +	&sensor_dev_attr_mfr_revision.dev_attr.attr,
> +	&sensor_dev_attr_mfr_location.dev_attr.attr,
> +	&sensor_dev_attr_erase_blackbox.dev_attr.attr,
> +	&sensor_dev_attr_read_blackbox.dev_attr.attr,
> +	&sensor_dev_attr_read_event_num.dev_attr.attr,
> +	&sensor_dev_attr_set_event_num.dev_attr.attr,
> +	&sensor_dev_attr_flash_key.dev_attr.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(delta);
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
> +
> +		.groups = delta_groups,
> +	},
> +};
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
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA))
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
> +
> +	if (ret != 4 || buf[0] != 'S') {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memcpy(info, &delta_info[chip_id], sizeof(*info));
> +
> +	return pmbus_do_probe(client, id, info);
> +
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
> +MODULE_AUTHOR("Delta <734056705@qq.com>");
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2NCAH / Q54SJ108A2NCDH / Q54SJ108A2NCPG / Q54SJ108A2NCPH");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

