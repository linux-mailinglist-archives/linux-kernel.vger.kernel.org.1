Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48D2C6A72
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgK0RNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:13:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37659 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgK0RN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:13:29 -0500
Received: by mail-qt1-f196.google.com with SMTP id l2so3677722qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWR+jnNm0NV39A++0ksVikR0mdEL/dClTzGlWVyp1Ds=;
        b=hsUB7blgTbNr0BkhavBIUMXAxT5knexeH4DwAAeTWwK1uSJT4B5UI2FJbN/osmlNvT
         iDRSALz4jLn/vicN9IbFPpdUfaoDJH5aMR5ufhvwOXaZ/UQ6ecFL2WbU7OhHych7eO93
         B1HM3QSrE8dPNwbLwMIS1Ux2q+op16tnMQvgTt9+B11ZH2epARq1MXirkOby4uBwj0wA
         7dKWy7a9+S9esvQYNri2ML7AJ2dJQOZPCeqUWQ7lfudMYKwnOSK0PqLHCGZ0LSX2niht
         7UaDtIb/b5rYc2veZ4TiC6UV0/IZ1NpJtliIBznw9rEGL5FXIPtcXkPhEnsaHApNWNer
         Ii8Q==
X-Gm-Message-State: AOAM530XRL0Hh5UpsAMKBO7UWRH47ydBxOE6c3XerMAwBRAO78JnAfM/
        SnpMz+4DAPmxcz0RTndQGwjco6BekQ5DVA==
X-Google-Smtp-Source: ABdhPJy/4lCt7cSVjFbjo1Hi5kD0Pzsc8lrliB4Fg4DVSZ3W0Y/SSOh57n3KDmv3DYBMjGopk6+43w==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr9485659qtt.136.1606497206326;
        Fri, 27 Nov 2020 09:13:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u22sm6451443qkk.51.2020.11.27.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:13:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Pu Wen <puwen@hygon.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Date:   Fri, 27 Nov 2020 12:13:24 -0500
Message-Id: <20201127171324.1846019-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  26bfa5f89486 ("x86, amd: Cleanup init_amd")
moved the code that remaps the TSEG region using 4k pages from
init_amd() to bsp_init_amd().

However, bsp_init_amd() is executed well before the direct mapping is
actually created:

  setup_arch()
    -> early_cpu_init()
      -> early_identify_cpu()
        -> this_cpu->c_bsp_init()
	  -> bsp_init_amd()
    ...
    -> init_mem_mapping()

So the change effectively disabled the 4k remapping, because
pfn_range_is_mapped() is always false at this point.

It has been over six years since the commit, and no-one seems to have
noticed this, so just remove the code. The original code was also
incomplete, since it doesn't check how large the TSEG address range
actually is, so it might remap only part of it in any case.

Hygon has copied the incorrect version, so the code has never run on it
since the cpu support was added two years ago. Remove it from there as
well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/kernel/cpu/amd.c   | 21 ---------------------
 arch/x86/kernel/cpu/hygon.c | 20 --------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f71c7616917..f8ca66f3d861 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -23,7 +23,6 @@
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
-# include <asm/set_memory.h>
 #endif
 
 #include "cpu.h"
@@ -509,26 +508,6 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
-
-#ifdef CONFIG_X86_64
-	if (c->x86 >= 0xf) {
-		unsigned long long tseg;
-
-		/*
-		 * Split up direct mapping around the TSEG SMM area.
-		 * Don't do it for gbpages because there seems very little
-		 * benefit in doing so.
-		 */
-		if (!rdmsrl_safe(MSR_K8_TSEG_ADDR, &tseg)) {
-			unsigned long pfn = tseg >> PAGE_SHIFT;
-
-			pr_debug("tseg: %010llx\n", tseg);
-			if (pfn_range_is_mapped(pfn, pfn + 1))
-				set_memory_4k((unsigned long)__va(tseg), 1);
-		}
-	}
-#endif
-
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 
 		if (c->x86 > 0x10 ||
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index dc0840aae26c..ae59115d18f9 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -14,9 +14,6 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
-#ifdef CONFIG_X86_64
-# include <asm/set_memory.h>
-#endif
 
 #include "cpu.h"
 
@@ -203,23 +200,6 @@ static void early_init_hygon_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_hygon(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
-	unsigned long long tseg;
-
-	/*
-	 * Split up direct mapping around the TSEG SMM area.
-	 * Don't do it for gbpages because there seems very little
-	 * benefit in doing so.
-	 */
-	if (!rdmsrl_safe(MSR_K8_TSEG_ADDR, &tseg)) {
-		unsigned long pfn = tseg >> PAGE_SHIFT;
-
-		pr_debug("tseg: %010llx\n", tseg);
-		if (pfn_range_is_mapped(pfn, pfn + 1))
-			set_memory_4k((unsigned long)__va(tseg), 1);
-	}
-#endif
-
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 		u64 val;
 
-- 
2.26.2

