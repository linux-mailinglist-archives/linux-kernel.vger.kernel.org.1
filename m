Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3151D9921
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgESOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:14:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30285 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729077AbgESOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:14:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589897684; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+ZgP1FahFYYzLV4C1qDNHdNlu5/WbgR+BfCRFfWfscU=; b=Ec3vfA8fp5+YoYbYiPpWMDN8+zGgbzpamQZGW/kCeON4nlmt344feXM1NsklsmdlCquO5qLs
 x75c7H0ZvmttnpU52wltNt2u5zRxAp8NBMQoT2FZ+KRkjsK5dIE+jw7T8KNZzgqJpNTRWrCA
 daOJqnpuMGgBGD47pBnSHxnB/Zs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec3e9bc.7f698e231c38-smtp-out-n03;
 Tue, 19 May 2020 14:14:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7DCDEC433D2; Tue, 19 May 2020 14:14:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D692C43637;
        Tue, 19 May 2020 14:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D692C43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        wufan@codeaurora.org, pratanan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [RFC v2 PATCH 1/8] qaic: Add skeleton driver
Date:   Tue, 19 May 2020 08:13:58 -0600
Message-Id: <1589897645-17088-2-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589897645-17088-1-git-send-email-jhugo@codeaurora.org>
References: <1589897645-17088-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Qualcomm Cloud AI 100 skeleton driver that does nothing but
registers a pci driver, probes on the proper device, and supports removal
of the module.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/misc/Kconfig         |  1 +
 drivers/misc/Makefile        |  1 +
 drivers/misc/qaic/Kconfig    | 20 ++++++++++++++
 drivers/misc/qaic/Makefile   |  9 +++++++
 drivers/misc/qaic/qaic_drv.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+)
 create mode 100644 drivers/misc/qaic/Kconfig
 create mode 100644 drivers/misc/qaic/Makefile
 create mode 100644 drivers/misc/qaic/qaic_drv.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 99e1514..ef91d062 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,4 +481,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/qaic/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9abf292..64f0770 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_QAIC)		+= qaic/
diff --git a/drivers/misc/qaic/Kconfig b/drivers/misc/qaic/Kconfig
new file mode 100644
index 0000000..502d176
--- /dev/null
+++ b/drivers/misc/qaic/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm Cloud AI 100 accelerators driver
+#
+
+config QAIC
+	tristate "Qualcomm Cloud AI 100 accelerators"
+	depends on PCI && HAS_IOMEM
+	depends on MHI_BUS
+	help
+	  Enables driver for Qualcomm's Cloud AI 100 accelerator PCIe cards
+	  that are designed to accelerate Deep Learning inference workloads.
+
+	  The driver manages the PCIe devices and provides an IOCTL interface
+	  for users to submit workloads to the devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qaic.
diff --git a/drivers/misc/qaic/Makefile b/drivers/misc/qaic/Makefile
new file mode 100644
index 0000000..9db6417
--- /dev/null
+++ b/drivers/misc/qaic/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm Cloud AI 100 accelerators driver
+#
+
+obj-$(CONFIG_QAIC)	:= qaic.o
+
+qaic-y := \
+	qaic_drv.o
diff --git a/drivers/misc/qaic/qaic_drv.c b/drivers/misc/qaic/qaic_drv.c
new file mode 100644
index 0000000..942dbf6
--- /dev/null
+++ b/drivers/misc/qaic/qaic_drv.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (c) 2019-2020, The Linux Foundation. All rights reserved. */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+#define PCI_DEV_AIC100			0xa100
+
+static int qaic_pci_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	pci_dbg(pdev, "%s\n", __func__);
+	pci_dbg(pdev, "%s: successful init\n", __func__);
+	return 0;
+}
+
+static void qaic_pci_remove(struct pci_dev *pdev)
+{
+	pci_dbg(pdev, "%s\n", __func__);
+}
+
+static const struct pci_device_id ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, PCI_DEV_AIC100), },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ids);
+
+static struct pci_driver qaic_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = ids,
+	.probe = qaic_pci_probe,
+	.remove = qaic_pci_remove,
+};
+
+static int __init qaic_init(void)
+{
+	int ret;
+
+	pr_debug("qaic: init\n");
+
+	ret = pci_register_driver(&qaic_pci_driver);
+
+	pr_debug("qaic: init success\n");
+
+	return ret;
+}
+
+static void __exit qaic_exit(void)
+{
+	pr_debug("qaic: exit\n");
+	pci_unregister_driver(&qaic_pci_driver);
+}
+
+module_init(qaic_init);
+module_exit(qaic_exit);
+
+MODULE_AUTHOR("Qualcomm Cloud AI 100 Accelerator Kernel Driver Team");
+MODULE_DESCRIPTION("Qualcomm Cloud AI 100 Accelerators Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.0.0"); /* MAJOR.MINOR.PATCH */
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
