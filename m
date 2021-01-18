Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992462F9CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbhARKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388298AbhARJsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:48:40 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E068322AAC;
        Mon, 18 Jan 2021 09:46:07 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6s-008RhD-5m; Mon, 18 Jan 2021 09:46:06 +0000
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
Subject: [PATCH v4 09/21] arm64: cpufeature: Add global feature override facility
Date:   Mon, 18 Jan 2021 09:45:21 +0000
Message-Id: <20210118094533.2874082-10-maz@kernel.org>
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

Add a facility to globally override a feature, no matter what
the HW says. Yes, this sounds dangerous, but we do respect the
"safe" value for a given feature. This doesn't mean the user
doesn't need to know what they are doing.

Nothing uses this yet, so we are pretty safe. For now.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 44 +++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9a555809b89c..465d2cb63bfc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -75,6 +75,8 @@ struct arm64_ftr_reg {
 	u64				sys_val;
 	u64				user_val;
 	const struct arm64_ftr_bits	*ftr_bits;
+	u64				*override_val;
+	u64				*override_mask;
 };
 
 extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e99eddec0a46..aaa075c6f029 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -544,13 +544,17 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 	ARM64_FTR_END,
 };
 
-#define ARM64_FTR_REG(id, table) {		\
-	.sys_id = id,				\
-	.reg = 	&(struct arm64_ftr_reg){	\
-		.name = #id,			\
-		.ftr_bits = &((table)[0]),	\
+#define ARM64_FTR_REG_OVERRIDE(id, table, v, m) {		\
+		.sys_id = id,					\
+		.reg = 	&(struct arm64_ftr_reg){		\
+			.name = #id,				\
+			.ftr_bits = &((table)[0]),		\
+			.override_val = v,			\
+			.override_mask = m,			\
 	}}
 
+#define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, NULL, NULL)
+
 static const struct __ftr_reg_entry {
 	u32			sys_id;
 	struct arm64_ftr_reg 	*reg;
@@ -760,6 +764,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	u64 strict_mask = ~0x0ULL;
 	u64 user_mask = 0;
 	u64 valid_mask = 0;
+	u64 override_val = 0, override_mask = 0;
 
 	const struct arm64_ftr_bits *ftrp;
 	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
@@ -767,9 +772,38 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	if (!reg)
 		return;
 
+	if (reg->override_mask && reg->override_val) {
+		override_mask = *reg->override_mask;
+		override_val = *reg->override_val;
+	}
+
 	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
 		u64 ftr_mask = arm64_ftr_mask(ftrp);
 		s64 ftr_new = arm64_ftr_value(ftrp, new);
+		s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
+
+		if ((ftr_mask & override_mask) == ftr_mask) {
+			s64 tmp = arm64_ftr_safe_value(ftrp, ftr_ovr, ftr_new);
+			char *str = NULL;
+
+			if (ftr_ovr != tmp) {
+				/* Unsafe, remove the override */
+				*reg->override_mask &= ~ftr_mask;
+				*reg->override_val &= ~ftr_mask;
+				tmp = ftr_ovr;
+				str = "ignoring override";
+			} else if (ftr_new != tmp) {
+				/* Override was valid */
+				ftr_new = tmp;
+				str = "forced";
+			}
+
+			if (str)
+				pr_warn("%s[%d:%d]: %s to %llx\n",
+					reg->name,
+					ftrp->shift + ftrp->width - 1,
+					ftrp->shift, str, tmp);
+		}
 
 		val = arm64_ftr_set_value(ftrp, val, ftr_new);
 
-- 
2.29.2

