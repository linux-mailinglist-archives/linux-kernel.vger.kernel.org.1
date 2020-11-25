Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73A32C4946
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgKYUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgKYUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:45:40 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB998C061A53
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:45:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id z5so2754481iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgQIyqQ0Um3ZJgnU52iyAduH0hQXWjJaT01kfmpRZ1w=;
        b=cykW1InNnzn0FJ7YHyJ5w9LnX9P6Jisz22B/CjBPz96PCnTW0z/EWQS6T+e+slkySM
         x//75t618tCM6O1Dic/y/eclszBaQox9ZuKtzkvRTQS+Q3tPiUPyad35iCrf8nFq2NQH
         2uQHk5ebMZcAriBf7KRpcP5KGBbA+DbfaXCV5MojFcS79RzKISl31yqzwpEGhrrrRv1x
         23XlYpCAEPvhuQXlzLvWMQt5ZI32Xu+uBtc2eVgj9aC7ZInwnBCF7bfw9ZOHVbylX7zB
         b1cjBv6SxgUvU44Fe8esasbKrqNYwzMMts5SQKcD8N9pcC8nB0ffkZJBP2RFxwlSlPcV
         8QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgQIyqQ0Um3ZJgnU52iyAduH0hQXWjJaT01kfmpRZ1w=;
        b=Q2mzgez43upWXe+22ouNua4OdLMYoWI+vDYB/m7sBJ05c4AjlcrqI+zvwzsRjZOzk2
         OiUZV0aJeceFNIRx7+Dm8kXBCNTAjRC2YLXYAguvPfHgLqd/0ygh23Lw2AeI4bdBW8MR
         tdLmNvIHSZ+nI5HPDYLNWQSUou9JuSrEUS/uyXvUYn63FXTYd1hIrWurueF9af0BWEyV
         Ji5KXzR4QsGVDYrTe9CJtcLOkhzaXiPF4V/Tod0adFNDT+RLNZsJJX9z4FIUOlv56XFX
         Pd9nYge059Q7vyS9QM4+xrDKayp0PiQPyqrgMIh0+mHw6PhuM6k3gnArvdQFuCAblYUD
         nJag==
X-Gm-Message-State: AOAM530rs8Xai+9N9ztiT9LcQcGFR+v4s93ToPWuErfohWEC2+kdOfSc
        awi+WE1i5jOVsdq8ItBkqrbCIg==
X-Google-Smtp-Source: ABdhPJzaSO0tBzGKBG4D5tHvPAhQ/Cj/2pCIjLOO6OaDjf8r2AzN23+161nxY6QKNd6Fy+fvVA0XEw==
X-Received: by 2002:a5e:df03:: with SMTP id f3mr4267216ioq.182.1606337133201;
        Wed, 25 Nov 2020 12:45:33 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n10sm1462225iom.36.2020.11.25.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:45:32 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: ipa: add support to code for IPA v4.5
Date:   Wed, 25 Nov 2020 14:45:20 -0600
Message-Id: <20201125204522.5884-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201125204522.5884-1-elder@linaro.org>
References: <20201125204522.5884-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the IPA code to make use of the updated IPA v4.5 register
definitions.  Generally what this patch does is, if IPA v4.5
hardware is in use:
  - Ensure new registers or fields in IPA v4.5 are updated where
    required
  - Ensure registers or fields not supported in IPA v4.5 are not
    examined when read, or are set to 0 when written
It does this while preserving the existing functionality for IPA
versions lower than v4.5.

The values to program for QSB_MAX_READS and QSB_MAX_WRITES and the
source and destination resource counts are updated to be correct for
all versions through v4.5 as well.

Note that IPA_RESOURCE_GROUP_SRC_MAX and IPA_RESOURCE_GROUP_DST_MAX
already reflect that 5 is an acceptable number of resources (which
IPA v4.5 implements).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 10 +++---
 drivers/net/ipa/ipa_main.c     | 63 ++++++++++++++++++++++++----------
 drivers/net/ipa/ipa_reg.h      |  7 ++++
 3 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index f28ea062aaf1d..27f543b6780b1 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -520,7 +520,7 @@ static void ipa_endpoint_init_hdr(struct ipa_endpoint *endpoint)
 		/* HDR_ADDITIONAL_CONST_LEN is 0; (RX only) */
 		/* HDR_A5_MUX is 0 */
 		/* HDR_LEN_INC_DEAGG_HDR is 0 */
-		/* HDR_METADATA_REG_VALID is 0 (TX only) */
+		/* HDR_METADATA_REG_VALID is 0 (TX only, version < v4.5) */
 	}
 
 	iowrite32(val, ipa->reg_virt + offset);
@@ -655,6 +655,7 @@ static void ipa_endpoint_init_aggr(struct ipa_endpoint *endpoint)
 			/* other fields ignored */
 		}
 		/* AGGR_FORCE_CLOSE is 0 */
+		/* AGGR_GRAN_SEL is 0 for IPA v4.5 */
 	} else {
 		val |= u32_encode_bits(IPA_BYPASS_AGGR, AGGR_EN_FMASK);
 		/* other fields ignored */
@@ -865,9 +866,10 @@ static void ipa_endpoint_status(struct ipa_endpoint *endpoint)
 			val |= u32_encode_bits(status_endpoint_id,
 					       STATUS_ENDP_FMASK);
 		}
-		/* STATUS_LOCATION is 0 (status element precedes packet) */
-		/* The next field is present for IPA v4.0 and above */
-		/* STATUS_PKT_SUPPRESS_FMASK is 0 */
+		/* STATUS_LOCATION is 0, meaning status element precedes
+		 * packet (not present for IPA v4.5)
+		 */
+		/* STATUS_PKT_SUPPRESS_FMASK is 0 (not present for v3.5.1) */
 	}
 
 	iowrite32(val, ipa->reg_virt + offset);
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 7cd7f6cc05b3c..f25bcfe51dd4b 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -230,8 +230,10 @@ static void ipa_hardware_config_comp(struct ipa *ipa)
 		val &= ~IPA_QMB_SELECT_CONS_EN_FMASK;
 		val &= ~IPA_QMB_SELECT_PROD_EN_FMASK;
 		val &= ~IPA_QMB_SELECT_GLOBAL_EN_FMASK;
-	} else  {
+	} else if (ipa->version < IPA_VERSION_4_5) {
 		val |= GSI_MULTI_AXI_MASTERS_DIS_FMASK;
+	} else {
+		/* For IPA v4.5 IPA_FULL_FLUSH_WAIT_RSC_CLOSE_EN is 0 */
 	}
 
 	val |= GSI_MULTI_INORDER_RD_DIS_FMASK;
@@ -243,25 +245,47 @@ static void ipa_hardware_config_comp(struct ipa *ipa)
 /* Configure DDR and PCIe max read/write QSB values */
 static void ipa_hardware_config_qsb(struct ipa *ipa)
 {
+	enum ipa_version version = ipa->version;
+	u32 max0;
+	u32 max1;
 	u32 val;
 
-	/* QMB_0 represents DDR; QMB_1 represents PCIe (not present in 4.2) */
+	/* QMB_0 represents DDR; QMB_1 represents PCIe */
 	val = u32_encode_bits(8, GEN_QMB_0_MAX_WRITES_FMASK);
-	if (ipa->version == IPA_VERSION_4_2)
-		val |= u32_encode_bits(0, GEN_QMB_1_MAX_WRITES_FMASK);
-	else
-		val |= u32_encode_bits(4, GEN_QMB_1_MAX_WRITES_FMASK);
+	switch (version) {
+	case IPA_VERSION_4_2:
+		max1 = 0;		/* PCIe not present */
+		break;
+	case IPA_VERSION_4_5:
+		max1 = 8;
+		break;
+	default:
+		max1 = 4;
+		break;
+	}
+	val |= u32_encode_bits(max1, GEN_QMB_1_MAX_WRITES_FMASK);
 	iowrite32(val, ipa->reg_virt + IPA_REG_QSB_MAX_WRITES_OFFSET);
 
-	if (ipa->version == IPA_VERSION_3_5_1) {
-		val = u32_encode_bits(8, GEN_QMB_0_MAX_READS_FMASK);
-		val |= u32_encode_bits(12, GEN_QMB_1_MAX_READS_FMASK);
-	} else {
-		val = u32_encode_bits(12, GEN_QMB_0_MAX_READS_FMASK);
-		if (ipa->version == IPA_VERSION_4_2)
-			val |= u32_encode_bits(0, GEN_QMB_1_MAX_READS_FMASK);
-		else
-			val |= u32_encode_bits(12, GEN_QMB_1_MAX_READS_FMASK);
+	max1 = 12;
+	switch (version) {
+	case IPA_VERSION_3_5_1:
+		max0 = 8;
+		break;
+	case IPA_VERSION_4_0:
+	case IPA_VERSION_4_1:
+		max0 = 12;
+		break;
+	case IPA_VERSION_4_2:
+		max0 = 12;
+		max1 = 0;		/* PCIe not present */
+		break;
+	case IPA_VERSION_4_5:
+		max0 = 16;
+		break;
+	}
+	val = u32_encode_bits(max0, GEN_QMB_0_MAX_READS_FMASK);
+	val |= u32_encode_bits(max1, GEN_QMB_1_MAX_READS_FMASK);
+	if (version != IPA_VERSION_3_5_1) {
 		/* GEN_QMB_0_MAX_READS_BEATS is 0 */
 		/* GEN_QMB_1_MAX_READS_BEATS is 0 */
 	}
@@ -294,7 +318,7 @@ static void ipa_idle_indication_cfg(struct ipa *ipa,
  */
 static void ipa_hardware_dcd_config(struct ipa *ipa)
 {
-	/* Recommended values for IPA 3.5 according to IPA HPG */
+	/* Recommended values for IPA 3.5 and later according to IPA HPG */
 	ipa_idle_indication_cfg(ipa, 256, false);
 }
 
@@ -320,13 +344,14 @@ static void ipa_hardware_config(struct ipa *ipa)
 		iowrite32(val, ipa->reg_virt + IPA_REG_BCR_OFFSET);
 	}
 
-	if (version != IPA_VERSION_3_5_1) {
-		/* Enable open global clocks (hardware workaround) */
+	/* Implement some hardware workarounds */
+	if (version != IPA_VERSION_3_5_1 && version < IPA_VERSION_4_5) {
+		/* Enable open global clocks (not needed for IPA v4.5) */
 		val = GLOBAL_FMASK;
 		val |= GLOBAL_2X_CLK_FMASK;
 		iowrite32(val, ipa->reg_virt + IPA_REG_CLKON_CFG_OFFSET);
 
-		/* Disable PA mask to allow HOLB drop (hardware workaround) */
+		/* Disable PA mask to allow HOLB drop */
 		val = ioread32(ipa->reg_virt + IPA_REG_TX_CFG_OFFSET);
 		val &= ~PA_MASK_EN_FMASK;
 		iowrite32(val, ipa->reg_virt + IPA_REG_TX_CFG_OFFSET);
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 7d10fa6dcbec1..3fabafd7e32c6 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -238,6 +238,7 @@ static inline u32 ipa_aggr_granularity_val(u32 usec)
 	return DIV_ROUND_CLOSEST(usec * TIMER_FREQUENCY, USEC_PER_SEC) - 1;
 }
 
+/* The next register is not present for IPA v4.5 */
 #define IPA_REG_TX_CFG_OFFSET				0x000001fc
 /* The first three fields are present for IPA v3.5.1 only */
 #define TX0_PREFETCH_DISABLE_FMASK		GENMASK(0, 0)
@@ -285,6 +286,9 @@ static inline u32 ipa_resource_group_src_count(enum ipa_version version)
 	case IPA_VERSION_4_2:
 		return 1;
 
+	case IPA_VERSION_4_5:
+		return 5;
+
 	default:
 		return 0;
 	}
@@ -304,6 +308,9 @@ static inline u32 ipa_resource_group_dst_count(enum ipa_version version)
 	case IPA_VERSION_4_2:
 		return 1;
 
+	case IPA_VERSION_4_5:
+		return 5;
+
 	default:
 		return 0;
 	}
-- 
2.20.1

