Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C623A1E7DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgE2NGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 09:06:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17248 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgE2NGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:06:17 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TCxZdB028266;
        Fri, 29 May 2020 09:05:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp8c20f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 09:05:58 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04TD5vV3004080
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 29 May 2020 09:05:57 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 09:05:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 09:05:56 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 29 May 2020 09:05:56 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04TD5pKN026894;
        Fri, 29 May 2020 09:05:53 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 1/6] hwmon: pmbus: adm1266: add support
Date:   Fri, 29 May 2020 16:05:01 +0300
Message-ID: <20200529130506.73511-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529130506.73511-1-alexandru.tachici@analog.com>
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_07:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add pmbus probing driver for the adm1266 Cascadable
Super Sequencer with Margin Control and Fault Recording.
Driver is using the pmbus_core, creating sysfs files
under hwmon for inputs: vh1->vh4 and vp1->vp13.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/hwmon/adm1266.rst | 35 +++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |  9 +++++
 drivers/hwmon/pmbus/Makefile    |  1 +
 drivers/hwmon/pmbus/adm1266.c   | 62 +++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
new file mode 100644
index 000000000000..65662115750c
--- /dev/null
+++ b/Documentation/hwmon/adm1266.rst
@@ -0,0 +1,35 @@
+Kernel driver adm1266
+=====================
+
+Supported chips:
+  * Analog Devices ADM1266
+    Prefix: 'adm1266'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
+
+Author: Alexandru Tachici <alexandru.tachici@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices ADM1266 sequencer.
+
+ADM1266 is a sequencer that features voltage readback from 17 channels via an
+integrated 12 bit SAR ADC, accessed using a PMBus interface.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write, history reset
+attributes are write-only, all other attributes are read-only.
+
+inX_label		"voutx"
+inX_input		Measured voltage.
+inX_min			Minimum Voltage.
+inX_max			Maximum voltage.
+inX_min_alarm		Voltage low alarm.
+inX_max_alarm		Voltage high alarm.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index de12a565006d..6949483aa732 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -26,6 +26,15 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ADM1266
+	tristate "Analog Devices ADM1266 Sequencer"
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices ADM1266 Cascadable Super Sequencer.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called adm1266.
+
 config SENSORS_ADM1275
 	tristate "Analog Devices ADM1275 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 5feb45806123..ed38f6d6f845 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
new file mode 100644
index 000000000000..a7ef048a9a5c
--- /dev/null
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1266 - Cascadable Super Sequencer with Margin
+ * Control and Fault Recording
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "pmbus.h"
+
+static int adm1266_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct pmbus_driver_info *info;
+	u32 funcs;
+	int i;
+
+	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
+			    GFP_KERNEL);
+
+	info->pages = 17;
+	info->format[PSC_VOLTAGE_OUT] = linear;
+	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+	for (i = 0; i < info->pages; i++)
+		info->func[i] = funcs;
+
+	return pmbus_do_probe(client, id, info);
+}
+
+static const struct of_device_id adm1266_of_match[] = {
+	{ .compatible = "adi,adm1266" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adm1266_of_match);
+
+static const struct i2c_device_id adm1266_id[] = {
+	{ "adm1266", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1266_id);
+
+static struct i2c_driver adm1266_driver = {
+	.driver = {
+		   .name = "adm1266",
+		   .of_match_table = adm1266_of_match,
+		  },
+	.probe = adm1266_probe,
+	.remove = pmbus_do_remove,
+	.id_table = adm1266_id,
+};
+
+module_i2c_driver(adm1266_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1266");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

