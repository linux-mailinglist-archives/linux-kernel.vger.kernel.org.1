Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C02F39B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406584AbhALTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406210AbhALTKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:10:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A73F23109;
        Tue, 12 Jan 2021 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478560;
        bh=HekozVSXDq8+ehwRE8jQRfXQI3Tl9pq7SZK6RBv4tfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH8U8atjtIwYLN1ZG82cpgAXHZb459AWo4Vzdd1C2oVSohQQhiFS/UvUM2FQzoSU/
         M+/F7iW7n06ZDO9Lz3A6GhmywLj0CvX+tYEpdW9qku7DtWB+6Z3nPMt10UmS4MAQiT
         psbv0+d65eMDIV0eCvxv/47L7YgAloaY3qklUxU7JGmGWOdctN1bKq7B0pcaFAIUYe
         QLyW/GDe6APWukDPEcP5GH6NxuYvdSDgC1tKl/79TCkrC+DR8WH2ojDnP+PCa/X1dz
         YslEFfa6c7YfDOcpbmRfiUSnQ9Q4t5KhZ01k/F4tgldtW8PJCNqHLhXLltF1t+bwbu
         WrvgCZKuejvZw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs/gaudi: print sync manager SEI interrupt info
Date:   Tue, 12 Jan 2021 21:09:13 +0200
Message-Id: <20210112190915.21164-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112190915.21164-1-ogabbay@kernel.org>
References: <20210112190915.21164-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver must print sync manager SEI information upon receiving
interrupt from FW.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 41 +++++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h |  7 ++++
 .../include/gaudi/gaudi_async_events.h        |  4 ++
 3 files changed, 52 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4b602aa7a6a3..126650e3a9ad 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -225,6 +225,12 @@ gaudi_qman_arb_error_cause[GAUDI_NUM_OF_QM_ARB_ERR_CAUSE] = {
 	"MSG AXI LBW returned with error"
 };
 
+enum gaudi_sm_sei_cause {
+	GAUDI_SM_SEI_SO_OVERFLOW,
+	GAUDI_SM_SEI_LBW_4B_UNALIGNED,
+	GAUDI_SM_SEI_AXI_RESPONSE_ERR
+};
+
 static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_0_0 */
 	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_0_1 */
@@ -6845,6 +6851,34 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 	}
 }
 
+static void gaudi_print_sm_sei_info(struct hl_device *hdev, u16 event_type,
+		struct hl_eq_sm_sei_data *sei_data)
+{
+	u32 index = event_type - GAUDI_EVENT_DMA_IF_SEI_0;
+
+	switch (sei_data->sei_cause) {
+	case GAUDI_SM_SEI_SO_OVERFLOW:
+		dev_err(hdev->dev,
+			"SM %u SEI Error: SO %u overflow/underflow",
+			index, le16_to_cpu(sei_data->sei_log));
+		break;
+	case GAUDI_SM_SEI_LBW_4B_UNALIGNED:
+		dev_err(hdev->dev,
+			"SM %u SEI Error: Unaligned 4B LBW access, monitor agent address low - %#x",
+			index, le16_to_cpu(sei_data->sei_log));
+		break;
+	case GAUDI_SM_SEI_AXI_RESPONSE_ERR:
+		dev_err(hdev->dev,
+			"SM %u SEI Error: AXI ID %u response error",
+			index, le16_to_cpu(sei_data->sei_log));
+		break;
+	default:
+		dev_err(hdev->dev, "Unknown SM SEI cause %u",
+				le16_to_cpu(sei_data->sei_log));
+		break;
+	}
+}
+
 static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		struct hl_eq_ecc_data *ecc_data)
 {
@@ -7468,6 +7502,13 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
+	case GAUDI_EVENT_DMA_IF_SEI_0 ... GAUDI_EVENT_DMA_IF_SEI_3:
+		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_sm_sei_info(hdev, event_type,
+					&eq_entry->sm_sei_data);
+		hl_fw_unmask_irq(hdev, event_type);
+		break;
+
 	case GAUDI_EVENT_FIX_POWER_ENV_S ... GAUDI_EVENT_FIX_THERMAL_ENV_E:
 		gaudi_print_clk_change_info(hdev, event_type);
 		hl_fw_unmask_irq(hdev, event_type);
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 00bd9b392f93..d75d1077461b 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -58,11 +58,18 @@ struct hl_eq_ecc_data {
 	__u8 pad[7];
 };
 
+struct hl_eq_sm_sei_data {
+	__le16 sei_log;
+	__u8 sei_cause;
+	__u8 pad[5];
+};
+
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
 		struct hl_eq_ecc_data ecc_data;
 		struct hl_eq_hbm_ecc_data hbm_ecc_data;
+		struct hl_eq_sm_sei_data sm_sei_data;
 		__le64 data[7];
 	};
 };
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index 9ccba8437ec9..49335e8334b4 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -212,6 +212,10 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC_SEI_2 = 266,
 	GAUDI_EVENT_NIC_SEI_3 = 267,
 	GAUDI_EVENT_NIC_SEI_4 = 268,
+	GAUDI_EVENT_DMA_IF_SEI_0 = 277,
+	GAUDI_EVENT_DMA_IF_SEI_1 = 278,
+	GAUDI_EVENT_DMA_IF_SEI_2 = 279,
+	GAUDI_EVENT_DMA_IF_SEI_3 = 280,
 	GAUDI_EVENT_PCIE_FLR = 290,
 	GAUDI_EVENT_TPC0_BMON_SPMU = 300,
 	GAUDI_EVENT_TPC0_KRN_ERR = 301,
-- 
2.25.1

