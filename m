Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35F2D0163
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgLFHPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 02:15:42 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:23502 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLFHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 02:15:41 -0500
Received: from localhost.localdomain ([93.23.13.76])
        by mwinf5d08 with ME
        id 0vDs240021eT3zR03vDso5; Sun, 06 Dec 2020 08:13:56 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Dec 2020 08:13:56 +0100
X-ME-IP: 93.23.13.76
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, trix@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] vme: switch from 'pci_' to 'dma_' API
Date:   Sun,  6 Dec 2020 08:13:52 +0100
Message-Id: <20201206071352.21949-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below and has been
hand modified to replace GFP_ with a correct flag.
It has been compile tested.

When memory is allocated in 'ca91cx42_alloc_consistent()' and
'tsi148_alloc_consistent()' GFP_KERNEL can be used because both functions
are called only from 'vme_alloc_consistent()' (vme.c). This function is
only called from the 'vme_user_probe()' probe function and no lock is
taken in the between.

When memory is allocated in 'ca91cx42_crcsr_init()' and
'tsi148_crcsr_init()' GFP_KERNEL can be used because both functions
are called only from their corresponding probe function and no lock is
taken in the between.

@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
---
 drivers/vme/bridges/vme_ca91cx42.c | 13 +++++++------
 drivers/vme/bridges/vme_tsi148.c   | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/vme/bridges/vme_ca91cx42.c b/drivers/vme/bridges/vme_ca91cx42.c
index ea938dc29c5e..439b0edeca08 100644
--- a/drivers/vme/bridges/vme_ca91cx42.c
+++ b/drivers/vme/bridges/vme_ca91cx42.c
@@ -1510,7 +1510,7 @@ static void *ca91cx42_alloc_consistent(struct device *parent, size_t size,
 	/* Find pci_dev container of dev */
 	pdev = to_pci_dev(parent);
 
-	return pci_alloc_consistent(pdev, size, dma);
+	return dma_alloc_coherent(&pdev->dev, size, dma, GFP_KERNEL);
 }
 
 static void ca91cx42_free_consistent(struct device *parent, size_t size,
@@ -1521,7 +1521,7 @@ static void ca91cx42_free_consistent(struct device *parent, size_t size,
 	/* Find pci_dev container of dev */
 	pdev = to_pci_dev(parent);
 
-	pci_free_consistent(pdev, size, vaddr, dma);
+	dma_free_coherent(&pdev->dev, size, vaddr, dma);
 }
 
 /*
@@ -1555,8 +1555,9 @@ static int ca91cx42_crcsr_init(struct vme_bridge *ca91cx42_bridge,
 	}
 
 	/* Allocate mem for CR/CSR image */
-	bridge->crcsr_kernel = pci_zalloc_consistent(pdev, VME_CRCSR_BUF_SIZE,
-						     &bridge->crcsr_bus);
+	bridge->crcsr_kernel = dma_alloc_coherent(&pdev->dev,
+						  VME_CRCSR_BUF_SIZE,
+						  &bridge->crcsr_bus, GFP_KERNEL);
 	if (!bridge->crcsr_kernel) {
 		dev_err(&pdev->dev, "Failed to allocate memory for CR/CSR "
 			"image\n");
@@ -1589,8 +1590,8 @@ static void ca91cx42_crcsr_exit(struct vme_bridge *ca91cx42_bridge,
 	/* Free image */
 	iowrite32(0, bridge->base + VCSR_TO);
 
-	pci_free_consistent(pdev, VME_CRCSR_BUF_SIZE, bridge->crcsr_kernel,
-		bridge->crcsr_bus);
+	dma_free_coherent(&pdev->dev, VME_CRCSR_BUF_SIZE,
+			  bridge->crcsr_kernel, bridge->crcsr_bus);
 }
 
 static int ca91cx42_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/vme/bridges/vme_tsi148.c b/drivers/vme/bridges/vme_tsi148.c
index 1227ea937059..be9051b02f24 100644
--- a/drivers/vme/bridges/vme_tsi148.c
+++ b/drivers/vme/bridges/vme_tsi148.c
@@ -2155,7 +2155,7 @@ static void *tsi148_alloc_consistent(struct device *parent, size_t size,
 	/* Find pci_dev container of dev */
 	pdev = to_pci_dev(parent);
 
-	return pci_alloc_consistent(pdev, size, dma);
+	return dma_alloc_coherent(&pdev->dev, size, dma, GFP_KERNEL);
 }
 
 static void tsi148_free_consistent(struct device *parent, size_t size,
@@ -2166,7 +2166,7 @@ static void tsi148_free_consistent(struct device *parent, size_t size,
 	/* Find pci_dev container of dev */
 	pdev = to_pci_dev(parent);
 
-	pci_free_consistent(pdev, size, vaddr, dma);
+	dma_free_coherent(&pdev->dev, size, vaddr, dma);
 }
 
 /*
@@ -2192,8 +2192,9 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	bridge = tsi148_bridge->driver_priv;
 
 	/* Allocate mem for CR/CSR image */
-	bridge->crcsr_kernel = pci_zalloc_consistent(pdev, VME_CRCSR_BUF_SIZE,
-						     &bridge->crcsr_bus);
+	bridge->crcsr_kernel = dma_alloc_coherent(&pdev->dev,
+						  VME_CRCSR_BUF_SIZE,
+						  &bridge->crcsr_bus, GFP_KERNEL);
 	if (!bridge->crcsr_kernel) {
 		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
 			"CR/CSR image\n");
@@ -2261,8 +2262,8 @@ static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
 	iowrite32be(0, bridge->base + TSI148_LCSR_CROU);
 	iowrite32be(0, bridge->base + TSI148_LCSR_CROL);
 
-	pci_free_consistent(pdev, VME_CRCSR_BUF_SIZE, bridge->crcsr_kernel,
-		bridge->crcsr_bus);
+	dma_free_coherent(&pdev->dev, VME_CRCSR_BUF_SIZE,
+			  bridge->crcsr_kernel, bridge->crcsr_bus);
 }
 
 static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.27.0

