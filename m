Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E921D938F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgESJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 05:42:00 -0400
Received: from foss.arm.com ([217.140.110.172]:57486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgESJl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:41:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B916101E;
        Tue, 19 May 2020 02:41:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DE703F305;
        Tue, 19 May 2020 02:41:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/17] arm64/cpufeature: Introduce ID_MMFR5 CPU register
Date:   Tue, 19 May 2020 15:10:43 +0530
Message-Id: <1589881254-10082-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic building blocks required for ID_MMFR5 CPU register which
provides information about the implemented memory model and memory
management support in AArch32 state. This is added per ARM DDI 0487F.a
specification.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpu.h    |  1 +
 arch/arm64/include/asm/sysreg.h |  3 +++
 arch/arm64/kernel/cpufeature.c  | 10 ++++++++++
 arch/arm64/kernel/cpuinfo.c     |  1 +
 arch/arm64/kvm/sys_regs.c       |  2 +-
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index d9a78bdec409..e1f5ef437671 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -45,6 +45,7 @@ struct cpuinfo_arm64 {
 	u32		reg_id_mmfr1;
 	u32		reg_id_mmfr2;
 	u32		reg_id_mmfr3;
+	u32		reg_id_mmfr5;
 	u32		reg_id_pfr0;
 	u32		reg_id_pfr1;
 	u32		reg_id_pfr2;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c1c97e08a799..b7f549d09c1c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -147,6 +147,7 @@
 #define SYS_ID_MMFR2_EL1		sys_reg(3, 0, 0, 1, 6)
 #define SYS_ID_MMFR3_EL1		sys_reg(3, 0, 0, 1, 7)
 #define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
+#define SYS_ID_MMFR5_EL1		sys_reg(3, 0, 0, 3, 6)
 
 #define SYS_ID_ISAR0_EL1		sys_reg(3, 0, 0, 2, 0)
 #define SYS_ID_ISAR1_EL1		sys_reg(3, 0, 0, 2, 1)
@@ -793,6 +794,8 @@
 #define ID_ISAR6_DP_SHIFT		4
 #define ID_ISAR6_JSCVT_SHIFT		0
 
+#define ID_MMFR5_ETS_SHIFT		0
+
 #define ID_PFR2_SSBS_SHIFT		4
 #define ID_PFR2_CSV3_SHIFT		0
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index faf644a66e89..3d5c31a7cd9d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -408,6 +408,11 @@ static const struct arm64_ftr_bits ftr_id_isar4[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_mmfr5[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR5_ETS_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_isar6[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_BF16_SHIFT, 4, 0),
@@ -533,6 +538,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
 	ARM64_FTR_REG(SYS_ID_PFR2_EL1, ftr_id_pfr2),
 	ARM64_FTR_REG(SYS_ID_DFR1_EL1, ftr_id_dfr1),
+	ARM64_FTR_REG(SYS_ID_MMFR5_EL1, ftr_id_mmfr5),
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
@@ -738,6 +744,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
 		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
 		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+		init_cpu_ftr_reg(SYS_ID_MMFR5_EL1, info->reg_id_mmfr5);
 		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
 		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
 		init_cpu_ftr_reg(SYS_ID_PFR2_EL1, info->reg_id_pfr2);
@@ -872,6 +879,8 @@ static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
 				      info->reg_id_mmfr2, boot->reg_id_mmfr2);
 	taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
 				      info->reg_id_mmfr3, boot->reg_id_mmfr3);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR5_EL1, cpu,
+				      info->reg_id_mmfr5, boot->reg_id_mmfr5);
 	taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
 				      info->reg_id_pfr0, boot->reg_id_pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
@@ -1012,6 +1021,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_MMFR1_EL1);
 	read_sysreg_case(SYS_ID_MMFR2_EL1);
 	read_sysreg_case(SYS_ID_MMFR3_EL1);
+	read_sysreg_case(SYS_ID_MMFR5_EL1);
 	read_sysreg_case(SYS_ID_ISAR0_EL1);
 	read_sysreg_case(SYS_ID_ISAR1_EL1);
 	read_sysreg_case(SYS_ID_ISAR2_EL1);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 50a281703d9d..54579bf08f74 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -374,6 +374,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
 		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
 		info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
+		info->reg_id_mmfr5 = read_cpuid(ID_MMFR5_EL1);
 		info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
 		info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
 		info->reg_id_pfr2 = read_cpuid(ID_PFR2_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0723cfbff7e9..7d7a39b01135 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1458,7 +1458,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(3,3),
 	ID_SANITISED(ID_PFR2_EL1),
 	ID_HIDDEN(ID_DFR1_EL1),
-	ID_UNALLOCATED(3,6),
+	ID_SANITISED(ID_MMFR5_EL1),
 	ID_UNALLOCATED(3,7),
 
 	/* AArch64 ID registers */
-- 
2.20.1

