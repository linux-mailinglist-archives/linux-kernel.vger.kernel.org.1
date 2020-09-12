Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B336267B42
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgILPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 11:36:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgILPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 11:36:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D52A511B3;
        Sat, 12 Sep 2020 08:36:10 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 758F03F68F;
        Sat, 12 Sep 2020 08:36:09 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc:     jason@lakedaemon.net, maz@kernel.org, catalin.marinas@arm.com,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v3 1/2] irqchip/gicv3: Spell out when pseudo-NMIs are enabled
Date:   Sat, 12 Sep 2020 16:37:06 +0100
Message-Id: <20200912153707.667731-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912153707.667731-1-alexandru.elisei@arm.com>
References: <20200912153707.667731-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NMIs cannot be enabled, the driver prints a message stating that
unambiguously. When they are enabled, the only feedback we get is a message
regarding the use of synchronization for ICC_PMR_EL1 writes, which is not
as useful for a user who is not intimately familiar with how NMIs are
implemented.

Let's make it obvious that pseudo-NMIs are enabled. Keep the message about
using a barrier for ICC_PMR_EL1 writes, because it has a non-negligible
impact on performance.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 850842f27bee..aa9b43d412b2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1564,8 +1564,8 @@ static void gic_enable_nmi_support(void)
 	if (gic_read_ctlr() & ICC_CTLR_EL1_PMHE_MASK)
 		static_branch_enable(&gic_pmr_sync);
 
-	pr_info("%s ICC_PMR_EL1 synchronisation\n",
-		static_branch_unlikely(&gic_pmr_sync) ? "Forcing" : "Relaxing");
+	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
+		static_branch_unlikely(&gic_pmr_sync) ? "forced" : "relaxed");
 
 	static_branch_enable(&supports_pseudo_nmis);
 
-- 
2.28.0

