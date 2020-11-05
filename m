Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A442A85D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgKESOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732091AbgKESO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:14:29 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:14:29 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so2221434ile.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLtk2ibesqsxzXzb9KuT/GH5fhME26PM/cBtUYjvqb8=;
        b=meZ+fiTEV2I0dOKr67GE4GP6C3/S9T9WnXAarJ6vJ7Udasf9z4NZLNpe9wXABhT6Rw
         wXepI40XY7I83C138kw+/E/d5+ulsUnptHpoWC5hpeSQc2cbBGPTz1sAEPJ8qbv4JkcK
         ZOGTHvhnoVMFa6h0ODvfuTX0RhFXd7K10VKQkjnIVaIGRulPzDDTKD1X8fnJIro/WeHv
         zsOue9c74fUsaPHSJC/9eb/3PcJA9EhpDD2gwZL1qKdyKbfS78V6ioSwU3BaAw7HWGub
         x56nqaUZ4dETBYsFe4Be95Ka1lEHkEMtFLKs4MjoWpwgTMun3YmgVb7euKUgTWzm+/Eg
         rzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLtk2ibesqsxzXzb9KuT/GH5fhME26PM/cBtUYjvqb8=;
        b=NacsZc6MtRAAacajHJEPevhxDmf/8qP0t5at9Zsvde7E7kxrVi/PugieKSrqq24Cjt
         1PzG5lw3YzroGrYjujWgLBX4M2KQIZcqBFlY7QOl3sR1hm7XxxMu8R87qeamIN37MWKp
         rNvdZ77kR3n/FXthj/Dewm5n0J6q8c+d4RFzest9c8xubyZFlcZTlt87lUmFbnqWYhph
         WUjqoFepqim34QJ8TjAsNDLT4K1a36voBfpiXbbu+fk5k8lJu5Oaibv01jXX0pJoCWIQ
         yusXa6461qoHaMjrTWMK37gcDvZpoWSafhVO0cacJVMV6bdKnUiyC7SiF1G9n8U/4XBL
         Okzw==
X-Gm-Message-State: AOAM531qgyYCTWIw6xTGd/Nk4Hh73P0juJLtyA/wxudvKO4pb5ji4M20
        2bzI1n1P2ZhHJaR/yEV0OnushQ==
X-Google-Smtp-Source: ABdhPJyLQRShErQLyjn9KMJ/DBmJgtwt8ZC9BewhJuCPJzZ5R5Ev9ftON8AjY7spQ1f1e8D07Vcy/Q==
X-Received: by 2002:a92:154c:: with SMTP id v73mr3004497ilk.263.1604600068896;
        Thu, 05 Nov 2020 10:14:28 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o19sm1554136ilt.24.2020.11.05.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:14:28 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/13] net: ipa: only enable GSI general IRQs when needed
Date:   Thu,  5 Nov 2020 12:14:06 -0600
Message-Id: <20201105181407.8006-13-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105181407.8006-1-elder@linaro.org>
References: <20201105181407.8006-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most GSI general errors are unrecoverable without a full reset.
Despite that, we want to receive these errors so we can at least
report what happened before whatever undefined behavior ensues.

Explicitly disable all such interrupts in gsi_irq_setup(), then
enable those we want in gsi_irq_enable().  List the interrupt types
we are interested in (everything but breakpoint) explicitly rather
than using GSI_CNTXT_GSI_IRQ_ALL, and remove that symbol's
definition.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 14 ++++++++++----
 drivers/net/ipa/gsi_reg.h |  1 -
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 5e10e5c1713b1..aa3983649bc30 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -261,6 +261,7 @@ static void gsi_irq_setup(struct gsi *gsi)
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
 	iowrite32(0, gsi->virt + GSI_INTER_EE_SRC_CH_IRQ_OFFSET);
 	iowrite32(0, gsi->virt + GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET);
+	iowrite32(0, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
 }
 
 /* Turn off all GSI interrupts when we're all done */
@@ -309,8 +310,14 @@ static void gsi_irq_enable(struct gsi *gsi)
 	iowrite32(ERROR_INT_FMASK, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 	gsi->type_enabled_bitmap |= BIT(GSI_GLOB_EE);
 
-	/* Never enable GSI_BREAK_POINT */
-	val = GSI_CNTXT_GSI_IRQ_ALL & ~BREAK_POINT_FMASK;
+	/* General GSI interrupts are reported to all EEs; if they occur
+	 * they are unrecoverable (without reset).  A breakpoint interrupt
+	 * also exists, but we don't support that.  We want to be notified
+	 * of errors so we can report them, even if they can't be handled.
+	 */
+	val = BUS_ERROR_FMASK;
+	val |= CMD_FIFO_OVRFLOW_FMASK;
+	val |= MCS_STACK_OVRFLOW_FMASK;
 	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
 	gsi->type_enabled_bitmap |= BIT(GSI_GENERAL);
 
@@ -1186,8 +1193,7 @@ static void gsi_isr_general(struct gsi *gsi)
 	val = ioread32(gsi->virt + GSI_CNTXT_GSI_IRQ_STTS_OFFSET);
 	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_CLR_OFFSET);
 
-	if (val)
-		dev_err(dev, "unexpected general interrupt 0x%08x\n", val);
+	dev_err(dev, "unexpected general interrupt 0x%08x\n", val);
 }
 
 /**
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index ae00aff1cfa50..c50464984c6e3 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -353,7 +353,6 @@ enum gsi_irq_type_id {
 #define BUS_ERROR_FMASK			GENMASK(1, 1)
 #define CMD_FIFO_OVRFLOW_FMASK		GENMASK(2, 2)
 #define MCS_STACK_OVRFLOW_FMASK		GENMASK(3, 3)
-#define GSI_CNTXT_GSI_IRQ_ALL		GENMASK(3, 0)
 
 #define GSI_CNTXT_INTSET_OFFSET \
 			GSI_EE_N_CNTXT_INTSET_OFFSET(GSI_EE_AP)
-- 
2.20.1

