Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213AD2FACD7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394798AbhARVja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389417AbhARKBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:01:05 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D80E2251F;
        Mon, 18 Jan 2021 10:00:20 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R77-008RhD-Ok; Mon, 18 Jan 2021 09:46:22 +0000
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
Subject: [PATCH v4 21/21] arm64: cpufeatures: Allow disabling of Pointer Auth from the command-line
Date:   Mon, 18 Jan 2021 09:45:33 +0000
Message-Id: <20210118094533.2874082-22-maz@kernel.org>
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

In order to be able to disable Pointer Authentication  at runtime,
whether it is for testing purposes, or to work around HW issues,
let's add support for overriding the ID_AA64ISAR1_EL1.{GPI,GPA,API,APA}
fields.

This is further mapped on the arm64.nopauth command-line alias.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/arm64/include/asm/cpufeature.h             |  2 ++
 arch/arm64/kernel/cpufeature.c                  |  5 ++++-
 arch/arm64/kernel/idreg-override.c              | 17 +++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7599fd0f1ad7..f9cb28a39bd0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -376,6 +376,9 @@
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
+	arm64.nopauth	[ARM64] Unconditionally disable Pointer Authentication
+			support
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index d3e0f6dd43c4..9d8dcf380ad5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -818,6 +818,8 @@ extern u64 id_aa64mmfr1_val;
 extern u64 id_aa64mmfr1_mask;
 extern u64 id_aa64pfr1_val;
 extern u64 id_aa64pfr1_mask;
+extern u64 id_aa64isar1_val;
+extern u64 id_aa64isar1_mask;
 
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f223171a7c34..f5ba7fd615b5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -559,6 +559,8 @@ u64 id_aa64mmfr1_val;
 u64 id_aa64mmfr1_mask;
 u64 id_aa64pfr1_val;
 u64 id_aa64pfr1_mask;
+u64 id_aa64isar1_val;
+u64 id_aa64isar1_mask;
 
 static const struct __ftr_reg_entry {
 	u32			sys_id;
@@ -604,7 +606,8 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
-	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1,
+			       &id_aa64isar1_val, &id_aa64isar1_mask),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index a9e3ed193fd4..7037c9b214d0 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -43,6 +43,19 @@ static const struct reg_desc pfr1 __initdata = {
 	},
 };
 
+static const struct reg_desc isar1 __initdata = {
+	.name		= "id_aa64isar1",
+	.val		= &id_aa64isar1_val,
+	.mask		= &id_aa64isar1_mask,
+	.fields		= {
+	        { "gpi", ID_AA64ISAR1_GPI_SHIFT },
+	        { "gpa", ID_AA64ISAR1_GPA_SHIFT },
+	        { "api", ID_AA64ISAR1_API_SHIFT },
+	        { "apa", ID_AA64ISAR1_APA_SHIFT },
+		{}
+	},
+};
+
 extern u64 kaslr_feature_val;
 extern u64 kaslr_feature_mask;
 
@@ -61,6 +74,7 @@ static const struct reg_desc kaslr __initdata = {
 static const struct reg_desc * const regs[] __initdata = {
 	&mmfr1,
 	&pfr1,
+	&isar1,
 	&kaslr,
 };
 
@@ -71,6 +85,9 @@ static const struct {
 	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
 	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
 	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
+	{ "arm64.nopauth",
+	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
+	  "id_aa64isar1.api=0 id_aa64isar1.apa=0"	   },
 	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
-- 
2.29.2

