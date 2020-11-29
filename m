Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBA2C7979
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgK2N4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgK2N4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:56:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863E42084C;
        Sun, 29 Nov 2020 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606658157;
        bh=9dPSz25RDJh1UU6URLFymQsSfLuFGxOAYeMvukynGGU=;
        h=From:To:Cc:Subject:Date:From;
        b=gP2coLow4m20ve3uSVEknw6zdp6lEvOlYDvGzDCsZk2PCBsiZL3hzbvAKsDBSvBjM
         NSaooAhUQq1x0mBTcllPb3NVKbpJrG6YVoPRChgXlULcy/W9/sZTFZJYL9mA/ief7I
         vgThFouMUGmoSgoW/4JNMpRLP2DMjUdcnyacVJMU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjNBD-00ETc4-Rt; Sun, 29 Nov 2020 13:55:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq/irqdomain: Don't try to free an interrupt that has no mapping
Date:   Sun, 29 Nov 2020 13:55:51 +0000
Message-Id: <20201129135551.396777-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interrupt allocation fails for N interrupts, it is pretty
common for the error handling code to free the same number of interrupts,
no matter how many interrupts have actually been allocated.

This may result in the domain freeing code to be unexpectedly called
for interrupts that have no mapping in that domain. Things end pretty
badly.

Instead, add some checks to irq_domain_free_irqs_hierarchy() to make
sure that we don't follow the hierarchy if no mapping exists for
a given interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/irqdomain.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..4d8f5a661c2a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1370,8 +1370,14 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
 					   unsigned int nr_irqs)
 {
-	if (domain->ops->free)
-		domain->ops->free(domain, irq_base, nr_irqs);
+	int i;
+
+	if (!domain->ops->free)
+		return;
+
+	for (i = 0; i < nr_irqs; i++)
+		if (irq_domain_get_irq_data(domain, irq_base + i))
+			domain->ops->free(domain, irq_base + i, 1);
 }
 
 int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-- 
2.29.2

