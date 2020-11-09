Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FBD2AB3CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKIJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:42:51 -0500
Received: from foss.arm.com ([217.140.110.172]:36228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B657113E;
        Mon,  9 Nov 2020 01:42:50 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 813B13F718;
        Mon,  9 Nov 2020 01:42:48 -0800 (PST)
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
Subject: [PATCH 1/5] irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()
Date:   Mon,  9 Nov 2020 09:41:17 +0000
Message-Id: <20201109094121.29975-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201109094121.29975-1-valentin.schneider@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic-v3.c | 6 ------
 drivers/irqchip/irq-gic.c    | 8 +-------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0febe8..3fc65375cbe0 100644
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
index 6053245a4754..9edbe5b5c4ac 100644
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
-- 
2.27.0

