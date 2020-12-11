Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EED2D7873
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437018AbgLKPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392272AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009EC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:47 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17doB12gh7JuQX+N54Y6DJRRlVnkzMUE8GdVbgsa0MA=;
        b=op7q6zt947iBI2b5nm9EuqsHdkMhr2js3eQdE24wgPa3fzEtc0QDZrfHXJz94b1lo4c0g4
        4LpOS7hi47U1/y4dpd92SNrMMHftVJEr6B8EZx9Jg5TfpHVWc5RTkO7YdZug9fRhOse8by
        ItWQpevhrsyk0aC9QRU7UZzzELtHWHynfKFNHvYU2FAaAvj7KqjsrrNMdCxSILhMCIbup/
        8irQvF1wBen4pBqtZyLw9ae8mmKp2u3Tmd7E+2SXExkwDhP34LPp7D3BhtoB8hXOaorv1D
        SN6i27NFNjW7ldRBcYoerDxg2bzSYG8e5GGSt0HbPuj4eTmjuER9McRAw4zUDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17doB12gh7JuQX+N54Y6DJRRlVnkzMUE8GdVbgsa0MA=;
        b=hyauzz5aTgtqEkeVL6q45lFSuiwpQJW3YCQcJZmVH/Voww1cetPOoDx2knaPtmxicFdksK
        U7BIa93YynX4arBQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic, gic-v3: Make SGIs use
 handle_percpu_devid_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201109094121.29975-2-valentin.schneider@arm.com>
References: <20201109094121.29975-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160769872415.3364.2359962393342316449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6abbd6988971aaa607b026eaa0ffd2301352f2ea
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6abbd6988971aaa607b026eaa0ffd2301352f2ea
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 09 Nov 2020 09:41:17 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()

handle_percpu_devid_fasteoi_ipi() states:

 * The biggest difference with the IRQ version is that the interrupt is
 * EOIed early, as the IPI could result in a context switch, and we need to
 * make sure the IPI can fire again

All that can actually happen scheduler-wise within the handling of an IPI
is the raising of TIF_NEED_RESCHED (and / or folding thereof into
preempt_count); see scheduler_ipi() or sched_ttwu_pending() for instance.

Said flag / preempt_count is evaluated some time later before returning to
whatever context was interrupted, and this gates a call to
preempt_schedule_irq() (arm64_preempt_schedule_irq() in arm64).

Per the above, SGI's do not need a different handler than PPI's, so make
them use the same (handle_percpu_devid_irq).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201109094121.29975-2-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 6 ------
 drivers/irqchip/irq-gic.c    | 8 +-------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0..3fc6537 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1302,12 +1302,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	switch (__get_intid_range(hw)) {
 	case SGI_RANGE:
-		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
-				    NULL, NULL);
-		break;
-
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a3c2f18..b1d9c22 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1005,13 +1005,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	switch (hw) {
-	case 0 ... 15:
-		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
-				    NULL, NULL);
-		break;
-	case 16 ... 31:
+	case 0 ... 31:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
