Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1072AF95C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgKKT7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgKKT72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:28 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0FB2087D;
        Wed, 11 Nov 2020 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605124767;
        bh=fCcwQJBb6f2qNjANN8lWIoBwl+AdTFVDsOTvR8WsDVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRXFAv8Qr00J68SXaYnRW/VO07JcEGib+kw9y8bfJIIgVNFRp5YRJ4sCEIL9+gNfo
         jXAHAsVInU0EV9pniLDRFJlS5yRIumN7R4r3K297I3pUf55UriKJf5MXZtJYbGKof8
         SwwHMSy5TpJS5fIZzAjHeEzM8T3vFMM7jXiePY2c=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: fetch HBM ecc info from FW
Date:   Wed, 11 Nov 2020 21:59:19 +0200
Message-Id: <20201111195920.18338-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111195920.18338-1-ogabbay@kernel.org>
References: <20201111195920.18338-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Once FW security is enabled there is no access to HBM ecc registers,
need to read values from FW using a dedicated interface.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 47 ++++++++++++++++---
 .../misc/habanalabs/include/common/cpucp_if.h | 32 +++++++++++++
 2 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6d54a4574284..bf34ca29e42b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6850,10 +6850,41 @@ static int gaudi_soft_reset_late_init(struct hl_device *hdev)
 	return hl_fw_unmask_irq_arr(hdev, gaudi->events, sizeof(gaudi->events));
 }
 
-static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device)
+static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
+			struct hl_eq_hbm_ecc_data *hbm_ecc_data)
 {
-	int ch, err = 0;
-	u32 base, val, val2;
+	u32 base, val, val2, wr_par, rd_par, ca_par, derr, serr, type, ch;
+	int err = 0;
+
+	if (!hdev->asic_prop.fw_security_disabled) {
+		if (!hbm_ecc_data) {
+			dev_err(hdev->dev, "No FW ECC data");
+			return 0;
+		}
+
+		wr_par = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_WR_PAR_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		rd_par = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_RD_PAR_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		ca_par = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_CA_PAR_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		derr = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_DERR_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		serr = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_SERR_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		type = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_TYPE_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+		ch = FIELD_GET(CPUCP_PKT_HBM_ECC_INFO_HBM_CH_MASK,
+				hbm_ecc_data->hbm_ecc_info);
+
+		dev_err(hdev->dev,
+			"HBM%d pc%d interrupts info: WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
+			device, ch, wr_par, rd_par, ca_par, serr, derr);
+
+		err = 1;
+
+		return 0;
+	}
 
 	base = GAUDI_HBM_CFG_BASE + device * GAUDI_HBM_CFG_OFFSET;
 	for (ch = 0 ; ch < GAUDI_HBM_CHANNELS ; ch++) {
@@ -6869,7 +6900,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device)
 
 			val2 = RREG32(base + ch * 0x1000 + 0x060);
 			dev_err(hdev->dev,
-				"HBM%d pc%d ECC info: 1ST_ERR_ADDR=0x%x, 1ST_ERR_TYPE=%d, SEC_CONT_CNT=%d, SEC_CNT=%d, DED_CNT=%d\n",
+				"HBM%d pc%d ECC info: 1ST_ERR_ADDR=0x%x, 1ST_ERR_TYPE=%d, SEC_CONT_CNT=%d, SEC_CNT=%d, DEC_CNT=%d\n",
 				device, ch * 2,
 				RREG32(base + ch * 0x1000 + 0x064),
 				(val2 & 0x200) >> 9, (val2 & 0xFC00) >> 10,
@@ -6889,7 +6920,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device)
 
 			val2 = RREG32(base + ch * 0x1000 + 0x070);
 			dev_err(hdev->dev,
-				"HBM%d pc%d ECC info: 1ST_ERR_ADDR=0x%x, 1ST_ERR_TYPE=%d, SEC_CONT_CNT=%d, SEC_CNT=%d, DED_CNT=%d\n",
+				"HBM%d pc%d ECC info: 1ST_ERR_ADDR=0x%x, 1ST_ERR_TYPE=%d, SEC_CONT_CNT=%d, SEC_CNT=%d, DEC_CNT=%d\n",
 				device, ch * 2 + 1,
 				RREG32(base + ch * 0x1000 + 0x074),
 				(val2 & 0x200) >> 9, (val2 & 0xFC00) >> 10,
@@ -7090,7 +7121,8 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_HBM3_SPI_0:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_hbm_read_interrupts(hdev,
-					  gaudi_hbm_event_to_dev(event_type));
+				gaudi_hbm_event_to_dev(event_type),
+				&eq_entry->hbm_ecc_data);
 		if (hdev->hard_reset_on_fw_events)
 			hl_device_reset(hdev, true, false);
 		break;
@@ -7101,7 +7133,8 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_HBM3_SPI_1:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_hbm_read_interrupts(hdev,
-					  gaudi_hbm_event_to_dev(event_type));
+				gaudi_hbm_event_to_dev(event_type),
+				&eq_entry->hbm_ecc_data);
 		break;
 
 	case GAUDI_EVENT_TPC0_DEC:
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 1c1e2b394457..759c068b2b7a 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -11,6 +11,37 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>
 
+#define NUM_HBM_PSEUDO_CH				2
+#define NUM_HBM_CH_PER_DEV				8
+#define CPUCP_PKT_HBM_ECC_INFO_WR_PAR_SHIFT		0
+#define CPUCP_PKT_HBM_ECC_INFO_WR_PAR_MASK		0x00000001
+#define CPUCP_PKT_HBM_ECC_INFO_RD_PAR_SHIFT		1
+#define CPUCP_PKT_HBM_ECC_INFO_RD_PAR_MASK		0x00000002
+#define CPUCP_PKT_HBM_ECC_INFO_CA_PAR_SHIFT		2
+#define CPUCP_PKT_HBM_ECC_INFO_CA_PAR_MASK		0x00000004
+#define CPUCP_PKT_HBM_ECC_INFO_DERR_SHIFT		3
+#define CPUCP_PKT_HBM_ECC_INFO_DERR_MASK		0x00000008
+#define CPUCP_PKT_HBM_ECC_INFO_SERR_SHIFT		4
+#define CPUCP_PKT_HBM_ECC_INFO_SERR_MASK		0x00000010
+#define CPUCP_PKT_HBM_ECC_INFO_TYPE_SHIFT		5
+#define CPUCP_PKT_HBM_ECC_INFO_TYPE_MASK		0x00000020
+#define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_SHIFT		6
+#define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_MASK		0x000007C0
+
+struct hl_eq_hbm_ecc_data {
+	/* SERR counter */
+	__le32 sec_cnt;
+	/* DERR counter */
+	__le32 dec_cnt;
+	/* Supplemental Information according to the mask bits */
+	__le32 hbm_ecc_info;
+	/* Address in hbm where the ecc happened */
+	__le32 first_addr;
+	/* SERR continuous address counter */
+	__le32 sec_cont_cnt;
+	__le32 pad;
+};
+
 /*
  * EVENT QUEUE
  */
@@ -31,6 +62,7 @@ struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
 		struct hl_eq_ecc_data ecc_data;
+		struct hl_eq_hbm_ecc_data hbm_ecc_data;
 		__le64 data[7];
 	};
 };
-- 
2.17.1

