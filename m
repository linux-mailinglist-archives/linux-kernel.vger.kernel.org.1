Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AD2B5545
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgKPXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgKPXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:38:20 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:38:20 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r9so19254231ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miGXLixORMdi7i2E2KGi5NSoYisIYv8Xp9fzXt5c7vw=;
        b=hviPeDalWc15oQvXLtAt/Q7e8K2nSWO5V9xZAl8H2DBXItZjZGUMLPQy3Oy1wE6XVf
         /AFZ/nyrkPK4/qjim1E64ZjZeQnv+u5FRPeoYK+qwhxe6O3CX2Lcb+TWF1RgnyjooVKv
         o7hz/CU6ecT1bNRWyGtJdBH9ld0mwwiE8l36kZMqqmvJUnLS/rOz1tCALxM6ySW646FA
         LRtoPU9kpf+AdcnB5AiI0IjsRJW/k1sCnEHBwcsLbV2YIR2WtYw36H3hwtUCVN3TL6sn
         aEtjq73dzg+JBwfjQgrWa/kgfGcb7Ez/Uo8V5DJv2XkR2XlK4v3tZbtDa5FR2d0LLq3V
         tIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miGXLixORMdi7i2E2KGi5NSoYisIYv8Xp9fzXt5c7vw=;
        b=nOgaJ16kk316J/MCXa4kBuEmUTqXNoIZbvcuJVdAody8wq0PMcTxnffvQhezIj5pGV
         AFBqT/oSf3LJS7HBVNn31dve8iV0nu1Y3OaO8as4qoFk+Yu7yF9azkPMk0O+VSI61v2Z
         KPLGOG88n7Jo+/J6FxkBxfaJFZoPfjm1Yw07M9/l4dzkK5HpwNkuLtWtpW7d0WUwC/Q1
         FhgqzjiDBINyvz95G1vnL1ICAqazsUDyN3N5aqWRnTc2ed4f6wPOJck3f304n+4etqTj
         /wf07JE8zAznFKlBfakVU19OLzlilaob7AuFFwVoU5DLX0r6nGvEBiAQICyTRmjQX576
         3G0w==
X-Gm-Message-State: AOAM531yMft/dx/Ax3w7P28+a9+zfK9N63rNz9k9urRsPIQOb6ctKSoL
        uyYlBTWP3FWrzBdPzfxMwLqnxA==
X-Google-Smtp-Source: ABdhPJwtFO6z5aQA3aPZ+Kd4jLfanxVArYEUi6XAqfyab/OJgUQRrJ034o424wNqMDl90uREqD2yUw==
X-Received: by 2002:a05:6638:b30:: with SMTP id c16mr1539600jab.61.1605569899560;
        Mon, 16 Nov 2020 15:38:19 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f18sm10180099ill.22.2020.11.16.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:38:19 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/11] net: ipa: fix two inconsistent IPA register names
Date:   Mon, 16 Nov 2020 17:37:58 -0600
Message-Id: <20201116233805.13775-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116233805.13775-1-elder@linaro.org>
References: <20201116233805.13775-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename two suspend IRQ registers so they follow the IPA_REG_IRQ_xxx
naming convention used elsewhere.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c |  6 +++---
 drivers/net/ipa/ipa_reg.h       | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index cc1ea28f7bc2e..61dd7605bcb66 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -139,12 +139,12 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	u32 val;
 
 	/* assert(mask & ipa->available); */
-	val = ioread32(ipa->reg_virt + IPA_REG_SUSPEND_IRQ_EN_OFFSET);
+	val = ioread32(ipa->reg_virt + IPA_REG_IRQ_SUSPEND_EN_OFFSET);
 	if (enable)
 		val |= mask;
 	else
 		val &= ~mask;
-	iowrite32(val, ipa->reg_virt + IPA_REG_SUSPEND_IRQ_EN_OFFSET);
+	iowrite32(val, ipa->reg_virt + IPA_REG_IRQ_SUSPEND_EN_OFFSET);
 }
 
 /* Enable TX_SUSPEND for an endpoint */
@@ -168,7 +168,7 @@ void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
 	u32 val;
 
 	val = ioread32(ipa->reg_virt + IPA_REG_IRQ_SUSPEND_INFO_OFFSET);
-	iowrite32(val, ipa->reg_virt + IPA_REG_SUSPEND_IRQ_CLR_OFFSET);
+	iowrite32(val, ipa->reg_virt + IPA_REG_IRQ_SUSPEND_CLR_OFFSET);
 }
 
 /* Simulate arrival of an IPA TX_SUSPEND interrupt */
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index b46e60744f57f..e24c190665139 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -454,17 +454,17 @@ static inline u32 rsrc_grp_encoded(enum ipa_version version, u32 rsrc_grp)
 					(0x00003030 + 0x1000 * (ee))
 /* ipa->available defines the valid bits in the SUSPEND_INFO register */
 
-#define IPA_REG_SUSPEND_IRQ_EN_OFFSET \
-				IPA_REG_SUSPEND_IRQ_EN_EE_N_OFFSET(GSI_EE_AP)
-#define IPA_REG_SUSPEND_IRQ_EN_EE_N_OFFSET(ee) \
+#define IPA_REG_IRQ_SUSPEND_EN_OFFSET \
+				IPA_REG_IRQ_SUSPEND_EN_EE_N_OFFSET(GSI_EE_AP)
+#define IPA_REG_IRQ_SUSPEND_EN_EE_N_OFFSET(ee) \
 					(0x00003034 + 0x1000 * (ee))
-/* ipa->available defines the valid bits in the SUSPEND_IRQ_EN register */
+/* ipa->available defines the valid bits in the IRQ_SUSPEND_EN register */
 
-#define IPA_REG_SUSPEND_IRQ_CLR_OFFSET \
-				IPA_REG_SUSPEND_IRQ_CLR_EE_N_OFFSET(GSI_EE_AP)
-#define IPA_REG_SUSPEND_IRQ_CLR_EE_N_OFFSET(ee) \
+#define IPA_REG_IRQ_SUSPEND_CLR_OFFSET \
+				IPA_REG_IRQ_SUSPEND_CLR_EE_N_OFFSET(GSI_EE_AP)
+#define IPA_REG_IRQ_SUSPEND_CLR_EE_N_OFFSET(ee) \
 					(0x00003038 + 0x1000 * (ee))
-/* ipa->available defines the valid bits in the SUSPEND_IRQ_CLR register */
+/* ipa->available defines the valid bits in the IRQ_SUSPEND_CLR register */
 
 /** enum ipa_cs_offload_en - checksum offload field in ENDP_INIT_CFG_N */
 enum ipa_cs_offload_en {
-- 
2.20.1

