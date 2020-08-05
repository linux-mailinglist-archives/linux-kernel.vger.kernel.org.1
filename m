Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1382023D08C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHETu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgHEQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:53:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759CC034617
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:49:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so5697530wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aeL1/kmzV5klgxwNmoqHqRskkWEVKnTd0w9wdAMhO/E=;
        b=WAmuiavoNO5SrR9ev60NCdMPW1s7JSDTVl3tsS2T9FBY1b18G+eebdQyaaJeIT0Ghi
         Pex8XIIGsYw4qPwkMZTz6zmTuHVi4T+PLDokYUjqNdPV+MDNMJnppTHQe/mBZjjluqic
         0FI/5htQhx5Pw+hs3C4xYFIoxIz5BFheWT/idUSj56K+Q/G61X+zyb5UzjGSLFizZbzY
         SSY0dTnkJ5vAidyXonsHmnucPLm4yoMlv7yv6D86gaMHZhMxXrDkIIgGSgCQ4k/ESe5U
         FvQ4esh+ykvDYYrX1QT+5qyF8ckUY3SSTNU/BvL4ViaI2XKWEcks/ECt8bzz5spVnmdk
         W5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aeL1/kmzV5klgxwNmoqHqRskkWEVKnTd0w9wdAMhO/E=;
        b=LuvOgNG3krafyC9QFZAWOpDqpXz051hBJWKMYaIwPQEFnnOUwz8gQDTcUGAimp8njI
         tjMqzawccrYli7o1vw4TK10oDKD2pJf+l4lFrylG+IaiRStBHdvy+Lz/PUPuu7kcXpsb
         1MmWygSybC22NTUGI0BCaVnlZntGTf2uPilawub5y3U/rKXhfI0+hv7JIshTx0kizt3I
         UBTMrhd+YLkNvcfQyC1wqJ2GxoPlGJBd+r8NFDVJ6+vt4VOsq2gZyMm5ejjO3S2DHC1W
         qniAOnCNSRK0lDmCKp8uhLtHw7MXV91T4FZkiQsc6dm289f4/ys1+hXtezcYaXfSTaxR
         9yyQ==
X-Gm-Message-State: AOAM53168VKYN2GpRvrkGUDdzuH6ZfDRk2im0KGbylVryH7jwm7+EkGp
        9VfgGV1dMGvxPuZN4Dv7lWnXnERP
X-Google-Smtp-Source: ABdhPJylKwIbndyLGfYQ0B7bmzNn5iv4k0xutgN9bL9Dv48Z0AtPAYsK0ZAePNYdSmBptYcPdUaX/g==
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr3035240wmc.115.1596631786445;
        Wed, 05 Aug 2020 05:49:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 33sm2713525wri.16.2020.08.05.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:49:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/2] habanalabs: remove security from ARB_MST_QUIET register
Date:   Wed,  5 Aug 2020 15:49:39 +0300
Message-Id: <20200805124939.13935-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805124939.13935-1-oded.gabbay@gmail.com>
References: <20200805124939.13935-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Allow user application to write to this register in order
to be able to configure the quiet period of the QMAN between grants.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/gaudi/gaudi_security.c    | 55 +++++++------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 8d5d6ddee6ed..615b547ad2b7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -831,8 +831,7 @@ static void gaudi_init_mme_protection_bits(struct hl_device *hdev)
 			PROT_BITS_OFFS;
 	word_offset = ((mmMME0_QM_ARB_MST_CHOISE_PUSH_OFST_23 &
 			PROT_BITS_OFFS) >> 7) << 2;
-	mask = 1 << ((mmMME0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmMME0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmMME0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmMME0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmMME0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmMME0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -1311,8 +1310,7 @@ static void gaudi_init_mme_protection_bits(struct hl_device *hdev)
 			PROT_BITS_OFFS;
 	word_offset = ((mmMME2_QM_ARB_MST_CHOISE_PUSH_OFST_23 &
 			PROT_BITS_OFFS) >> 7) << 2;
-	mask = 1 << ((mmMME2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmMME2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmMME2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmMME2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmMME2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmMME2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -1790,8 +1788,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -2186,8 +2183,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA1_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA1_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA1_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA1_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -2582,8 +2578,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -2978,8 +2973,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA3_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA3_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA3_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA3_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -3374,8 +3368,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA4_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA4_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA4_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA4_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -3770,8 +3763,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA5_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA5_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA5_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA5_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -4166,8 +4158,8 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA6_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+
+	mask = 1 << ((mmDMA6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA6_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA6_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA6_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -4562,8 +4554,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	word_offset =
 		((mmDMA7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
 		<< 2;
-	mask = 1 << ((mmDMA7_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmDMA7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmDMA7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA7_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA7_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmDMA7_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -5491,8 +5482,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 
 	word_offset = ((mmTPC0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -5947,8 +5937,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 
 	word_offset = ((mmTPC1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC1_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC1_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC1_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC1_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -6402,8 +6391,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 								PROT_BITS_OFFS;
 	word_offset = ((mmTPC2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -6857,8 +6845,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 								PROT_BITS_OFFS;
 	word_offset = ((mmTPC3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC3_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC3_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC3_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC3_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -7312,8 +7299,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 								PROT_BITS_OFFS;
 	word_offset = ((mmTPC4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC4_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC4_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC4_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC4_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -7767,8 +7753,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 								PROT_BITS_OFFS;
 	word_offset = ((mmTPC5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC5_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC5_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC5_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC5_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -8223,8 +8208,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 
 	word_offset = ((mmTPC6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC6_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC6_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC6_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC6_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
@@ -8681,8 +8665,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 			PROT_BITS_OFFS;
 	word_offset = ((mmTPC7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
 								>> 7) << 2;
-	mask = 1 << ((mmTPC7_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask = 1 << ((mmTPC7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC7_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC7_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC7_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
-- 
2.17.1

