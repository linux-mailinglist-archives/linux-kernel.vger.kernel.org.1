Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0928DFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgJNLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJNLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:13:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF06C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d6so1556976plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCAlxQYBAHJOM66Tl9XrWq4I3MFhx12/Jre9Tsla770=;
        b=TEjlQZLOxzuYSMYwL++eUGhRQeAT+WtUpGlNQjNTx7NrlyXm35SSmALugfO79ZNY6u
         xSoMGpm0cxMlXIcTrPqj0GqHNV9tAUhnAq7sjvT4AsSzNCXaSS31YamqHgQ3Bwa1y9oK
         uMtjaTEKNr/As71Et4xDgFLc4awXt9vW4zqqTjGlC+9P2DF07ZBeeYaOWIotR8ku2k3c
         FY2SKWsbquGHtvBCfIDYBbIkI3wBDpdg4AKCi2XDOG1Ac7v8WSYT7/inOyhwhbxQDoZ1
         wy1XzW7cBX0HN6uhMwhA9vJPJd6itein5OGxtz11X70UbB1kkQsQKcPftYU2aCo/oW0F
         KioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCAlxQYBAHJOM66Tl9XrWq4I3MFhx12/Jre9Tsla770=;
        b=lKBsVh9Xg48YsGuo3CUnpU41FuApzuufK0Tbiu2YMYW/yzoyd33ngqN6e6bUvNnPDG
         UyfqrvVVhM6pTeMNcoccFQwSKMll2J78x4SupIZSOJyS/+Gmv7Qq2EIktM/t47jjjvf5
         lpfjO+Rvk26JWveeww61q9iJVkcfCeex432J9BBilKclnoHwCe7yFvMSyJ7znMp+22hP
         M2guQftdrqmRbmMRq9X7y6+6PVy5/hkDnYrHmU0J3U00DDqkLHEFpXBnUnvvLAUjDOom
         YIPLwh4qSLxLEHdG4ZuJp5j+LizBvjpNN2Ad3R1gfAJFQkylk+ujC2T3XrMM/XgbwGQn
         dKdQ==
X-Gm-Message-State: AOAM532qAlvq7AsL6230WSISr482pouw/HkLNlh+KbqO9o4c4LB4LJEP
        f2DbxxG92+zFkxYr328qghv4gA==
X-Google-Smtp-Source: ABdhPJwZgJCLnB0sYHZvmp2LbPzGTwbKFKenfSU6o+4rxDcwmkwakAExJItwc5kA+H/MrkRB0LpILg==
X-Received: by 2002:a17:90a:9504:: with SMTP id t4mr3171951pjo.82.1602673992891;
        Wed, 14 Oct 2020 04:13:12 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:13:11 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 4/5] arm64: kgdb: Round up cpus using IPI as NMI
Date:   Wed, 14 Oct 2020 16:42:10 +0530
Message-Id: <1602673931-28782-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to round up CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to round up CPUs using IPI turned as NMI. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
this IPI will act as a normal IPI which maintains existing kgdb
functionality.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/kgdb.h |  8 ++++++++
 arch/arm64/kernel/ipi_nmi.c   |  5 ++++-
 arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e..6f3d3af 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+#ifdef CONFIG_KGDB
+extern void ipi_kgdb_nmicallback(int cpu, void *regs);
+#else
+static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index a959256..e0a9e03 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -26,7 +27,9 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
 
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	unsigned int cpu = smp_processor_id();
+
+	ipi_kgdb_nmicallback(cpu, get_irq_regs());
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca3..0991275 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(cpu, regs);
+}
+
+#ifdef CONFIG_SMP
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arch_send_call_nmi_func_ipi_mask(&mask);
+}
+#endif
-- 
2.7.4

