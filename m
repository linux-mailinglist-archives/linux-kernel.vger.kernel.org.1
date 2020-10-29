Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887E629EEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJ2O7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgJ2O7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:59:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F284C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:59:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so1402036plx.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2BcD1V2PWIC84tedyjPNBhOL9YmKQfq2/p2+3YKmlM=;
        b=n+vTpMTQwDqndje9E2gUY+QXt7Qn9stwgTDRJVc0Cb2sT9hBHygE98lnxVG0ts+MDi
         /o6XKBcMYGUY+P667hm/S4Q4mSnWcAPronjlvdfnJM73yqvIfjttWAKSf5Jskef3zhN0
         evwSzWN0/Y7S52GsN5KSLAgUTXGLSclADgHcOAWt0/aDq2JzFi3aacKFk49xlKIB/3on
         3TC13ZIo2vI9A2lDoROQlyqL2+IdRMfsRKM4bj8eua2ExXB55m4eeSeLvshwkQK9G8YN
         I5xYYQGNNIb4u0pOelBmyBqijvUZzbzPvPVE1l3zQupUh/v/3fQZuFt5Bft8kuOlOIJ9
         BtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p2BcD1V2PWIC84tedyjPNBhOL9YmKQfq2/p2+3YKmlM=;
        b=PAp8CqZhIhjIZkyEPzwxW4ftXcdiTwB0MricBCkJ88BTizOq/t8lsgbrsfM7KRlyVO
         Od4cWy/Bx1Km8A7O+h+llwhMZTQCd0jGhmqApzcl1LcLqp1fTPvrBpu3HkswGY72BJbJ
         U/eBlMFXQzcLVOTjdiQd2ioCHUA590kPWRSei0PTnpnFo/q2tn5X9s3B5SxJUAnaXkWy
         DrpKn4+Ss1jghxv31qgeLt4Cw5KNS5W2FBqQAeOkgrCAgnLRTvkwJGKzG4B3Shtb4iDb
         2zLNfZqGvRQhuDyFFcIx4l2CHBJRlv19rGacEmU0JlfADdGRyQd4A/Qfchllomm/oh5D
         tFiw==
X-Gm-Message-State: AOAM533mu64grKS0bdr1MBQCd86fJlKnlwTzNOKchfLCQ5R9/wdYJFmT
        CVOu2WlEnle9Ee3ih+XT+gnk5vZtC/YMzA==
X-Google-Smtp-Source: ABdhPJwzdKIE9Z+RU535miYWHiUs7hW+ACKuH9/ZGTNzlFy1YROrCmeOP6o4woJU5feSQy9V41Wcyg==
X-Received: by 2002:a17:902:bf43:b029:d6:19b1:7942 with SMTP id u3-20020a170902bf43b02900d619b17942mr4289008pls.61.1603983552904;
        Thu, 29 Oct 2020 07:59:12 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:59:12 -0700 (PDT)
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
Subject: [PATCH v6 7/7] arm64: kgdb: Roundup cpus using IPI as NMI
Date:   Thu, 29 Oct 2020 20:26:27 +0530
Message-Id: <1603983387-8738-8-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to roundup CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to roundup CPUs using IPI turned as NMI. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
it will switch back to default kgdb CPUs roundup mechanism.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/kgdb.h |  9 +++++++++
 arch/arm64/kernel/ipi_nmi.c   |  5 +++++
 arch/arm64/kernel/kgdb.c      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e..c3d2425 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,15 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+#ifdef CONFIG_KGDB
+extern bool kgdb_ipi_nmicallback(int cpu, void *regs);
+#else
+static inline bool kgdb_ipi_nmicallback(int cpu, void *regs)
+{
+	return false;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 597dcf7..6ace182 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/nmi.h>
 #include <linux/smp.h>
 
@@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
+	unsigned int cpu = smp_processor_id();
 
 	if (nmi_cpu_backtrace(get_irq_regs()))
 		ret = IRQ_HANDLED;
 
+	if (kgdb_ipi_nmicallback(cpu, get_irq_regs()))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca3..c26e710 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -353,3 +354,37 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+bool kgdb_ipi_nmicallback(int cpu, void *regs)
+{
+	if (atomic_read(&kgdb_active) != -1) {
+		kgdb_nmicallback(cpu, regs);
+		return true;
+	}
+
+	return false;
+}
+
+static void kgdb_smp_callback(void *data)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(cpu, get_irq_regs());
+}
+
+bool kgdb_arch_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	if (!arm64_supports_nmi())
+		return false;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return false;
+
+	arm64_send_nmi(&mask);
+	return true;
+}
-- 
2.7.4

