Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C772529EEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJ2O7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgJ2O7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:59:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE54C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:59:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so1423100ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRwqyoyBEeMity0cyda+uu/rJEIK2HXvyD5N7tr1KQA=;
        b=VaV6/Go+khoksNqGfCUHDeBSHVzAJEA+svM5XJTrMpaiwQW5OlTmX/9P+0AhI2Wgrc
         eaYH6kMXDCKlBsBdwgq0a2AvqpQJFku5TSiBp8O9O1W6GvFJvEqB0WWZiW7gaMNQT2PN
         JjueUsyk1j1ZDQ4eRWBrzvLUpzbK6D7wXp99Ea6n2DFJoqRpGOqqVsM7B4ahs+rEim/x
         7GCHwMuXp3+jVVF5LWSemEJME2d/XEGagujBza5F+oXi2yDsg2/yn7tJa2lMuruEsQyG
         zzn4vNRJTm1+P8cplXnjZhqwceqWIQYRcmtckz5f8cQH8CuKEpDZGwf2pC+80kwUCRzu
         /OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vRwqyoyBEeMity0cyda+uu/rJEIK2HXvyD5N7tr1KQA=;
        b=A+ECdSx4yRFBrz7SiVshaU2+RjjwBeZW+vB1QuMh+Jb9WzpiHABomg4B41JQJ5fA1C
         sfFJWeb5h/6lhhGPkDd3+5EipckoJnB78mcCE7n3EeC7yf+lwhW3xMA0Z6PSTlsCWloL
         18xXY3GKn3dxbL5oSJ3foVvp1/5YWLC51nWRmds0WZj7QKSXYQq5WVqng2HqXoU2TFkr
         fyKiVCiZhUpkDfeyB118Oxpzxpd4O7Iz7LSoYPfwFGGbSVf6MSJMDrC6YbKvSur45I1B
         r4fjs+A6lNOLDa59dRHZ5ktL0SqL4/GCGzSIaICoBsAqAAiR5BYY56gBFNGVDTSJBT5K
         JgrA==
X-Gm-Message-State: AOAM5327eyyXoCOUOatxdBxtUnxvp9UZLSeHTmDtRMi0+10rG36hevtV
        TV8L+1pp17VQzZIa/33jNx13OA==
X-Google-Smtp-Source: ABdhPJyZHAWcF9UXIuaciASbmUM2nhi5xQ3CWgJ6UeAed6E2uiOLILawF0T8+k3uKF2R+aWSxlR5CA==
X-Received: by 2002:a17:902:7c86:b029:d5:f680:f756 with SMTP id y6-20020a1709027c86b02900d5f680f756mr4717679pll.39.1603983543591;
        Thu, 29 Oct 2020 07:59:03 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:59:02 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, msys.mizuma@gmail.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 6/7] kgdb: roundup: Allow runtime arch specific override
Date:   Thu, 29 Oct 2020 20:26:26 +0530
Message-Id: <1603983387-8738-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new API kgdb_arch_roundup_cpus() for a particular archichecture to
override default kgdb roundup and if it detects at runtime to not support
NMI roundup then it can fallback to default implementation using async
SMP cross-calls.

Currently such an architecture example is arm64 supporting pseudo NMIs
feature which is only available on platforms which have support for GICv3
or later version.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/powerpc/kernel/kgdb.c |  3 ++-
 arch/sparc/kernel/smp_64.c |  3 ++-
 arch/x86/kernel/kgdb.c     |  6 ++++--
 include/linux/kgdb.h       |  5 +++--
 kernel/debug/debug_core.c  | 10 +++++++++-
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 4090802..126575d 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -125,9 +125,10 @@ static int kgdb_debugger_ipi(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-void kgdb_roundup_cpus(void)
+bool kgdb_arch_roundup_cpus(void)
 {
 	smp_send_debugger_break();
+	return true;
 }
 #endif
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e38d8bf..c459c83 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1014,9 +1014,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 }
 
 #ifdef CONFIG_KGDB
-void kgdb_roundup_cpus(void)
+bool kgdb_arch_roundup_cpus(void)
 {
 	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
+	return true;
 }
 #endif
 
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index ff7878d..1b756d9 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -404,7 +404,8 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 
 #ifdef CONFIG_SMP
 /**
- *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
+ *	kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
+ *				 in an architectural specific manner
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them be in a known state.  This should do what is needed
@@ -414,9 +415,10 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  *
  *	On non-SMP systems, this is not called.
  */
-void kgdb_roundup_cpus(void)
+bool kgdb_arch_roundup_cpus(void)
 {
 	apic_send_IPI_allbutself(NMI_VECTOR);
+	return true;
 }
 #endif
 
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 0d6cf64..f9db5b8 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -200,7 +200,8 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 extern void kgdb_call_nmi_hook(void *ignored);
 
 /**
- *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
+ *	kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
+ *				 in an architectural specific manner
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them into a known state.  This should do what is needed
@@ -210,7 +211,7 @@ extern void kgdb_call_nmi_hook(void *ignored);
  *
  *	On non-SMP systems, this is not called.
  */
-extern void kgdb_roundup_cpus(void);
+extern bool kgdb_arch_roundup_cpus(void);
 
 /**
  *	kgdb_arch_set_pc - Generic call back to the program counter
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1e75a89..27e401c 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -241,13 +241,21 @@ void __weak kgdb_call_nmi_hook(void *ignored)
 }
 NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 
-void __weak kgdb_roundup_cpus(void)
+bool __weak kgdb_arch_roundup_cpus(void)
+{
+	return false;
+}
+
+static void kgdb_roundup_cpus(void)
 {
 	call_single_data_t *csd;
 	int this_cpu = raw_smp_processor_id();
 	int cpu;
 	int ret;
 
+	if (kgdb_arch_roundup_cpus())
+		return;
+
 	for_each_online_cpu(cpu) {
 		/* No need to roundup ourselves */
 		if (cpu == this_cpu)
-- 
2.7.4

