Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9A27156E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 11:42:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54296C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 08:42:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f295d00e5d202e3eda3e8ee.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:5d00:e5d2:2e3:eda3:e8ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59B4B1EC0249;
        Sun, 20 Sep 2020 17:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600616555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=3b/RE3ZMasj0TFhiWS7CP4z6SfyNr1Q2Kc+v2J/PudE=;
        b=BQzk2DuplAAhNuBJPQcW2gkFF+np91wxWeAeyRrok8L1fIfrLUgvrzimBcMxf3iPG5+lA5
        GQd96ckPLPs0lbUWP2haRDTWRiSNQRWl5g9NGNHVN7n9nOM0Q0wgoJYylSIymZD5CaGan3
        6MujZ42y8Wq47qhV5gMTyTxEdj+NN98=
Date:   Sun, 20 Sep 2020 17:42:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200920154228.GB7473@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so tglx hates this clearcpuid= interface where you have to give the
X86_FEATURE array indices in order to disable a feature bit for testing.
Below is a first attempt (lightly tested in a VM only) to accept the bit
names from /proc/cpuinfo too.

I say "too" because not all feature bits have names and we would still
have to support the numbers. Yeah, yuck.

An exemplary cmdline would then be something like:

clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
purpose).

and it says:

[    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow

Also, I'm thinking we should taint the kernel when this option is used.

Thoughts?

---
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 59bf91c57aa8..10b65045fc37 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -32,14 +32,17 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 };
 
+#define X86_CAP_FMT_BARE "%d:%d"
+#define x86_cap_flag_bare(flag) ((flag) >> 5), ((flag) & 31)
+
 #ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
 #else
-#define X86_CAP_FMT "%d:%d"
-#define x86_cap_flag(flag) ((flag) >> 5), ((flag) & 31)
+#define X86_CAP_FMT X86_CAP_FMT_BARE
+#define x86_cap_flag(flag) x86_cap_flag_bare((flag))
 #endif
 
 /*
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index f8ff895aaf7e..17be3c99b65d 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -244,8 +244,8 @@ static void __init fpu__init_system_ctx_switch(void)
 static void __init fpu__init_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, bit, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -273,21 +273,45 @@ static void __init fpu__init_parse_early_param(void)
 		return;
 
 	pr_info("Clearing CPUID bits:");
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
+
+	while (argptr) {
+		int i;
+
+		opt = (strsep(&argptr, ","));
+		if (!opt)
+			continue;
+
+		if (!kstrtoint(opt, 10, &bit)) {
+			if (bit >= 0 && bit < NCAPINTS * 32) {
+				if (!x86_cap_flag(bit))
+					pr_cont(" " X86_CAP_FMT_BARE, x86_cap_flag_bare(bit));
+				else
+					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+
+				setup_clear_cpu_cap(bit);
+				taint++;
+				continue;
+			}
 		}
-	} while (res == 2);
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+		for (i = 0; i < 32 * NCAPINTS; i++) {
+			if (!x86_cap_flags[i])
+				continue;
+
+			if (strcmp(x86_cap_flags[i], opt))
+				continue;
+
+			pr_cont(" %s", opt);
+			setup_clear_cpu_cap(i);
+			taint++;
+		}
+#endif
+	}
 	pr_cont("\n");
+
+	if (taint)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 /*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
