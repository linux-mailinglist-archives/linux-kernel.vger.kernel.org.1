Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8CD2D158C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgLGQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:06:40 -0500
Received: from mout01.posteo.de ([185.67.36.65]:41293 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:06:38 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 186B1160063
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607357139; bh=nRJfbb5FURsl66LBfD121NZ0Jzc/B49gGyen0MlXIpk=;
        h=Date:From:To:Cc:Subject:From;
        b=PSHnJ+M1SwSIIn9ygex8NTnk4PFGqNm8hW1dJmU6RoBe+ZvSJVlFqjlNHjYRU3TlU
         75FT/qnmod0q6IiFrV6kksAQx8h6TldYFC9nq5X2pFJJ95LKyLwIhaYpN6Ezc8VqlV
         I00RQVmvwt9Kuwhg9vx7XnZfYHB7GQVA25uhpNLbRh7jQY541RX+R9Tfsvd6I66Tkj
         LV3IFqaiodvKMQzW54QvRh823Go3CvUl50leeEmym3gJ2FdM5mTNoEZDg2xv+bUIvu
         4ad5X2AmKTQzpyeruCX55x4niszk5wBNl9w1cAvFX5097EX59dxHJ1+Q0jOvSzNLZz
         TexLh41/oZvEQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CqSp90pNdz6tmN;
        Mon,  7 Dec 2020 17:05:37 +0100 (CET)
Date:   Mon, 7 Dec 2020 17:05:34 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v3 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <296866d054f0373e8af9e3226e59844ebc791a5e.1607353274.git.wilken.gottwalt@posteo.net>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607353274.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the sun8i_hwspinlock driver for the hardware spinlock unit found in
most of the sun8i compatible SoCs.

This unit provides at least 32 spinlocks in hardware. The implementation
supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
reading a register and released by writing a 0 to it. This driver
supports all 4 spinlock setups, but for now only the first setup (32
locks) seem to exist in available devices. This spinlock unit is shared
between all ARM cores and the embedded OpenRisc AR100 core. All of them
can take/release a lock with a single cycle operation. It can be used to
sync access to devices shared by the ARM cores and the OpenRisc core.

There are two ways to check if a lock is taken. The first way is to read
a lock. If a 0 is returned, the lock was free and is taken now. If an 1
is returned, the caller has to try again. Which means the lock is taken.
The second way is to read a 32bit wide status register where every bit
represents one of the 32 first locks. According to the datasheets this
status register supports only the 32 first locks. This is the reason the
first way (lock read/write) approach is used to be able to cover all 256
locks in future devices. The driver also reports the amount of supported
locks via debugfs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v3:
  - moved test description to cover letter
  - changed name and symbols from sunxi to sun8i
  - improved driver description
  - further simpliefied driver
  - fully switched to devm_* and devm_add_action_* functions

Changes in v2:
  - added suggestions from Bjorn Andersson and Maxime Ripard
  - provided better driver and test description
---
 MAINTAINERS                           |   6 +
 drivers/hwspinlock/Kconfig            |   9 ++
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/sun8i_hwspinlock.c | 205 ++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/hwspinlock/sun8i_hwspinlock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebe4829cdd4d..46846113f1eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/allwinner/
 
+ALLWINNER HARDWARE SPINLOCK SUPPORT
+M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
+F:	drivers/hwspinlock/sun8i_hwspinlock.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>
diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 32cd26352f38..b03fd99aab32 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
 
 	  If unsure, say N.
 
+config HWSPINLOCK_SUN8I
+	tristate "SUN8I Hardware Spinlock device"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  Say y here to support the SUN8I Hardware Spinlock device which can be
+	  found in most of the sun8i compatible Allwinner SoCs.
+
+	  If unsure, say N.
+
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on ARCH_U8500 || COMPILE_TEST
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index ed053e3f02be..3496648d9257 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_SUN8I)		+= sun8i_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
diff --git a/drivers/hwspinlock/sun8i_hwspinlock.c b/drivers/hwspinlock/sun8i_hwspinlock.c
new file mode 100644
index 000000000000..0a48a7c1365a
--- /dev/null
+++ b/drivers/hwspinlock/sun8i_hwspinlock.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sun8i_hwspinlock.c - hardware spinlock driver for sun8i compatible Allwinner SoCs
+ * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "hwspinlock_internal.h"
+
+#define DRIVER_NAME		"sun8i_hwspinlock"
+
+#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device per SoC */
+#define SPINLOCK_SYSSTATUS_REG	0x0000
+#define SPINLOCK_LOCK_REGN	0x0100
+#define SPINLOCK_NOTTAKEN	0
+
+struct sun8i_hwspinlock_data {
+	struct hwspinlock_device *bank;
+	struct reset_control *reset;
+	struct clk *ahb_clk;
+	struct dentry *debugfs;
+	int nlocks;
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+static int hwlocks_supported_show(struct seq_file *seqf, void *unused)
+{
+	struct sun8i_hwspinlock_data *priv = seqf->private;
+
+	seq_printf(seqf, "%d\n", priv->nlocks);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
+
+static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
+{
+	priv->debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
+	debugfs_create_file("supported", 0444, priv->debugfs, priv, &hwlocks_supported_fops);
+}
+
+#else
+
+static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
+{
+}
+
+#endif
+
+static int sun8i_hwspinlock_trylock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	return (readl(lock_addr) == SPINLOCK_NOTTAKEN);
+}
+
+static void sun8i_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	writel(SPINLOCK_NOTTAKEN, lock_addr);
+}
+
+static const struct hwspinlock_ops sun8i_hwspinlock_ops = {
+	.trylock	= sun8i_hwspinlock_trylock,
+	.unlock		= sun8i_hwspinlock_unlock,
+};
+
+static void sun8i_hwspinlock_disable(void *data)
+{
+	struct sun8i_hwspinlock_data *priv = data;
+
+	debugfs_remove_recursive(priv->debugfs);
+	reset_control_assert(priv->reset);
+	clk_disable_unprepare(priv->ahb_clk);
+}
+
+static int sun8i_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct sun8i_hwspinlock_data *priv;
+	struct hwspinlock *hwlock;
+	void __iomem *io_base;
+	u32 num_banks;
+	int err, i;
+
+	io_base = devm_platform_ioremap_resource(pdev, SPINLOCK_BASE_ID);
+	if (IS_ERR(io_base)) {
+		err = PTR_ERR(io_base);
+		dev_err(&pdev->dev, "unable to request MMIO (%d)\n", err);
+		return err;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	err = devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, priv);
+	if (err) {
+		dev_err(&pdev->dev, "unable to add disable action\n");
+		return err;
+	}
+
+	priv->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(priv->ahb_clk)) {
+		err = PTR_ERR(priv->ahb_clk);
+		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
+		return err;
+	}
+
+	priv->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
+	if (IS_ERR(priv->reset)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
+				     "unable to get reset control\n");
+	}
+
+	err = reset_control_deassert(priv->reset);
+	if (err) {
+		dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(priv->ahb_clk);
+	if (err) {
+		dev_err(&pdev->dev, "unable to prepare AHB clk (%d)\n", err);
+		return err;
+	}
+
+	/*
+	 * bit 28 and 29 hold the amount of spinlock banks, but at the same time the datasheet
+	 * says, bit 30 and 31 are reserved while the values can be 0 to 4, which is not reachable
+	 * by two bits alone, so the reserved bits are also taken into account
+	 */
+	num_banks = readl(io_base + SPINLOCK_SYSSTATUS_REG) >> 28;
+	switch (num_banks) {
+	case 1 ... 4:
+		/*
+		 * 32, 64, 128 and 256 spinlocks are supported by the hardware implementation,
+		 * though most of the SoCs support 32 spinlocks only
+		 */
+		priv->nlocks = 1 << (4 + num_banks);
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported hwspinlock setup (%d)\n", num_banks);
+		return -EINVAL;
+	}
+
+	priv->bank = devm_kzalloc(&pdev->dev, struct_size(priv->bank, lock, priv->nlocks),
+				  GFP_KERNEL);
+	if (!priv->bank)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->nlocks; ++i) {
+		hwlock = &priv->bank->lock[i];
+		hwlock->priv = io_base + SPINLOCK_LOCK_REGN + sizeof(u32) * i;
+	}
+
+	sun8i_hwspinlock_debugfs_init(priv);
+	platform_set_drvdata(pdev, priv);
+
+	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun8i_hwspinlock_ops,
+					 SPINLOCK_BASE_ID, priv->nlocks);
+}
+
+static const struct of_device_id sun8i_hwspinlock_ids[] = {
+	{ .compatible = "allwinner,sun8i-hwspinlock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun8i_hwspinlock_ids);
+
+static struct platform_driver sun8i_hwspinlock_driver = {
+	.probe	= sun8i_hwspinlock_probe,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= sun8i_hwspinlock_ids,
+	},
+};
+
+static int __init sun8i_hwspinlock_init(void)
+{
+	return platform_driver_register(&sun8i_hwspinlock_driver);
+}
+module_init(sun8i_hwspinlock_init);
+
+static void __exit sun8i_hwspinlock_exit(void)
+{
+	platform_driver_unregister(&sun8i_hwspinlock_driver);
+}
+module_exit(sun8i_hwspinlock_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SUN8I hardware spinlock driver");
+MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.29.2

