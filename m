Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED6276B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIXIF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgIXIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:05:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:05:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so2553936wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Z2aGNY8IpZ1LR8iWsEvNki0T2pt7g9BTrj//i8HEyA=;
        b=VnUlSGZ1n0RiJR9k+cM2T8TyGuI4fg3/dB1/VedMncEYfwYctrgrxVcDHfsTc2xyPg
         sNYvQClw6uQx/gQhZLKdVu7/SM7o5Y+62N0bqouSIfp/hctRFFjcpVjp2t6Q/xyrcULX
         UBsxLQsFsQgJB2DpVjsThFed8Zgvkmi89XacGpk8AvsEplU/EFaHXLwAa+GME2i7as7f
         wWySDNkwFq5qC5feCS6ZBOjNXUtQ06GstZsBpFIFv7GqeLzXBX1YVatq2mIj0uPyMGr3
         QtJoQuqYWwDUlFahB3t/ipMTvASbSMREks/Vq7RMif3pBGe6m4K66Qf1Wqdfo5YTtiEt
         Fs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Z2aGNY8IpZ1LR8iWsEvNki0T2pt7g9BTrj//i8HEyA=;
        b=D3Sg4NhHu7bxW/IkEYKTLBm0lr5oBUMEDvp7Xb0JU8QvKUHbP5l7FppAZyA/V9fH/6
         PjEsLkuN08FuG7iBtkX6NW7ThzDR5iY5ddd7sDNIOkMVvVrUwwr7hfRZYaP8wMOHJNCe
         d9M4AFXAP/yzBE2Zb0zSYbPNRJpwNX9/PyBNt2teCWBKbrrJpE5hSjRWv7dO9yMoSBvV
         67N5Pt/A0sJtcTUPgFbYdC3PlcE+RxrAB+cXY6aoiehzuq1v2nMr3RQUrIz+a0AorePU
         8xefrXCD7yGcnYxI+CMf8CT8qa/JrGs9I/0VuL0gchYfhdgtgCMQ6jsPiGlpslAclxpB
         xfnA==
X-Gm-Message-State: AOAM530yBCsZipndpsTpcGWr/AK1PPfLh4VvBdypww3AHNfAUXaMhc/t
        IR0NgQva7mbzMAnxbx9Da/46YzcSn6g=
X-Google-Smtp-Source: ABdhPJynqIvlwMmIhy8h8wSzSAEbz55ZK7gGWtFZ6D4J5MYQ3wrRXX+ZmqOELKmotOvc6vobJFM9wQ==
X-Received: by 2002:a1c:9a0c:: with SMTP id c12mr3455162wme.85.1600934720805;
        Thu, 24 Sep 2020 01:05:20 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id u13sm2507009wrm.77.2020.09.24.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:05:19 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: configure QMAN LDMA registers properly
Date:   Thu, 24 Sep 2020 11:05:16 +0300
Message-Id: <20200924080516.4778-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

LDMA registers are configured with a fixed value.
We add new define set which gives the configuration
a proper meaning.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 62 +++++++++++++++++---------
 drivers/misc/habanalabs/gaudi/gaudiP.h |  8 ++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1b51e670bd4e..a227806be328 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1865,9 +1865,11 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 	WREG32(mmDMA0_QM_PQ_PI_0 + q_off, 0);
 	WREG32(mmDMA0_QM_PQ_CI_0 + q_off, 0);
 
-	WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
-	WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
-	WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+	WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, QMAN_LDMA_SIZE_OFFSET);
+	WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SRC_OFFSET);
+	WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_DST_OFFSET);
 
 	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_en_lo);
 	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_en_hi);
@@ -2025,13 +2027,19 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_PQ_PI_0 + q_off, 0);
 		WREG32(mmDMA0_QM_PQ_CI_0 + q_off, 0);
 
-		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x81BC);
-		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x81B4);
-		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_CPDMA_SIZE_OFFSET);
+		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_SRC_OFFSET);
+		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_DST_OFFSET);
 	} else {
-		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
-		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
-		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_LDMA_SIZE_OFFSET);
+		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SRC_OFFSET);
+		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SIZE_OFFSET);
 
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
@@ -2135,13 +2143,19 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 		WREG32(mmMME0_QM_PQ_PI_0 + q_off, 0);
 		WREG32(mmMME0_QM_PQ_CI_0 + q_off, 0);
 
-		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x81BC);
-		WREG32(mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x81B4);
-		WREG32(mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_CPDMA_SIZE_OFFSET);
+		WREG32(mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_SRC_OFFSET);
+		WREG32(mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_DST_OFFSET);
 	} else {
-		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
-		WREG32(mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
-		WREG32(mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_LDMA_SIZE_OFFSET);
+		WREG32(mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SRC_OFFSET);
+		WREG32(mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_DST_OFFSET);
 
 		/* Configure RAZWI IRQ */
 		mme_id = mme_offset /
@@ -2249,13 +2263,19 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 		WREG32(mmTPC0_QM_PQ_PI_0 + q_off, 0);
 		WREG32(mmTPC0_QM_PQ_CI_0 + q_off, 0);
 
-		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x81BC);
-		WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x81B4);
-		WREG32(mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_CPDMA_SIZE_OFFSET);
+		WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_SRC_OFFSET);
+		WREG32(mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_CPDMA_DST_OFFSET);
 	} else {
-		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
-		WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
-		WREG32(mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_LDMA_SIZE_OFFSET);
+		WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SRC_OFFSET);
+		WREG32(mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_DST_OFFSET);
 
 		/* Configure RAZWI IRQ */
 		tpc_id = tpc_offset /
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index b70b810c21c9..83ad2b0a3a61 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -84,6 +84,14 @@
 
 #define DMA_CORE_OFFSET		(mmDMA1_CORE_BASE - mmDMA0_CORE_BASE)
 
+#define QMAN_LDMA_SRC_OFFSET	(mmDMA0_CORE_SRC_BASE_LO - mmDMA0_CORE_CFG_0)
+#define QMAN_LDMA_DST_OFFSET	(mmDMA0_CORE_DST_BASE_LO - mmDMA0_CORE_CFG_0)
+#define QMAN_LDMA_SIZE_OFFSET	(mmDMA0_CORE_DST_TSIZE_0 - mmDMA0_CORE_CFG_0)
+
+#define QMAN_CPDMA_SRC_OFFSET	(mmDMA0_QM_CQ_PTR_LO_4 - mmDMA0_CORE_CFG_0)
+#define QMAN_CPDMA_DST_OFFSET	(mmDMA0_CORE_DST_BASE_LO - mmDMA0_CORE_CFG_0)
+#define QMAN_CPDMA_SIZE_OFFSET	(mmDMA0_QM_CQ_TSIZE_4 - mmDMA0_CORE_CFG_0)
+
 #define SIF_RTR_CTRL_OFFSET	(mmSIF_RTR_CTRL_1_BASE - mmSIF_RTR_CTRL_0_BASE)
 
 #define NIF_RTR_CTRL_OFFSET	(mmNIF_RTR_CTRL_1_BASE - mmNIF_RTR_CTRL_0_BASE)
-- 
2.17.1

