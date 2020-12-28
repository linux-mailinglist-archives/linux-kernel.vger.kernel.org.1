Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3262E6B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgL1W4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:03 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57947 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgL1Uo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:44:58 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A50D21C0002;
        Mon, 28 Dec 2020 20:44:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] misc: remove atmel_tclib
Date:   Mon, 28 Dec 2020 21:44:13 +0100
Message-Id: <20201228204413.2677762-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no driver depending on atmel_tclib anymore. Remove this driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/misc/Kconfig       |   8 --
 drivers/misc/Makefile      |   1 -
 drivers/misc/atmel_tclib.c | 200 -------------------------------------
 3 files changed, 209 deletions(-)
 delete mode 100644 drivers/misc/atmel_tclib.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0d8099..e90c2524e46c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -50,14 +50,6 @@ config AD525X_DPOT_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad525x_dpot-spi.
 
-config ATMEL_TCLIB
-	bool "Atmel AT32/AT91 Timer/Counter Library"
-	depends on ARCH_AT91
-	help
-	  Select this if you want a library to allocate the Timer/Counter
-	  blocks found on many Atmel processors.  This facilitates using
-	  these blocks by different drivers despite processor differences.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e73330..f65e8b18ecd8 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
-obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
deleted file mode 100644
index 7de7840f613c..000000000000
--- a/drivers/misc/atmel_tclib.c
+++ /dev/null
@@ -1,200 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/of.h>
-#include <soc/at91/atmel_tcb.h>
-
-/*
- * This is a thin library to solve the problem of how to portably allocate
- * one of the TC blocks.  For simplicity, it doesn't currently expect to
- * share individual timers between different drivers.
- */
-
-#if defined(CONFIG_AVR32)
-/* AVR32 has these divide PBB */
-const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#elif defined(CONFIG_ARCH_AT91)
-/* AT91 has these divide MCK */
-const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#endif
-
-static DEFINE_SPINLOCK(tc_list_lock);
-static LIST_HEAD(tc_list);
-
-/**
- * atmel_tc_alloc - allocate a specified TC block
- * @block: which block to allocate
- *
- * Caller allocates a block.  If it is available, a pointer to a
- * pre-initialized struct atmel_tc is returned. The caller can access
- * the registers directly through the "regs" field.
- */
-struct atmel_tc *atmel_tc_alloc(unsigned block)
-{
-	struct atmel_tc		*tc;
-	struct platform_device	*pdev = NULL;
-
-	spin_lock(&tc_list_lock);
-	list_for_each_entry(tc, &tc_list, node) {
-		if (tc->allocated)
-			continue;
-
-		if ((tc->pdev->dev.of_node && tc->id == block) ||
-		    (tc->pdev->id == block)) {
-			pdev = tc->pdev;
-			tc->allocated = true;
-			break;
-		}
-	}
-	spin_unlock(&tc_list_lock);
-
-	return pdev ? tc : NULL;
-}
-EXPORT_SYMBOL_GPL(atmel_tc_alloc);
-
-/**
- * atmel_tc_free - release a specified TC block
- * @tc: Timer/counter block that was returned by atmel_tc_alloc()
- *
- * This reverses the effect of atmel_tc_alloc(), invalidating the resource
- * returned by that routine and making the TC available to other drivers.
- */
-void atmel_tc_free(struct atmel_tc *tc)
-{
-	spin_lock(&tc_list_lock);
-	if (tc->allocated)
-		tc->allocated = false;
-	spin_unlock(&tc_list_lock);
-}
-EXPORT_SYMBOL_GPL(atmel_tc_free);
-
-#if defined(CONFIG_OF)
-static struct atmel_tcb_config tcb_rm9200_config = {
-	.counter_width = 16,
-};
-
-static struct atmel_tcb_config tcb_sam9x5_config = {
-	.counter_width = 32,
-};
-
-static const struct of_device_id atmel_tcb_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-tcb",
-		.data = &tcb_rm9200_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &tcb_sam9x5_config,
-	}, {
-		/* sentinel */
-	}
-};
-
-MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
-#endif
-
-static int __init tc_probe(struct platform_device *pdev)
-{
-	struct atmel_tc *tc;
-	struct clk	*clk;
-	int		irq;
-	unsigned int	i;
-
-	if (of_get_child_count(pdev->dev.of_node))
-		return -EBUSY;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -EINVAL;
-
-	tc = devm_kzalloc(&pdev->dev, sizeof(struct atmel_tc), GFP_KERNEL);
-	if (!tc)
-		return -ENOMEM;
-
-	tc->pdev = pdev;
-
-	clk = devm_clk_get(&pdev->dev, "t0_clk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	tc->slow_clk = devm_clk_get(&pdev->dev, "slow_clk");
-	if (IS_ERR(tc->slow_clk))
-		return PTR_ERR(tc->slow_clk);
-
-	tc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tc->regs))
-		return PTR_ERR(tc->regs);
-
-	/* Now take SoC information if available */
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(atmel_tcb_dt_ids, pdev->dev.of_node);
-		if (match)
-			tc->tcb_config = match->data;
-
-		tc->id = of_alias_get_id(tc->pdev->dev.of_node, "tcb");
-	} else {
-		tc->id = pdev->id;
-	}
-
-	tc->clk[0] = clk;
-	tc->clk[1] = devm_clk_get(&pdev->dev, "t1_clk");
-	if (IS_ERR(tc->clk[1]))
-		tc->clk[1] = clk;
-	tc->clk[2] = devm_clk_get(&pdev->dev, "t2_clk");
-	if (IS_ERR(tc->clk[2]))
-		tc->clk[2] = clk;
-
-	tc->irq[0] = irq;
-	tc->irq[1] = platform_get_irq(pdev, 1);
-	if (tc->irq[1] < 0)
-		tc->irq[1] = irq;
-	tc->irq[2] = platform_get_irq(pdev, 2);
-	if (tc->irq[2] < 0)
-		tc->irq[2] = irq;
-
-	for (i = 0; i < 3; i++)
-		writel(ATMEL_TC_ALL_IRQ, tc->regs + ATMEL_TC_REG(i, IDR));
-
-	spin_lock(&tc_list_lock);
-	list_add_tail(&tc->node, &tc_list);
-	spin_unlock(&tc_list_lock);
-
-	platform_set_drvdata(pdev, tc);
-
-	return 0;
-}
-
-static void tc_shutdown(struct platform_device *pdev)
-{
-	int i;
-	struct atmel_tc *tc = platform_get_drvdata(pdev);
-
-	for (i = 0; i < 3; i++)
-		writel(ATMEL_TC_ALL_IRQ, tc->regs + ATMEL_TC_REG(i, IDR));
-}
-
-static struct platform_driver tc_driver = {
-	.driver = {
-		.name	= "atmel_tcb",
-		.of_match_table	= of_match_ptr(atmel_tcb_dt_ids),
-	},
-	.shutdown = tc_shutdown,
-};
-
-static int __init tc_init(void)
-{
-	return platform_driver_probe(&tc_driver, tc_probe);
-}
-arch_initcall(tc_init);
-- 
2.29.2

