Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFF3045D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393871AbhAZSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:00:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390865AbhAZJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:30 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8te45000597;
        Tue, 26 Jan 2021 10:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=12HwvlPBuSR/zDssyt6nTVihM14VFcWDtTsZr7M56ac=;
 b=FpPMotRQOWUfYcIXD3Qeew24EOBA4iAV1mQwfHOOdrTGdb7j1G06jGYLCJa+AV+4PhQo
 Kh/Il2TwnQ85qlEsi96Y0Wc0wzLHMLk9YRTfcPXCsa3A9ZqXeHY6C/qPOLyG/tta4WkG
 WysXHk35vYnLx2omJZOIpcQBPhsspPNq2vli8IIFQg5xDTztMp+5/NBn+EDl6rHHpo/i
 Hkiybc29KDWYXPT8U747utjP1AdYaMmqoFO+XqldU0TCGSxDp4hlr1EFzs5Bz9TpuBIW
 nMsCwMMw6UPzmlGEHxUDd4aqviXXG02fszZmGk5eNvGhz0DreeMytEair0lIyEmGz+6A pQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368c15qgjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BD7D10002A;
        Tue, 26 Jan 2021 10:04:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C90D2288C8;
        Tue, 26 Jan 2021 10:04:37 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:36
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/14] reset: stm32mp1: remove stm32mp1 reset
Date:   Tue, 26 Jan 2021 10:01:12 +0100
Message-ID: <20210126090120.19900-7-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
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
index 71ab75a46491..6c58056f1732 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -188,12 +188,6 @@ config RESET_SIMPLE
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
index 1054123fd187..c17f5b3c641e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
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

