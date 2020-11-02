Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D022A29C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgKBLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgKBLqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:15 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56172C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:46:15 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so4508590pfz.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4e2yfnMR++56KFut6kOLfTQarMmYrpZq1CE3qMECL4w=;
        b=skNzlcCkdr9wzJXlmrr6gmgfHRTLV42b1oW7ebcQoKXyoXyHWWt5Jr6PVfjM9LS+Rx
         UdZOnOkUaN29N6r8/5uxtPHxugCAQfUTVF2hPdZsCgUP5qW0QehGQKN0s9v47EgkGGWu
         MjCQbhdv0IKDH66Y18dIy6JqpbCTypO1JXzmeSWS33eQBYZkn5SbUTl6HPcm0FvKw6Rf
         hMbPJU4yg8M806nYFhwlxgKDWgYut7nLY7ZAkNtAYAL5xEwfpCO7g1TjrCf1t6bqILBR
         gwUhYmBpuflxVNfRcOQj8eOZ857M4bbZ+RRC1+5yvNybwmRO4KU2pgOhsFatJCPvV3eG
         qVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4e2yfnMR++56KFut6kOLfTQarMmYrpZq1CE3qMECL4w=;
        b=NnF+EGCTjK/WFR3pjNQIvpl0U9CE9a00KGthtrNOkmC0SCbVV73323jomubW/4Z1mT
         92JB0PJhiVIX1ayG/GI2E2exmIssVgIwK0zBnezU60Hd0hN20pscY/hAuqyo08KhpcdX
         FQc4w5uPSNXboKZVoYpfmLESsgIllv5dLP3aXVVA66F0Yz4XVbtxkj5dJfvsBgmlUW8o
         DKSyNF/g1cVJnkplTc5oIc02fkz/DZuQOdLJVWFUHokhwNqE+DiKovzV7tuvBUZavBBE
         MkxjHdEO1J2PIn8Nd9bt7e0q9tp5a+OPsWXkHF855KSgTrGGagKK0nMx4+ExzO6J+ii+
         6qBg==
X-Gm-Message-State: AOAM531B1ehKBpQwsXxCCCRmkTwe5XD3sT07s3cEJuYMKOHHmD6tdIGW
        zxGc9ZbLM+wDpecTu8hQrsadvQ==
X-Google-Smtp-Source: ABdhPJxcN+aly9xBYoQsGmN+f/I9xVnYq1Ko48D+USEJqWMLjBrqoYTk1Rj65/kGBvvxlzWGdVbZ/Q==
X-Received: by 2002:a17:90b:3542:: with SMTP id lt2mr16842829pjb.187.1604317574793;
        Mon, 02 Nov 2020 03:46:14 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.46.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:46:14 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 4/7] nmi: backtrace: Allow runtime arch specific override
Date:   Mon,  2 Nov 2020 17:14:44 +0530
Message-Id: <1604317487-14543-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a boolean return to arch_trigger_cpumask_backtrace() to support a
use-case where a particular architecture detects at runtime if it supports
NMI backtrace or it would like to fallback to default implementation using
SMP cross-calls.

Currently such an architecture example is arm64 supporting pseudo NMIs
feature which is only available on platforms which have support for GICv3
or later version.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/include/asm/irq.h       |  2 +-
 arch/arm/kernel/smp.c            |  3 ++-
 arch/mips/include/asm/irq.h      |  2 +-
 arch/mips/kernel/process.c       |  3 ++-
 arch/powerpc/include/asm/nmi.h   |  2 +-
 arch/powerpc/kernel/stacktrace.c |  3 ++-
 arch/sparc/include/asm/irq_64.h  |  2 +-
 arch/sparc/kernel/process_64.c   |  4 +++-
 arch/x86/include/asm/irq.h       |  2 +-
 arch/x86/kernel/apic/hw_nmi.c    |  3 ++-
 include/linux/nmi.h              | 12 ++++--------
 11 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d4114..54b0180 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,7 +31,7 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
-extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48099c6e..bb20a43 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -856,7 +856,8 @@ static void raise_nmi(cpumask_t *mask)
 	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
+	return true;
 }
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index c5d3517..34f3b42 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -78,7 +78,7 @@ extern int cp0_fdc_irq;
 
 extern int get_c0_fdc_int(void);
 
-void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 75ebd8d..d19e672 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -735,9 +735,10 @@ static void raise_backtrace(cpumask_t *mask)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
+	return true;
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index 84b4cfe..a5eb3e2 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -9,7 +9,7 @@ static inline void arch_touch_nmi_watchdog(void) {}
 #endif
 
 #if defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
-extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index b644065..22b112a 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -264,8 +264,9 @@ static void raise_backtrace_ipi(cpumask_t *mask)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
+	return true;
 }
 #endif /* defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) */
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 4d748e9..35c01ff 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -87,7 +87,7 @@ static inline unsigned long get_softint(void)
 	return retval;
 }
 
-void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index a75093b..9182001 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -248,7 +248,7 @@ static void __global_reg_poll(struct global_reg_snapshot *gp)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	struct thread_info *tp = current_thread_info();
 	struct pt_regs *regs = get_irq_regs();
@@ -303,6 +303,8 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
 
 	spin_unlock_irqrestore(&global_cpu_snapshot_lock, flags);
+
+	return true;
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 528c8a7..b7668e0 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -47,7 +47,7 @@ extern void init_ISA_irqs(void);
 extern void __init init_IRQ(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+bool arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 34a992e..e7dcd28 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -34,10 +34,11 @@ static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 	apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self,
 				      nmi_raise_cpu_backtrace);
+	return true;
 }
 
 static int nmi_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f3..cedbfc1 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -143,26 +143,22 @@ static inline void touch_nmi_watchdog(void)
 #ifdef arch_trigger_cpumask_backtrace
 static inline bool trigger_all_cpu_backtrace(void)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, false);
-	return true;
+	return arch_trigger_cpumask_backtrace(cpu_online_mask, false);
 }
 
 static inline bool trigger_allbutself_cpu_backtrace(void)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, true);
-	return true;
+	return arch_trigger_cpumask_backtrace(cpu_online_mask, true);
 }
 
 static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
-	arch_trigger_cpumask_backtrace(mask, false);
-	return true;
+	return arch_trigger_cpumask_backtrace(mask, false);
 }
 
 static inline bool trigger_single_cpu_backtrace(int cpu)
 {
-	arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
-	return true;
+	return arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
 }
 
 /* generic implementation */
-- 
2.7.4

