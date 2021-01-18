Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20A72FACDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394858AbhARVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389101AbhARKAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:00:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08CC22228;
        Mon, 18 Jan 2021 10:00:10 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R75-008RhD-6e; Mon, 18 Jan 2021 09:46:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v4 20/21] arm64: Defer enabling pointer authentication on boot core
Date:   Mon, 18 Jan 2021 09:45:32 +0000
Message-Id: <20210118094533.2874082-21-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Ramana <sramana@codeaurora.org>

Defer enabling pointer authentication on boot core until
after its required to be enabled by cpufeature framework.
This will help in controlling the feature dynamically
with a boot parameter.

Signed-off-by: Ajay Patil <pajay@qti.qualcomm.com>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1610152163-16554-2-git-send-email-sramana@codeaurora.org
---
 arch/arm64/include/asm/pointer_auth.h   | 10 ++++++++++
 arch/arm64/include/asm/stackprotector.h |  1 +
 arch/arm64/kernel/head.S                |  4 ----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index c6b4f0603024..b112a11e9302 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -76,6 +76,15 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 	return ptrauth_clear_pac(ptr);
 }
 
+static __always_inline void ptrauth_enable(void)
+{
+	if (!system_supports_address_auth())
+		return;
+	sysreg_clear_set(sctlr_el1, 0, (SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |
+					SCTLR_ELx_ENDA | SCTLR_ELx_ENDB));
+	isb();
+}
+
 #define ptrauth_thread_init_user(tsk)					\
 	ptrauth_keys_init_user(&(tsk)->thread.keys_user)
 #define ptrauth_thread_init_kernel(tsk)					\
@@ -84,6 +93,7 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 	ptrauth_keys_switch_kernel(&(tsk)->thread.keys_kernel)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
+#define ptrauth_enable()
 #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_thread_init_user(tsk)
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 7263e0bac680..33f1bb453150 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -41,6 +41,7 @@ static __always_inline void boot_init_stack_canary(void)
 #endif
 	ptrauth_thread_init_kernel(current);
 	ptrauth_thread_switch_kernel(current);
+	ptrauth_enable();
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b3c4dd04f74b..2a152d96d767 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -404,10 +404,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	adr_l	x5, init_task
 	msr	sp_el0, x5			// Save thread_info
 
-#ifdef CONFIG_ARM64_PTR_AUTH
-	__ptrauth_keys_init_cpu	x5, x6, x7, x8
-#endif
-
 	adr_l	x8, vectors			// load VBAR_EL1 with virtual
 	msr	vbar_el1, x8			// vector table address
 	isb
-- 
2.29.2

