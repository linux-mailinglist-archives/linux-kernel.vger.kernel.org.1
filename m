Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524EA28DD81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgJNJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgJNJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B830C0613DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:26:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so582400pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTZ0TY6V/O5G/81ybrQ47uBho41Y6v3NILTItnTrKis=;
        b=T3Cnn4d1Ny8T3yEUuaeG/1+IH1vROXxkaEaD4oCx3/SUz2fANe41fdb43L3Sz5SUEW
         gdCLROFz1PhQAIbYAKSolN7hxHW6M8WDHDyKuaBqV4m1dZMJXX9XaUPn20YEkdRwd2Sp
         PBSasWiplYjvEMc2K/r04sCKdsaBmpDkTtWnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTZ0TY6V/O5G/81ybrQ47uBho41Y6v3NILTItnTrKis=;
        b=sldHUMfE/DizuT3HyVRLERXUcyVt8HVS7nkpGfVIwX5dRtyXP3Wt4PtH3LrgGQM0BK
         W6lh3JnilM4cPGpgwe6K88IGZJB3ZuXXPQvEQFVKdkXMX8KXdQvFCTLBxSV0i1W4cO8u
         7gSRIcRueNjjYnb4xiZ47yup1ybGZPiOnyOjihhje8XqcowYdrveefmBPwFLgz/ErVlA
         O6ab3Scak2cNVgteR3w0yMEVzo71LNINQtdoDgJ2yN4brB+KovSErfDy8jGlUweD/wOe
         VppzZjgtNzczlT+JUY90+yA+vA+tglbQWmgjJ2gS2Lw2VzcyEpJzobYD37cGG9cHpIit
         LpAw==
X-Gm-Message-State: AOAM532BpFg9tSm0+BoLcFuhiQqyI0hf9kDTF7MSDD/Xfl+zayS1rC7M
        u80gstqZzOIO4BGe0LRNRDEREA==
X-Google-Smtp-Source: ABdhPJw5ERljxRf+ppIaCppwP2hYl/Q2fTvmgZmRjyD1gtAuM5lCQGnkocPD2bHIa1j0bXRARwbObw==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr319550pjb.6.1602624386670;
        Tue, 13 Oct 2020 14:26:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id b15sm167713pju.16.2020.10.13.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 14:26:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-i2c@vger.kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] soc: qcom: geni: Optimize/comment select fifo/dma mode
Date:   Tue, 13 Oct 2020 14:25:30 -0700
Message-Id: <20201013142448.v2.3.I646736d3969dc47de8daceb379c6ba85993de9f4@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201013212531.428538-1-dianders@chromium.org>
References: <20201013212531.428538-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions geni_se_select_fifo_mode() and
geni_se_select_fifo_mode() are a little funny.  They read/write a
bunch of memory mapped registers even if they don't change or aren't
relevant for the current protocol.  Let's make them a little more
sane.  We'll also add a comment explaining why we don't do some of the
operations for UART.

NOTE: there is no evidence at all that this makes any performance
difference and it fixes no bugs.  However, it seems (to me) like it
makes the functions a little easier to understand.  Decreasing the
amount of times we read/write memory mapped registers is also nice,
even if we are using "relaxed" variants.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note that I didn't add Dmitry Baryshkov's Tested-by tag to the 3rd
patch since it changed subtly.  Also note that when adding comments
about why the UART is special it seems clear to me that we really
shouldn't be managing these interrupt enables in the common code.  It
seems like drivers should manage / enable the interrupts that they
care about.  That seems like a bigger change, though, and I didn't
want to muddy the waters and potentially delay the important fix from
patch #1 and #2.  Hopefully someone from Qualcomm can take on cleaning
this stuff up after these fixes land.

Changes in v2:
- Consistently use "val_old" to keep track of old value.
- Add comments about why UART is special.

 drivers/soc/qcom/qcom-geni-se.c | 50 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 751a49f6534f..7649b2057b9a 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -266,49 +266,63 @@ EXPORT_SYMBOL(geni_se_init);
 static void geni_se_select_fifo_mode(struct geni_se *se)
 {
 	u32 proto = geni_se_read_proto(se);
-	u32 val;
+	u32 val, val_old;
 
 	geni_se_irq_clear(se);
 
-	val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
+	/*
+	 * The RX path for the UART is asynchronous and so needs more
+	 * complex logic for enabling / disabling its interrupts.
+	 *
+	 * Specific notes:
+	 * - The done and TX-related interrupts are managed manually.
+	 * - We don't RX from the main sequencer (we use the secondary) so
+	 *   we don't need the RX-related interrupts enabled in the main
+	 *   sequencer for UART.
+	 */
 	if (proto != GENI_SE_UART) {
+		val_old = val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 		val |= M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN;
 		val |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-	}
-	writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
+		if (val != val_old)
+			writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
 
-	val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
-	if (proto != GENI_SE_UART)
+		val_old = val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
 		val |= S_CMD_DONE_EN;
-	writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
+		if (val != val_old)
+			writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
+	}
 
-	val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
+	val_old = val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
 	val &= ~GENI_DMA_MODE_EN;
-	writel_relaxed(val, se->base + SE_GENI_DMA_MODE_EN);
+	if (val != val_old)
+		writel_relaxed(val, se->base + SE_GENI_DMA_MODE_EN);
 }
 
 static void geni_se_select_dma_mode(struct geni_se *se)
 {
 	u32 proto = geni_se_read_proto(se);
-	u32 val;
+	u32 val, val_old;
 
 	geni_se_irq_clear(se);
 
-	val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 	if (proto != GENI_SE_UART) {
+		val_old = val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 		val &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 		val &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-	}
-	writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
+		if (val != val_old)
+			writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
 
-	val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
-	if (proto != GENI_SE_UART)
+		val_old = val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
 		val &= ~S_CMD_DONE_EN;
-	writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
+		if (val != val_old)
+			writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
+	}
 
-	val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
+	val_old = val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
 	val |= GENI_DMA_MODE_EN;
-	writel_relaxed(val, se->base + SE_GENI_DMA_MODE_EN);
+	if (val != val_old)
+		writel_relaxed(val, se->base + SE_GENI_DMA_MODE_EN);
 }
 
 /**
-- 
2.28.0.1011.ga647a8990f-goog

