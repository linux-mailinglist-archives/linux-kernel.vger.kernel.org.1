Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495D2AF657
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKKQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:28:53 -0500
Received: from foss.arm.com ([217.140.110.172]:57726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgKKQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:28:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C72201480;
        Wed, 11 Nov 2020 08:28:49 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4B23F6CF;
        Wed, 11 Nov 2020 08:28:48 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] irqchip/gic-v3-its: Disable vSGI upon (CPUIF < v4.1) detection
Date:   Wed, 11 Nov 2020 16:28:41 +0000
Message-Id: <20201111162841.3151-3-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC CPU interfaces versions predating GIC v4.1 were not built to
accommodate vINTID within the vSGI range; as reported in the GIC
specifications (8.2 "Changes to the CPU interface"), it is
CONSTRAINED UNPREDICTABLE to deliver a vSGI to a PE with
ID_AA64PFR0_EL1.GIC == b0001.

Check the GIC CPUIF version through the arm64 capabilities
infrastructure and disable vSGIs if a CPUIF version < 4.1 is
detected to prevent using vSGIs on systems where they may
misbehave.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fec31931e11..6ed4ba60ba7e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -39,6 +39,20 @@
 
 #include "irq-gic-common.h"
 
+#ifdef CONFIG_ARM64
+#include <asm/cpufeature.h>
+
+static inline bool gic_cpuif_has_vsgi(void)
+{
+	return cpus_have_const_cap(ARM64_HAS_GIC_CPUIF_VSGI);
+}
+#else
+static inline bool gic_cpuif_has_vsgi(void)
+{
+	return false;
+}
+#endif
+
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
@@ -5415,7 +5429,11 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (has_v4 & rdists->has_vlpis) {
 		const struct irq_domain_ops *sgi_ops;
 
-		if (has_v4_1)
+		/*
+		 * Enable vSGIs only if the ITS and the
+		 * GIC CPUIF support them.
+		 */
+		if (has_v4_1 && gic_cpuif_has_vsgi())
 			sgi_ops = &its_sgi_domain_ops;
 		else
 			sgi_ops = NULL;
-- 
2.29.1

