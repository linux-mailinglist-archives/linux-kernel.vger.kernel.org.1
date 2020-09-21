Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0827355B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgIUV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:57:01 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68169C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:57:01 -0700 (PDT)
Received: from [2400:4160:1877:2b00:5573:e9d:4014:d922] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1kKTnp-0002iA-3R; Mon, 21 Sep 2020 21:56:54 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <glandium@goemon>)
        id 1kKTnj-0009tL-Tj; Tue, 22 Sep 2020 06:56:47 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mike Hommey <mh@glandium.org>
Subject: [PATCH v3] x86/boot: Handle fpu-related and clearcpuid command line arguments earlier
Date:   Tue, 22 Sep 2020 06:56:38 +0900
Message-Id: <20200921215638.37980-1-mh@glandium.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921131005.GF5901@zn.tnic>
References: <20200921131005.GF5901@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RDNS_NONE,SPF_FAIL,SPF_HELO_FAIL autolearn=disabled version=3.4.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU initialization handles them currently. However, in the case of
clearcpuid, some other early initialization code may check for features
before the FPU initialization code is called. Handling the argument
earlier allows the command line to influence those early
initializations.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 arch/x86/kernel/cpu/common.c | 55 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/fpu/init.c   | 55 ------------------------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8d4715e84268..6220fae87263 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -23,6 +23,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
 
+#include <asm/cmdline.h>
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
@@ -1220,6 +1221,59 @@ static void detect_nopl(void)
 #endif
 }
 
+/*
+ * We parse cpu parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init cpu_parse_early_param(void)
+{
+	char arg[128];
+	char *argptr = arg;
+	int arglen, res, bit;
+
+#ifdef CONFIG_X86_32
+	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
+		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
+		setup_clear_cpu_cap(X86_FEATURE_FXSR);
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
+
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+
+	pr_info("Clearing CPUID bits:");
+	do {
+		res = get_option(&argptr, &bit);
+		if (res == 0 || res == 3)
+			break;
+
+		/* If the argument was too long, the last bit may be cut off */
+		if (res == 1 && arglen >= sizeof(arg))
+			break;
+
+		if (bit >= 0 && bit < NCAPINTS * 32) {
+			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			setup_clear_cpu_cap(bit);
+		}
+	} while (res == 2);
+	pr_cont("\n");
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1255,6 +1309,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_cap(c);
 		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		cpu_parse_early_param();
 
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index f8ff895aaf7e..701f196d7c68 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,7 +5,6 @@
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
-#include <asm/cmdline.h>
 
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -237,66 +236,12 @@ static void __init fpu__init_system_ctx_switch(void)
 	on_boot_cpu = 0;
 }
 
-/*
- * We parse fpu parameters early because fpu__init_system() is executed
- * before parse_early_param().
- */
-static void __init fpu__init_parse_early_param(void)
-{
-	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
-
-#ifdef CONFIG_X86_32
-	if (cmdline_find_option_bool(boot_command_line, "no387"))
-#ifdef CONFIG_MATH_EMULATION
-		setup_clear_cpu_cap(X86_FEATURE_FPU);
-#else
-		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
-		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
-
-	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
-
-	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
-
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
-
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
-			setup_clear_cpu_cap(bit);
-		}
-	} while (res == 2);
-	pr_cont("\n");
-}
-
 /*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
-	fpu__init_parse_early_param();
 	fpu__init_system_early_generic(c);
 
 	/*
-- 
2.28.0

