Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13912D7D11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405557AbgLKRiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395357AbgLKRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83AC061282
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:36:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so7582976pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVPYkWaeqMRbpAICVnlwraNYfLqLPR2L2jFSS5f+NE0=;
        b=PVHaNXQHd6ToEC+ALUwEtOXHJitrrb/WMMQnlbJjIPQfC+3SEcWBVJI3wTO3HH8T8S
         o1U2Gz65zEvfY8byhsG7VkWHvrTn2LgmCMJMP5t7CL8XXvK6+Vx7cHSp/mGJufz4OKcL
         nKXjiCPqyZNzTEDLzff0sUSvDhSnotQY6jQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVPYkWaeqMRbpAICVnlwraNYfLqLPR2L2jFSS5f+NE0=;
        b=a6TNBbh8e/uXweo34XA97bNXT3o/FV1z6Va+dS9jVfpv+JQkan/hwuWLGFLqbg43u3
         IIrjQzGCHyYPf0XABjEPjiKq09yvbvmLsgbf+CTNPH8aNEcYsciYKaj4mU7sCuajQADN
         017Gp6cujV5czFl0jAERUQ3DFlgoqMpRe/m15/KhaiUFW1h6XdKqXihONpfn2FSV/eS3
         8RCVUTfLaajnEMTcWVv9gWiJRBxCHajcxuUb0oJrposid4k+YFUCM8NvDc5hW6H/y9mH
         xi+QDS5OqvfDsXHi3XWGZdeWLL3d1Hrj1EHyru+KFc0dNWT5FHIeRr9d/AHn8f7b8pah
         D5gA==
X-Gm-Message-State: AOAM533uovKdhSsy9A5h/ZDTflWVxM9sNsv29wgSeomiygpprXxWcNUl
        gCwDzZXYMRijPoyRo3QN+F2ZRQ==
X-Google-Smtp-Source: ABdhPJydFoFshHn2yBECPREYWjWAjjeQIsvhnc7xf2S3q4n8tRUhTckbrNbT6jG1sjtCft1b0EoBAw==
X-Received: by 2002:a05:6a00:1596:b029:19d:96b8:6eab with SMTP id u22-20020a056a001596b029019d96b86eabmr12744405pfk.38.1607708161904;
        Fri, 11 Dec 2020 09:36:01 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id r185sm11402765pfc.53.2020.12.11.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 09:36:01 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     hdegoede@redhat.com, swboyd@chromium.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, andrea@borgia.bo.it,
        kai.heng.feng@canonical.com,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core
Date:   Fri, 11 Dec 2020 09:35:26 -0800
Message-Id: <20201211092956.v7.4.If41b7d621633b94d56653c6d53f5f89c5274de7b@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201211173526.1516653-1-dianders@chromium.org>
References: <20201211173526.1516653-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix i2c-hid touchscreens are mostly i2c-hid compliant but have some
special power sequencing requirements, including the need to drive a
reset line during the sequencing.

Let's use the new rejiggering of i2c-hid to support this with a thin
wrapper driver to support the first Goodix i2c-hid touchscreen:
GT7375P

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v6)

Changes in v6:
- Suspend/resume are no longer exported from the core.

Changes in v5:
- i2chid_subclass_data => i2chid_ops.
- power_up_device => power_up (same with power_down).
- subclass => ops.

Changes in v4:
- Totally redid based on the new subclass system.

Changes in v3:
- Rework to use subclassing.

 drivers/hid/i2c-hid/Kconfig             |  19 +++-
 drivers/hid/i2c-hid/Makefile            |   1 +
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 116 ++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index 819b7521c182..a16c6a69680b 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -32,10 +32,25 @@ config I2C_HID_OF
 	  will be called i2c-hid-of.  It will also build/depend on the
 	  module i2c-hid.
 
+config I2C_HID_OF_GOODIX
+	tristate "Driver for Goodix hid-i2c based devices on OF systems"
+	default n
+	depends on I2C && INPUT && OF
+	help
+	  Say Y here if you want support for Goodix i2c devices that use
+	  the i2c-hid protocol on Open Firmware (Device Tree)-based
+	  systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-hid-of-goodix.  It will also build/depend on
+	  the module i2c-hid.
+
 endmenu
 
 config I2C_HID_CORE
 	tristate
-	default y if I2C_HID_ACPI=y || I2C_HID_OF=y
-	default m if I2C_HID_ACPI=m || I2C_HID_OF=m
+	default y if I2C_HID_ACPI=y || I2C_HID_OF=y || I2C_HID_OF_GOODIX=y
+	default m if I2C_HID_ACPI=m || I2C_HID_OF=m || I2C_HID_OF_GOODIX=m
 	select HID
diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
index 9b4a73446841..302545a771f3 100644
--- a/drivers/hid/i2c-hid/Makefile
+++ b/drivers/hid/i2c-hid/Makefile
@@ -10,3 +10,4 @@ i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
 
 obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o
 obj-$(CONFIG_I2C_HID_OF)			+= i2c-hid-of.o
+obj-$(CONFIG_I2C_HID_OF_GOODIX)			+= i2c-hid-of-goodix.o
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
new file mode 100644
index 000000000000..7cc51c25c609
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Goodix touchscreens that use the i2c-hid protocol.
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+
+#include "i2c-hid.h"
+
+struct goodix_i2c_hid_timing_data {
+	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_power_delay_ms;
+};
+
+struct i2c_hid_of_goodix {
+	struct i2chid_ops ops;
+
+	struct regulator *vdd;
+	struct gpio_desc *reset_gpio;
+	const struct goodix_i2c_hid_timing_data *timings;
+};
+
+static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
+{
+	struct i2c_hid_of_goodix *ihid_goodix =
+		container_of(ops, struct i2c_hid_of_goodix, ops);
+	int ret;
+
+	ret = regulator_enable(ihid_goodix->vdd);
+	if (ret)
+		return ret;
+
+	if (ihid_goodix->timings->post_power_delay_ms)
+		msleep(ihid_goodix->timings->post_power_delay_ms);
+
+	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 0);
+	if (ihid_goodix->timings->post_gpio_reset_delay_ms)
+		msleep(ihid_goodix->timings->post_gpio_reset_delay_ms);
+
+	return 0;
+}
+
+static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
+{
+	struct i2c_hid_of_goodix *ihid_goodix =
+		container_of(ops, struct i2c_hid_of_goodix, ops);
+
+	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+	regulator_disable(ihid_goodix->vdd);
+}
+
+static int i2c_hid_of_goodix_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct i2c_hid_of_goodix *ihid_goodix;
+
+	ihid_goodix = devm_kzalloc(&client->dev, sizeof(*ihid_goodix),
+				   GFP_KERNEL);
+	if (!ihid_goodix)
+		return -ENOMEM;
+
+	ihid_goodix->ops.power_up = goodix_i2c_hid_power_up;
+	ihid_goodix->ops.power_down = goodix_i2c_hid_power_down;
+
+	/* Start out with reset asserted */
+	ihid_goodix->reset_gpio =
+		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ihid_goodix->reset_gpio))
+		return PTR_ERR(ihid_goodix->reset_gpio);
+
+	ihid_goodix->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(ihid_goodix->vdd))
+		return PTR_ERR(ihid_goodix->vdd);
+
+	ihid_goodix->timings = device_get_match_data(&client->dev);
+
+	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001);
+}
+
+static const struct goodix_i2c_hid_timing_data goodix_gt7375p_timing_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_delay_ms = 120,
+};
+
+static const struct of_device_id goodix_i2c_hid_of_match[] = {
+	{ .compatible = "goodix,gt7375p", .data = &goodix_gt7375p_timing_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_i2c_hid_of_match);
+
+static struct i2c_driver goodix_i2c_hid_ts_driver = {
+	.driver = {
+		.name	= "i2c_hid_of_goodix",
+		.pm	= &i2c_hid_core_pm,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match_ptr(goodix_i2c_hid_of_match),
+	},
+	.probe		= i2c_hid_of_goodix_probe,
+	.remove		= i2c_hid_core_remove,
+	.shutdown	= i2c_hid_core_shutdown,
+};
+module_i2c_driver(goodix_i2c_hid_ts_driver);
+
+MODULE_AUTHOR("Douglas Anderson <dianders@chromium.org>");
+MODULE_DESCRIPTION("Goodix i2c-hid touchscreen driver");
+MODULE_LICENSE("GPL v2");
-- 
2.29.2.576.ga3fc446d84-goog

