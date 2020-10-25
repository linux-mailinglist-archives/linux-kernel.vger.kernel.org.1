Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07E32980B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 08:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767857AbgJYHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767849AbgJYHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 03:38:27 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997EC0613CE;
        Sun, 25 Oct 2020 00:38:26 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CJqZn3nZXzQky8;
        Sun, 25 Oct 2020 08:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received; s=mail20150812; t=1603611501; bh=sN3A3G1duQ
        r8V9p5VzNIha0EVoLDBV2AN7M2LjxJqXs=; b=mIkmHs3Hv/JXuYKnhaxyb6/UT+
        4sbFeZ3nwv2ykiq+2FabrF0ZxemIy8h4/yAlftNj0jb1qPhhF9A+07twWSc41qUF
        XLZ5Wn3JmbMqeRAzv/WjpuRFomhXEs1ifxi5vPEiBeD3fb6W5UtIC2Q+okJBIzyF
        rtPY8po6zMFdvwrsSES8vBzk60XajnM7GSsbjFSy+CdynJSLa2dncTs+aw5StNN1
        hhCtNh4MD5QOgIjBJZ7SjHQG4PXJfColzM1hvPopnIzcSLAE4wY13Af7mSti0fxj
        iHE9QKUVwlRfFROTMcwdGm1Jo42EuRpWi+NB9H+CYcTyO+EZz9EnO4qj2L0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1603611503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uv3IQ85VfhZr65KVW/qTwLIOpmI+e6+H5rwLOK7Wsw=;
        b=xrCcFEQU9kykVWbWCk8aim2iwcwIIZwNRXNX2U8cXk3c07jJY5mv2H3eW/QRykGGQpgQQv
        qZnfHd7PRYPeh10unJUzcMoJIFvoixaaOAHkUtPWpDzUuoDUirUEu7EslV2nT/F7wT2Zg2
        g6cFMOVFRbhiROa1nJz5DvZDvHqAxm2dC+qX5n3qBKglDNw9Kb6YwR2i/+W93rpuEdaTXQ
        p/nCpdUXr1aXBCoPJAHkDmhvo/EVtVMZShGWdKbGtnyiF4CquJbbbxB1wvf7SJfbJu9LCC
        2oliwg9bFWLqFUVqC917b7PprTrTWgwfyJ0eXitm6boCzc1THBcqE8d8QwNQVw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id AYcA--ixA_6o; Sun, 25 Oct 2020 08:38:21 +0100 (CET)
Date:   Sun, 25 Oct 2020 08:38:19 +0100
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 1/1] hwmon: add Corsair PSU HID controller driver
Message-ID: <2256b63fb8f618a773de3eb96edf4c8fa6415e7d.1603609465.git.wilken.gottwalt@mailbox.org>
References: <cover.1603609465.git.wilken.gottwalt@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603609465.git.wilken.gottwalt@mailbox.org>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.38 / 15.00 / 15.00
X-Rspamd-Queue-Id: 42FC917DB
X-Rspamd-UID: 2be3e6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a driver for the Corsair PSU HID protocol, currently supporting
all power supplies of the HXi/RMi series.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 Documentation/hwmon/corsair-psu.rst |  78 ++++
 Documentation/hwmon/index.rst       |   1 +
 MAINTAINERS                         |   7 +
 drivers/hwmon/Kconfig               |  12 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/corsair-psu.c         | 664 ++++++++++++++++++++++++++++
 6 files changed, 763 insertions(+)
 create mode 100644 Documentation/hwmon/corsair-psu.rst
 create mode 100644 drivers/hwmon/corsair-psu.c

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
new file mode 100644
index 000000000000..59e89b4ec270
--- /dev/null
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver corsair-psu
+=========================
+
+Supported devices:
+
+* Corsair Power Supplies
+
+  Corsair HX650i
+
+  Corsair HX750i
+
+  Corsair HX850i
+
+  Corsair HX1000i
+
+  Corsair HX1200i
+
+  Corsair RM650i
+
+  Corsair RM750i
+
+  Corsair RM850i
+
+  Corsair RM1000i
+
+Author: Wilken Gottwalt
+
+Description
+-----------
+
+This driver implements the sysfs interface for the Corsair PSUs with a HID protocol
+interface of the HXi and RMi series.
+These power supplies provide access to a micro-controller with 2 attached
+temperature sensors, 1 fan rpm sensor, 4 sensors for volt levels, 4 sensors for
+power usage and 4 sensors for current levels and addtional non-sensor information
+like uptimes.
+
+Sysfs entries
+-------------
+
+=======================	========================================================
+curr1_input		Total current usage
+curr2_input		Current on the 12v psu rail
+curr3_input		Current on the 5v psu rail
+curr4_input		Current on the 3.3v psu rail
+fan1_input		RPM of psu fan
+in0_input		Voltage of the psu ac input
+in1_input		Voltage of the 12v psu rail
+in2_input		Voltage of the 5v psu rail
+in3_input		Voltage of the 3.3 psu rail
+power1_input		Total power usage
+power2_input		Power usage of the 12v psu rail
+power3_input		Power usage of the 5v psu rail
+power4_input		Power usage of the 3.3v psu rail
+temp1_input		Temperature of the psu vrm component
+temp2_input		Temperature of the psu case
+=======================	========================================================
+
+Usage Notes
+-----------
+
+It is an USB HID device, so it is auto-detected and supports hot-swapping.
+
+Flickering values in the rail voltage levels can be an indicator for a failing
+PSU. The driver also provides some additional useful values via debugfs, which
+do not fit into the hwmon class.
+
+Debugfs entries
+---------------
+
+=======================	========================================================
+uptime			Current uptime of the psu
+uptime_total		Total uptime of the psu
+vendor			Vendor name of the psu
+product			Product name of the psu
+=======================	========================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 750d3a975d82..b2a8a47f742a 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -48,6 +48,7 @@ Hardware Monitoring Kernel Drivers
    bt1-pvt
    coretemp
    corsair-cpro
+   corsair-psu
    da9052
    da9055
    dell-smm-hwmon
diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..d1a4e54b21ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4478,6 +4478,13 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/corsair-cpro.c
 
+CORSAIR-PSU HARDWARE MONITOR DRIVER
+M:	Wilken Gottwalt <wilken.gottwalt@mailbox.org>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/corsair-psu.rst
+F:	drivers/hwmon/corsair-psu.c
+
 COSA/SRP SYNC SERIAL DRIVER
 M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
 S:	Maintained
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8dc28b26916e..bc8fdd13e387 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -449,6 +449,18 @@ config SENSORS_CORSAIR_CPRO
 	  This driver can also be built as a module. If so, the module
 	  will be called corsair-cpro.
 
+config SENSORS_CORSAIR_PSU
+	tristate "Corsair PSU HID controller"
+	depends on HID
+	help
+	  If you say yes here you get support for Corsair PSUs with a HID
+	  interface.
+	  Currently this driver supports the (RM/HX)650i, (RM/HX)750i,
+	  (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies by Corsair.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called corsair-psu.
+
 config SENSORS_DRIVETEMP
 	tristate "Hard disk drives with temperature sensors"
 	depends on SCSI && ATA
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a8f4b35b136b..2651bcc7ae5f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
 obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
+obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
 obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
 obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
new file mode 100644
index 000000000000..f3007e1471d9
--- /dev/null
+++ b/drivers/hwmon/corsair-psu.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * corsair-psu.c - Linux driver for Corsair power supplies with HID sensors interface
+ * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@mailbox.org>
+ */
+
+#include <linux/completion.h>
+#include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/hid.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ * Corsair protocol for PSUs
+ *
+ * message size = 64 bytes (request and response, little endian)
+ * request:
+ *	[length][command][param0][param1][paramX]...
+ * reply:
+ *	[echo of length][echo of command][data0][data1][dataX]...
+ *
+ *	- commands are byte sized opcodes
+ *	- length is the sum of all bytes of the commands/params
+ *	- the micro-controller of most of these PSUs support concatenation in the request and reply,
+ *	  but it is better to not rely on this (it is also hard to parse)
+ *	- the driver uses raw events to be accessible from userspace (though this is not really
+ *	  supported, it is just there for convenience, may be removed in the future)
+ *	- a reply always start with the length and command in the same order the request used it
+ *	- length of the reply data is specific to the command used
+ *	- some of the commands work on a rail and can be switched to a specific rail (0 = 12v,
+ *	  1 = 5v, 2 = 3.3v)
+ *	- the format of the init command 0xFE is swapped length/command bytes
+ *	- parameter bytes amount and values are specific to the command (rail setting is the only
+ *	  for now that uses non-zero values)
+ *	- there are much more commands, especially for configuring the device, but they are not
+ *	  supported because a wrong command/length can lockup the micro-controller
+ *	- the driver supports debugfs for values not fitting into the hwmon class
+ *	- not every device class (HXi, RMi or AXi) supports all commands
+ *	- it is a pure sensors reading driver (will not support configuring)
+ */
+
+#define DRIVER_NAME		"corsair-psu"
+
+#define REPLY_SIZE		16 /* max length of a reply to a single command */
+#define CMD_BUFFER_SIZE		64
+#define CMD_TIMEOUT_MS		250
+#define SECONDS_PER_HOUR	(60 * 60)
+#define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
+
+#define PSU_CMD_SELECT_RAIL	0x00
+#define PSU_CMD_IN_VOLTS	0x88
+#define PSU_CMD_IN_AMPS		0x89
+#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
+#define PSU_CMD_RAIL_AMPS	0x8C
+#define PSU_CMD_TEMP0		0x8D
+#define PSU_CMD_TEMP1		0x8E
+#define PSU_CMD_FAN		0x90
+#define PSU_CMD_RAIL_WATTS	0x96
+#define PSU_CMD_VEND_STR	0x99
+#define PSU_CMD_PROD_STR	0x9A
+#define PSU_CMD_TOTAL_WATTS	0xEE
+#define PSU_CMD_TOTAL_UPTIME	0xD1
+#define PSU_CMD_UPTIME		0xD2
+#define PSU_CMD_INIT		0xFE
+
+#define L_IN_VOLTS		"v_in"
+#define L_OUT_VOLTS_12V		"v_out +12v"
+#define L_OUT_VOLTS_5V		"v_out +5v"
+#define L_OUT_VOLTS_3_3V	"v_out +3.3v"
+#define L_IN_AMPS		"curr in"
+#define L_AMPS_12V		"curr +12v"
+#define L_AMPS_5V		"curr +5v"
+#define L_AMPS_3_3V		"curr +3.3v"
+#define L_FAN			"psu fan"
+#define L_TEMP0			"vrm temp"
+#define L_TEMP1			"case temp"
+#define L_WATTS			"power total"
+#define L_WATTS_12V		"power +12v"
+#define L_WATTS_5V		"power +5v"
+#define L_WATTS_3_3V		"power +3.3v"
+
+struct corsairpsu_data {
+	struct hid_device *hdev;
+	struct device *hwmon_dev;
+	struct completion wait_completion;
+	struct mutex lock; /* for locking access to cmd_buffer */
+	u8 *cmd_buffer;
+	char vendor[REPLY_SIZE];
+	char product[REPLY_SIZE];
+};
+
+/* some values are SMBus LINEAR11 data which need a conversion */
+static int corsairpsu_linear11_to_int(const u16 val)
+{
+	int exp = val >> 0x0B;
+	int mant = val & 0x7FF;
+	int i;
+
+	if (exp > 0x0F)
+		exp -= 0x20;
+	if (mant > 0x3FF)
+		mant -= 0x800;
+	if ((mant & 0x01) == 1)
+		++mant;
+	if (exp < 0) {
+		for (i = 0; i < -exp; ++i)
+			mant /= 2;
+	} else {
+		for (i = 0; i < exp; ++i)
+			mant *= 2;
+	}
+
+	return mant;
+}
+
+static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
+{
+	unsigned long time;
+	int ret;
+
+	memset(priv->cmd_buffer, 0, CMD_BUFFER_SIZE);
+	priv->cmd_buffer[0] = p0;
+	priv->cmd_buffer[1] = p1;
+	priv->cmd_buffer[2] = p2;
+
+	reinit_completion(&priv->wait_completion);
+
+	ret = hid_hw_output_report(priv->hdev, priv->cmd_buffer, CMD_BUFFER_SIZE);
+	if (ret < 0)
+		return ret;
+
+	time = wait_for_completion_timeout(&priv->wait_completion,
+					   msecs_to_jiffies(CMD_TIMEOUT_MS));
+	if (!time)
+		return -ETIMEDOUT;
+
+	/* at the start of the reply is an echo of the send command/length in the same order it was
+	 * send
+	 * not every command is supported on every device class, if a command is not supported, the
+	 * length value in the reply is okay, but the command value is set to 0
+	 */
+	if (p0 != priv->cmd_buffer[0] || p1 != priv->cmd_buffer[1])
+		return -EOPNOTSUPP;
+
+	if (data)
+		memcpy(data, priv->cmd_buffer + 2, REPLY_SIZE);
+
+	return 0;
+}
+
+static int corsairpsu_init(struct corsairpsu_data *priv)
+{
+	/* PSU_CMD_INIT uses swapped length/command and expects 2 parameter bytes, this command
+	 * actually generates a reply, but we don't need it
+	 */
+	return corsairpsu_usb_cmd(priv, PSU_CMD_INIT, 3, 0, NULL);
+}
+
+static int corsairpsu_fwinfo(struct corsairpsu_data *priv)
+{
+	int ret;
+
+	ret = corsairpsu_usb_cmd(priv, 3, PSU_CMD_VEND_STR, 0, priv->vendor);
+	if (ret < 0)
+		return ret;
+
+	ret = corsairpsu_usb_cmd(priv, 3, PSU_CMD_PROD_STR, 0, priv->product);
+	if (ret < 0)
+		return ret;
+
+	dev_info(&priv->hdev->dev, "Corsair PSU: %s %s\n", priv->vendor, priv->product);
+
+	return 0;
+}
+
+static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, void *data)
+{
+	int ret;
+
+	mutex_lock(&priv->lock);
+	switch (cmd) {
+	case PSU_CMD_RAIL_OUT_VOLTS:
+	case PSU_CMD_RAIL_AMPS:
+	case PSU_CMD_RAIL_WATTS:
+		/* PSU_CMD_SELECT_RAIL is the only command with 1 parameter byte only, it is
+		 * the only command for now, that uses a non-zero parameter
+		 */
+		ret = corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
+		if (ret < 0)
+			goto cmd_fail;
+		fallthrough;
+	case PSU_CMD_IN_VOLTS:
+	case PSU_CMD_IN_AMPS:
+	case PSU_CMD_TEMP0:
+	case PSU_CMD_TEMP1:
+	case PSU_CMD_FAN:
+	case PSU_CMD_TOTAL_WATTS:
+	case PSU_CMD_TOTAL_UPTIME:
+	case PSU_CMD_UPTIME:
+		if (!data) {
+			ret = -EIO;
+			goto cmd_fail;
+		}
+		ret = corsairpsu_usb_cmd(priv, 3, cmd, 0, data);
+		break;
+	default:
+		/* don't allow wrong cmd/length combinations which can lockup the micro-controller
+		 * also don't allow a direct rail or call once command (init, vendor, product)
+		 */
+		ret = -EIO;
+		break;
+	}
+
+cmd_fail:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, u32 *val)
+{
+	u8 data[REPLY_SIZE];
+	int ret;
+
+	ret = corsairpsu_request(priv, cmd, rail, data);
+	if (ret < 0)
+		return ret;
+
+	switch (cmd) {
+	case PSU_CMD_IN_VOLTS:
+	case PSU_CMD_IN_AMPS:
+	case PSU_CMD_RAIL_OUT_VOLTS:
+	case PSU_CMD_RAIL_AMPS:
+	case PSU_CMD_TEMP0:
+	case PSU_CMD_TEMP1:
+		*val = (data[1] << 8) + data[0];
+		*val = corsairpsu_linear11_to_int(*val) * 1000;
+		break;
+	case PSU_CMD_FAN:
+		/* TODO: hard to check if this is the correct way to calculate the value, these
+		 *	 Corsair PSU's are semi-passive and you need to put quite some load on the
+		 *	 PSU to get the fan to start spinning
+		 */
+		*val = (data[0] << 8) + data[1];
+		break;
+	case PSU_CMD_RAIL_WATTS:
+	case PSU_CMD_TOTAL_WATTS:
+		*val = (data[1] << 8) + data[0];
+		*val = corsairpsu_linear11_to_int(*val) * 1000000;
+		break;
+	case PSU_CMD_TOTAL_UPTIME:
+	case PSU_CMD_UPTIME:
+		*val = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
+		break;
+	default:
+		ret = -EIO;
+		break;
+	}
+
+	return ret;
+}
+
+static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
+					       u32 attr, int channel)
+{
+	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
+		return 0444;
+	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
+		return 0444;
+	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
+		return 0444;
+	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
+		return 0444;
+	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
+		return 0444;
+
+	return 0;
+}
+
+static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+				     int channel, long *val)
+{
+	struct corsairpsu_data *priv = dev_get_drvdata(dev);
+	u32 tmp;
+	int ret;
+
+	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
+		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
+					   &tmp);
+	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, &tmp);
+	} else if (type == hwmon_power && attr == hwmon_power_input) {
+		switch (channel) {
+		case 0:
+			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, &tmp);
+			break;
+		case 1:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, 0, &tmp);
+			break;
+		case 2:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, 1, &tmp);
+			break;
+		case 3:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, 2, &tmp);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	} else if (type == hwmon_in && attr == hwmon_in_input) {
+		switch (channel) {
+		case 0:
+			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, &tmp);
+			break;
+		case 1:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, 0, &tmp);
+			break;
+		case 2:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, 1, &tmp);
+			break;
+		case 3:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, 2, &tmp);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
+		switch (channel) {
+		case 0:
+			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, &tmp);
+			break;
+		case 1:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, 0, &tmp);
+			break;
+		case 2:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, 1, &tmp);
+			break;
+		case 3:
+			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, 2, &tmp);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (ret < 0)
+		return ret;
+	*val = tmp;
+
+	return 0;
+}
+
+static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum hwmon_sensor_types type,
+					    u32 attr, int channel, const char **str)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_label) {
+		*str = channel ? L_TEMP1 : L_TEMP0;
+		return 0;
+	} else if (type == hwmon_fan && attr == hwmon_fan_label) {
+		*str = L_FAN;
+		return 0;
+	} else if (type == hwmon_power && attr == hwmon_power_label) {
+		switch (channel) {
+		case 0:
+			*str = L_WATTS;
+			return 0;
+		case 1:
+			*str = L_WATTS_12V;
+			return 0;
+		case 2:
+			*str = L_WATTS_5V;
+			return 0;
+		case 3:
+			*str = L_WATTS_3_3V;
+			return 0;
+		default:
+			break;
+		}
+	} else if (type == hwmon_in && attr == hwmon_in_label) {
+		switch (channel) {
+		case 0:
+			*str = L_IN_VOLTS;
+			return 0;
+		case 1:
+			*str = L_OUT_VOLTS_12V;
+			return 0;
+		case 2:
+			*str = L_OUT_VOLTS_5V;
+			return 0;
+		case 3:
+			*str = L_OUT_VOLTS_3_3V;
+			return 0;
+		default:
+			break;
+		}
+	} else if (type == hwmon_curr && attr == hwmon_curr_label) {
+		switch (channel) {
+		case 0:
+			*str = L_IN_AMPS;
+			return 0;
+		case 1:
+			*str = L_AMPS_12V;
+			return 0;
+		case 2:
+			*str = L_AMPS_5V;
+			return 0;
+		case 3:
+			*str = L_AMPS_3_3V;
+			return 0;
+		default:
+			break;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops corsairpsu_hwmon_ops = {
+	.is_visible	= corsairpsu_hwmon_ops_is_visible,
+	.read		= corsairpsu_hwmon_ops_read,
+	.read_string	= corsairpsu_hwmon_ops_read_string,
+};
+
+static const struct hwmon_channel_info *corsairpsu_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info corsairpsu_chip_info = {
+	.ops	= &corsairpsu_hwmon_ops,
+	.info	= corsairpsu_info,
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+static void print_uptime(struct seq_file *seqf, u8 cmd)
+{
+	struct corsairpsu_data *priv = seqf->private;
+	u32 val;
+	int ret;
+
+	ret = corsairpsu_get_value(priv, cmd, 0, &val);
+	if (ret < 0) {
+		seq_puts(seqf, "N/A\n");
+		return;
+	}
+
+	if (val > SECONDS_PER_DAY) {
+		seq_printf(seqf, "%d day(s), %02d:%02d:%02d\n", val / SECONDS_PER_DAY,
+			   val % SECONDS_PER_DAY / SECONDS_PER_HOUR, val % SECONDS_PER_HOUR / 60,
+			   val % 60);
+		return;
+	}
+
+	seq_printf(seqf, "%02d:%02d:%02d\n", val % SECONDS_PER_DAY / SECONDS_PER_HOUR,
+		   val % SECONDS_PER_HOUR / 60, val % 60);
+}
+
+static int uptime_show(struct seq_file *seqf, void *unused)
+{
+	print_uptime(seqf, PSU_CMD_UPTIME);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(uptime);
+
+static int uptime_total_show(struct seq_file *seqf, void *unused)
+{
+	print_uptime(seqf, PSU_CMD_TOTAL_UPTIME);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(uptime_total);
+
+static int vendor_show(struct seq_file *seqf, void *unused)
+{
+	struct corsairpsu_data *priv = seqf->private;
+
+	seq_printf(seqf, "%s\n", priv->vendor);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(vendor);
+
+static int product_show(struct seq_file *seqf, void *unused)
+{
+	struct corsairpsu_data *priv = seqf->private;
+
+	seq_printf(seqf, "%s\n", priv->product);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(product);
+
+static void corsairpsu_debugfs_cleanup(void *ddir)
+{
+	debugfs_remove_recursive(ddir);
+}
+
+static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
+{
+	struct dentry *debugfs;
+	char name[32];
+
+	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
+
+	debugfs = debugfs_create_dir(name, NULL);
+	if (debugfs) {
+		debugfs_create_file("uptime", 0444, debugfs, priv, &uptime_fops);
+		debugfs_create_file("uptime_total", 0444, debugfs, priv, &uptime_total_fops);
+		debugfs_create_file("vendor", 0444, debugfs, priv, &vendor_fops);
+		debugfs_create_file("product", 0444, debugfs, priv, &product_fops);
+		devm_add_action_or_reset(&priv->hdev->dev, corsairpsu_debugfs_cleanup, debugfs);
+	}
+}
+
+#else
+
+static void corsairpsu_debugfs_init(struct corsairlink_data *priv)
+{
+}
+
+#endif
+
+static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct corsairpsu_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&hdev->dev, sizeof(struct corsairpsu_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cmd_buffer = devm_kmalloc(&hdev->dev, CMD_BUFFER_SIZE, GFP_KERNEL);
+	if (!priv->cmd_buffer)
+		return -ENOMEM;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto fail_and_stop;
+
+	priv->hdev = hdev;
+	hid_set_drvdata(hdev, priv);
+	mutex_init(&priv->lock);
+	init_completion(&priv->wait_completion);
+
+	hid_device_io_start(hdev);
+
+	ret = corsairpsu_init(priv);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
+		goto fail_and_stop;
+	}
+
+	ret = corsairpsu_fwinfo(priv);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
+		goto fail_and_stop;
+	}
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
+							  &corsairpsu_chip_info, 0);
+
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret = PTR_ERR(priv->hwmon_dev);
+		goto fail_and_close;
+	}
+
+	corsairpsu_debugfs_init(priv);
+
+	return 0;
+
+fail_and_close:
+	hid_hw_close(hdev);
+fail_and_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void corsairpsu_remove(struct hid_device *hdev)
+{
+	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
+
+	hwmon_device_unregister(priv->hwmon_dev);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
+				int size)
+{
+	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
+
+	if (completion_done(&priv->wait_completion))
+		return 0;
+
+	memcpy(priv->cmd_buffer, data, min(CMD_BUFFER_SIZE, size));
+	complete(&priv->wait_completion);
+
+	return 0;
+}
+
+static const struct hid_device_id corsairpsu_idtable[] = {
+	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
+	{ },
+};
+MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
+
+static struct hid_driver corsairpsu_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= corsairpsu_idtable,
+	.probe		= corsairpsu_probe,
+	.remove		= corsairpsu_remove,
+	.raw_event	= corsairpsu_raw_event,
+};
+module_hid_driver(corsairpsu_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@mailbox.org>");
+MODULE_DESCRIPTION("Linux driver for Corsair power supplies with HID sensors interface");
-- 
2.29.0

