Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E65266A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgIKVvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:51:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35599 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIKVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:24 -0400
Received: by mail-io1-f68.google.com with SMTP id r9so12665854ioa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9z3VR6zD4FpK2wX25Sr8AogKHA4TBLm2zvFT7kdd5s=;
        b=Exz8gV2y0lI/cYMrL377fkyDjGrNl59IjgexelFzX7oCQxLp7jAuWNJ4KaDFG4kmlo
         Zx+1g4MQbTA9+uILZPu/qXAmI0mRkF7CXpp5/KjGLyJA3H1DoZD2tI7PArHuxSgtFGsq
         o0rhSbMDinllCkgfUwtINy5urpIazrrgFYfMFE4ftMjuyV0gFDvIQmhIGA7akmLNU90x
         ot6pH+SrJ06daa87HN7Zs6IeDrfYv5HS+gCAl5j/Zzt+KN/lfHaGI6CVZhguyoIyjEzI
         eiBJ1CMYpWVpWmRMuylAwk6MIoSIYT4s6CpmdcWl5yrjQT8FFWO6TJQssG/iJPCSTND3
         Vy2A==
X-Gm-Message-State: AOAM533p673nf5xTqh/18pWwddf3AeCz1KtJoI0dDtaf9ZVJr9pzMXcm
        5UuoSMyoxxdPwzIPZwgllw==
X-Google-Smtp-Source: ABdhPJxQx+roCAKx4AnaIPIlqaXgWUyZqSxBkBNIXV9ppawnV7/t50T8OV2VivzabOEHQrk8gp6dLw==
X-Received: by 2002:a02:4b07:: with SMTP id q7mr4008190jaa.84.1599861081813;
        Fri, 11 Sep 2020 14:51:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 01/10] arm64: pmu: Add hook to handle pmu-related undefined instructions
Date:   Fri, 11 Sep 2020 15:51:09 -0600
Message-Id: <20200911215118.2887710-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

This patch introduces a protection for the userspace processes which are
trying to access the registers from the pmu registers on a big.LITTLE
environment. It introduces a hook to handle undefined instructions.

The goal here is to prevent the process to be interrupted by a signal
when the error is caused by the task being scheduled while accessing
a counter, causing the counter access to be invalid. As we are not able
to know efficiently the number of counters available physically on both
pmu in that context we consider that any faulting access to a counter
which is architecturally correct should not cause a SIGILL signal if
the permissions are set accordingly.

This commit also modifies the mask of the mrs_hook declared in
arch/arm64/kernel/cpufeatures.c which emulates only feature register
access. This is necessary because this hook's mask was too large and
thus masking any mrs instruction, even if not related to the emulated
registers which made the pmu emulation inefficient.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix warning for set but unused sys_reg
---
 arch/arm64/kernel/cpufeature.c |  4 +--
 arch/arm64/kernel/perf_event.c | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a389b999482e..00bf53ffd9b0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2811,8 +2811,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
 }
 
 static struct undef_hook mrs_hook = {
-	.instr_mask = 0xfff00000,
-	.instr_val  = 0xd5300000,
+	.instr_mask = 0xffff0000,
+	.instr_val  = 0xd5380000,
 	.pstate_mask = PSR_AA32_MODE_MASK,
 	.pstate_val = PSR_MODE_EL0t,
 	.fn = emulate_mrs,
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9cc44b..70538ae684da 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -8,9 +8,11 @@
  * This code is based heavily on the ARMv7 perf event code.
  */
 
+#include <asm/cpu.h>
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -1016,6 +1018,58 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static int emulate_pmu(struct pt_regs *regs, u32 insn)
+{
+	u32 rt;
+	u32 pmuserenr;
+
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	pmuserenr = read_sysreg(pmuserenr_el0);
+
+	if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
+	    (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
+		return -EINVAL;
+
+
+	/*
+	 * Userspace is expected to only use this in the context of the scheme
+	 * described in the struct perf_event_mmap_page comments.
+	 *
+	 * Given that context, we can only get here if we got migrated between
+	 * getting the register index and doing the MSR read.  This in turn
+	 * implies we'll fail the sequence and retry, so any value returned is
+	 * 'good', all we need is to be non-fatal.
+	 *
+	 * The choice of the value 0 is comming from the fact that when
+	 * accessing a register which is not counting events but is accessible,
+	 * we get 0.
+	 */
+	pt_regs_write_reg(regs, rt, 0);
+
+	arm64_skip_faulting_instruction(regs, 4);
+	return 0;
+}
+
+/*
+ * This hook will only be triggered by mrs
+ * instructions on PMU registers. This is mandatory
+ * in order to have a consistent behaviour even on
+ * big.LITTLE systems.
+ */
+static struct undef_hook pmu_hook = {
+	.instr_mask = 0xffff8800,
+	.instr_val  = 0xd53b8800,
+	.fn = emulate_pmu,
+};
+
+static int __init enable_pmu_emulation(void)
+{
+	register_undef_hook(&pmu_hook);
+	return 0;
+}
+
+core_initcall(enable_pmu_emulation);
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
-- 
2.25.1

