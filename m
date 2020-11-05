Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB32A85E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgKESOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbgKESOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:14:19 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C7C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:14:18 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o11so2723617ioo.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TH7blo20rTPHF+D/1Kt9vUa1rwMJKIl1wJXSbs7bGmo=;
        b=Y1RUgKz+2yqALbO60ShBg6g0oLJQPG3SwTop2MNSYuWzRplVOdof5ab+E4Qgbiscul
         Pjck9qGPMF4eaaks/lr9PfSgZQoctaAeAVztHIxTjC/DG6nvZ8w8rHPiKtHO0mTbOpD1
         YWgVoNjCzDKU7bu2NweHVIPwyX1M7M29kvJZ8KsxP0PUllmoeuxZxoCH9RzaI595Cs+N
         6m+vnhdC2V4FezwscxcOfuLaeR2D+mHkd12hA6IDN88IWr5LfYc+3lZKpUUqo9rS7hKt
         EoHZHAGkQN4RXjg76ctZZbDN/AF5+4Li5fXjef8NCjaaoWBRnfKRcwR3yxa3hQCSWaXJ
         OAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH7blo20rTPHF+D/1Kt9vUa1rwMJKIl1wJXSbs7bGmo=;
        b=FZzXa3Z2wgsNuiUI9FoYYbjYlA1dDRdnNnl+fppWCgx3q+AY57tWd0idvwgQanRx83
         tc0hUlmZ/O3uPzCdGWo62e6DElSjL4oPj3Mr3I2Yr5LoyhWVJDoR+3UYAYSi27iYAzI1
         kqu8dJtOOMIoTatVgy8cx1nsHBvG7gyta1xbRKa8FEA6qO7bAE6LFmEpJ5hNGN8blgA+
         id3yrWml5Vjq+DaXKdBgN0z5vfsWF9/LncOlkT4N0DYWKM2EpyDXO8KC1ZaV3ih1eGDE
         9Skn764FdkkxZ3vCrvAMf1sjW735Y0xxza/N+pOvjCKlRD02HgPc5x1dwQng3tC02MPl
         8AhA==
X-Gm-Message-State: AOAM530wPo32Qmo81uKiO/ofeoeZyIz47+uwTGimuD1HsLQJMbKrcgsW
        P70ba5rGKdQwfKg1DFOaJH4xxg==
X-Google-Smtp-Source: ABdhPJylSeVwH9lOXXG+dgu4+lzMy/eXwGr4ExVNu68bbQua2o75BklWj3/AvceSjyBD0svJRQ7lvQ==
X-Received: by 2002:a02:606d:: with SMTP id d45mr3077008jaf.73.1604600057655;
        Thu, 05 Nov 2020 10:14:17 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o19sm1554136ilt.24.2020.11.05.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:14:17 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/13] net: ipa: define GSI interrupt types with an enum
Date:   Thu,  5 Nov 2020 12:13:58 -0600
Message-Id: <20201105181407.8006-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105181407.8006-1-elder@linaro.org>
References: <20201105181407.8006-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the GSI interrupt types with an enumerated type whose values
are the bit positions representing each interrupt type.  Include a
short comment describing how each interrupt type is used.

Build up the enabled interrupt mask explicitly in gsi_irq_enable(),
and get rid of the definition of GSI_CNTXT_TYPE_IRQ_MSK_ALL.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 21 ++++++++++++---------
 drivers/net/ipa/gsi_reg.h | 19 ++++++++++---------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index ea1126a827a1c..da5204268df29 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -253,10 +253,12 @@ static void gsi_irq_enable(struct gsi *gsi)
 {
 	u32 val;
 
-	/* We don't use inter-EE channel or event interrupts */
-	val = GSI_CNTXT_TYPE_IRQ_MSK_ALL;
-	val &= ~INTER_EE_CH_CTRL_FMASK;
-	val &= ~INTER_EE_EV_CTRL_FMASK;
+	val = BIT(GSI_CH_CTRL);
+	val |= BIT(GSI_EV_CTRL);
+	val |= BIT(GSI_GLOB_EE);
+	val |= BIT(GSI_IEOB);
+	/* We don't use inter-EE channel or event control interrupts */
+	val |= BIT(GSI_GENERAL);
 	iowrite32(val, gsi->virt + GSI_CNTXT_TYPE_IRQ_MSK_OFFSET);
 
 	val = GENMASK(gsi->channel_count - 1, 0);
@@ -1130,6 +1132,7 @@ static irqreturn_t gsi_isr(int irq, void *dev_id)
 	u32 intr_mask;
 	u32 cnt = 0;
 
+	/* enum gsi_irq_type_id defines GSI interrupt types */
 	while ((intr_mask = ioread32(gsi->virt + GSI_CNTXT_TYPE_IRQ_OFFSET))) {
 		/* intr_mask contains bitmask of pending GSI interrupts */
 		do {
@@ -1138,19 +1141,19 @@ static irqreturn_t gsi_isr(int irq, void *dev_id)
 			intr_mask ^= gsi_intr;
 
 			switch (gsi_intr) {
-			case CH_CTRL_FMASK:
+			case BIT(GSI_CH_CTRL):
 				gsi_isr_chan_ctrl(gsi);
 				break;
-			case EV_CTRL_FMASK:
+			case BIT(GSI_EV_CTRL):
 				gsi_isr_evt_ctrl(gsi);
 				break;
-			case GLOB_EE_FMASK:
+			case BIT(GSI_GLOB_EE):
 				gsi_isr_glob_ee(gsi);
 				break;
-			case IEOB_FMASK:
+			case BIT(GSI_IEOB):
 				gsi_isr_ieob(gsi);
 				break;
-			case GENERAL_FMASK:
+			case BIT(GSI_GENERAL):
 				gsi_isr_general(gsi);
 				break;
 			default:
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index 9668797aa58ef..1dd81cf0b46a8 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -262,15 +262,16 @@
 			GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFSET(GSI_EE_AP)
 #define GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFSET(ee) \
 			(0x0001f088 + 0x4000 * (ee))
-/* The masks below are used for the TYPE_IRQ and TYPE_IRQ_MASK registers */
-#define CH_CTRL_FMASK			GENMASK(0, 0)
-#define EV_CTRL_FMASK			GENMASK(1, 1)
-#define GLOB_EE_FMASK			GENMASK(2, 2)
-#define IEOB_FMASK			GENMASK(3, 3)
-#define INTER_EE_CH_CTRL_FMASK		GENMASK(4, 4)
-#define INTER_EE_EV_CTRL_FMASK		GENMASK(5, 5)
-#define GENERAL_FMASK			GENMASK(6, 6)
-#define GSI_CNTXT_TYPE_IRQ_MSK_ALL	GENMASK(6, 0)
+/* Values here are bit positions in the TYPE_IRQ and TYPE_IRQ_MSK registers */
+enum gsi_irq_type_id {
+	GSI_CH_CTRL		= 0,	/* channel allocation, etc.  */
+	GSI_EV_CTRL		= 1,	/* event ring allocation, etc. */
+	GSI_GLOB_EE		= 2,	/* global/general event */
+	GSI_IEOB		= 3,	/* TRE completion */
+	GSI_INTER_EE_CH_CTRL	= 4,	/* remote-issued stop/reset (unused) */
+	GSI_INTER_EE_EV_CTRL	= 5,	/* remote-issued event reset (unused) */
+	GSI_GENERAL		= 6,	/* general-purpose event */
+};
 
 #define GSI_CNTXT_SRC_CH_IRQ_OFFSET \
 			GSI_EE_N_CNTXT_SRC_CH_IRQ_OFFSET(GSI_EE_AP)
-- 
2.20.1

