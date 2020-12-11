Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC932D71B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436925AbgLKIZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:25:51 -0500
Received: from mout01.posteo.de ([185.67.36.65]:57369 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbgLKIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:25:17 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2DA5816006F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:24:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607675058; bh=vOdH7nn2L8IZqwOqthlIoQm6pGHhCPAlREbpPPFcQf8=;
        h=Date:From:To:Cc:Subject:From;
        b=SAhPNDpuaqaioc+r1Xv63XKxgqcSBXNgvGjFFjmCzFjcI7dlww/XOpnzUDn0Jh2yN
         mv62aAjWXM/Oc0fTdmRMQn7VwKz1hrszfLRLYbC89pZJlHBNDKIC2izVKELtLPfVY+
         wbfipKjdfeCml8z27CXmVePx+ThTbnBoYHTtvo5iEynHnti9kdLGPkoL2sxo4mKtJA
         jSyVgF5BXSJZN278qypFyfLaW08yX43HMw/V538LxxQ+VcZntCAWKL+Kn7Gxo2XUOe
         yM+fg/JwCXuxcTEnfJelm4UCdD2NOP3y+K5n6cXcG0D1oRV9zyPFjRnc2SErEXg+1S
         mWQ5VU0sXk8Aw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CskN04F9Hz6tmX;
        Fri, 11 Dec 2020 09:24:16 +0100 (CET)
Date:   Fri, 11 Dec 2020 09:24:15 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v4 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <e374bc4212fa316a68b88bd17f5722387f88f332.1607674518.git.wilken.gottwalt@posteo.net>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607674518.git.wilken.gottwalt@posteo.net>
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
Changes in v4:
  - further simplified driver
  - fixed an add_action_and_reset_ function issue
  - changed bindings from sun8i-hwspinlock to sun8i-a33-hwspinlock

Changes in v3:
  - moved test description to cover letter
  - changed name and symbols from sunxi to sun8i
  - improved driver description
  - further simplified driver
  - fully switched to devm_* and devm_add_action_* functions

Changes in v2:
  - added suggestions from Bjorn Andersson and Maxime Ripard
  - provided better driver and test description
---
 MAINTAINERS                           |   6 +
 drivers/hwspinlock/Kconfig            |   9 ++
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/sun8i_hwspinlock.c | 197 ++++++++++++++++++++++++++
 4 files changed, 213 insertions(+)
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
index 000000000000..878dae6f1763
--- /dev/null
+++ b/drivers/hwspinlock/sun8i_hwspinlock.c
@@ -0,0 +1,197 @@
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
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(priv->ahb_clk)) {
+		err = PTR_ERR(priv->ahb_clk);
+		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
+		return err;
+	}
+
+	priv->reset = devm_reset_control_get(&pdev->dev, "ahb");
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
+				     "unable to get reset control\n");
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
+	sun8i_hwspinlock_debugfs_init(priv);
+
+	err = devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, priv);
+	if (err) {
+		dev_err(&pdev->dev, "unable to add disable action\n");
+		return err;
+	}
+
+	/*
+	 * bit 28 and 29 represents the hwspinlock setup
+	 *
+	 * every datasheet (A64, A80, A83T, H3, H5, H6 ...) says the default value is 0x1 and 0x1
+	 * to 0x4 represent 32, 64, 128 and 256 locks
+	 * but later datasheets (H5, H6) say 00, 01, 10, 11 represent 32, 64, 128 and 256 locks,
+	 * but that would mean H5 and H6 have 64 locks, while their datasheets talk about 32 locks
+	 * all the time, not a single mentioning of 64 locks
+	 * the 0x4 value is also not representable by 2 bits alone, so some datasheets are not
+	 * correct
+	 * one thing have all in common, default value of the sysstatus register is 0x10000000,
+	 * which results in bit 28 being set
+	 * this is the reason 0x1 is considered being 32 locks and bit 30 is taken into account
+	 * verified on H2+ (datasheet 0x1 = 32 locks) and H5 (datasheet 01 = 64 locks)
+	 */
+	num_banks = readl(io_base + SPINLOCK_SYSSTATUS_REG) >> 28;
+	switch (num_banks) {
+	case 1 ... 4:
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
+	platform_set_drvdata(pdev, priv);
+
+	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun8i_hwspinlock_ops,
+					 SPINLOCK_BASE_ID, priv->nlocks);
+}
+
+static const struct of_device_id sun8i_hwspinlock_ids[] = {
+	{ .compatible = "allwinner,sun8i-a33-hwspinlock", },
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
+module_platform_driver(sun8i_hwspinlock_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SUN8I hardware spinlock driver");
+MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.29.2

