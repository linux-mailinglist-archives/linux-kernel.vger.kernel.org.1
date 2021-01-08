Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD482EF688
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbhAHRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbhAHRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:36:28 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D27C0612FD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 09:35:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c79so6678185pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYkzYWMleX3qMt/pYBfE+NT2hyGkrkjahRGphftC+6U=;
        b=NHlEzY+bSJyUuMChX1xu1cawgmxyUcHAbrm3nVHqPnG/bRp7qYCTOeZ0oLneiu4A63
         1CVsPYp6LNwFyLxuS33DztP8G3p9CGGYRUGdAEvlAaFNh4QqlWQ9f1hxFLolsOsCMfyW
         TRLloydHP96EsjiC1hiUcwdjIvVDnTfGMaV/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYkzYWMleX3qMt/pYBfE+NT2hyGkrkjahRGphftC+6U=;
        b=nXYYFfbApL4q7G3yEi3BBdS4YmDYtFWsYdrb/x0iOJtooZNSW8fpCwV8qxP9VsMpeg
         YNjeUGstznRs3wVwQLRzdnK9nBdY9yiC9CeToBbDvLuL/v2okPkCBbyBNrMX2dj+Pk0r
         UEi8Jdv9Ykt04Q5ROT5pVL5iHm27xeIFTKR+T5lU5czW2adiyLDGwb1kiTY9IRdbD2oy
         gFGCyooR7F041Tvkw5T0x6zUTcWwObXvrBGRJ/euvXcqey9AZU7UpQKl1/Zo97QSCF58
         Ym9IOTDz0luX+iqaQHW74qmequ28sZgwPw5Wx5hXgroF+hW5P9t5+bQ7wGdTL1rugkmU
         1qMg==
X-Gm-Message-State: AOAM530vDpMuoW6df80f7DoOvksAs/neLIlge32Eye03UvQYmDa34EnI
        2lF4r8kxiNJu8b64kM55W+okYg==
X-Google-Smtp-Source: ABdhPJyK0aabqVagQDNA17Xpi+5kBKYUQBiRd6UN2GtPqlDhIWRZKS9di/e0FCPbLoRKAxKH7axQhA==
X-Received: by 2002:a63:1142:: with SMTP id 2mr8114323pgr.263.1610127348077;
        Fri, 08 Jan 2021 09:35:48 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id z23sm10245619pfj.143.2021.01.08.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 09:35:47 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] pinctrl: qcom: No need to read-modify-write the interrupt status
Date:   Fri,  8 Jan 2021 09:35:14 -0800
Message-Id: <20210108093339.v5.2.I3635de080604e1feda770591c5563bd6e63dd39d@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Qualcomm pinctrl driver wants to Ack an interrupt, it does a
read-modify-write on the interrupt status register.  On some SoCs it
makes sure that the status bit is 1 to "Ack" and on others it makes
sure that the bit is 0 to "Ack".  Presumably the first type of
interrupt controller is a "write 1 to clear" type register and the
second just let you directly set the interrupt status register.

As far as I can tell from scanning structure definitions, the
interrupt status bit is always in a register by itself.  Thus with
both types of interrupt controllers it is safe to "Ack" interrupts
without doing a read-modify-write.  We can do a simple write.

It should be noted that if the interrupt status bit _was_ ever in a
register with other things (like maybe status bits for other GPIOs):
a) For "write 1 clear" type controllers then read-modify-write would
   be totally wrong because we'd accidentally end up clearing
   interrupts we weren't looking at.
b) For "direct set" type controllers then read-modify-write would also
   be wrong because someone setting one of the other bits in the
   register might accidentally clear (or set) our interrupt.
I say this simply to show that the current read-modify-write doesn't
provide any sort of "future proofing" of the code.  In fact (for
"write 1 clear" controllers) the new code is slightly more "future
proof" since it would allow more than one interrupt status bits to
share a register.

NOTE: this code fixes no bugs--it simply avoids an extra register
read.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("pinctrl: qcom: No need to read-modify-write the ...") new for v5.

 drivers/pinctrl/qcom/pinctrl-msm.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1d2a78452c2d..1787ada6bfab 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -792,16 +792,13 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	if (status_clear) {
-		/*
-		 * clear the interrupt status bit before unmask to avoid
-		 * any erroneous interrupts that would have got latched
-		 * when the interrupt is not in use.
-		 */
-		val = msm_readl_intr_status(pctrl, g);
-		val &= ~BIT(g->intr_status_bit);
-		msm_writel_intr_status(val, pctrl, g);
-	}
+	/*
+	 * clear the interrupt status bit before unmask to avoid
+	 * any erroneous interrupts that would have got latched
+	 * when the interrupt is not in use.
+	 */
+	if (status_clear)
+		msm_writel_intr_status(0, pctrl, g);
 
 	val = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
@@ -906,11 +903,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	val = msm_readl_intr_status(pctrl, g);
-	if (g->intr_ack_high)
-		val |= BIT(g->intr_status_bit);
-	else
-		val &= ~BIT(g->intr_status_bit);
+	val = (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;
 	msm_writel_intr_status(val, pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
-- 
2.29.2.729.g45daf8777d-goog

