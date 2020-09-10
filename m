Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67978264FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 21:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIJTsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbgIJPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A264C0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:04:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a12so6615167eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTE5okIaZncPcsNAR/BLkNFx9agcEUU8fNdeLliCC+o=;
        b=PAhxqj8d4BjZcNqyTI5oy9vce0jGU+gd1VbIjm4jPzZAM8ZU6y1smrj62r+lUaMPlX
         VNCcoJWN62Nzm/7gCVs8OxaV8p7EUZoLrxptFwqeZPQ8uOyM/jluUiIgJzcrkTF16HpL
         k52L4xDbCBIDf/z7PoriWberOij1vyLniaKa/kD+NFhEi/B8kOtwCqGcq0aCvJe92Ngw
         rfZEO9bFCWWAT+tY8nu5cVZj6YJ19gAltdU9qRLWVLUHO9dX4I+TvNmQkTqrrdeQBF8x
         u3h/yR0MCYNdyC+GxCACATrkqRR5BvrGF2TLnoZ73a8Z1nfYOKYUrbkeOR8IpXJqDc8S
         ZEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTE5okIaZncPcsNAR/BLkNFx9agcEUU8fNdeLliCC+o=;
        b=MG1dWBo0/+qGhWtBgj74k/xUJ+R6+HRJ3IzqPmtSc6WyrcoqJjquEwMvHWj0Rb1jv5
         h7vmdfv5gxDHk1OqtlUc80/t6JZzm21ISjuObewlQpI6SrjCUYxqGaNkFGUfyVyKXxsr
         nD7bUidfhqP4KJ82NqoddDbX6/2LQeQtmq7S99Lo9D4VE4VNScmLc9PcjhOGFr5KRRfD
         MUs5/PF2iBuHWxkIHECCTVNtsqFBcSmpg+Eea+Ytr02Mkgmki94195Ah9Cwa2SA2IiST
         o/jXwK1OHChAIERAjBN6ypg8NrPezzI3cTINPB+Iw7AkpIuhjMJf2oOdw5D491X9IeCD
         u8jA==
X-Gm-Message-State: AOAM533VKQaWM4ij37UhNW2ZddPJcmyYXVA4GuzWRupGrHlk5rNNnuah
        jFVgNiOQZXrm1F4eY5rl/ScGsjciLts=
X-Google-Smtp-Source: ABdhPJwYrYpuVAOPwCUBwmFZSxDzU3T/sbb3FzqLpyNhbpUmUJwCCfBrm5cqSGGWRVVBMhn731e9dQ==
X-Received: by 2002:a50:cf46:: with SMTP id d6mr9854798edk.339.1599750243986;
        Thu, 10 Sep 2020 08:04:03 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id o3sm7443925edt.79.2020.09.10.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:04:03 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 11/15] habanalabs/gaudi: add QP error handling
Date:   Thu, 10 Sep 2020 18:03:24 +0300
Message-Id: <20200910150328.20545-12-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910150328.20545-1-oded.gabbay@gmail.com>
References: <20200910150328.20545-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add Queue Pair (QP) error notification to the user e.g. security violation,
too many retransmissions, invalid QP etc.

Whenever a QP caused an error, the firmware will send an event to the
driver which will push the error as an error entry to the Completion Queue
(if exists).

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c     | 13 ++++
 drivers/misc/habanalabs/gaudi/gaudiP.h    |  1 +
 drivers/misc/habanalabs/gaudi/gaudi_nic.c | 93 +++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 34b99bd94ef0..8fc2288fb424 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6658,6 +6658,19 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
+	case GAUDI_EVENT_NIC0_QP0:
+	case GAUDI_EVENT_NIC0_QP1:
+	case GAUDI_EVENT_NIC1_QP0:
+	case GAUDI_EVENT_NIC1_QP1:
+	case GAUDI_EVENT_NIC2_QP0:
+	case GAUDI_EVENT_NIC2_QP1:
+	case GAUDI_EVENT_NIC3_QP0:
+	case GAUDI_EVENT_NIC3_QP1:
+	case GAUDI_EVENT_NIC4_QP0:
+	case GAUDI_EVENT_NIC4_QP1:
+		gaudi_nic_handle_qp_err(hdev, event_type);
+		break;
+
 	case GAUDI_EVENT_PSOC_GPIO_U16_0:
 		cause = le64_to_cpu(eq_entry->data[0]) & 0xFF;
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index ba3150c073ca..dc1dcff43cd6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -578,5 +578,6 @@ netdev_tx_t gaudi_nic_handle_tx_pkt(struct gaudi_nic_device *gaudi_nic,
 					struct sk_buff *skb);
 int gaudi_nic_sw_init(struct hl_device *hdev);
 void gaudi_nic_sw_fini(struct hl_device *hdev);
+void gaudi_nic_handle_qp_err(struct hl_device *hdev, u16 event_type);
 
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_nic.c b/drivers/misc/habanalabs/gaudi/gaudi_nic.c
index 8f6585c700cf..41789f7ed32e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_nic.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_nic.c
@@ -3958,3 +3958,96 @@ int gaudi_nic_cq_mmap(struct hl_device *hdev, struct vm_area_struct *vma)
 
 	return rc;
 }
+
+static char *get_syndrome_text(u32 syndrome)
+{
+	char *str;
+
+	switch (syndrome) {
+	case 0x05:
+		str = "Rx got invalid QP";
+		break;
+	case 0x06:
+		str = "Rx transport service mismatch";
+		break;
+	case 0x09:
+		str = "Rx Rkey check failed";
+		break;
+	case 0x40:
+		str = "timer retry exceeded";
+		break;
+	case 0x41:
+		str = "NACK retry exceeded";
+		break;
+	case 0x42:
+		str = "doorbell on invalid QP";
+		break;
+	case 0x43:
+		str = "doorbell security check failed";
+		break;
+	case 0x44:
+		str = "Tx got invalid QP";
+		break;
+	case 0x45:
+		str = "responder got ACK/NACK on invalid QP";
+		break;
+	case 0x46:
+		str = "responder try to send ACK/NACK on invalid QP";
+		break;
+	default:
+		str = "unknown syndrome";
+		break;
+	}
+
+	return str;
+}
+
+void gaudi_nic_handle_qp_err(struct hl_device *hdev, u16 event_type)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct gaudi_nic_device *gaudi_nic =
+			&gaudi->nic_devices[event_type - GAUDI_EVENT_NIC0_QP0];
+	struct qp_err *qp_err_arr = gaudi_nic->qp_err_mem_cpu;
+	struct hl_nic_cqe cqe_sw;
+	u32 pi, ci;
+
+	mutex_lock(&gaudi->nic_qp_err_lock);
+
+	if (!gaudi->nic_cq_enable)
+		dev_err_ratelimited(hdev->dev,
+			"received NIC %d QP error event %d but no CQ to push it\n",
+			gaudi_nic->port, event_type);
+
+	pi = NIC_RREG32(mmNIC0_QPC0_ERR_FIFO_PRODUCER_INDEX);
+	ci = gaudi_nic->qp_err_ci;
+
+	cqe_sw.is_err = true;
+	cqe_sw.port = gaudi_nic->port;
+
+	while (ci < pi) {
+		cqe_sw.type = QP_ERR_IS_REQ(qp_err_arr[ci]) ?
+				HL_NIC_CQE_TYPE_REQ : HL_NIC_CQE_TYPE_RES;
+		cqe_sw.qp_number = QP_ERR_QP_NUM(qp_err_arr[ci]);
+		cqe_sw.qp_err.syndrome = QP_ERR_ERR_NUM(qp_err_arr[ci]);
+
+		ci = (ci + 1) & (QP_ERR_BUF_LEN - 1);
+
+		dev_err_ratelimited(hdev->dev,
+			"NIC QP error port: %d, type: %d, qpn: %d, syndrome: %s (0x%x)\n",
+			cqe_sw.port, cqe_sw.type, cqe_sw.qp_number,
+			get_syndrome_text(cqe_sw.qp_err.syndrome),
+			cqe_sw.qp_err.syndrome);
+
+		if (gaudi->nic_cq_enable)
+			copy_cqe_to_main_queue(hdev, &cqe_sw);
+	}
+
+	gaudi_nic->qp_err_ci = ci;
+	NIC_WREG32(mmNIC0_QPC0_ERR_FIFO_CONSUMER_INDEX, ci);
+
+	/* signal the completion queue that there are available CQEs */
+	if (gaudi->nic_cq_enable)
+		complete(&gaudi->nic_cq_comp);
+
+	mutex_unlock(&gaudi->nic_qp_err_lock);
+}
-- 
2.17.1

