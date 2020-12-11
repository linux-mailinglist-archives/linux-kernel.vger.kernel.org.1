Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088182D7885
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437437AbgLKPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406437AbgLKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:33 -0500
Date:   Fri, 11 Dec 2020 14:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yx5pB43vNGPkocdh/zgefHcPjVHF4/lq/2lk4e1a6UU=;
        b=eINNnC0btbozXQtRApLNVT1PwlTAqNWuRlKwBWCh6oGmBqxrmrLQCRLvXV6yxhygp3MPC0
        rO0zbpL2yQ04k2PC7J7y2ivavdLhZCos1UdRpHQQJEJ+A7UOcez+Y+TKJr0R4H5B+Fkc0x
        0eJZ3TDcXoP87ec049fmYSktzUFMIj2SKEBcfAo7jNnZ81kW0WEa8L1J8qVAI8+4gG+AAV
        vdcpTT38VrtBOH9YK6dFeMx+rjgrSrE/0mL02l5iNVX68KjOHEJ7xkVPbzwXDfUVNeGi4H
        mls3R89B20v5/11XloHTHQR1UwiEhhxvQ5VtadMEhH3taez15hz8qM+cpu3Iog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yx5pB43vNGPkocdh/zgefHcPjVHF4/lq/2lk4e1a6UU=;
        b=24AaEl/seIxJuOEf4cYG0yOdyY3tiHl+ysBdLtXj19aHsX2EvDpO6O8ORxpvB3/+V3qk3p
        XsBhNJKXJKZkiOBQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] Revert "genirq: Add fasteoi IPI flow"
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201109094121.29975-6-valentin.schneider@arm.com>
References: <20201109094121.29975-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160769872348.3364.14005331716265088070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b388fa50142510fb6477f130bb1b3f05a0a263a1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b388fa50142510fb6477f130bb1b3f05a0a263a1
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 09 Nov 2020 09:41:21 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

Revert "genirq: Add fasteoi IPI flow"

handle_percpu_devid_fasteoi_ipi() has no more users, and
handle_percpu_devid_irq() can do all that it was supposed to do. Get rid of
it.

This reverts commit c5e5ec033c4ab25c53f1fd217849e75deb0bf7bf.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201109094121.29975-6-valentin.schneider@arm.com
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c543653..ca26bec 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -647,7 +647,6 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b9b9618..0ae308e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -945,33 +945,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 }
 
 /**
- * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
- *				     dev ids
- * @desc:	the interrupt description structure for this irq
- *
- * The biggest difference with the IRQ version is that the interrupt is
- * EOIed early, as the IPI could result in a context switch, and we need to
- * make sure the IPI can fire again. We also assume that the arch code has
- * registered an action. If not, we are positively doomed.
- */
-void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
-	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
-
-	__kstat_incr_irqs_this_cpu(desc);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-	trace_irq_handler_exit(irq, action, res);
-}
-
-/**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
  * @desc:	the interrupt description structure for this irq
