Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75C2A48D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgKCPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgKCPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:00:56 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E89223BF;
        Tue,  3 Nov 2020 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415656;
        bh=sCYd+MasIxW818AJrDTnfUu/KGyZ5UfToQ5UC/b/9vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8LcFfRGfEtt4RyjektnlkHCC7fB8nYZHxTpQEmT6spWG6RsQzOegd2RFhICeOFHW
         hJa8ouQYNtmkV57nuioChL8GxlhiLYdgvLSl3wG61Uk7UXYElsQPq1sy54MrYegc4C
         sIH3+a2WtoY7+DSYlFZ9i3BA2tNM06xr9aXAB6jw=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs/gaudi: Set DMA5 QMAN internal
Date:   Tue,  3 Nov 2020 17:00:45 +0200
Message-Id: <20201103150046.19074-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103150046.19074-1-ogabbay@kernel.org>
References: <20201103150046.19074-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

DMA5 QMAN is designated to be used for reduction process, hence it will
be no longer configured as external queue.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 31 +++++++++++---------------
 drivers/misc/habanalabs/gaudi/gaudiP.h |  8 +++----
 include/uapi/misc/habanalabs.h         | 12 +++++-----
 3 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 91916040faac..2ba15d3470dd 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -38,7 +38,7 @@
  *
  * MMU is always enabled.
  *
- * QMAN DMA channels 0,1,5 (PCI DMAN):
+ * QMAN DMA channels 0,1 (PCI DMAN):
  *     - DMA is not secured.
  *     - PQ and CQ are secured.
  *     - CP is secured: The driver needs to parse CB but WREG should be allowed
@@ -55,7 +55,7 @@
  *       idle)
  *     - MMU page tables area clear (happens on init)
  *
- * QMAN DMA 2-4,6,7, TPC, MME, NIC:
+ * QMAN DMA 2-7, TPC, MME, NIC:
  * PQ is secured and is located on the Host (HBM CON TPC3 bug)
  * CQ, CP and the engine are not secured
  *
@@ -113,12 +113,12 @@ static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 static const u8 gaudi_dma_assignment[GAUDI_DMA_MAX] = {
 	[GAUDI_PCI_DMA_1] = GAUDI_ENGINE_ID_DMA_0,
 	[GAUDI_PCI_DMA_2] = GAUDI_ENGINE_ID_DMA_1,
-	[GAUDI_PCI_DMA_3] = GAUDI_ENGINE_ID_DMA_5,
 	[GAUDI_HBM_DMA_1] = GAUDI_ENGINE_ID_DMA_2,
 	[GAUDI_HBM_DMA_2] = GAUDI_ENGINE_ID_DMA_3,
 	[GAUDI_HBM_DMA_3] = GAUDI_ENGINE_ID_DMA_4,
-	[GAUDI_HBM_DMA_4] = GAUDI_ENGINE_ID_DMA_6,
-	[GAUDI_HBM_DMA_5] = GAUDI_ENGINE_ID_DMA_7
+	[GAUDI_HBM_DMA_4] = GAUDI_ENGINE_ID_DMA_5,
+	[GAUDI_HBM_DMA_5] = GAUDI_ENGINE_ID_DMA_6,
+	[GAUDI_HBM_DMA_6] = GAUDI_ENGINE_ID_DMA_7
 };
 
 static const u8 gaudi_cq_assignment[NUMBER_OF_CMPLT_QUEUES] = {
@@ -130,10 +130,6 @@ static const u8 gaudi_cq_assignment[NUMBER_OF_CMPLT_QUEUES] = {
 	[5] = GAUDI_QUEUE_ID_DMA_1_1,
 	[6] = GAUDI_QUEUE_ID_DMA_1_2,
 	[7] = GAUDI_QUEUE_ID_DMA_1_3,
-	[8] = GAUDI_QUEUE_ID_DMA_5_0,
-	[9] = GAUDI_QUEUE_ID_DMA_5_1,
-	[10] = GAUDI_QUEUE_ID_DMA_5_2,
-	[11] = GAUDI_QUEUE_ID_DMA_5_3
 };
 
 static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
@@ -249,10 +245,10 @@ static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_4_1 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_4_2 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_4_3 */
-	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_5_0 */
-	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_5_1 */
-	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_5_2 */
-	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_5_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_5_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_5_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_5_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_5_3 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_6_0 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_6_1 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_DMA_6_2 */
@@ -979,8 +975,7 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 		q = &gaudi->internal_qmans[i];
 
 		switch (i) {
-		case GAUDI_QUEUE_ID_DMA_2_0 ... GAUDI_QUEUE_ID_DMA_4_3:
-		case GAUDI_QUEUE_ID_DMA_6_0 ... GAUDI_QUEUE_ID_DMA_7_3:
+		case GAUDI_QUEUE_ID_DMA_2_0 ... GAUDI_QUEUE_ID_DMA_7_3:
 			q->pq_size = HBM_DMA_QMAN_SIZE_IN_BYTES;
 			break;
 		case GAUDI_QUEUE_ID_MME_0_0 ... GAUDI_QUEUE_ID_MME_1_3:
@@ -3433,21 +3428,21 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 		break;
 
 	case GAUDI_QUEUE_ID_DMA_5_0...GAUDI_QUEUE_ID_DMA_5_3:
-		dma_id = gaudi_dma_assignment[GAUDI_PCI_DMA_3];
+		dma_id = gaudi_dma_assignment[GAUDI_HBM_DMA_4];
 		dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 		q_off = dma_qm_offset + ((hw_queue_id - 1) & 0x3) * 4;
 		db_reg_offset = mmDMA0_QM_PQ_PI_0 + q_off;
 		break;
 
 	case GAUDI_QUEUE_ID_DMA_6_0...GAUDI_QUEUE_ID_DMA_6_3:
-		dma_id = gaudi_dma_assignment[GAUDI_HBM_DMA_4];
+		dma_id = gaudi_dma_assignment[GAUDI_HBM_DMA_5];
 		dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 		q_off = dma_qm_offset + ((hw_queue_id - 1) & 0x3) * 4;
 		db_reg_offset = mmDMA0_QM_PQ_PI_0 + q_off;
 		break;
 
 	case GAUDI_QUEUE_ID_DMA_7_0...GAUDI_QUEUE_ID_DMA_7_3:
-		dma_id = gaudi_dma_assignment[GAUDI_HBM_DMA_5];
+		dma_id = gaudi_dma_assignment[GAUDI_HBM_DMA_6];
 		dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 		q_off = dma_qm_offset + ((hw_queue_id - 1) & 0x3) * 4;
 		db_reg_offset = mmDMA0_QM_PQ_PI_0 + q_off;
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 5b99c94ebe36..73171d8b40d8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -15,7 +15,7 @@
 #include "../include/gaudi/gaudi.h"
 #include "../include/gaudi/gaudi_async_events.h"
 
-#define NUMBER_OF_EXT_HW_QUEUES		12
+#define NUMBER_OF_EXT_HW_QUEUES		8
 #define NUMBER_OF_CMPLT_QUEUES		NUMBER_OF_EXT_HW_QUEUES
 #define NUMBER_OF_CPU_HW_QUEUES		1
 #define NUMBER_OF_INT_HW_QUEUES		100
@@ -62,8 +62,8 @@
 #error "GAUDI_MAX_PENDING_CS must be power of 2 and greater than 1"
 #endif
 
-#define PCI_DMA_NUMBER_OF_CHNLS		3
-#define HBM_DMA_NUMBER_OF_CHNLS		5
+#define PCI_DMA_NUMBER_OF_CHNLS		2
+#define HBM_DMA_NUMBER_OF_CHNLS		6
 #define DMA_NUMBER_OF_CHNLS		(PCI_DMA_NUMBER_OF_CHNLS + \
 						HBM_DMA_NUMBER_OF_CHNLS)
 
@@ -205,12 +205,12 @@
 enum gaudi_dma_channels {
 	GAUDI_PCI_DMA_1,
 	GAUDI_PCI_DMA_2,
-	GAUDI_PCI_DMA_3,
 	GAUDI_HBM_DMA_1,
 	GAUDI_HBM_DMA_2,
 	GAUDI_HBM_DMA_3,
 	GAUDI_HBM_DMA_4,
 	GAUDI_HBM_DMA_5,
+	GAUDI_HBM_DMA_6,
 	GAUDI_DMA_MAX
 };
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 2b244d0bdc26..4661a74f0425 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -18,8 +18,8 @@
 #define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START		0x8000	/* 32KB */
 #define GAUDI_DRIVER_SRAM_RESERVED_SIZE_FROM_START	0x80	/* 128 bytes */
 
-#define GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT		48
-#define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		24
+#define GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT		32
+#define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		16
 /*
  * Goya queue Numbering
  *
@@ -76,10 +76,10 @@ enum gaudi_queue_id {
 	GAUDI_QUEUE_ID_DMA_4_1 = 18,	/* internal */
 	GAUDI_QUEUE_ID_DMA_4_2 = 19,	/* internal */
 	GAUDI_QUEUE_ID_DMA_4_3 = 20,	/* internal */
-	GAUDI_QUEUE_ID_DMA_5_0 = 21,	/* external */
-	GAUDI_QUEUE_ID_DMA_5_1 = 22,	/* external */
-	GAUDI_QUEUE_ID_DMA_5_2 = 23,	/* external */
-	GAUDI_QUEUE_ID_DMA_5_3 = 24,	/* external */
+	GAUDI_QUEUE_ID_DMA_5_0 = 21,	/* internal */
+	GAUDI_QUEUE_ID_DMA_5_1 = 22,	/* internal */
+	GAUDI_QUEUE_ID_DMA_5_2 = 23,	/* internal */
+	GAUDI_QUEUE_ID_DMA_5_3 = 24,	/* internal */
 	GAUDI_QUEUE_ID_DMA_6_0 = 25,	/* internal */
 	GAUDI_QUEUE_ID_DMA_6_1 = 26,	/* internal */
 	GAUDI_QUEUE_ID_DMA_6_2 = 27,	/* internal */
-- 
2.17.1

