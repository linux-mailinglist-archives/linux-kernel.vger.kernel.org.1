Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8912F57D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbhANCI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:08:57 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35220 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbhANCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:52 -0500
Received: by mail-oi1-f169.google.com with SMTP id s2so4416448oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqVBajMoMnSfWnbi41uWFFaCqAQ4/xj4iLLfaHLfrWs=;
        b=GQAvTHISIeQjwO1LOOk1J/6Hf3jDdnOJYR01gakMUD8LVZhap1vWYIJGW93JTDFV0N
         /KG5L49K0ypOsDpmx0YWVmzz3TviqjUa1gu0Cl0w4saz0TT6j+4cx4u+Nug6jo1fnoKp
         mdhznY8hfJtbjw1KyuoLzvSRtv7X5K2pt3tPv8eIHmHKwcWVb+KlDRG+hXQFq7RxIHpi
         QEXuNey0CNDSinRQ1T4Hmkl8DBcNorkvhvlUSYuv6DG7tOZfZoAzWkbRUsgdDTtF4mds
         ct1vgfboKryTQ9CyA39QopKvGtkV0Kojw+YGBqVU/gtiC0TcMiHBj4XpDi1Cwt6lgIdr
         AmpQ==
X-Gm-Message-State: AOAM5333GyRKkzJfPRd9COg0A0kbO+4mx/OZILHxxeUGz0SuJxmAMioM
        nzr3Pg44UzrLzPIPzj5Hug==
X-Google-Smtp-Source: ABdhPJzalXbG+PJgcPR/OWqlHSAZDh4f+wAxAcalStkFmD3tJSVMHalSt62gGg92HvkukvrswuSFng==
X-Received: by 2002:aca:47c2:: with SMTP id u185mr1300772oia.56.1610589971161;
        Wed, 13 Jan 2021 18:06:11 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:10 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 2/9] arm64: perf: Enable PMU counter direct access for perf event
Date:   Wed, 13 Jan 2021 20:05:58 -0600
Message-Id: <20210114020605.3943992-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Keep track of event opened with direct access to the hardware counters
and modify permissions while they are open.

The strategy used here is the same which x86 uses: every time an event
is mapped, the permissions are set if required. The atomic field added
in the mm_context helps keep track of the different event opened and
de-activate the permissions when all are unmapped.
We also need to update the permissions in the context switch code so
that tasks keep the right permissions.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I'm not completely sure if using current->active_mm in an IPI is okay?
It seems to work in my testing.

Peter Z says (event->oncpu == smp_processor_id()) in the user page
update is always true, but my testing says otherwise[1].

v5:
 - Only set cap_user_rdpmc if event is on current cpu
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.

v2:
 - Move mapped/unmapped into arm64 code. Fixes arm32.
 - Rebase on cap_user_time_short changes

Changes from Raphael's v4:
  - Drop homogeneous check
  - Disable access for chained counters
  - Set pmc_width in user page

[1] https://lore.kernel.org/lkml/CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com/
---
 arch/arm64/include/asm/mmu.h         |  5 +++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/include/asm/perf_event.h  | 14 +++++++++
 arch/arm64/kernel/perf_event.c       | 47 ++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 75beffe2ee8a..ee08447455da 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,11 @@
 
 typedef struct {
 	atomic64_t	id;
+	/*
+	 * non-zero if userspace have access to hardware
+	 * counters directly.
+	 */
+	atomic_t	pmu_direct_access;
 #ifdef CONFIG_COMPAT
 	void		*sigpage;
 #endif
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0b3079fd28eb..25aee6ab4127 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -21,6 +21,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
+#include <asm/perf_event.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
@@ -231,6 +232,7 @@ static inline void __switch_mm(struct mm_struct *next)
 	}
 
 	check_and_switch_context(next);
+	perf_switch_user_access(next);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 60731f602d3e..112f3f63b79e 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -8,6 +8,7 @@
 
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
+#include <linux/mm_types.h>
 
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -254,4 +255,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+static inline void perf_switch_user_access(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return;
+
+	if (atomic_read(&mm->context.pmu_direct_access)) {
+		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
+			     pmuserenr_el0);
+	} else {
+		write_sysreg(0, pmuserenr_el0);
+	}
+}
+
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 21f6f4cdd05f..38b1cdc7bbe2 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -889,6 +889,46 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void refresh_pmuserenr(void *mm)
+{
+	if (mm == current->active_mm)
+		perf_switch_user_access(mm);
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	/*
+	 * This function relies on not being called concurrently in two
+	 * tasks in the same mm.  Otherwise one task could observe
+	 * pmu_direct_access > 1 and return all the way back to
+	 * userspace with user access disabled while another task is still
+	 * doing on_each_cpu_mask() to enable user access.
+	 *
+	 * For now, this can't happen because all callers hold mmap_lock
+	 * for write.  If this changes, we'll need a different solution.
+	 */
+	lockdep_assert_held_write(&mm->mmap_lock);
+
+	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
+		on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
+		on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1120,6 +1160,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
@@ -1299,6 +1341,11 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR) &&
+		(event->oncpu == smp_processor_id());
+
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = armv8pmu_event_is_64bit(event) ? 64 : 32;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
-- 
2.27.0

