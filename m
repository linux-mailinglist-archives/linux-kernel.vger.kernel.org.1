Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7812D05ED
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgLFQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLFQ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:20 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: remove duplicated gaudi packets masks
Date:   Sun,  6 Dec 2020 18:28:30 +0200
Message-Id: <20201206162835.4088-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As all packets use the same CTL register masks, we remove duplicated
masks and use common masks instead.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 32 +++++++++----------
 .../habanalabs/include/gaudi/gaudi_packets.h  | 24 --------------
 2 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 076a55ebf357..9ddf39deb692 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7903,10 +7903,10 @@ static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
 	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, sob_id * 4);
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OP_MASK, 0); /* write the value */
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 3); /* W_S SOB base */
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, eb);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, eb);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -7923,10 +7923,10 @@ static u32 gaudi_add_mon_msg_short(struct packet_msg_short *pkt, u32 value,
 
 	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, addr);
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 2);  /* W_S MON base */
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 0); /* last pkt MB */
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 0); /* last pkt MB */
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -7972,10 +7972,10 @@ static u32 gaudi_add_arm_monitor_pkt(struct hl_device *hdev,
 	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, msg_addr_offset);
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OP_MASK, 0); /* write the value */
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 2); /* W_S MON base */
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -7993,10 +7993,10 @@ static u32 gaudi_add_fence_pkt(struct packet_fence *pkt)
 	cfg |= FIELD_PREP(GAUDI_PKT_FENCE_CFG_TARGET_VAL_MASK, 1);
 	cfg |= FIELD_PREP(GAUDI_PKT_FENCE_CFG_ID_MASK, 2);
 
-	ctl = FIELD_PREP(GAUDI_PKT_FENCE_CTL_OPCODE_MASK, PACKET_FENCE);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
+	ctl = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_FENCE);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
 	pkt->cfg = cpu_to_le32(cfg);
 	pkt->ctl = cpu_to_le32(ctl);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
index f30f2c0458d7..784b5bc8d0ba 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
@@ -111,18 +111,6 @@ struct packet_msg_long {
 #define GAUDI_PKT_SHORT_CTL_BASE_SHIFT		22
 #define GAUDI_PKT_SHORT_CTL_BASE_MASK		0x00C00000
 
-#define GAUDI_PKT_SHORT_CTL_OPCODE_SHIFT	24
-#define GAUDI_PKT_SHORT_CTL_OPCODE_MASK		0x1F000000
-
-#define GAUDI_PKT_SHORT_CTL_EB_SHIFT		29
-#define GAUDI_PKT_SHORT_CTL_EB_MASK		0x20000000
-
-#define GAUDI_PKT_SHORT_CTL_RB_SHIFT		30
-#define GAUDI_PKT_SHORT_CTL_RB_MASK		0x40000000
-
-#define GAUDI_PKT_SHORT_CTL_MB_SHIFT		31
-#define GAUDI_PKT_SHORT_CTL_MB_MASK		0x80000000
-
 struct packet_msg_short {
 	__le32 value;
 	__le32 ctl;
@@ -146,18 +134,6 @@ struct packet_msg_prot {
 #define GAUDI_PKT_FENCE_CTL_PRED_SHIFT		0
 #define GAUDI_PKT_FENCE_CTL_PRED_MASK		0x0000001F
 
-#define GAUDI_PKT_FENCE_CTL_OPCODE_SHIFT	24
-#define GAUDI_PKT_FENCE_CTL_OPCODE_MASK		0x1F000000
-
-#define GAUDI_PKT_FENCE_CTL_EB_SHIFT		29
-#define GAUDI_PKT_FENCE_CTL_EB_MASK		0x20000000
-
-#define GAUDI_PKT_FENCE_CTL_RB_SHIFT		30
-#define GAUDI_PKT_FENCE_CTL_RB_MASK		0x40000000
-
-#define GAUDI_PKT_FENCE_CTL_MB_SHIFT		31
-#define GAUDI_PKT_FENCE_CTL_MB_MASK		0x80000000
-
 struct packet_fence {
 	__le32 cfg;
 	__le32 ctl;
-- 
2.17.1

