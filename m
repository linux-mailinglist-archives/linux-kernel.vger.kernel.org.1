Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5924A026
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgHSNgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:36:31 -0400
Received: from foss.arm.com ([217.140.110.172]:37106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbgHSNfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:35:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3255C1435;
        Wed, 19 Aug 2020 06:35:42 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87BD3F71F;
        Wed, 19 Aug 2020 06:35:40 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc:     jason@lakedaemon.net, maz@kernel.org, catalin.marinas@arm.com,
        tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com
Subject: [PATCH v2 1/2] irqchip/gicv3: Spell out when pseudo-NMIs are enabled
Date:   Wed, 19 Aug 2020 14:36:29 +0100
Message-Id: <20200819133630.527243-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819133630.527243-1-alexandru.elisei@arm.com>
References: <20200819133630.527243-1-alexandru.elisei@arm.com>
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
index 324f280ff606..ce8944ae1b84 100644
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

