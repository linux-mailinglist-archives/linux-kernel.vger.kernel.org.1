Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78A2E1BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgLWLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:36:14 -0500
Received: from mout01.posteo.de ([185.67.36.65]:59034 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgLWLgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:36:13 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 56547160062
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1608723313; bh=wvEIoLEEjxhfJrx0HwxUHZDUQo6EL87vKCgSvIX8Tx4=;
        h=Date:From:To:Cc:Subject:From;
        b=MlSXWnH3jPvpiHuqpMd+l48ls/yynoPjXiVvgjADsERdnB/OAg5GPGvOig3cbcMYx
         FQ/oFPr7xRPsZECsqSFGwf+flEwnkr8lm2d6XpwL9Ootg0B/9T4C3OQlTNM74tBhhs
         zD5WytUnnsg5xXpZ/b1BqJp7m7wYQTeALn1M5ZQE+Qr3PzdOqi0pCo2vwZjoi7NTh5
         eJ4KbQ4AetVgtLri0RKV1sc7uqa3cqRkAf1WZhtnRa6YM5xSQSWDHJUdL3kES/OjjH
         dczag1kM9M9p7sHdfh7Y24w7+UBdXR9OQf1xVgslqUqgCiLS5+6PdPogQaFSpL2bjx
         6XU8v5okhAAzQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4D1B2m0GMSz6tmH;
        Wed, 23 Dec 2020 12:35:12 +0100 (CET)
Date:   Wed, 23 Dec 2020 12:35:10 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <0deae76aec31586da45c316546b12bcc316442ee.1608721968.git.wilken.gottwalt@posteo.net>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608721968.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
most of the sun6i compatible SoCs.

This unit provides at least 32 spinlocks in hardware. The implementation
supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
reading a register and released by writing a 0 to it. This driver
supports all 4 spinlock setups, but for now only the first setup (32
locks) seem to exist in available devices. This spinlock unit is shared
between all ARM cores and the embedded companion core. All of them can
take/release a lock with a single cycle operation. It can be used to
sync access to devices shared by the ARM cores and the companion core.

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
Changes in v5:
  - changed symbols to the earliest known supported SoC (sun6i/a31)
  - changed init back to classic probe/remove callbacks

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
 drivers/hwspinlock/sun6i_hwspinlock.c | 214 ++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad0e34bf8453..0842b2a3ea89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/allwinner/
 
+ALLWINNER HARDWARE SPINLOCK SUPPORT
+M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
+F:	drivers/hwspinlock/sun6i_hwspinlock.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>
diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 32cd26352f38..56ecc1aa3166 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
 
 	  If unsure, say N.
 
+config HWSPINLOCK_SUN6I
+	tristate "SUN6I Hardware Spinlock device"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  Say y here to support the SUN6I Hardware Spinlock device which can be
+	  found in most of the sun6i compatible Allwinner SoCs.
+
+	  If unsure, say N.
+
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on ARCH_U8500 || COMPILE_TEST
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index ed053e3f02be..83ec4f03decc 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_SUN6I)		+= sun6i_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
diff --git a/drivers/hwspinlock/sun6i_hwspinlock.c b/drivers/hwspinlock/sun6i_hwspinlock.c
new file mode 100644
index 000000000000..ba56eed818e7
--- /dev/null
+++ b/drivers/hwspinlock/sun6i_hwspinlock.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sun6i_hwspinlock.c - hardware spinlock driver for sun6i compatible Allwinner SoCs
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
+#define DRIVER_NAME		"sun6i_hwspinlock"
+
+#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device per SoC */
+#define SPINLOCK_SYSSTATUS_REG	0x0000
+#define SPINLOCK_LOCK_REGN	0x0100
+#define SPINLOCK_NOTTAKEN	0
+
+struct sun6i_hwspinlock_data {
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
+	struct sun6i_hwspinlock_data *priv = seqf->private;
+
+	seq_printf(seqf, "%d\n", priv->nlocks);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
+
+static void sun6i_hwspinlock_debugfs_init(struct sun6i_hwspinlock_data *priv)
+{
+	priv->debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
+	debugfs_create_file("supported", 0444, priv->debugfs, priv, &hwlocks_supported_fops);
+}
+
+#else
+
+static void sun6i_hwspinlock_debugfs_init(struct sun6i_hwspinlock_data *priv)
+{
+}
+
+#endif
+
+static int sun6i_hwspinlock_trylock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	return (readl(lock_addr) == SPINLOCK_NOTTAKEN);
+}
+
+static void sun6i_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	writel(SPINLOCK_NOTTAKEN, lock_addr);
+}
+
+static const struct hwspinlock_ops sun6i_hwspinlock_ops = {
+	.trylock	= sun6i_hwspinlock_trylock,
+	.unlock		= sun6i_hwspinlock_unlock,
+};
+
+static int sun6i_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct sun6i_hwspinlock_data *priv;
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
+		goto clk_fail;
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
+		err = -EINVAL;
+		dev_err(&pdev->dev, "unsupported hwspinlock setup (%d)\n", num_banks);
+		goto bank_fail;
+	}
+
+	priv->bank = devm_kzalloc(&pdev->dev, struct_size(priv->bank, lock, priv->nlocks),
+				  GFP_KERNEL);
+	if (!priv->bank) {
+		err = -ENOMEM;
+		goto bank_fail;
+	}
+
+	for (i = 0; i < priv->nlocks; ++i) {
+		hwlock = &priv->bank->lock[i];
+		hwlock->priv = io_base + SPINLOCK_LOCK_REGN + sizeof(u32) * i;
+	}
+
+	/* failure of debugfs is considered non-fatal */
+	sun6i_hwspinlock_debugfs_init(priv);
+	if (IS_ERR(priv->debugfs))
+		priv->debugfs = NULL;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun6i_hwspinlock_ops,
+					 SPINLOCK_BASE_ID, priv->nlocks);
+bank_fail:
+	clk_disable_unprepare(priv->ahb_clk);
+clk_fail:
+	reset_control_assert(priv->reset);
+
+	return err;
+}
+
+static int sun6i_hwspinlock_remove(struct platform_device *pdev)
+{
+	struct sun6i_hwspinlock_data *priv = platform_get_drvdata(pdev);
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
+	clk_disable_unprepare(priv->ahb_clk);
+	reset_control_assert(priv->reset);
+
+	return 0;
+}
+
+static const struct of_device_id sun6i_hwspinlock_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-hwspinlock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun6i_hwspinlock_ids);
+
+static struct platform_driver sun6i_hwspinlock_driver = {
+	.probe	= sun6i_hwspinlock_probe,
+	.remove	= sun6i_hwspinlock_remove,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= sun6i_hwspinlock_ids,
+	},
+};
+module_platform_driver(sun6i_hwspinlock_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SUN6I hardware spinlock driver");
+MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.29.2

