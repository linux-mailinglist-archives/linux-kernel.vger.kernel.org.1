Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1750B300124
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbhAVLDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:03:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12424 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726880AbhAVKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:21 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAmG87002482;
        Fri, 22 Jan 2021 11:51:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Ss6Pwd3LBnUuLlPGR+/BUSEo5DJkrygwz9JdwiLD4c0=;
 b=W2PwNMhnNEoyRhIqrCnV0VdcIza0PFFMGcKmTlPmcEeiLjq7Ivr11YpOyiSl67eyIKC8
 qvrQ8za+cZRwG880E9ptPq4bzfNZuJvnDqCmzy5wIxaoh+Zbj/ZgFyWhnwwf+QIhLH06
 q+9JGjFNw8GdbYXJ327OAL+oOcZRXgC2ls+4/FFFxtNQmqHAq/xxIdr8mZ/PDjXQd3Nb
 6M8M23zQa9vXyFb+yimQ1ZxIuP7ebSv2jVw0P3l5vTMUaD3Ux4EdDoE2ZmhUTUIIebRd
 CrebzY46S6l86Q1zB/08Yk421Ny35MaSVN+kVFSXYwNNBm6NCTsM/0wyIYEWTlrHxjoA iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pqhdur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FF82100034;
        Fri, 22 Jan 2021 11:51:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4258622DBCA;
        Fri, 22 Jan 2021 11:51:23 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:22
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/14] reset: stm32mp1: remove stm32mp1 reset
Date:   Fri, 22 Jan 2021 11:50:53 +0100
Message-ID: <20210122105101.27374-7-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

st32mp1 RCC reset driver was moved into stm32mp1 RCC clock driver.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/reset/Kconfig          |   6 --
 drivers/reset/Makefile         |   1 -
 drivers/reset/reset-stm32mp1.c | 115 ---------------------------------
 3 files changed, 122 deletions(-)
 delete mode 100644 drivers/reset/reset-stm32mp1.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index df2725e1798e..97c9acc2064e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -198,12 +198,6 @@ config RESET_SIMPLE
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
 
-config RESET_STM32MP157
-	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-	default MACH_STM32MP157
-	help
-	  This enables the RCC reset controller driver for STM32 MPUs.
-
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
 	default ARCH_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 65a118a91b27..ac3e612ad953 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
-obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/reset-stm32mp1.c b/drivers/reset/reset-stm32mp1.c
deleted file mode 100644
index b221a28041fa..000000000000
--- a/drivers/reset/reset-stm32mp1.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
- * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
- */
-
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-
-#define CLR_OFFSET 0x4
-
-struct stm32_reset_data {
-	struct reset_controller_dev	rcdev;
-	void __iomem			*membase;
-};
-
-static inline struct stm32_reset_data *
-to_stm32_reset_data(struct reset_controller_dev *rcdev)
-{
-	return container_of(rcdev, struct stm32_reset_data, rcdev);
-}
-
-static int stm32_reset_update(struct reset_controller_dev *rcdev,
-			      unsigned long id, bool assert)
-{
-	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	void __iomem *addr;
-
-	addr = data->membase + (bank * reg_width);
-	if (!assert)
-		addr += CLR_OFFSET;
-
-	writel(BIT(offset), addr);
-
-	return 0;
-}
-
-static int stm32_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	return stm32_reset_update(rcdev, id, true);
-}
-
-static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return stm32_reset_update(rcdev, id, false);
-}
-
-static int stm32_reset_status(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	u32 reg;
-
-	reg = readl(data->membase + (bank * reg_width));
-
-	return !!(reg & BIT(offset));
-}
-
-static const struct reset_control_ops stm32_reset_ops = {
-	.assert		= stm32_reset_assert,
-	.deassert	= stm32_reset_deassert,
-	.status		= stm32_reset_status,
-};
-
-static const struct of_device_id stm32_reset_dt_ids[] = {
-	{ .compatible = "st,stm32mp1-rcc"},
-	{ /* sentinel */ },
-};
-
-static int stm32_reset_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct stm32_reset_data *data;
-	void __iomem *membase;
-	struct resource *res;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	membase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(membase))
-		return PTR_ERR(membase);
-
-	data->membase = membase;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
-	data->rcdev.ops = &stm32_reset_ops;
-	data->rcdev.of_node = dev->of_node;
-
-	return devm_reset_controller_register(dev, &data->rcdev);
-}
-
-static struct platform_driver stm32_reset_driver = {
-	.probe	= stm32_reset_probe,
-	.driver = {
-		.name		= "stm32mp1-reset",
-		.of_match_table	= stm32_reset_dt_ids,
-	},
-};
-
-builtin_platform_driver(stm32_reset_driver);
-- 
2.17.1

