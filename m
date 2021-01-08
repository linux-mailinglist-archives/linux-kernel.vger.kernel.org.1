Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D02EFA92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbhAHV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:29:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:25786 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbhAHV3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:36 -0500
IronPort-SDR: zz3eIrISKTzo+cMTpq2pBrddudzPt94B9GCQ18YIQyfCx89LzOx2e0TF6y7aQqZBquQ8WDwaS5
 2XOSTw4QgwSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="175079540"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="175079540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:06 -0800
IronPort-SDR: N95VhpPH+ts7EJ5xrU+TqgN8QYpbfyWj+UT/n1Tlc1f3x2m9Y5pqbHANlYGyHAmAnOwplmYiLw
 ojJU7fiomgEg==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="403469866"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:06 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 252E1636A;
        Fri,  8 Jan 2021 13:26:06 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGo-0009d5-0S; Fri, 08 Jan 2021 13:26:06 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v2 29/34] Intel tsens i2c slave driver.
Date:   Fri,  8 Jan 2021 13:25:55 -0800
Message-Id: <20210108212600.36850-30-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
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
 drivers/misc/intel_tsens/Kconfig           |  14 +++
 drivers/misc/intel_tsens/Makefile          |   1 +
 drivers/misc/intel_tsens/intel_tsens_i2c.c | 119 +++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_i2c.c

diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
index 8b263fdd80c3..c2138339bd89 100644
--- a/drivers/misc/intel_tsens/Kconfig
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
 	  Say Y if using a processor that includes the Intel VPU such as
 	  Keem Bay.  If unsure, say N.
 
+config INTEL_TSENS_I2C_SLAVE
+	bool "I2C slave driver for intel tsens"
+	depends on INTEL_TSENS_LOCAL_HOST
+	select I2C
+	select I2C_SLAVE
+	help
+	  This option enables tsens i2c slave driver.
+
+	  This driver is used for reporting thermal data via I2C
+	  SMBUS to remote host.
+	  Enable this option if you want to have support for thermal
+	  management controller
+	  Say Y if using a processor that includes the Intel VPU such as
+	  Keem Bay.  If unsure, say N.
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

