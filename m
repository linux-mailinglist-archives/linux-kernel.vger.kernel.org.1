Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC29B271656
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgITRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 13:30:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgITRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:30:02 -0400
Received: from zn.tnic (p200300ec2f295d00bdfb2ba46bfb7e19.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:5d00:bdfb:2ba4:6bfb:7e19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 725891EC0249;
        Sun, 20 Sep 2020 19:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600623000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZK/pK7hyUJbvzqeprax2YuNNymLlRHB61Jw3fFVfyEE=;
        b=nxqUOgkMu/kTf6hylnqHb8H6VeTneEpGfIFC7o7PwBK6eoz4Csr36D3F+Lb58g3vyTUwNL
        MZ8XXpU2Y+tDSqRPkMo/XFBuiypyXWfsJA0//dLNa9Jd1qkw3oYYmC5688IFJHcCZWpkEZ
        QNwlpmqzK9Ub/AfFNo4AtIFCKHonEy0=
Date:   Sun, 20 Sep 2020 19:29:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200920172954.GC7473@zn.tnic>
References: <20200920154228.GB7473@zn.tnic>
 <20200920161628.GA3951950@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920161628.GA3951950@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 12:16:28PM -0400, Arvind Sankar wrote:
> Allowing 13:24 as input would be icing on the cake :)

Well, I'm kinda "meh" on that. Why, you ask?

Well, whether the user multiplies two integers or the kernel does it for
her/him, I'd prefer the user.

But that's not even the problem - whether the product of the word number
and the bit within that word, or the two supplied as a pair - either is
the wrong interface. It is ugly and not even close to even beginning to
be user-friendly.

However, we can't make it fully user-friendly yet because not all bits
have names. :-\

But you know what, that doesn't matter too because that clearcpuid=
thing is mainly for poking at sh*t and testing, not meant for users.
Thus the tainting...

So I guess the one who needs it, can go the minute distance and do the
multiplication. According to that argument, adding the string parsing is
not really needed too, but it is simple enough so WTH.

I've incorporated all your other comments, see below.

Thx!

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
index f8ff895aaf7e..98c0e571561f 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -244,8 +244,8 @@ static void __init fpu__init_system_ctx_switch(void)
 static void __init fpu__init_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -273,21 +273,48 @@ static void __init fpu__init_parse_early_param(void)
 		return;
 
 	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
 
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
+	while (argptr) {
+		unsigned int bit;
+
+		opt = strsep(&argptr, ",");
+
+		if (!kstrtouint(opt, 10, &bit)) {
+			if (bit < NCAPINTS * 32) {
+				if (!x86_cap_flag(bit))
+					pr_cont(" " X86_CAP_FMT_BARE, x86_cap_flag_bare(bit));
+				else
+					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+
+				setup_clear_cpu_cap(bit);
+				taint++;
+			}
+			/*
+			 * We're assuming there are no feature names with only
+			 * numbers in the name thus go to the next argument.
+			 */
+			continue;
+		}
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
+			if (!x86_cap_flags[bit])
+				continue;
+
+			if (strcmp(x86_cap_flags[bit], opt))
+				continue;
 
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			pr_cont(" %s", opt);
 			setup_clear_cpu_cap(bit);
+			taint++;
+			break;
 		}
-	} while (res == 2);
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
