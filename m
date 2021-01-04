Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76E2E9D15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbhADScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:32:22 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:54717 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbhADScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:32:22 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 Jan 2021 10:31:42 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Jan 2021 10:31:40 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Jan 2021 00:01:23 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 2200421860; Tue,  5 Jan 2021 00:01:23 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, manivannan.sadhasivam@linaro.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, vigneshr@ti.com
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH V2] mtd: rawnand: qcom: update last code word register
Date:   Tue,  5 Jan 2021 00:01:18 +0530
Message-Id: <1609785078-22310-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QPIC version 2.0 onwards new register got added to
read last codeword. This change will update the same.

For first three code word READ_LOCATION_n register will be
use.For last code wrod READ_LOCATION_LAST_CW_n register will be
use.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
[V2]
 * Fixed alignment for NAND_READ_LOCATION_LAST_CW_n reg macro
 * Changed number of register write to 1 when NAND_READ_LOCATION_LAST_CW_n register will use
 drivers/mtd/nand/raw/qcom_nandc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index eaef51d..9e89236 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -48,10 +48,10 @@
 #define	NAND_READ_LOCATION_1		0xf24
 #define	NAND_READ_LOCATION_2		0xf28
 #define	NAND_READ_LOCATION_3		0xf2c
-#define NAND_READ_LOCATION_LAST_CW_0    0xf40
-#define NAND_READ_LOCATION_LAST_CW_1    0xf44
-#define NAND_READ_LOCATION_LAST_CW_2    0xf48
-#define NAND_READ_LOCATION_LAST_CW_3    0xf4c
+#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
+#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
+#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
+#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
 
 /* dummy register offsets, used by write_reg_dma */
 #define	NAND_DEV_CMD1_RESTORE		0xdead
@@ -1125,7 +1125,7 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
 	if (nandc->props->is_bam) {
 		if (nandc->props->qpic_v2)
 			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
-				      4, NAND_BAM_NEXT_SGL);
+				      1, NAND_BAM_NEXT_SGL);
 		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
 			      NAND_BAM_NEXT_SGL);
 	}
-- 
2.7.4

