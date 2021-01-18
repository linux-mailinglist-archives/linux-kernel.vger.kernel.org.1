Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692F52FACCD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394801AbhARVh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389452AbhARKDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF8122B47;
        Mon, 18 Jan 2021 10:00:35 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6s-008RhD-Rx; Mon, 18 Jan 2021 09:46:06 +0000
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
Subject: [PATCH v4 10/21] arm64: cpufeature: Use IDreg override in __read_sysreg_by_encoding()
Date:   Mon, 18 Jan 2021 09:45:22 +0000
Message-Id: <20210118094533.2874082-11-maz@kernel.org>
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

__read_sysreg_by_encoding() is used by a bunch of cpufeature helpers,
which should take the feature override into account. Let's do that.

For a good measure (and because we are likely to need to further
down the line), make this helper available to the rest of the
non-modular kernel.

Code that needs to know the *real* features of a CPU can still
use read_sysreg_s(), and find the bare, ugly truth.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 465d2cb63bfc..fe0130d6c0ff 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -602,6 +602,7 @@ void __init setup_cpu_features(void);
 void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
+u64 __read_sysreg_by_encoding(u32 sys_id);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aaa075c6f029..48a011935d8c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1149,14 +1149,17 @@ u64 read_sanitised_ftr_reg(u32 id)
 EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
-	case r:		return read_sysreg_s(r)
+	case r:		val = read_sysreg_s(r); break;
 
 /*
  * __read_sysreg_by_encoding() - Used by a STARTING cpu before cpuinfo is populated.
  * Read the system register on the current CPU
  */
-static u64 __read_sysreg_by_encoding(u32 sys_id)
+u64 __read_sysreg_by_encoding(u32 sys_id)
 {
+	struct arm64_ftr_reg *regp;
+	u64 val;
+
 	switch (sys_id) {
 	read_sysreg_case(SYS_ID_PFR0_EL1);
 	read_sysreg_case(SYS_ID_PFR1_EL1);
@@ -1199,6 +1202,14 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 		BUG();
 		return 0;
 	}
+
+	regp  = get_arm64_ftr_reg(sys_id);
+	if (regp && regp->override_mask && regp->override_val) {
+		val &= ~*regp->override_mask;
+		val |= (*regp->override_val & *regp->override_mask);
+	}
+
+	return val;
 }
 
 #include <linux/irqchip/arm-gic-v3.h>
-- 
2.29.2

