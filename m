Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AE2AB3CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKIJm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:42:59 -0500
Received: from foss.arm.com ([217.140.110.172]:36292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgKIJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC4413A1;
        Mon,  9 Nov 2020 01:42:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 345C53F718;
        Mon,  9 Nov 2020 01:42:54 -0800 (PST)
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
Subject: [PATCH 4/5] irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
Date:   Mon,  9 Nov 2020 09:41:20 +0000
Message-Id: <20201109094121.29975-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201109094121.29975-1-valentin.schneider@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
handle_percpu_devid_fasteoi_ipi() isn't actually required.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-hip04.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 9b73dcfaf48d..a6ed877d9dd3 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -296,11 +296,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 16) {
-		irq_set_percpu_devid(irq);
-		irq_set_chip_and_handler(irq, &hip04_irq_chip,
-					 handle_percpu_devid_fasteoi_ipi);
-	} else if (hw < 32) {
+	if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
-- 
2.27.0

