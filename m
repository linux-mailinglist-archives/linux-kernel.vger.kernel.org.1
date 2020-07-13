Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3921C292
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGKGno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 02:43:44 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:39900 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGKGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:43:44 -0400
Received: from localhost.localdomain ([93.22.151.150])
        by mwinf5d86 with ME
        id 1ije2300L3Ewh7h03ijfPk; Sat, 11 Jul 2020 08:43:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jul 2020 08:43:40 +0200
X-ME-IP: 93.22.151.150
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     xx@mail.com
Cc:     list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] rsxx: switch from 'pci_free_consistent()' to 'dma_free_coherent()'
Date:   Sat, 11 Jul 2020 08:43:36 +0200
Message-Id: <20200711064336.247502-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script bellow.
It has been compile tested.

This also aligns code with what is in use in '/rsxx/dma.c'


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

For an example of code used in '/rsxx/dma.c', see:
   https://elixir.bootlin.com/linux/v5.7.8/source/drivers/block/rsxx/dma.c#L951
---
 drivers/block/rsxx/core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 9230f453bb8b..e631749e14ca 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -562,13 +562,15 @@ static int rsxx_eeh_frozen(struct pci_dev *dev)
 
 	for (i = 0; i < card->n_targets; i++) {
 		if (card->ctrl[i].status.buf)
-			pci_free_consistent(card->dev, STATUS_BUFFER_SIZE8,
-					    card->ctrl[i].status.buf,
-					    card->ctrl[i].status.dma_addr);
+			dma_free_coherent(&card->dev->dev,
+					  STATUS_BUFFER_SIZE8,
+					  card->ctrl[i].status.buf,
+					  card->ctrl[i].status.dma_addr);
 		if (card->ctrl[i].cmd.buf)
-			pci_free_consistent(card->dev, COMMAND_BUFFER_SIZE8,
-					    card->ctrl[i].cmd.buf,
-					    card->ctrl[i].cmd.dma_addr);
+			dma_free_coherent(&card->dev->dev,
+					  COMMAND_BUFFER_SIZE8,
+					  card->ctrl[i].cmd.buf,
+					  card->ctrl[i].cmd.dma_addr);
 	}
 
 	return 0;
@@ -711,15 +713,15 @@ static pci_ers_result_t rsxx_slot_reset(struct pci_dev *dev)
 failed_hw_buffers_init:
 	for (i = 0; i < card->n_targets; i++) {
 		if (card->ctrl[i].status.buf)
-			pci_free_consistent(card->dev,
-					STATUS_BUFFER_SIZE8,
-					card->ctrl[i].status.buf,
-					card->ctrl[i].status.dma_addr);
+			dma_free_coherent(&card->dev->dev,
+					  STATUS_BUFFER_SIZE8,
+					  card->ctrl[i].status.buf,
+					  card->ctrl[i].status.dma_addr);
 		if (card->ctrl[i].cmd.buf)
-			pci_free_consistent(card->dev,
-					COMMAND_BUFFER_SIZE8,
-					card->ctrl[i].cmd.buf,
-					card->ctrl[i].cmd.dma_addr);
+			dma_free_coherent(&card->dev->dev,
+					  COMMAND_BUFFER_SIZE8,
+					  card->ctrl[i].cmd.buf,
+					  card->ctrl[i].cmd.dma_addr);
 	}
 failed_hw_setup:
 	rsxx_eeh_failure(dev);
-- 
2.25.1

