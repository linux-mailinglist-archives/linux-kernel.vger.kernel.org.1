Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF52B7AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKRKCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:02:47 -0500
Received: from mout02.posteo.de ([185.67.36.66]:50709 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKRKCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:02:47 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0FA252400FF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1605693763; bh=X5KkTbi7sUFJc+JHAn4fTqGn5ocE9G7DWmqMzlOnbew=;
        h=Date:From:To:Cc:Subject:From;
        b=bwq/Fl+AJfVQatJPr3ZL0jTOYjO05GvtgmmdLv3wiA7WlZ8rLV/kzOw5FEGC/RZ+Z
         qRYGkVJ/utUIsdos5poAIqwERordVbwHiVgiS1bkG1sc02j1Om5krDaSf9YQP790qA
         icWdiN/8SXDl6Jgc7/ALQx3IVfZeCKGk0MwnCfe0CCwEcujbnEZ2f9Yf90MmM3WXjp
         uCCqfU+D3wZV16HxT7arJiSPXawetZToJhM7BsP63MKRnYfakVeI+HO8ZZD3T6IXpq
         Gn6f94ABfgv1Xx8/z/8WOP0jRhfgI50lcPiJ4/JHj1CYdzHV+BfxBghsBAlvsYaZ9j
         OtcGeCmTRVSOA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Cbdf95b3fz9rxG;
        Wed, 18 Nov 2020 11:02:41 +0100 (CET)
Date:   Wed, 18 Nov 2020 11:02:40 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605693132.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the sunxi_hwspinlock driver and updates makefiles/maintainers.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 MAINTAINERS                           |   6 +
 drivers/hwspinlock/Kconfig            |   9 +
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/sunxi_hwspinlock.c | 282 ++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/hwspinlock/sunxi_hwspinlock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cc595ac7b28..7765da172f10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/allwinner/
 
+ALLWINNER HARDWARE SPINLOCK SUPPORT
+M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
+F:	drivers/hwspinlock/sunxi_hwspinlock.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>
diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 32cd26352f38..27b6e22126f7 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
 
 	  If unsure, say N.
 
+config HWSPINLOCK_SUNXI
+	tristate "SUNXI Hardware Spinlock device"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  Say y here to support the Allwinner hardware mutex device available
+	  in the H2+, H3, H5 and H6 SoCs.
+
+	  If unsure, say N.
+
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on ARCH_U8500 || COMPILE_TEST
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index ed053e3f02be..bf46bee95226 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_SUNXI)		+= sunxi_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
diff --git a/drivers/hwspinlock/sunxi_hwspinlock.c b/drivers/hwspinlock/sunxi_hwspinlock.c
new file mode 100644
index 000000000000..54e6ad3ac1c2
--- /dev/null
+++ b/drivers/hwspinlock/sunxi_hwspinlock.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sunxi_hwspinlock.c - hardware spinlock driver for Allwinner SoCs
+ * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
+ */
+
+#include <linux/bitops.h>
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
+#define DRIVER_NAME		"sunxi_hwspinlock"
+
+#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device in each SoC */
+#define SPINLOCK_SYSSTATUS_REG	0x0000
+#define SPINLOCK_STATUS_REG	0x0010
+#define SPINLOCK_LOCK_REGN	0x0100
+#define SPINLOCK_NOTTAKEN	0
+#define SPINLOCK_TAKEN		1
+
+struct sunxi_hwspinlock {
+	void __iomem *io_base;
+};
+
+struct sunxi_hwspinlock_data {
+	void __iomem *io_base;
+	struct hwspinlock_device *bank;
+	struct reset_control *reset;
+	struct clk *ahb_clock;
+	struct dentry *debugfs;
+	int nlocks;
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+static int hwlocks_supported_show(struct seq_file *seqf, void *unused)
+{
+	struct sunxi_hwspinlock_data *priv = seqf->private;
+
+	seq_printf(seqf, "%d\n", priv->nlocks);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
+
+static int hwlocks_inuse_show(struct seq_file *seqf, void *unused)
+{
+	struct sunxi_hwspinlock_data *priv = seqf->private;
+	int inuse;
+
+	/* getting the status of only the main 32 spinlocks is supported */
+	inuse = hweight32(readl(priv->io_base + SPINLOCK_STATUS_REG));
+	seq_printf(seqf, "%d\n", inuse);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hwlocks_inuse);
+
+static void sunxi_hwspinlock_debugfs_init(struct sunxi_hwspinlock_data *priv)
+{
+	char name[32];
+
+	scnprintf(name, sizeof(name), "%s", DRIVER_NAME);
+
+	priv->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_file("hwlocks_supported", 0444, priv->debugfs, priv,
+			    &hwlocks_supported_fops);
+	debugfs_create_file("hwlocks_inuse", 0444, priv->debugfs, priv, &hwlocks_inuse_fops);
+}
+
+#else
+
+static void sunxi_hwspinlock_debugfs_init(struct sunxi_hwspinlock_data *priv)
+{
+}
+
+#endif
+
+static int sunxi_hwspinlock_trylock(struct hwspinlock *lock)
+{
+	struct sunxi_hwspinlock_data *priv = lock->priv;
+	void __iomem *lock_addr = priv->io_base;
+
+	return (readl(lock_addr) == SPINLOCK_NOTTAKEN);
+}
+
+static void sunxi_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	struct sunxi_hwspinlock_data *priv = lock->priv;
+	void __iomem *lock_addr = priv->io_base;
+
+	writel(SPINLOCK_NOTTAKEN, lock_addr);
+}
+
+static const struct hwspinlock_ops sunxi_hwspinlock_ops = {
+	.trylock	= sunxi_hwspinlock_trylock,
+	.unlock		= sunxi_hwspinlock_unlock,
+};
+
+static int sunxi_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct sunxi_hwspinlock_data *priv;
+	struct sunxi_hwspinlock *hwpriv;
+	struct hwspinlock *hwlock;
+	struct resource *res;
+	int num_banks, err, i;
+
+	if (!node)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->io_base)) {
+		err = PTR_ERR(priv->io_base);
+		dev_err(&pdev->dev, "unable to request MMIO (%d)\n", err);
+		return err;
+	}
+
+	priv->ahb_clock = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(priv->ahb_clock)) {
+		err = PTR_ERR(priv->ahb_clock);
+		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
+		return err;
+	}
+
+	priv->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
+	if (IS_ERR(priv->reset)) {
+		err = PTR_ERR(priv->reset);
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		dev_info(&pdev->dev, "no optional reset control available (%d)\n", err);
+		priv->reset = NULL;
+	}
+
+	if (priv->reset) {
+		err = reset_control_deassert(priv->reset);
+		if (err) {
+			dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
+			return err;
+		}
+	}
+
+	err = clk_prepare_enable(priv->ahb_clock);
+	if (err) {
+		dev_err(&pdev->dev, "unable to prepare AHB clock (%d)\n", err);
+		goto reset_fail;
+	}
+
+	/* bit 28 and 29 hold the amount of spinlock banks */
+	num_banks = (readl(priv->io_base + SPINLOCK_SYSSTATUS_REG) >> 28) & 0x03;
+	switch (num_banks) {
+	case 1 ... 4:
+		/*
+		 * 32, 64, 128 and 256 spinlocks are supported by the hardware implementation,
+		 * though most only support 32 spinlocks
+		 */
+		priv->nlocks = 1 << (4 + num_banks);
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported hwspinlock setup (%d)\n", num_banks);
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/*
+	 * the Allwinner hwspinlock device uses 32bit registers for representing every single
+	 * spinlock, which is a real waste of space
+	 */
+	priv->bank = devm_kzalloc(&pdev->dev, priv->nlocks * sizeof(*hwlock) + sizeof(*priv->bank),
+				  GFP_KERNEL);
+	if (!priv->bank) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0, hwlock = &priv->bank->lock[0]; i < priv->nlocks; ++i, ++hwlock) {
+		hwlock->priv = devm_kzalloc(&pdev->dev, sizeof(struct sunxi_hwspinlock),
+					    GFP_KERNEL);
+		if (!hwlock->priv) {
+			err = -ENOMEM;
+			goto fail;
+		}
+
+		hwpriv = hwlock->priv;
+		hwpriv->io_base = priv->io_base + SPINLOCK_LOCK_REGN + sizeof(u32) * i;
+	}
+
+	err = hwspin_lock_register(priv->bank, &pdev->dev, &sunxi_hwspinlock_ops, SPINLOCK_BASE_ID,
+				   priv->nlocks);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register hwspinlocks (%d)\n", err);
+		goto fail;
+	}
+
+	sunxi_hwspinlock_debugfs_init(priv);
+
+	dev_dbg(&pdev->dev, "SUNXI hardware spinlock driver enabled (%d locks)\n", priv->nlocks);
+
+	return 0;
+
+fail:
+	clk_disable_unprepare(priv->ahb_clock);
+
+reset_fail:
+	if (priv->reset)
+		reset_control_assert(priv->reset);
+
+	return err;
+}
+
+static int sunxi_hwspinlock_remove(struct platform_device *pdev)
+{
+	struct sunxi_hwspinlock_data *priv = platform_get_drvdata(pdev);
+	int err;
+
+	debugfs_remove_recursive(priv->debugfs);
+
+	err = hwspin_lock_unregister(priv->bank);
+	if (err) {
+		dev_err(&pdev->dev, "unregister device failed (%d)\n", err);
+		return err;
+	}
+
+	if (priv->reset)
+		reset_control_assert(priv->reset);
+
+	clk_disable_unprepare(priv->ahb_clock);
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_hwspinlock_ids[] = {
+	{ .compatible = "allwinner,sun8i-hwspinlock", },
+	{ .compatible = "allwinner,sun50i-hwspinlock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sunxi_hwspinlock_ids);
+
+static struct platform_driver sunxi_hwspinlock_driver = {
+	.probe	= sunxi_hwspinlock_probe,
+	.remove	= sunxi_hwspinlock_remove,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= of_match_ptr(sunxi_hwspinlock_ids),
+	},
+};
+
+static int __init sunxi_hwspinlock_init(void)
+{
+	return platform_driver_register(&sunxi_hwspinlock_driver);
+}
+postcore_initcall(sunxi_hwspinlock_init);
+
+static void __exit sunxi_hwspinlock_exit(void)
+{
+	platform_driver_unregister(&sunxi_hwspinlock_driver);
+}
+module_exit(sunxi_hwspinlock_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SUNXI hardware spinlock driver");
+MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.29.2

