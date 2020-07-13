Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70D42188B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgGHNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgGHNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CBC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:15:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so5576762pgm.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeH6T0xnzW7jFBhFc0hgdvqYTZU942iahhJCQgsP6LI=;
        b=f3XM/bklDRHyh0jy9YOqLyIbbuDKBYLnr2E0gAbFagx8W98n2v9PhOLaEJjKs0zAbv
         I65JFuaNwWJXKh+8I9BJNN5r5ISCUxQJ47Gx4bC4jhyayyOKvbEU6bwyXlvmof3by78m
         xnYlbSg2l0oD/4hvCXZ+62boL1Tan34ZWIVDuxc1Du66YvmgigTPoKMUTlgqxIYnP38P
         PJQTw7Dz3fHvoMzc3+vAvdTxq0ZW70dWQGeQ9+FoblFV23A74Pfc3eNI8ezgBH0SIN37
         KsvNzj4eO1qCNvVLARdw9ikchN4/Kbsv3EwMBYUENuRjOcZVXn3FUKdXyh36NYZON/z7
         fOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeH6T0xnzW7jFBhFc0hgdvqYTZU942iahhJCQgsP6LI=;
        b=VuYTJLf3i/rqG19TtzfhbQ816HxZE25RSLoXL7Cs19YnEnhl+1SPhfZRFVTLBfE6Eh
         F0vz/Rdfg5RrjRFsTnHZf5/Hq98kZhRsfdiZI+c13jmPU7s8EpuJ/O8Zqf7/oz5veae0
         L4UDwiiqGDjjXaz0XAWJYUC1VdniIdeZPxjTf1330vwVOUB3p01keXlczy3sS2H9h1tf
         1mwNvacObllgJQhm0ArZFi3U1oaTugXP81znyC/vEqKInxSuEbdgJjZ+UFXHEdFDvqdB
         +82R02lQ2+QB4yGqxFiP5Ju9xU/7G4S+bGl/fZC9B8rVw/6BgRw1fAQV+JKRKPXjnrBB
         GSBg==
X-Gm-Message-State: AOAM530ZSUJ6sVE1SPsJLvo94DOqGMpWYeFxpzC/vDs9up2Feg881MR2
        UFH8Z9Ycc/C9MYovBwRlZ4GoCEmoR2bq6g==
X-Google-Smtp-Source: ABdhPJxfXU930uaRwT098kELAmtJZl0Hguk0ooGKImAuHhy6P2vyi5V03PKTOloOtFQ1Vb+W9DMHOg==
X-Received: by 2002:a05:6a00:845:: with SMTP id q5mr38208443pfk.247.1594214124566;
        Wed, 08 Jul 2020 06:15:24 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id y63sm4096366pgb.49.2020.07.08.06.15.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:15:23 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v3 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
Date:   Wed,  8 Jul 2020 22:14:23 +0900
Message-Id: <20200708131424.18729-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708131424.18729-1-masahisa.kojima@linaro.org>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
window that is backed by the SPI command sequencer in the SPI bus
controller. This arrangement has the limitation that only byte size
accesses are supported, and so we'll need to provide a separate module
that take this into account.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/char/tpm/Kconfig             |  12 ++
 drivers/char/tpm/Makefile            |   1 +
 drivers/char/tpm/tpm_tis_synquacer.c | 196 +++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 58b4c573d176..a18c314da211 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
 	  If you have a H1 secure module running Cr50 firmware on SPI bus,
 	  say Yes and it will be accessible from within Linux.
 
+config TCG_TIS_SYNQUACER
+	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
+	depends on ARCH_SYNQUACER
+	select TCG_TIS_CORE
+	help
+	  If you have a TPM security chip that is compliant with the
+	  TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
+	  specification (TPM2.0) say Yes and it will be accessible from
+	  within Linux on Socionext SynQuacer platform.
+	  To compile this driver as a module, choose  M here;
+	  the module will be called tpm_tis_synquacer.
+
 config TCG_TIS_I2C_ATMEL
 	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
 	depends on I2C
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9567e5197f74..84db4fb3a9c9 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -21,6 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
+obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
 
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
 tpm_tis_spi-y := tpm_tis_spi_main.o
diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
new file mode 100644
index 000000000000..51f0aedcedcc
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * This device driver implements MMIO TPM on SynQuacer Platform.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/kernel.h>
+#include "tpm.h"
+#include "tpm_tis_core.h"
+
+struct tpm_info {
+	struct resource res;
+	/* irq > 0 means: use irq $irq;
+	 * irq = 0 means: autoprobe for an irq;
+	 * irq = -1 means: no irq support
+	 */
+	int irq;
+};
+
+struct tpm_tis_tcg_phy {
+	struct tpm_tis_data priv;
+	void __iomem *iobase;
+};
+
+static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
+{
+	return container_of(data, struct tpm_tis_tcg_phy, priv);
+}
+
+static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
+			      u8 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		*result++ = ioread8(phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
+			       const u8 *value)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		iowrite8(*value++, phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	*result = (ioread8(phy->iobase + addr + 1) << 8) |
+		  (ioread8(phy->iobase + addr));
+
+	return 0;
+}
+
+static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	*result = (ioread8(phy->iobase + addr + 3) << 24) |
+		  (ioread8(phy->iobase + addr + 2) << 16) |
+		  (ioread8(phy->iobase + addr + 1) << 8) |
+		  (ioread8(phy->iobase + addr));
+
+	return 0;
+}
+
+static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	iowrite8(value >> 24, phy->iobase + addr + 3);
+	iowrite8(value >> 16, phy->iobase + addr + 2);
+	iowrite8(value >> 8, phy->iobase + addr + 1);
+	iowrite8(value, phy->iobase + addr);
+
+	return 0;
+}
+
+static const struct tpm_tis_phy_ops tpm_tcg_bw = {
+	.read_bytes	= tpm_tcg_read_bytes,
+	.write_bytes	= tpm_tcg_write_bytes,
+	.read16		= tpm_tcg_read16_bw,
+	.read32		= tpm_tcg_read32_bw,
+	.write32	= tpm_tcg_write32_bw,
+};
+
+static int tpm_tis_synquacer_init(struct device *dev, struct tpm_info *tpm_info)
+{
+	struct tpm_tis_tcg_phy *phy;
+	int irq = -1;
+
+	phy = devm_kzalloc(dev, sizeof(struct tpm_tis_tcg_phy), GFP_KERNEL);
+	if (phy == NULL)
+		return -ENOMEM;
+
+	phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
+	if (IS_ERR(phy->iobase))
+		return PTR_ERR(phy->iobase);
+
+	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg_bw,
+				 ACPI_HANDLE(dev));
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int tpm_tis_synquacer_probe(struct platform_device *pdev)
+{
+	struct tpm_info tpm_info = {};
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		return -ENODEV;
+	}
+	tpm_info.res = *res;
+
+	tpm_info.irq = -1;
+
+	return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
+}
+
+static int tpm_tis_synquacer_remove(struct platform_device *pdev)
+{
+	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
+
+	tpm_chip_unregister(chip);
+	tpm_tis_remove(chip);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id tis_synquacer_of_platform_match[] = {
+	{.compatible = "socionext,synquacer-tpm-mmio"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tis_synquacer_of_platform_match);
+#endif
+
+static struct platform_driver tis_synquacer_drv = {
+	.probe = tpm_tis_synquacer_probe,
+	.remove = tpm_tis_synquacer_remove,
+	.driver = {
+		.name		= "tpm_tis_synquacer",
+		.pm		= &tpm_tis_synquacer_pm,
+		.of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
+	},
+};
+
+static int __init init_tis_synquacer(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&tis_synquacer_drv);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void __exit cleanup_tis_synquacer(void)
+{
+	platform_driver_unregister(&tis_synquacer_drv);
+}
+
+module_init(init_tis_synquacer);
+module_exit(cleanup_tis_synquacer);
+MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
+MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
-- 
2.20.1

