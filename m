Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA32FACCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394793AbhARVhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389447AbhARKDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC2A22AB0;
        Mon, 18 Jan 2021 10:00:26 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6z-008RhD-RY; Mon, 18 Jan 2021 09:46:14 +0000
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
Subject: [PATCH v4 18/21] arm64: Move "nokaslr" over to the early cpufeature infrastructure
Date:   Mon, 18 Jan 2021 09:45:30 +0000
Message-Id: <20210118094533.2874082-19-maz@kernel.org>
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

Given that the early cpufeature infrastructure has borrowed quite
a lot of code from the kaslr implementation, let's reimplement
the matching of the "nokaslr" option with it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++
 arch/arm64/kernel/kaslr.c          | 37 +++---------------------------
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 1db54878b2c4..143fe7b8e3ce 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -33,8 +33,24 @@ static const struct reg_desc mmfr1 __initdata = {
 	},
 };
 
+extern u64 kaslr_feature_val;
+extern u64 kaslr_feature_mask;
+
+static const struct reg_desc kaslr __initdata = {
+	.name		= "kaslr",
+#ifdef CONFIG_RANDOMIZE_BASE
+	.val		= &kaslr_feature_val,
+	.mask		= &kaslr_feature_mask,
+#endif
+	.fields		= {
+		{ "disabled", 0 },
+		{}
+	},
+};
+
 static const struct reg_desc * const regs[] __initdata = {
 	&mmfr1,
+	&kaslr,
 };
 
 static const struct {
@@ -43,6 +59,7 @@ static const struct {
 } aliases[] __initdata = {
 	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
 	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
+	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
 static int __init find_field(const char *cmdline, const struct reg_desc *reg,
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 5fc86e7d01a1..dcc4a5aadbe2 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -51,39 +51,8 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init bool cmdline_contains_nokaslr(const u8 *cmdline)
-{
-	const u8 *str;
-
-	str = strstr(cmdline, "nokaslr");
-	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
-}
-
-static __init bool is_kaslr_disabled_cmdline(void *fdt)
-{
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		int node;
-		const u8 *prop;
-
-		node = fdt_path_offset(fdt, "/chosen");
-		if (node < 0)
-			goto out;
-
-		prop = fdt_getprop(fdt, node, "bootargs", NULL);
-		if (!prop)
-			goto out;
-
-		if (cmdline_contains_nokaslr(prop))
-			return true;
-
-		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
-			goto out;
-
-		return false;
-	}
-out:
-	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
-}
+u64 kaslr_feature_val __initdata;
+u64 kaslr_feature_mask __initdata;
 
 /*
  * This routine will be executed with the kernel mapped at its default virtual
@@ -126,7 +95,7 @@ u64 __init kaslr_early_init(void)
 	 * Check if 'nokaslr' appears on the command line, and
 	 * return 0 if that is the case.
 	 */
-	if (is_kaslr_disabled_cmdline(fdt)) {
+	if (kaslr_feature_val & kaslr_feature_mask & 0xf) {
 		kaslr_status = KASLR_DISABLED_CMDLINE;
 		return 0;
 	}
-- 
2.29.2

