Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5322F87B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbhAOVcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbhAOVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:32:40 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81802C061757;
        Fri, 15 Jan 2021 13:31:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t29so1178465pfg.11;
        Fri, 15 Jan 2021 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=daB8SKpGoYp46Xadk+GW4C9RuVGs4Ns6xxK2/c/M4MU=;
        b=UqaWxJEd68lv54fW0hnFrhSSnn7PZeLuMOUFfl+E6+RQoeRqQSYrb2IdPG5GpH8Ont
         ESmnjvp5HuyGNNHtmygqq4cT59G3LoQdelHlRoDED0j7FHM/XagKJscCpjT0J0NwmmSM
         V5hy6MPokLOo1e7DDRZ5wDLdmhBih/WqdZlNv1i0USXAvGgH25LqYpaBxivf/zo+USWA
         wSW2yFDrLp3tsdzLwlggJaRRAW3nn3DfOULO9uockYQvEmKvYqd46nAiH6caNDb40jKv
         qNX7/5pJCSiR2dbawJOFY0NsL6nJuGmAPxrDo7R4TCzWfplx8rM8IFN5H5Q3BLgPa5PI
         HKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=daB8SKpGoYp46Xadk+GW4C9RuVGs4Ns6xxK2/c/M4MU=;
        b=EpNwUL9bq60fB0ueqb403P3nfB2g3gjmTnBVsqwqInEy6RDGKC7kpmybEJBPiY5uX1
         kZ3KIxKxZvea1DMjb01bm7qFdT593VI6hNIx4aF+vcC275Fu6V6y9WjGJWypzvZfwhIp
         2nmxSkBvYgtGQk4+wpo7wshP72P6DQ4TeiZSsAPF4BfpHKl0mTCjv+HMiLWxhqixCfvI
         jNGk1Bj5RBfZn9pDps3+5OA5yX/IXCSJLsUxx4vgpk6S6K+5uQKZhGEKaVrPaL8XTr77
         d6W99r/wXfU/EdUxPEbkPbyFsZevx7pQVXierYgDeElTrzKsOOFTO1jUCniL5FfTH+Vn
         qzBA==
X-Gm-Message-State: AOAM533hMygA4UkV1NPqecs7FU8R3geXeO1vnHbeZybJMYjijVyWVAoK
        9IbDanWiTX6Y2Z3+hCZHyC1Zi8PobMw=
X-Google-Smtp-Source: ABdhPJxDQTrH5NaVjuHXHKhKIBYFgbOsd48youJAXEKgLfsPN9Y3H21P6fWdngiz8j2HeC/ubihCyA==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr14492223pgl.54.1610746318686;
        Fri, 15 Jan 2021 13:31:58 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m22sm9252250pgj.46.2021.01.15.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:31:58 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: [PATCH] usb: bdc: Remove the BDC PCI driver
Date:   Fri, 15 Jan 2021 16:31:42 -0500
Message-Id: <20210115213142.35003-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BDC PCI driver was only used for design verification with
an PCI/FPGA board. The board no longer exists and is not in use
anywhere. All instances of this core now exist as a memory mapped
device on the platform bus.

NOTE: This only removes the PCI driver and does not remove the
platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/Kconfig   |  11 ---
 drivers/usb/gadget/udc/bdc/Makefile  |   2 -
 drivers/usb/gadget/udc/bdc/bdc_pci.c | 128 ---------------------------
 3 files changed, 141 deletions(-)
 delete mode 100644 drivers/usb/gadget/udc/bdc/bdc_pci.c

diff --git a/drivers/usb/gadget/udc/bdc/Kconfig b/drivers/usb/gadget/udc/bdc/Kconfig
index 3e88c7670b2e..8bedb7f64eba 100644
--- a/drivers/usb/gadget/udc/bdc/Kconfig
+++ b/drivers/usb/gadget/udc/bdc/Kconfig
@@ -11,14 +11,3 @@ config USB_BDC_UDC
 
 	Say "y" here to link the driver statically, or "m" to build a dynamically
 	linked module called "bdc".
-
-if USB_BDC_UDC
-
-comment "Platform Support"
-config	USB_BDC_PCI
-	tristate "BDC support for PCIe based platforms"
-	depends on USB_PCI
-	default USB_BDC_UDC
-	help
-		Enable support for platforms which have BDC connected through PCIe, such as Lego3 FPGA platform.
-endif
diff --git a/drivers/usb/gadget/udc/bdc/Makefile b/drivers/usb/gadget/udc/bdc/Makefile
index 52cb5ea48bbe..1b21c9518efc 100644
--- a/drivers/usb/gadget/udc/bdc/Makefile
+++ b/drivers/usb/gadget/udc/bdc/Makefile
@@ -5,5 +5,3 @@ bdc-y	:= bdc_core.o bdc_cmd.o bdc_ep.o bdc_udc.o
 ifneq ($(CONFIG_USB_GADGET_VERBOSE),)
 	bdc-y			+= bdc_dbg.o
 endif
-
-obj-$(CONFIG_USB_BDC_PCI)	+= bdc_pci.o
diff --git a/drivers/usb/gadget/udc/bdc/bdc_pci.c b/drivers/usb/gadget/udc/bdc/bdc_pci.c
deleted file mode 100644
index 6dbc489513cd..000000000000
--- a/drivers/usb/gadget/udc/bdc/bdc_pci.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * bdc_pci.c - BRCM BDC USB3.0 device controller PCI interface file.
- *
- * Copyright (C) 2014 Broadcom Corporation
- *
- * Author: Ashwini Pahuja
- *
- * Based on drivers under drivers/usb/
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/platform_device.h>
-
-#include "bdc.h"
-
-#define BDC_PCI_PID 0x1570
-
-struct bdc_pci {
-	struct device *dev;
-	struct platform_device *bdc;
-};
-
-static int bdc_setup_msi(struct pci_dev *pci)
-{
-	int ret;
-
-	ret = pci_enable_msi(pci);
-	if (ret) {
-		pr_err("failed to allocate MSI entry\n");
-		return ret;
-	}
-
-	return ret;
-}
-
-static int bdc_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
-{
-	struct resource res[2];
-	struct platform_device *bdc;
-	struct bdc_pci *glue;
-	int ret = -ENOMEM;
-
-	glue = devm_kzalloc(&pci->dev, sizeof(*glue), GFP_KERNEL);
-	if (!glue)
-		return -ENOMEM;
-
-	glue->dev = &pci->dev;
-	ret = pci_enable_device(pci);
-	if (ret) {
-		dev_err(&pci->dev, "failed to enable pci device\n");
-		return -ENODEV;
-	}
-	pci_set_master(pci);
-
-	bdc = platform_device_alloc(BRCM_BDC_NAME, PLATFORM_DEVID_AUTO);
-	if (!bdc)
-		return -ENOMEM;
-
-	memset(res, 0x00, sizeof(struct resource) * ARRAY_SIZE(res));
-	bdc_setup_msi(pci);
-
-	res[0].start	= pci_resource_start(pci, 0);
-	res[0].end	= pci_resource_end(pci, 0);
-	res[0].name	= BRCM_BDC_NAME;
-	res[0].flags	= IORESOURCE_MEM;
-
-	res[1].start	= pci->irq;
-	res[1].name	= BRCM_BDC_NAME;
-	res[1].flags	= IORESOURCE_IRQ;
-
-	ret = platform_device_add_resources(bdc, res, ARRAY_SIZE(res));
-	if (ret) {
-		dev_err(&pci->dev,
-			"couldn't add resources to bdc device\n");
-		platform_device_put(bdc);
-		return ret;
-	}
-
-	pci_set_drvdata(pci, glue);
-
-	dma_set_coherent_mask(&bdc->dev, pci->dev.coherent_dma_mask);
-
-	bdc->dev.dma_mask = pci->dev.dma_mask;
-	bdc->dev.dma_parms = pci->dev.dma_parms;
-	bdc->dev.parent = &pci->dev;
-	glue->bdc = bdc;
-
-	ret = platform_device_add(bdc);
-	if (ret) {
-		dev_err(&pci->dev, "failed to register bdc device\n");
-		platform_device_put(bdc);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void bdc_pci_remove(struct pci_dev *pci)
-{
-	struct bdc_pci *glue = pci_get_drvdata(pci);
-
-	platform_device_unregister(glue->bdc);
-	pci_disable_msi(pci);
-}
-
-static struct pci_device_id bdc_pci_id_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BDC_PCI_PID), },
-	{} /* Terminating Entry */
-};
-
-MODULE_DEVICE_TABLE(pci, bdc_pci_id_table);
-
-static struct pci_driver bdc_pci_driver = {
-	.name = "bdc-pci",
-	.id_table = bdc_pci_id_table,
-	.probe = bdc_pci_probe,
-	.remove = bdc_pci_remove,
-};
-
-MODULE_AUTHOR("Ashwini Pahuja <ashwini.linux@gmail.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("BRCM BDC USB3 PCI Glue layer");
-module_pci_driver(bdc_pci_driver);
-- 
2.17.1

