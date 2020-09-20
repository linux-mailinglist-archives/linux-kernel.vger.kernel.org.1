Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F61271858
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgITWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:00:55 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:00:54 -0700 (PDT)
Received: from [2400:4160:1877:2b00:3dc4:3545:b496:6a29] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1kK7O1-0005Fd-Kz; Sun, 20 Sep 2020 22:00:46 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <glandium@goemon>)
        id 1kK7Nv-0001xE-Ia; Mon, 21 Sep 2020 07:00:39 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mike Hommey <mh@glandium.org>
Subject: [PATCH v2] x86/boot: Handle fpu-related and clearcpuid command line arguments earlier
Date:   Mon, 21 Sep 2020 07:00:36 +0900
Message-Id: <20200920220036.7469-1-mh@glandium.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920083626.GA7473@zn.tnic>
References: <20200920083626.GA7473@zn.tnic>
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
 arch/x86/kernel/cpu/common.c | 41 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/fpu/init.c   | 41 ------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..5e2e4d3621bd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -23,6 +23,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
 
+#include <asm/cmdline.h>
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
@@ -1220,6 +1221,45 @@ static void detect_nopl(void)
 #endif
 }
 
+/*
+ * We parse cpu parameters early because early_identify_cpu() is executed
+ * before parse_early_param().
+ */
+static void __init cpu__init_parse_early_param(void)
+{
+	char arg[32];
+	char *argptr = arg;
+	int bit;
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
+	if (cmdline_find_option(boot_command_line, "clearcpuid", arg,
+				sizeof(arg)) &&
+	    get_option(&argptr, &bit) &&
+	    bit >= 0 &&
+	    bit < NCAPINTS * 32)
+		setup_clear_cpu_cap(bit);
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1255,6 +1295,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_cap(c);
 		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		cpu__init_parse_early_param();
 
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 61ddc3a5e5c2..701f196d7c68 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,7 +5,6 @@
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
-#include <asm/cmdline.h>
 
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -237,52 +236,12 @@ static void __init fpu__init_system_ctx_switch(void)
 	on_boot_cpu = 0;
 }
 
-/*
- * We parse fpu parameters early because fpu__init_system() is executed
- * before parse_early_param().
- */
-static void __init fpu__init_parse_early_param(void)
-{
-	char arg[32];
-	char *argptr = arg;
-	int bit;
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
-	if (cmdline_find_option(boot_command_line, "clearcpuid", arg,
-				sizeof(arg)) &&
-	    get_option(&argptr, &bit) &&
-	    bit >= 0 &&
-	    bit < NCAPINTS * 32)
-		setup_clear_cpu_cap(bit);
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

