Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD252A29C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKBLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgKBLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:46:40 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so10885452pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JyvPCaqqbOYfCXpYx0pOVqmUQ12hYhEPEwMON22pNjk=;
        b=uCcmpbkowm5jgVzKL5iyPFHUhu/8J3iCv9LXeYwdXeL0hGI1Lcu7XVewGbCxodYOqi
         Uf67FbBxpsW5SKTmkpPHTDL0w4EiYZX7WMblNDDAm4+FSg4Hs+wZ9Sz70B3pUHPF0oQn
         44q18yg4+jIlgmULBSgTvbTsnwRC7b+YmVZjZXlDoYyc85PDhTsi+645DPsajTudK96v
         mNa/J+dBSFYD1BopcjX4zTxQY5Om0JD0iUcYMz9arNALeRncogCniUb1qlIj+sC1q+2m
         7DmOPf0nu6RNqv7qF4L0V8P1R/n2xF3qKsCA1IbccTPBH7b0sTq75OoLX8vrU91wvE4Q
         bFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JyvPCaqqbOYfCXpYx0pOVqmUQ12hYhEPEwMON22pNjk=;
        b=OMp+3xpL6h6CwIBnebjlfM6EM5A+QWG8DjKcZWQVeDWYpg4XRb1q8UfeMXTC1MUw9t
         7CgdbqS/cQBoLon5Tjd6jUsnAzKzSz055d3I6dDehYlIL/raIYB0myz2k002/0qxJy/y
         grILsF4hY5GxaiKUd9n8JsxwCMRTU+omcyMK2cnimOL6ItNDhDUznxfH3DdCy6a6R93w
         XFMVi05OEqzk4ufmGOszRdCyO6uLQfZGGfEXyGpqnxCfTAZu/JJUBIyPLHb+MHttEnOh
         uubuCxDPYzPZFeixtbcNu1o4vQajrRHfRbKyEnXklWCF7luTmctUnIVCFO1cg3e15Q/q
         s3+Q==
X-Gm-Message-State: AOAM532LO53FdfuixJ8uhwGCl32EHoh0PnJtdyRRFYW+2/rs4qOzrtVs
        GttKXQW13sdZBD8n6IQAyr/XVA==
X-Google-Smtp-Source: ABdhPJxya51ixKRZ4J+w5F3LFYNiyvEMS5yCU1E+CoRLMD+YzEfvZmLOlP27VhF4kmnTj0B5cnUOLQ==
X-Received: by 2002:a17:90b:111:: with SMTP id p17mr17762114pjz.159.1604317600138;
        Mon, 02 Nov 2020 03:46:40 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.46.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:46:39 -0800 (PST)
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
Subject: [PATCH v7 7/7] arm64: kgdb: Roundup cpus using IPI as NMI
Date:   Mon,  2 Nov 2020 17:14:47 +0530
Message-Id: <1604317487-14543-8-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
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
 arch/arm64/kernel/ipi_nmi.c |  5 +++++
 arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 597dcf7..898d69c 100644
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
 
+	if (!kgdb_nmicallback(cpu, get_irq_regs()))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca3..371b176 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -353,3 +354,20 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	if (!arm64_supports_nmi()) {
+		kgdb_smp_call_nmi_hook();
+		return;
+	}
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arm64_send_nmi(&mask);
+}
-- 
2.7.4

