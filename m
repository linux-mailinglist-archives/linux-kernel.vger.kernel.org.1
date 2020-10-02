Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60D281D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJBVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:24:09 -0400
Received: from mail-ua1-x961.google.com (mail-ua1-x961.google.com [IPv6:2607:f8b0:4864:20::961])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DBAC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:24:09 -0700 (PDT)
Received: by mail-ua1-x961.google.com with SMTP id v5so753588uau.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8ffbs2FO4vbxV0RvAOrcexGDCubGhJEMvtryEnxP5k=;
        b=eP4s1NVVyERRIejzRzRSIVVFqRlsDLJSuxwKPNfrHpsXKjs/cmzMdwsqZpaynFebu+
         cbGJwVePshWydmt+cc/iNhq89hFa34FaaAIjJyv9npiA1MlmY5yHN22tCMOEQ8Z/FuIc
         s98vxDqoCU8HF+8CSgWghy+g50GcDE0eM3yIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8ffbs2FO4vbxV0RvAOrcexGDCubGhJEMvtryEnxP5k=;
        b=nC9l11Jpiz3+/AWzwhGtViopYM9PKq61+fs0KUz9yl0OMnOJ0OTjhzY4wIuEBVA5yG
         RbRguEGh9SwycvU4Hosmy96xcH0Caro+PwfGm5HdU1EDFZNlp1BfRTTJ7bmkYdNmFrNv
         GPBb0TrMY8TLStU0V2lOH7BeQb0CPjyys3zYQyF2IgpJXiavsM1VV25z3Qp6xjfwVSks
         bIbJ6Yo9y+XVTQ2Rw18u8qYUYJumyST+7FP0leDxhN0lxRjGhY7T+87Gd342bpGidH45
         6/P9lU6X32ZAtQky5EJ/BWEuH5CeUbHnGUAuznQl+sXihddvpoHF7+aSJ3rOAhZJWmTA
         Lslw==
X-Gm-Message-State: AOAM530mYIC+Ce5b+aPEMB25lX+vT+ZDKiHbkc5Cn7cA50Ai10dHPDU1
        IDBQ8Q9PhalCHEn4jC4Y9mprr2s64sEjGrvM4IBx9bcQZLuv
X-Google-Smtp-Source: ABdhPJw5w5Z9u1rA800NjginMpVkcl7g6MZbkhSei4ssbbfKhrmh6RYLXvbuXxI3bi++Rj7Qc+1OVcvB1VPR
X-Received: by 2002:ab0:2a8c:: with SMTP id h12mr2455839uar.26.1601673848805;
        Fri, 02 Oct 2020 14:24:08 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:24:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 02/14] misc: bcm-vk: add Broadcom VK driver
Date:   Fri,  2 Oct 2020 14:23:15 -0700
Message-Id: <20201002212327.18393-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial version of Broadcom VK driver to enumerate PCI device IDs
of Valkyrie and Viper device IDs.

VK based cards provide real-time high performance, high throughput,
low latency offload compute engine operations.
They are used for multiple parallel offload tasks as:
audio, video and image processing and crypto operations.

Further commits add additional features to driver beyond probe/remove.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/Kconfig             |   1 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/bcm-vk/Kconfig      |  15 ++++
 drivers/misc/bcm-vk/Makefile     |   8 ++
 drivers/misc/bcm-vk/bcm_vk.h     |  29 +++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 141 +++++++++++++++++++++++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ce136d685d14..9d42b5def81b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -469,6 +469,7 @@ source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
+source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..766837e4b961 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
+obj-$(CONFIG_BCM_VK)		+= bcm-vk/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
new file mode 100644
index 000000000000..2272e47655ed
--- /dev/null
+++ b/drivers/misc/bcm-vk/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Broadcom VK device
+#
+config BCM_VK
+	tristate "Support for Broadcom VK Accelerators"
+	depends on PCI_MSI
+	help
+	  Select this option to enable support for Broadcom
+	  VK Accelerators.  VK is used for performing
+	  specific offload processing.
+	  This driver enables userspace programs to access these
+	  accelerators via /dev/bcm-vk.N devices.
+
+	  If unsure, say N.
diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
new file mode 100644
index 000000000000..f8a7ac4c242f
--- /dev/null
+++ b/drivers/misc/bcm-vk/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Broadcom VK driver
+#
+
+obj-$(CONFIG_BCM_VK) += bcm_vk.o
+bcm_vk-objs := \
+	bcm_vk_dev.o
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
new file mode 100644
index 000000000000..9152785199ab
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef BCM_VK_H
+#define BCM_VK_H
+
+#include <linux/pci.h>
+
+#define DRV_MODULE_NAME		"bcm-vk"
+
+/* VK device supports a maximum of 3 bars */
+#define MAX_BAR	3
+
+enum pci_barno {
+	BAR_0 = 0,
+	BAR_1,
+	BAR_2
+};
+
+#define BCM_VK_NUM_TTY 2
+
+struct bcm_vk {
+	struct pci_dev *pdev;
+	void __iomem *bar[MAX_BAR];
+};
+
+#endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
new file mode 100644
index 000000000000..14afe2477b97
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#include "bcm_vk.h"
+
+#define PCI_DEVICE_ID_VALKYRIE	0x5e87
+#define PCI_DEVICE_ID_VIPER	0x5e88
+
+/* MSIX usages */
+#define VK_MSIX_MSGQ_MAX		3
+#define VK_MSIX_NOTF_MAX		1
+#define VK_MSIX_TTY_MAX			BCM_VK_NUM_TTY
+#define VK_MSIX_IRQ_MAX			(VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX + \
+					 VK_MSIX_TTY_MAX)
+#define VK_MSIX_IRQ_MIN_REQ             (VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX)
+
+/* Number of bits set in DMA mask*/
+#define BCM_VK_DMA_BITS			64
+
+static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int err;
+	int i;
+	int irq;
+	struct bcm_vk *vk;
+	struct device *dev = &pdev->dev;
+
+	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
+	if (!vk)
+		return -ENOMEM;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device\n");
+		goto err_free_exit;
+	}
+	vk->pdev = pci_dev_get(pdev);
+
+	err = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (err) {
+		dev_err(dev, "Cannot obtain PCI resources\n");
+		goto err_disable_pdev;
+	}
+
+	/* make sure DMA is good */
+	err = dma_set_mask_and_coherent(&pdev->dev,
+					DMA_BIT_MASK(BCM_VK_DMA_BITS));
+	if (err) {
+		dev_err(dev, "failed to set DMA mask\n");
+		goto err_disable_pdev;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vk);
+
+	irq = pci_alloc_irq_vectors(pdev,
+				    1,
+				    VK_MSIX_IRQ_MAX,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+
+	if (irq < VK_MSIX_IRQ_MIN_REQ) {
+		dev_err(dev, "failed to get min %d MSIX interrupts, irq(%d)\n",
+			VK_MSIX_IRQ_MIN_REQ, irq);
+		err = (irq >= 0) ? -EINVAL : irq;
+		goto err_disable_pdev;
+	}
+
+	if (irq != VK_MSIX_IRQ_MAX)
+		dev_warn(dev, "Number of IRQs %d allocated - requested(%d).\n",
+			 irq, VK_MSIX_IRQ_MAX);
+
+	for (i = 0; i < MAX_BAR; i++) {
+		/* multiple by 2 for 64 bit BAR mapping */
+		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
+		if (!vk->bar[i]) {
+			dev_err(dev, "failed to remap BAR%d\n", i);
+			goto err_iounmap;
+		}
+	}
+
+	return 0;
+
+err_iounmap:
+	for (i = 0; i < MAX_BAR; i++) {
+		if (vk->bar[i])
+			pci_iounmap(pdev, vk->bar[i]);
+	}
+	pci_release_regions(pdev);
+
+err_disable_pdev:
+	pci_free_irq_vectors(pdev);
+	pci_disable_device(pdev);
+	pci_dev_put(pdev);
+
+err_free_exit:
+	kfree(vk);
+
+	return err;
+}
+
+static void bcm_vk_remove(struct pci_dev *pdev)
+{
+	int i;
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	for (i = 0; i < MAX_BAR; i++) {
+		if (vk->bar[i])
+			pci_iounmap(pdev, vk->bar[i]);
+	}
+
+	pci_release_regions(pdev);
+	pci_free_irq_vectors(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id bcm_vk_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
+
+static struct pci_driver pci_driver = {
+	.name     = DRV_MODULE_NAME,
+	.id_table = bcm_vk_ids,
+	.probe    = bcm_vk_probe,
+	.remove   = bcm_vk_remove,
+};
+module_pci_driver(pci_driver);
+
+MODULE_DESCRIPTION("Broadcom VK Host Driver");
+MODULE_AUTHOR("Scott Branden <scott.branden@broadcom.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("1.0");
-- 
2.17.1

