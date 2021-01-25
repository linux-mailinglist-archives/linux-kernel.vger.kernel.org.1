Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D7302428
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbhAYLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbhAYLEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:04:47 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C39822D50;
        Mon, 25 Jan 2021 10:53:50 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l3zS6-009rDe-SV; Mon, 25 Jan 2021 10:50:35 +0000
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
Subject: [PATCH v5 12/21] arm64: cpufeature: Add an early command-line cpufeature override facility
Date:   Mon, 25 Jan 2021 10:50:10 +0000
Message-Id: <20210125105019.2946057-13-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125105019.2946057-1-maz@kernel.org>
References: <20210125105019.2946057-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to override CPU features at boot time,
let's add a command line parser that matches options of the
form "cpureg.feature=value", and store the corresponding
value into the override val/mask pair.

No features are currently defined, so no expected change in
functionality.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/head.S           |   1 +
 arch/arm64/kernel/idreg-override.c | 130 +++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/idreg-override.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 86364ab6f13f..2262f0392857 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o
+			   syscall.o proton-pack.o idreg-override.o
 
 targets			+= efi-entry.o
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d74e5f84042e..3243e3ae9bd8 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -435,6 +435,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 
 	mov	x0, x21				// pass FDT address in x0
 	bl	early_fdt_map			// Try mapping the FDT early
+	bl	init_feature_override
 	bl	switch_to_vhe
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
new file mode 100644
index 000000000000..2d184d6674fd
--- /dev/null
+++ b/arch/arm64/kernel/idreg-override.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Early cpufeature override framework
+ *
+ * Copyright (C) 2020 Google LLC
+ * Author: Marc Zyngier <maz@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+
+#include <asm/cacheflush.h>
+#include <asm/setup.h>
+
+struct ftr_set_desc {
+	const char 			*name;
+	struct arm64_ftr_override	*override;
+	struct {
+		const char 		*name;
+		u8			shift;
+	} 				fields[];
+};
+
+static const struct ftr_set_desc * const regs[] __initdata = {
+};
+
+static char *cmdline_contains_option(const char *cmdline, const char *option)
+{
+	char *str = strstr(cmdline, option);
+
+	if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')))
+		return str;
+
+	return NULL;
+}
+
+static int __init find_field(const char *cmdline,
+			     const struct ftr_set_desc *reg, int f, u64 *v)
+{
+	char buf[256], *str;
+	size_t len;
+
+	snprintf(buf, ARRAY_SIZE(buf), "%s.%s=", reg->name, reg->fields[f].name);
+
+	str = cmdline_contains_option(cmdline, buf);
+	if (!str)
+		return -1;
+
+	str += strlen(buf);
+	len = strcspn(str, " ");
+	len = min(len, ARRAY_SIZE(buf) - 1);
+	strncpy(buf, str, len);
+	buf[len] = 0;
+
+	return kstrtou64(buf, 0, v);
+}
+
+static void __init match_options(const char *cmdline)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		int f;
+
+		if (!regs[i]->override)
+			continue;
+
+		for (f = 0; regs[i]->fields[f].name; f++) {
+			u64 v;
+
+			if (find_field(cmdline, regs[i], f, &v))
+				continue;
+
+			regs[i]->override->val  |= (v & 0xf) << regs[i]->fields[f].shift;
+			regs[i]->override->mask |= 0xfUL << regs[i]->fields[f].shift;
+		}
+	}
+}
+
+static __init void parse_cmdline(void)
+{
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		const u8 *prop;
+		void *fdt;
+		int node;
+
+		fdt = get_early_fdt_ptr();
+		if (!fdt)
+			goto out;
+
+		node = fdt_path_offset(fdt, "/chosen");
+		if (node < 0)
+			goto out;
+
+		prop = fdt_getprop(fdt, node, "bootargs", NULL);
+		if (!prop)
+			goto out;
+
+		match_options(prop);
+
+		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+			return;
+	}
+
+out:
+	match_options(CONFIG_CMDLINE);
+}
+
+/* Keep checkers quiet */
+void init_feature_override(void);
+
+asmlinkage void __init init_feature_override(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		if (regs[i]->override) {
+			regs[i]->override->val  = 0;
+			regs[i]->override->mask = 0;
+		}
+	}
+
+	parse_cmdline();
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		if (regs[i]->override)
+			__flush_dcache_area(regs[i]->override,
+					    sizeof(*regs[i]->override));
+	}
+}
-- 
2.29.2

