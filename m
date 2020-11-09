Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C62AB3CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgKIJnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:43:05 -0500
Received: from foss.arm.com ([217.140.110.172]:36312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgKIJm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC4701424;
        Mon,  9 Nov 2020 01:42:57 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DE733F718;
        Mon,  9 Nov 2020 01:42:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 5/5] Revert "genirq: Add fasteoi IPI flow"
Date:   Mon,  9 Nov 2020 09:41:21 +0000
Message-Id: <20201109094121.29975-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201109094121.29975-1-valentin.schneider@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_percpu_devid_fasteoi_ipi() has no more users, and
handle_percpu_devid_irq() can do all that it was supposed to do. Get rid of
it.

This reverts commit c5e5ec033c4ab25c53f1fd217849e75deb0bf7bf.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c54365309e97..ca26bec51cec 100644
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
index b9b9618e1aca..0ae308efa604 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -944,33 +944,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-/**
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
 /**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
-- 
2.27.0

