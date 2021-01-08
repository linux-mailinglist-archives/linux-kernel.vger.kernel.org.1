Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD472EF68C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbhAHRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbhAHRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:37:07 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5DC06129D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 09:35:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n25so8074078pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWeNVhHBQriYHElYut4sIDkeHCxpOsy0zeO3R0EcrZs=;
        b=gitdbsRXUUNlxvhhaDHU9H74LPVrCzER8lNo58HHLgmXTbtA4Zz0DS47MFLORIDenw
         AuIjVRUIYBxTr+zdgUMdLGrT49UyLpVE7nYPnEwgudirgVEUcQ2kKSj8GvkzivuYfo9R
         oEWhmBwgYquKQr+3HCKaquX6HOmmgZ6fQnV4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWeNVhHBQriYHElYut4sIDkeHCxpOsy0zeO3R0EcrZs=;
        b=aFDzPtNeDSCbqLpdWRhWNhl+pDgVlPD8E+H35ovbNeMwe6RQmMIf2tuseEdxP86HXs
         HJmamXh8EQaTACtBTpN5U/I0U14u82tGbXbpjUtyX0jDC4pURQBvoPMU8/9noEq1GmBi
         NFctvzHNWoVNokczMgsqJyT4XIsmBNjqj+FZ7Tvq0nI6x5hNpqydNEBg2w5Q0zvSyPku
         AE4syA2FlE1RY/9kVX9sJLhp1jcsUwjUs1rWahNQQMUWeXoX1U5IXX4OnQkSTp5L/TTw
         idpaagTJn8IONcqIqcVq0Fb/MweynkMJhHCsCEfoLsbnmQDNcNj/26pp+XUeW01mTqA8
         VrTQ==
X-Gm-Message-State: AOAM532TFcLK5b2ePfvAig2lCHD17X7KoQBz5urqMOwdR15bYdbPhEJh
        1y1+KJvaJ+K2xE9Ch6dQ47i5HA==
X-Google-Smtp-Source: ABdhPJwGKvhGrqpD2mUiuU9++lk/mDnNGEcCmGVCYte+Fgza04DZRHEsAH8Sgef/6OucwTC5fZ1xgA==
X-Received: by 2002:a63:dc4c:: with SMTP id f12mr8023342pgj.167.1610127349809;
        Fri, 08 Jan 2021 09:35:49 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id z23sm10245619pfj.143.2021.01.08.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 09:35:49 -0800 (PST)
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
Subject: [PATCH v5 3/4] pinctrl: qcom: Properly clear "intr_ack_high" interrupts when unmasking
Date:   Fri,  8 Jan 2021 09:35:15 -0800
Message-Id: <20210108093339.v5.3.I32d0f4e174d45363b49ab611a13c3da8f1e87d0f@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
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
---
It should be noted that this code will be moved in the next patch.  In
theory this could be squashed into the next patch but it seems more
documenting to have this as a separate patch.

Changes in v5:
- ("pinctrl: qcom: Properly clear "intr_ack_high" interrupts...") new for v5.

 drivers/pinctrl/qcom/pinctrl-msm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1787ada6bfab..a6b0c17e2f78 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -96,6 +96,14 @@ MSM_ACCESSOR(intr_cfg)
 MSM_ACCESSOR(intr_status)
 MSM_ACCESSOR(intr_target)
 
+static void msm_ack_intr_status(struct msm_pinctrl *pctrl,
+				const struct msm_pingroup *g)
+{
+	u32 val = (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;
+
+	msm_writel_intr_status(val, pctrl, g);
+}
+
 static int msm_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -798,7 +806,7 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
 	 * when the interrupt is not in use.
 	 */
 	if (status_clear)
-		msm_writel_intr_status(0, pctrl, g);
+		msm_ack_intr_status(pctrl, g);
 
 	val = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
@@ -891,7 +899,6 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
-	u32 val;
 
 	if (test_bit(d->hwirq, pctrl->skip_wake_irqs)) {
 		if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
@@ -903,8 +910,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	val = (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;
-	msm_writel_intr_status(val, pctrl, g);
+	msm_ack_intr_status(pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
-- 
2.29.2.729.g45daf8777d-goog

