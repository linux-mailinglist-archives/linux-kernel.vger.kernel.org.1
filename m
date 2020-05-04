Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCB1C35B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEDJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 05:29:19 -0400
Received: from foss.arm.com ([217.140.110.172]:40558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEDJ3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:29:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC751113E;
        Mon,  4 May 2020 02:29:16 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B8BB93F305;
        Mon,  4 May 2020 02:29:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: [PATCH v2 3/5] arm/arm64: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
Date:   Mon,  4 May 2020 10:29:03 +0100
Message-Id: <20200504092905.10580-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504092905.10580-1-sudeep.holla@arm.com>
References: <20200504092905.10580-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of maintaining 2 sets of enums/macros for tracking SMCCC version,
let us drop smccc_version enum and use ARM_SMCCC_VERSION_1_x directly
instead.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/paravirt.c | 2 +-
 drivers/firmware/psci/psci.c | 8 ++++----
 include/linux/psci.h         | 7 +------
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 1ef702b0be2d..295d66490584 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -120,7 +120,7 @@ static bool has_pv_steal_clock(void)
 	struct arm_smccc_res res;
 
 	/* To detect the presence of PV time support we require SMCCC 1.1+ */
-	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
 		return false;
 
 	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2937d44b5df4..6a56d7196697 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -54,12 +54,12 @@ bool psci_tos_resident_on(int cpu)
 
 struct psci_operations psci_ops = {
 	.conduit = SMCCC_CONDUIT_NONE,
-	.smccc_version = SMCCC_VERSION_1_0,
+	.smccc_version = ARM_SMCCC_VERSION_1_0,
 };
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
 {
-	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
+	if (psci_ops.smccc_version < ARM_SMCCC_VERSION_1_1)
 		return SMCCC_CONDUIT_NONE;
 
 	return psci_ops.conduit;
@@ -411,8 +411,8 @@ static void __init psci_init_smccc(void)
 	if (feature != PSCI_RET_NOT_SUPPORTED) {
 		u32 ret;
 		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
-		if (ret == ARM_SMCCC_VERSION_1_1) {
-			psci_ops.smccc_version = SMCCC_VERSION_1_1;
+		if (ret >= ARM_SMCCC_VERSION_1_1) {
+			psci_ops.smccc_version = ret;
 			ver = ret;
 		}
 	}
diff --git a/include/linux/psci.h b/include/linux/psci.h
index a67712b73b6c..29bd0671e5bb 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,11 +21,6 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(void);
 bool psci_has_osi_support(void);
 
-enum smccc_version {
-	SMCCC_VERSION_1_0,
-	SMCCC_VERSION_1_1,
-};
-
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -36,7 +31,7 @@ struct psci_operations {
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
 	enum arm_smccc_conduit conduit;
-	enum smccc_version smccc_version;
+	u32 smccc_version;
 };
 
 extern struct psci_operations psci_ops;
-- 
2.17.1

