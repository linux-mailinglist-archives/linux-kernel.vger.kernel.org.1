Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8622FACC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbhARVgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389451AbhARKDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 382EF22B40;
        Mon, 18 Jan 2021 10:00:33 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6w-008RhD-F5; Mon, 18 Jan 2021 09:46:11 +0000
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
Subject: [PATCH v4 15/21] arm64: Add an aliasing facility for the idreg override
Date:   Mon, 18 Jan 2021 09:45:27 +0000
Message-Id: <20210118094533.2874082-16-maz@kernel.org>
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

In order to map the override of idregs to options that a user
can easily understand, let's introduce yet another option
array, which maps an option to the corresponding idreg options.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 75d9845f489b..16bc8b3b93ae 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -37,6 +37,12 @@ static const struct reg_desc * const regs[] __initdata = {
 	&mmfr1,
 };
 
+static const struct {
+	const char * const	alias;
+	const char * const	feature;
+} aliases[] __initdata = {
+};
+
 static int __init find_field(const char *cmdline, const struct reg_desc *reg,
 			     int f, u64 *v)
 {
@@ -80,6 +86,18 @@ static void __init match_options(const char *cmdline)
 	}
 }
 
+static __init void match_aliases(const char *cmdline)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aliases); i++) {
+		char *str = strstr(cmdline, aliases[i].alias);
+
+		if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')))
+			match_options(aliases[i].feature);
+	}
+}
+
 static __init void parse_cmdline(void)
 {
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
@@ -100,6 +118,7 @@ static __init void parse_cmdline(void)
 			goto out;
 
 		match_options(prop);
+		match_aliases(prop);
 
 		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
 			return;
@@ -107,6 +126,7 @@ static __init void parse_cmdline(void)
 
 out:
 	match_options(CONFIG_CMDLINE);
+	match_aliases(CONFIG_CMDLINE);
 }
 
 void __init init_shadow_regs(void)
-- 
2.29.2

