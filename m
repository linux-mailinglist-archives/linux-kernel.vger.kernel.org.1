Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41240304DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbhAZXXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:23:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:32229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388763AbhAZFqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:46:01 -0500
IronPort-SDR: zD1buEwU7p2m1k3j/H9ztYqRtR/RHTtzni0/TCnyqMsZFhW0Bk5RlnzWH268nhMMMe3w+P+q0e
 dRyZfUpEsy9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241381385"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="241381385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
IronPort-SDR: F1IXRONNOKtaOcTHi/AaSMx76aTF5kqqIAS/UVen8Z9NVA80g2M55qcdmIaFoP9mtpjFQ+ZSNr
 KIWm7JioRUUQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="504418204"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id A40FB6375;
        Mon, 25 Jan 2021 21:40:41 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 93AB3363534; Mon, 25 Jan 2021 21:40:41 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v3 29/34] Intel tsens i2c slave driver.
Date:   Mon, 25 Jan 2021 21:40:31 -0800
Message-Id: <20210126054036.61587-30-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C, Udhayakumar" <udhayakumar.c@intel.com>

Add Intel tsens i2c slave driver for Intel Edge.AI Computer Vision
platforms.

The tsens i2c slave driver enables reading of on chip sensors present
in the Intel Edge.AI Computer Vision platforms. In the tsens i2c module
various junction and SoC temperatures are reported using i2c slave
protocol.

Signed-off-by: C, Udhayakumar <udhayakumar.c@intel.com>
---
 drivers/misc/intel_tsens/Kconfig           |  15 +++
 drivers/misc/intel_tsens/Makefile          |   1 +
 drivers/misc/intel_tsens/intel_tsens_i2c.c | 119 +++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_i2c.c

diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
index 8b263fdd80c3..9b2198ab28c3 100644
--- a/drivers/misc/intel_tsens/Kconfig
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -14,6 +14,21 @@ config INTEL_TSENS_LOCAL_HOST
 	  Say Y if using a processor that includes the Intel VPU such as
 	  Keem Bay.  If unsure, say N.
 
+config INTEL_TSENS_I2C_SLAVE
+	bool "I2C slave driver for intel tsens"
+	depends on INTEL_TSENS_LOCAL_HOST
+	select I2C
+	select I2C_SLAVE
+	help
+	  This option enables tsens I2C slave driver.
+
+	  This driver is used for reporting thermal data via I2C
+	  SMBUS to remote host.
+	  Enable this option if you want to have support for thermal
+	  management controller.
+	  Say Y if using a processor that includes the Intel VPU such as
+	  Keem Bay.  If unsure, say N.
+
 config INTEL_TSENS_IA_HOST
 	tristate "Temperature sensor driver for intel tsens remote host"
 	depends on I2C && THERMAL
diff --git a/drivers/misc/intel_tsens/Makefile b/drivers/misc/intel_tsens/Makefile
index 250dc484fb49..f6f41bbca80c 100644
--- a/drivers/misc/intel_tsens/Makefile
+++ b/drivers/misc/intel_tsens/Makefile
@@ -5,4 +5,5 @@
 #
 
 obj-$(CONFIG_INTEL_TSENS_LOCAL_HOST)	+= intel_tsens_thermal.o
+obj-$(CONFIG_INTEL_TSENS_I2C_SLAVE)	+= intel_tsens_i2c.o
 obj-$(CONFIG_INTEL_TSENS_IA_HOST)	+= intel_tsens_host.o
diff --git a/drivers/misc/intel_tsens/intel_tsens_i2c.c b/drivers/misc/intel_tsens/intel_tsens_i2c.c
new file mode 100644
index 000000000000..520c3f4bf392
--- /dev/null
+++ b/drivers/misc/intel_tsens/intel_tsens_i2c.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Intel tsens I2C thermal Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "intel_tsens_thermal.h"
+
+#define TSENS_BYTE_INDEX_SHIFT	0x6
+#define TSENS_BYTE_INDEX_MASK	0x3
+#define TSENS_SENSOR_TYPE_MASK	0x3F
+
+struct intel_tsens_i2c {
+	int sensor_type;
+	u16 buffer_idx;
+	bool read_only;
+	u8 idx_write_cnt;
+	struct intel_tsens_i2c_plat_data *plat_data;
+};
+
+static int intel_i2c_tsens_slave_cb(struct i2c_client *client,
+				    enum i2c_slave_event event, u8 *val)
+{
+	struct intel_tsens_i2c *tsens_i2c = i2c_get_clientdata(client);
+	struct intel_tsens_i2c_plat_data *plat_data = tsens_i2c->plat_data;
+	int ret = 0;
+
+	switch (event) {
+	case I2C_SLAVE_WRITE_RECEIVED:
+		tsens_i2c->sensor_type = *val;
+		break;
+
+	case I2C_SLAVE_READ_PROCESSED:
+	case I2C_SLAVE_READ_REQUESTED:
+		if (plat_data->get_temp) {
+			int temp;
+			int sensor_type = tsens_i2c->sensor_type &
+						TSENS_SENSOR_TYPE_MASK;
+
+			if (!plat_data->get_temp(sensor_type, &temp,
+						 plat_data->pdata)) {
+				u8 offset = (tsens_i2c->sensor_type >>
+						TSENS_BYTE_INDEX_SHIFT) &
+						TSENS_BYTE_INDEX_MASK;
+				u8 *ptr_temp = (u8 *)&temp;
+
+				*val = ptr_temp[offset];
+				tsens_i2c->buffer_idx++;
+				ret = 0;
+			} else {
+				ret = -EINVAL;
+			}
+		} else {
+			ret = -EINVAL;
+		}
+		break;
+
+	case I2C_SLAVE_STOP:
+	case I2C_SLAVE_WRITE_REQUESTED:
+		tsens_i2c->idx_write_cnt = 0;
+		tsens_i2c->buffer_idx = 0;
+		break;
+
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int intel_i2c_tsens_slave_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{	struct intel_tsens_i2c *priv;
+	int ret;
+
+	if (!id->driver_data) {
+		dev_err(&client->dev, "No platform data");
+		return -EINVAL;
+	}
+	priv = devm_kzalloc(&client->dev,
+			    sizeof(struct intel_tsens_i2c),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->plat_data = (struct intel_tsens_i2c_plat_data *)id->driver_data;
+	i2c_set_clientdata(client, priv);
+	ret = i2c_slave_register(client, intel_i2c_tsens_slave_cb);
+	if (ret)
+		dev_err(&client->dev, "i2c slave register failed\n");
+
+	return ret;
+};
+
+static struct i2c_device_id intel_i2c_tsens_slave_id[] = {
+	{ "intel_tsens", (kernel_ulong_t)&i2c_plat_data},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, intel_i2c_tsens_slave_id);
+
+static struct i2c_driver intel_i2c_tsens_slave_driver = {
+	.driver = {
+		.name = "intel_tsens",
+	},
+	.probe = intel_i2c_tsens_slave_probe,
+	.remove = i2c_slave_unregister,
+	.id_table = intel_i2c_tsens_slave_id,
+};
+
+module_i2c_driver(intel_i2c_tsens_slave_driver);
+
+MODULE_AUTHOR("Udhayakumar C <udhayakumar.c@intel.com>");
+MODULE_DESCRIPTION("tsens i2c slave driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

