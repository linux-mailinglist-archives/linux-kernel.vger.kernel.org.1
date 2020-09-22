Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42927425A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:47:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbgIVMrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:47:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81611EC1867C6C16A37F;
        Tue, 22 Sep 2020 20:47:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 20:46:56 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v3 1/2] drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
Date:   Tue, 22 Sep 2020 20:44:29 +0800
Message-ID: <1600778670-60370-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600778670-60370-1-git-send-email-tiantao6@hisilicon.com>
References: <1600778670-60370-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding driver implementation to support i2c driver algorithms for
bit-shift adapters, so hibmc will using the interface provided by
drm to read edid.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile        |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 25 ++++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c | 99 +++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index f991327..684ef79 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_ttm.o
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_ttm.o hibmc_drm_i2c.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 197485e..87d2aad 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -14,11 +14,23 @@
 #ifndef HIBMC_DRM_DRV_H
 #define HIBMC_DRM_DRV_H
 
+#include <linux/gpio/consumer.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/i2c.h>
+
+#include <drm/drm_edid.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 
 struct drm_device;
 
+struct hibmc_connector {
+	struct drm_connector base;
+
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data bit_data;
+};
+
 struct hibmc_drm_private {
 	/* hw */
 	void __iomem   *mmio;
@@ -31,10 +43,20 @@ struct hibmc_drm_private {
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
-	struct drm_connector connector;
+	struct hibmc_connector connector;
 	bool mode_config_initialized;
 };
 
+static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
+{
+	return container_of(connector, struct hibmc_connector, base);
+}
+
+static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
+{
+	return dev->dev_private;
+}
+
 void hibmc_set_power_mode(struct hibmc_drm_private *priv,
 			  unsigned int power_mode);
 void hibmc_set_current_gate(struct hibmc_drm_private *priv,
@@ -47,6 +69,7 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc);
 void hibmc_mm_fini(struct hibmc_drm_private *hibmc);
 int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args);
+int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
 
 extern const struct drm_mode_config_funcs hibmc_mode_funcs;
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
new file mode 100644
index 0000000..86d7120
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *      Tian Tao <tiantao6@hisilicon.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
+
+#include "hibmc_drm_drv.h"
+
+#define GPIO_DATA		0x0802A0
+#define GPIO_DATA_DIRECTION	0x0802A4
+
+#define I2C_SCL_MASK		BIT(0)
+#define I2C_SDA_MASK		BIT(1)
+
+static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
+{
+	struct hibmc_connector *hibmc_connector = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
+
+	if (value) {
+		tmp_dir &= ~mask;
+		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
+	} else {
+		u32 tmp_data = readl(priv->mmio + GPIO_DATA);
+
+		tmp_data &= ~mask;
+		writel(tmp_data, priv->mmio + GPIO_DATA);
+
+		tmp_dir |= mask;
+		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
+	}
+}
+
+static int hibmc_get_i2c_signal(void *data, u32 mask)
+{
+	struct hibmc_connector *hibmc_connector = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
+
+	if ((tmp_dir & mask) != mask) {
+		tmp_dir &= ~mask;
+		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
+	}
+
+	return (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
+}
+
+static void hibmc_ddc_setsda(void *data, int state)
+{
+	hibmc_set_i2c_signal(data, I2C_SDA_MASK, state);
+}
+
+static void hibmc_ddc_setscl(void *data, int state)
+{
+	hibmc_set_i2c_signal(data, I2C_SCL_MASK, state);
+}
+
+static int hibmc_ddc_getsda(void *data)
+{
+	return hibmc_get_i2c_signal(data, I2C_SDA_MASK);
+}
+
+static int hibmc_ddc_getscl(void *data)
+{
+	return hibmc_get_i2c_signal(data, I2C_SCL_MASK);
+}
+
+int hibmc_ddc_create(struct drm_device *drm_dev,
+		     struct hibmc_connector *connector)
+{
+	connector->adapter.owner = THIS_MODULE;
+	connector->adapter.class = I2C_CLASS_DDC;
+	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
+	connector->adapter.dev.parent = &drm_dev->pdev->dev;
+	i2c_set_adapdata(&connector->adapter, connector);
+	connector->adapter.algo_data = &connector->bit_data;
+
+	connector->bit_data.udelay = 20;
+	connector->bit_data.timeout = usecs_to_jiffies(2000);
+	connector->bit_data.data = connector;
+	connector->bit_data.setsda = hibmc_ddc_setsda;
+	connector->bit_data.setscl = hibmc_ddc_setscl;
+	connector->bit_data.getsda = hibmc_ddc_getsda;
+	connector->bit_data.getscl = hibmc_ddc_getscl;
+
+	return i2c_bit_add_bus(&connector->adapter);
+}
-- 
2.7.4

