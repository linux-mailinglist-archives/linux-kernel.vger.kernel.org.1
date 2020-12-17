Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83392DD295
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgLQOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:04:04 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:35832 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:04:04 -0500
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 17 Dec 2020 06:03:22 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 17 Dec 2020 06:03:21 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg01-blr.qualcomm.com with ESMTP; 17 Dec 2020 19:33:06 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 2313A219ED; Thu, 17 Dec 2020 19:33:05 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, manivannan.sadhasivam@linaro.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH] mtd: rawnand: qcom: update last code word register
Date:   Thu, 17 Dec 2020 19:32:56 +0530
Message-Id: <1608213776-19584-1-git-send-email-mdalam@codeaurora.org>
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
 drivers/mtd/nand/raw/qcom_nandc.c | 79 +++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 667e4bf..eaef51d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -48,6 +48,10 @@
 #define	NAND_READ_LOCATION_1		0xf24
 #define	NAND_READ_LOCATION_2		0xf28
 #define	NAND_READ_LOCATION_3		0xf2c
+#define NAND_READ_LOCATION_LAST_CW_0    0xf40
+#define NAND_READ_LOCATION_LAST_CW_1    0xf44
+#define NAND_READ_LOCATION_LAST_CW_2    0xf48
+#define NAND_READ_LOCATION_LAST_CW_3    0xf4c
 
 /* dummy register offsets, used by write_reg_dma */
 #define	NAND_DEV_CMD1_RESTORE		0xdead
@@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
 	      ((size) << READ_LOCATION_SIZE) |			\
 	      ((is_last) << READ_LOCATION_LAST))
 
+#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
+nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
+	      ((offset) << READ_LOCATION_OFFSET) |		\
+	      ((size) << READ_LOCATION_SIZE) |			\
+	      ((is_last) << READ_LOCATION_LAST))
+
 /*
  * Returns the actual register address for all NAND_DEV_ registers
  * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
@@ -316,6 +326,10 @@ struct nandc_regs {
 	__le32 read_location1;
 	__le32 read_location2;
 	__le32 read_location3;
+	__le32 read_location_last0;
+	__le32 read_location_last1;
+	__le32 read_location_last2;
+	__le32 read_location_last3;
 
 	__le32 erased_cw_detect_cfg_clr;
 	__le32 erased_cw_detect_cfg_set;
@@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
 		return &regs->read_location2;
 	case NAND_READ_LOCATION_3:
 		return &regs->read_location3;
+	case NAND_READ_LOCATION_LAST_CW_0:
+		return &regs->read_location_last0;
+	case NAND_READ_LOCATION_LAST_CW_1:
+		return &regs->read_location_last1;
+	case NAND_READ_LOCATION_LAST_CW_2:
+		return &regs->read_location_last2;
+	case NAND_READ_LOCATION_LAST_CW_3:
+		return &regs->read_location_last3;
 	default:
 		return NULL;
 	}
@@ -719,9 +741,13 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
-	if (read)
+	if (read) {
+		if (nandc->props->qpic_v2)
+			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
+					host->cw_data : host->cw_size, 1);
 		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
 				   host->cw_data : host->cw_size, 1);
+	}
 }
 
 /*
@@ -1096,9 +1122,13 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
 static void
 config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
 {
-	if (nandc->props->is_bam)
+	if (nandc->props->is_bam) {
+		if (nandc->props->qpic_v2)
+			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
+				      4, NAND_BAM_NEXT_SGL);
 		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
 			      NAND_BAM_NEXT_SGL);
+	}
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
@@ -1633,16 +1663,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
+		else
+			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
 		read_loc += data_size1;
 
-		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
+		else
+			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
 		read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
+		else
+			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
 		read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
+		else
+			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
 	}
 
 	config_nand_cw_read(nandc, false);
@@ -1873,14 +1915,27 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
-				nandc_set_read_loc(nandc, 1, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
+					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
+					nandc_set_read_loc_last(nandc, 1, data_size,
+								oob_size, 1);
+				} else {
+					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
+					nandc_set_read_loc(nandc, 1, data_size,
+							   oob_size, 1);
+				}
 			} else if (data_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
+				else
+					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(nandc, 0, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc_last(nandc, 0, data_size,
+								oob_size, 1);
+				else
+					nandc_set_read_loc(nandc, 0, data_size,
+							   oob_size, 1);
 			}
 		}
 
-- 
2.7.4

