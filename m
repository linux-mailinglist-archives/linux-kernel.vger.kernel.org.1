Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82BC1FCD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgFQMj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 08:39:26 -0400
Received: from foss.arm.com ([217.140.110.172]:57162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQMjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC1511FB;
        Wed, 17 Jun 2020 05:39:22 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9353F71F;
        Wed, 17 Jun 2020 05:39:20 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/2] arm64: kvm: Save/restore MTE registers
Date:   Wed, 17 Jun 2020 13:38:43 +0100
Message-Id: <20200617123844.29960-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617123844.29960-1-steven.price@arm.com>
References: <20200617123844.29960-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the new system registers that MTE introduces and context switch
them. Also hide the MTE feature from the ID register as it isn't
supported in a VM yet.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  7 +++++++
 arch/arm64/kvm/hyp/sysreg-sr.c    | 12 ++++++++++++
 arch/arm64/kvm/sys_regs.c         |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..1f10e9dee2e0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -92,6 +92,9 @@ struct kvm_arch {
 	 * supported.
 	 */
 	bool return_nisv_io_abort_to_user;
+
+	/* If any VCPU has MTE enabled then all memory must be MTE enabled */
+	bool vcpu_has_mte;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -123,6 +126,8 @@ enum vcpu_sysreg {
 	SCTLR_EL1,	/* System Control Register */
 	ACTLR_EL1,	/* Auxiliary Control Register */
 	CPACR_EL1,	/* Coprocessor Access Control */
+	RGSR_EL1,	/* Random Allocation Tag Seed Register */
+	GCR_EL1,	/* Tag Control Register */
 	ZCR_EL1,	/* SVE Control */
 	TTBR0_EL1,	/* Translation Table Base Register 0 */
 	TTBR1_EL1,	/* Translation Table Base Register 1 */
@@ -139,6 +144,8 @@ enum vcpu_sysreg {
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	AMAIR_EL1,	/* Aux Memory Attribute Indirection Register */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
+	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
+	TFSR_EL1,	/* Tag Fault Stauts Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
 	MDSCR_EL1,	/* Monitor Debug System Control Register */
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 75b1925763f1..6ecee1528566 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -26,6 +26,12 @@
 static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
+	if (system_supports_mte()) {
+		ctxt->sys_regs[RGSR_EL1] = read_sysreg_s(SYS_RGSR_EL1);
+		ctxt->sys_regs[GCR_EL1] = read_sysreg_s(SYS_GCR_EL1);
+		ctxt->sys_regs[TFSRE0_EL1] = read_sysreg_s(SYS_TFSRE0_EL1);
+		ctxt->sys_regs[TFSR_EL1] = read_sysreg_s(SYS_TFSR_EL1);
+	}
 
 	/*
 	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
@@ -99,6 +105,12 @@ NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
 static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
+	if (system_supports_mte()) {
+		write_sysreg_s(ctxt->sys_regs[RGSR_EL1], SYS_RGSR_EL1);
+		write_sysreg_s(ctxt->sys_regs[GCR_EL1], SYS_GCR_EL1);
+		write_sysreg_s(ctxt->sys_regs[TFSRE0_EL1], SYS_TFSRE0_EL1);
+		write_sysreg_s(ctxt->sys_regs[TFSR_EL1], SYS_TFSR_EL1);
+	}
 
 	/*
 	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 51db934702b6..3ae008a9b0bd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1095,6 +1095,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
 		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
+	} else if (id == SYS_ID_AA64PFR1_EL1) {
+		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
 	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
 		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
@@ -1504,6 +1506,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
 	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+	{ SYS_DESC(SYS_RGSR_EL1), trap_raz_wi, reset_unknown, RGSR_EL1 },
+	{ SYS_DESC(SYS_GCR_EL1), trap_raz_wi, reset_unknown, GCR_EL1 },
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
@@ -1528,6 +1532,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
 
+	{ SYS_DESC(SYS_TFSR_EL1), trap_raz_wi, reset_unknown, TFSR_EL1 },
+	{ SYS_DESC(SYS_TFSRE0_EL1), trap_raz_wi, reset_unknown, TFSRE0_EL1 },
+
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 
-- 
2.20.1

