Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF92D730F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405691AbgLKJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405685AbgLKJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:49:50 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B696C0613D3;
        Fri, 11 Dec 2020 01:49:10 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id h7so1587633pjk.1;
        Fri, 11 Dec 2020 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBoMhoNsYSUmHOByBj0xCh3ibWRQ1E2P2SuWlUAPYpM=;
        b=BQiZqWeRq5iQcB29t+jyNA/9VCyjLntJAmZWrHoOe7Wc/lKt7pjsSjd0PMg9/c7A9i
         H/RQf1m7zRm90ozxNg2oK0O6p5V60vCgwB/jE+OJ0G8LALKFMn2ZBgzIBTY/H3hckBCR
         F9JH+joCn8Eh1+amzKVUXg/m2Y2oHp+T+55+WRP3r+re0rzgU0R1dTRwfiTNfs5o51lw
         +YCeMjbigauDqbEOaF4yOHlawydU4I9kdzR7VNShnEusS1CRwxLXtwOAJgnlmeXhx8/a
         FhdukEBWIWcEVEBFwWRfYQ579tHA3YRPAyX241PzoVI8pvTJyb1eehVJZsLgwn5ixn7y
         CA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBoMhoNsYSUmHOByBj0xCh3ibWRQ1E2P2SuWlUAPYpM=;
        b=e0DfHtAKeFd1Xx4Pdq10Qv1f6XdRjfqorNpmzAV1Bl4NOC9aknw/ECqQUwF1uGqdwR
         S+Ak775Ilh+vHyzWCvl364bTIXjt7qNyxwPIbotI/ff0CUALh0falzlx5goV55wjHi+5
         VXW67HRCsF/4STzn6GakQWUPYfEex+B8kWbyUGi7X5/QYAmNHXu6MRo99paeOQqegej/
         sV1mqtjW0xMcdAkb4nJ8dDEzC7fJ0ncRIljHMB6O4pPh/5wB9NmTwF8B2U/Dz9fW+XgB
         N5M5F/ImyrE0PZRvwQTCeVRcn0T2GGrT63dPk9zIP7FaDCm7CMCUJRUnaLYiYOUTK6EO
         Hq0g==
X-Gm-Message-State: AOAM531wrsJiKk3BGRsvRlYZmhNCI9Hf63EQBbePtFIJyceBDH7NADA6
        eqXBPGlffHJbcLUiWMGa6ENWex2Wf98=
X-Google-Smtp-Source: ABdhPJyrpGLx8XPYtnAQiZOtYyIT8i9RMs5xxS+gcqU+jlM5zsW8y2y6naNyG+z88vxq3zWOfHdERQ==
X-Received: by 2002:a17:90a:f404:: with SMTP id ch4mr12027837pjb.78.1607680149292;
        Fri, 11 Dec 2020 01:49:09 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.local (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.googlemail.com with ESMTPSA id a31sm3805894pgb.93.2020.12.11.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:49:08 -0800 (PST)
From:   Charles Hsu <hsu.yungteng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net
Cc:     alan@redhat.com, Charles Hsu <hsu.yungteng@gmail.com>
Subject: [PATCH v6] hwmon: Add driver for STMicroelectronics PM6764 Voltage Regulator.
Date:   Fri, 11 Dec 2020 17:46:05 +0800
Message-Id: <20201211094605.270734-1-hsu.yungteng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output voltage use the MFR_READ_VOUT 0xD4
Vout value returned is linear11.

Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
---
v6:
 - Fix misspelling.
v5:
 - Add MAINTAINERS.
v4:
 - Add pm6764tr to Documentation/hwmon/index.rst.
v3:
 - Add Documentation(Documentation/hwmon/pm6764tr.rst).
 - Fix include order.
v2:
 - Fix formatting.
 - Remove pmbus_do_remove.
 - Change from .probe to .probe_new.
v1:
 - Initial patchset.
---
 Documentation/hwmon/index.rst    |  1 +
 Documentation/hwmon/pm6764tr.rst | 32 ++++++++++++++
 MAINTAINERS                      |  7 +++
 drivers/hwmon/pmbus/Kconfig      |  9 ++++
 drivers/hwmon/pmbus/Makefile     |  1 +
 drivers/hwmon/pmbus/pm6764tr.c   | 76 ++++++++++++++++++++++++++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 Documentation/hwmon/pm6764tr.rst
 create mode 100644 drivers/hwmon/pmbus/pm6764tr.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b797db738225..b3ed0047543b 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -144,6 +144,7 @@ Hardware Monitoring Kernel Drivers
    pc87360
    pc87427
    pcf8591
+   pm6764
    pmbus
    powr1220
    pxe1610
diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
new file mode 100644
index 000000000000..4681780d3f0d
--- /dev/null
+++ b/Documentation/hwmon/pm6764tr.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver pm6764tr
+======================
+
+Supported chips:
+
+  * ST PM6764TR
+
+	Prefix: 'pm6764tr'
+
+	Addresses scanned: -
+
+	Datasheet: http://www.st.com/resource/en/data_brief/pm6764.pdf
+
+Authors:
+	<hsu.yungteng@gmail.com>
+
+Description:
+------------
+
+This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
+performance digital controller designed to power Intel’s VR12.5 processors and memories.
+
+The device utilizes digital technology to implement all control and power management
+functions to provide maximum flexibility and performance. The NVM is embedded to store
+custom configurations. The PM6764TR device features up to 4-phase programmable operation.
+
+The PM6764TR supports power state transitions featuring VFDE, and programmable DPM
+maintaining the best efficiency over all loading conditions without compromising transient
+response. The device assures fast and independent protection against load overcurrent,
+under/overvoltage and feedback disconnections.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..0456a2101622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13893,6 +13893,13 @@ M:	Logan Gunthorpe <logang@deltatee.com>
 S:	Maintained
 F:	drivers/dma/plx_dma.c
 
+PM6764TR DRIVER
+M:	Charles Hsu	<hsu.yungteng@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/pm6764tr.rst
+F:	drivers/hwmon/pmbus/pm6764tr.c
+
 PM-GRAPH UTILITY
 M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a25faf69fce3..9c846facce9f 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -220,6 +220,15 @@ config SENSORS_MP2975
 	  This driver can also be built as a module. If so, the module will
 	  be called mp2975.
 
+config SENSORS_PM6764TR
+	tristate "ST PM6764TR"
+	help
+	  If you say yes here you get hardware monitoring support for ST
+	  PM6764TR.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pm6764tr.
+
 config SENSORS_PXE1610
 	tristate "Infineon PXE1610"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c97ad0bd791..31ebdef5d4a6 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
+obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
new file mode 100644
index 000000000000..9531f370d7df
--- /dev/null
+++ b/drivers/hwmon/pmbus/pm6764tr.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for STMicroelectronics digital controller PM6764TR
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+#define PM6764TR_PMBUS_READ_VOUT	0xD4
+
+static int pm6764tr_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VMON:
+		ret = pmbus_read_word_data(client, page, PM6764TR_PMBUS_READ_VOUT);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info pm6764tr_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = vid,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
+		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+	.read_word_data = pm6764tr_read_word_data,
+};
+
+static int pm6764tr_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &pm6764tr_info);
+}
+
+static const struct i2c_device_id pm6764tr_id[] = {
+	{"pm6764tr", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
+
+static const struct of_device_id pm6764tr_of_match[] = {
+	{.compatible = "st,pm6764tr"},
+	{}
+};
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pm6764tr_driver = {
+	.driver = {
+		   .name = "pm6764tr",
+		   .of_match_table = of_match_ptr(pm6764tr_of_match),
+		   },
+	.probe_new = pm6764tr_probe,
+	.id_table = pm6764tr_id,
+};
+
+module_i2c_driver(pm6764tr_driver);
+
+MODULE_AUTHOR("Charles Hsu");
+MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
+MODULE_LICENSE("GPL");
-- 
2.25.1

