Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBB27EA52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgI3Nv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:51:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y11so1184925qtn.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEQhLVt+nh+NhMtSNXoFzmNW+708cqCmbOcewdCxEwo=;
        b=MITSbwf0aPYaB5cpIBa6M69JAEZah9LJ8zUnYMBRqHbYXe+Fvx8PUyhSPnJmJgfp6j
         +GM9BCLnXTHY6TxTRZuUxjOVq5PxCnsxxMwhq9fcOrEhXPJF0ziiCr+JpgXIhPaboKln
         mJcq6Zmga4UmdFd1aAGZCaIl558UTjwgq+aXnsyfjUQRWP/tGrmLQp8PL1ufDxSMsY8B
         b678kYir+8kqgu9MvAGBaYxIDFxIuGMvEP/5G5igAbAX9s3jZkW3GH4dvqKGab4+KbbQ
         5aNL4NUDvBk9B/0OAOVixFsty81Oe+ECBiPCmN4o7IJmco7oKEMtZmV1ggKRHZgvNrbP
         SrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEQhLVt+nh+NhMtSNXoFzmNW+708cqCmbOcewdCxEwo=;
        b=fX6DsZY8YEX5+iRLfAAYH2y+LkaGI2HNBb9HvxIWXWVdB6e5t368IRV8c8DaP++5b2
         dPmfuuscqYLPiLgealJts8UqMppDTDVeFB3DiL4NlDo4RbENJ03x/tahnBlrGG/xKnNU
         gS4U5gDPZZdx+1hJAr+p+/T6vzNij4dJe0mSNRCCXISiyWb1JtfvgqPglqYP0S100Hww
         tHnBNw3CkcHykJ5X1/UniqPkYdGCHeu0FQJRnP09odhsU3CDLzWplZriuH6a0CcI3W5X
         T3iW2PaC2OGRBbN3tKIP16PAtDTALGvnGrhHXdbgOWcFMpmZUyJx2ZETePCUb6O21Z+w
         ctKQ==
X-Gm-Message-State: AOAM532wHC58bmSrS9TZTccUmr8CkKygD0LxhCQxEc2fQlxHuzerulJW
        FlcGQFtXUStzLrhXf+I4xVO5qg==
X-Google-Smtp-Source: ABdhPJySyjG/L5gHspnKJijgYRoeiUk34kSlDLUMoGez3VDmnS2fA7DVC6L2GSgU6JYp+Bx7Xogw6A==
X-Received: by 2002:ac8:6f50:: with SMTP id n16mr2351271qtv.190.1601473916146;
        Wed, 30 Sep 2020 06:51:56 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id b28sm2109788qka.117.2020.09.30.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:51:55 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Cc:     Richard Hughes <richard@hughsie.com>
Subject: [PATCH 2/2] Platform integrity information in sysfs (version 9)
Date:   Wed, 30 Sep 2020 10:51:48 -0300
Message-Id: <20200930135148.5651-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the BIOS Write Enable (bioswe), BIOS
Lock Enable (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of
the BIOS Control register using the platform-integrity misc kernel module.
The idea is to keep adding more flags, not only from the BC but also from
other registers in following versions.

The goal is that the attributes are avilable to fwupd when SecureBoot
is turned on.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
Tested-by: Richard Hughes <richard@hughsie.com>
---
 drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 ++++++++++++++-
 .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
 drivers/mtd/spi-nor/controllers/intel-spi.c   | 91 ++++++++++++++++++-
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
 5 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..e7eaef506fc2 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
 
 config SPI_INTEL_SPI
 	tristate
+	depends on PLATFORM_INTEGRITY_DATA
 
 config SPI_INTEL_SPI_PCI
 	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index c72aa1ab71ad..644b1a6091dc 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -10,11 +10,19 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform-integrity.h>
 
 #include "intel-spi.h"
 
 #define BCR		0xdc
 #define BCR_WPD		BIT(0)
+#define BCR_BLE		BIT(1)
+#define BCR_SMM_BWP	BIT(5)
+
+struct cnl_spi_attr {
+	struct device_attribute dev_attr;
+	u32 mask;
+};
 
 static const struct intel_spi_boardinfo bxt_info = {
 	.type = INTEL_SPI_BXT,
@@ -24,6 +32,70 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
+static ssize_t intel_spi_cnl_spi_attr_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf, u32 mask)
+{
+	u32 bcr;
+
+	if (dev->parent == NULL)
+		return -EIO;
+
+	if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
+				  BCR, &bcr) != PCIBIOS_SUCCESSFUL)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
+}
+
+static ssize_t bioswe_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_WPD);
+}
+static DEVICE_ATTR_RO(bioswe);
+
+static ssize_t biosle_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_BLE);
+}
+static DEVICE_ATTR_RO(biosle);
+
+static ssize_t smm_bioswp_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_SMM_BWP);
+}
+static DEVICE_ATTR_RO(smm_bioswp);
+
+static struct attribute *cnl_attrs[] = {
+	&dev_attr_bioswe.attr,
+	&dev_attr_biosle.attr,
+	&dev_attr_smm_bioswp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cnl);
+
+static struct device *
+register_local_platform_integrity_device(struct device *parent,
+					 enum intel_spi_type type)
+{
+	return create_platform_integrity_device(parent,	"intel-spi",
+		cnl_groups);
+}
+
+#else
+
+static struct device *
+register_local_platform_integrity_device(struct device *parent,
+					 enum intel_spi_type type)
+{
+	return NULL;
+}
+#endif /* CONFIG_PLATFORM_INTEGRITY_DATA */
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -50,7 +122,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
-	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
+	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info,
+			       register_local_platform_integrity_device);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c b/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
index f80f1086f928..5b1a9989426a 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
@@ -23,7 +23,7 @@ static int intel_spi_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ispi = intel_spi_probe(&pdev->dev, mem, info);
+	ispi = intel_spi_probe(&pdev->dev, mem, info, NULL);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index b54a56a68100..ff0d2afc9bf4 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/platform_data/intel-spi.h>
+#include <linux/platform-integrity.h>
 
 #include "intel-spi.h"
 
@@ -95,6 +96,8 @@
 #define BYT_SSFSTS_CTL			0x90
 #define BYT_BCR				0xfc
 #define BYT_BCR_WPD			BIT(0)
+#define BYT_BCR_BLE			BIT(1)
+#define BYT_BCR_SMM_BWP			BIT(5)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -157,6 +160,7 @@ struct intel_spi {
 	bool erase_64k;
 	u8 atomic_preopcode;
 	u8 opcodes[8];
+	struct device *platform_integrity_device;
 };
 
 static bool writeable;
@@ -305,7 +309,69 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
-static int intel_spi_init(struct intel_spi *ispi)
+#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
+static ssize_t byt_spi_attr_show(struct device *dev,
+				 struct device_attribute *attr, char *buf,
+				 u32 mask)
+{
+	u32 bcr;
+	struct intel_spi *ispi;
+
+	if (dev->parent == NULL)
+		return -EIO;
+
+	ispi = dev_get_drvdata(dev->parent);
+
+	bcr = readl(ispi->base + BYT_BCR);
+	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
+}
+
+static ssize_t bioswe_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_WPD);
+}
+static DEVICE_ATTR_RO(bioswe);
+
+static ssize_t biosle_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_BLE);
+}
+static DEVICE_ATTR_RO(biosle);
+
+static ssize_t smm_bioswp_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_SMM_BWP);
+}
+static DEVICE_ATTR_RO(smm_bioswp);
+
+static struct attribute *byt_attrs[] = {
+	&dev_attr_bioswe.attr,
+	&dev_attr_biosle.attr,
+	&dev_attr_smm_bioswp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(byt);
+
+static struct device *
+register_local_platform_integrity_device(struct device *parent,
+					 enum intel_spi_type type)
+{
+	switch (type) {
+	case INTEL_SPI_BYT:
+		return create_platform_integrity_device(parent, "intel-spi",
+							byt_groups);
+
+	default:
+		return NULL;
+	}
+}
+#endif /* CONFIG_PLATFORM_INTEGRITY_DATA */
+
+static int intel_spi_init(struct intel_spi *ispi,
+			  register_platform_integrity_t register_pi_cb)
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
 	int i;
@@ -422,6 +488,15 @@ static int intel_spi_init(struct intel_spi *ispi)
 
 	intel_spi_dump_regs(ispi);
 
+#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
+	if (register_pi_cb == NULL)
+		register_pi_cb = register_local_platform_integrity_device;
+	ispi->platform_integrity_device = register_pi_cb(ispi->dev,
+							 ispi->info->type);
+	if (IS_ERR(ispi->platform_integrity_device))
+		ispi->platform_integrity_device = NULL;
+#endif
+
 	return 0;
 }
 
@@ -904,7 +979,8 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 };
 
 struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info)
+	struct resource *mem, const struct intel_spi_boardinfo *info,
+	register_platform_integrity_t register_platform_integrity_cb)
 {
 	const struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ |
@@ -930,7 +1006,7 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	ispi->info = info;
 	ispi->writeable = info->writeable;
 
-	ret = intel_spi_init(ispi);
+	ret = intel_spi_init(ispi, register_platform_integrity_cb);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -960,6 +1036,15 @@ EXPORT_SYMBOL_GPL(intel_spi_probe);
 
 int intel_spi_remove(struct intel_spi *ispi)
 {
+#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
+	if (ispi->platform_integrity_device != NULL) {
+		destroy_platform_integrity_device(
+			ispi->platform_integrity_device);
+
+		ispi->platform_integrity_device = NULL;
+	}
+#endif /* CONFIG_PLATFORM_INTEGRITY_DATA */
+
 	return mtd_device_unregister(&ispi->nor.mtd);
 }
 EXPORT_SYMBOL_GPL(intel_spi_remove);
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
index e2f41b8827bf..5b00df0d4f19 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.h
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.h
@@ -14,8 +14,13 @@
 struct intel_spi;
 struct resource;
 
-struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info);
+typedef struct device *(*register_platform_integrity_t)(struct device *parent,
+			enum intel_spi_type type);
+
+struct intel_spi *intel_spi_probe(struct device *dev, struct resource *mem,
+				  const struct intel_spi_boardinfo *info,
+				  register_platform_integrity_t register_pi_cb);
+
 int intel_spi_remove(struct intel_spi *ispi);
 
 #endif /* INTEL_SPI_H */
-- 
2.25.1

