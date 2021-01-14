Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787F02F6F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbhANXmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbhANXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:42:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260C5C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:40:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so3725231plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q86Uq39kF8Izless20lhwV7RldITJfPHzjplumZKKI8=;
        b=HvV8loM/5Wc3tTQUEaDMeVNQC6pGH3KzlsUhPabq6hf2LsCeAwPn80SUEGwvIh7n7Z
         9r2ERtZBQSw+gafo60uWTEeYxkPI3PWj4S137Xu6H6pylfkTmFsJLtHSNC6b4J5gzCkE
         9eFdF8SX56161ylOOsEQ3Ys9rwCRfu1tBEtOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q86Uq39kF8Izless20lhwV7RldITJfPHzjplumZKKI8=;
        b=B8HeezcMv0Pq2mnJ9MMmS42CNqqjRGOWK8mnAINykmxAO05/LYF3wGe+u5+BatxxRi
         acPcg1KbuB4FyTbVOGwLRLLXGEaNpDm3B+3CLpH4RZu0Ldrwf+a8xLJOcma98OsCbAem
         UyrdmNjryXz9TrYrBz9hvmvB3fm7bEGA61aWJSfVD7nf61H42xF/Ckwr/jd1U6ZXt+5c
         MCBSbisT/SeBhl+6tE9aSRJ6VS86zkAH58mqJt/H8CZ9i1UTP70doEMQ96fFU47qPc7q
         QkQeEZawBrsLSbnapyU84LrcT6MIkY88pOzpjPBM1T6sNo+wHo0ZwPGaZKfKJKnWtkPN
         UYqA==
X-Gm-Message-State: AOAM530IolFHGwvtHZvI3gJcZo51cmpcpvZbIRUoyB0jw7hbOJLV/QQs
        S40Yd/2pmPGPdEliwBYkHa7QBQ==
X-Google-Smtp-Source: ABdhPJyNFjW5H2OxoC30TO+bl5lQRqLQZkFSxFgLLb+XdKJIv2USPjBdhtesQzHM2eypDY5p7HSMjg==
X-Received: by 2002:a17:90b:e88:: with SMTP id fv8mr7386990pjb.126.1610667653718;
        Thu, 14 Jan 2021 15:40:53 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id x1sm6498804pfj.95.2021.01.14.15.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:40:53 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] pinctrl: qcom: Properly clear "intr_ack_high" interrupts when unmasking
Date:   Thu, 14 Jan 2021 15:40:26 -0800
Message-Id: <20210114154004.v6.3.I32d0f4e174d45363b49ab611a13c3da8f1e87d0f@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210114154004.v6.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
References: <20210114154004.v6.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4b7618fdc7e6 ("pinctrl: qcom: Add irq_enable callback for
msm gpio") we tried to Ack interrupts during unmask.  However, that
patch forgot to check "intr_ack_high" so, presumably, it only worked
for a certain subset of SoCs.

Let's add a small accessor so we don't need to open-code the logic in
both places.

This was found by code inspection.  I don't have any access to the
hardware in question nor software that needs the Ack during unmask.

Fixes: 4b7618fdc7e6 ("pinctrl: qcom: Add irq_enable callback for msm gpio")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
It should be noted that this code will be moved in the next patch.  In
theory this could be squashed into the next patch but it seems more
documenting to have this as a separate patch.

Changes in v6:
- Remove unneeded parenthesis.

Changes in v5:
- ("pinctrl: qcom: Properly clear "intr_ack_high" interrupts...") new for v5.

 drivers/pinctrl/qcom/pinctrl-msm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 2f363c28d9d9..192ed31eabf4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -96,6 +96,14 @@ MSM_ACCESSOR(intr_cfg)
 MSM_ACCESSOR(intr_status)
 MSM_ACCESSOR(intr_target)
 
+static void msm_ack_intr_status(struct msm_pinctrl *pctrl,
+				const struct msm_pingroup *g)
+{
+	u32 val = g->intr_ack_high ? BIT(g->intr_status_bit) : 0;
+
+	msm_writel_intr_status(val, pctrl, g);
+}
+
 static int msm_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -797,7 +805,7 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
 	 * when the interrupt is not in use.
 	 */
 	if (status_clear)
-		msm_writel_intr_status(0, pctrl, g);
+		msm_ack_intr_status(pctrl, g);
 
 	val = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
@@ -890,7 +898,6 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
-	u32 val;
 
 	if (test_bit(d->hwirq, pctrl->skip_wake_irqs)) {
 		if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
@@ -902,8 +909,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	val = g->intr_ack_high ? BIT(g->intr_status_bit) : 0;
-	msm_writel_intr_status(val, pctrl, g);
+	msm_ack_intr_status(pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

