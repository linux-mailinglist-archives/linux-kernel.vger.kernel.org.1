Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D782800BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbgJAOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41857 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbgJAOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id x69so5660136oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGHjCWNuUtJOPPTBOxuddLTs3d0txBwILlyxZmCjVFc=;
        b=LVkr6R8N1x4W0J3cR5hdK4Gjju8I/OL59+hCYsI7yqsh9aRdgj0VcfGCs0M39TiW4d
         iPqy8b6oVnGOnI+YdPSKivgDKuogyfcuCaPu+Rvt81jmzMHsCQODCJshEqOoLu71k1xn
         7JZc23FFj+lvqpYIyglWa1FoXF+1G0pohuPil6lurXhEB7MiOJ9KD/ktFVOJUhF7YE1o
         MP6toL5/l0mHKhQTJk2e0jVR/36K+NTqecLtcsEK7pJjdQBeK949FUaiZc5idc1GS327
         +1aLgn5JaQF1RQB96qVVSlFmaZVeE7w4YT9BB2ehCbCWYkm7zIdI+X/SpCTxsy7Hffnu
         0OQg==
X-Gm-Message-State: AOAM532Zc11vD8d8rfQJVmLdwfaF+mH0C3hmfmKyd9fWMnyAEqLnneWw
        ojJuDUO7fjF1AiacpjwcVpxdNQTXcJlV
X-Google-Smtp-Source: ABdhPJwuW/VR5HT7BouAtrDFt4L8ZuQXLIGKKO9USCH3BhyIK3u/U+9i2jQ/ZNVZYEWdbx9SLCCqfA==
X-Received: by 2002:aca:fd16:: with SMTP id b22mr54484oii.179.1601560881707;
        Thu, 01 Oct 2020 07:01:21 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 2/9] arm64: perf: Enable pmu counter direct access for perf event on armv8
Date:   Thu,  1 Oct 2020 09:01:09 -0500
Message-Id: <20201001140116.651970-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Keep track of event opened with direct access to the hardware counters
and modify permissions while they are open.

The strategy used here is the same which x86 uses: everytime an event
is mapped, the permissions are set if required. The atomic field added
in the mm_context helps keep track of the different event opened and
de-activate the permissions when all are unmapped.
We also need to update the permissions in the context switch code so
that tasks keep the right permissions.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Move mapped/unmapped into arm64 code. Fixes arm32.
 - Rebase on cap_user_time_short changes

Changes from Raphael's v4:
  - Drop homogeneous check
  - Disable access for chained counters
  - Set pmc_width in user page
---
 arch/arm64/include/asm/mmu.h         |  5 ++++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
 arch/arm64/kernel/perf_event.c       | 41 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index a7a5ecaa2e83..52cfdb676f06 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,11 @@
 
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
index f2d7537d6f83..d24589ecb07a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -21,6 +21,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
+#include <asm/perf_event.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
@@ -224,6 +225,7 @@ static inline void __switch_mm(struct mm_struct *next)
 	}
 
 	check_and_switch_context(next);
+	perf_switch_user_access(next);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 2c2d7dbe8a02..a025d9595d51 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -8,6 +8,7 @@
 
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
+#include <linux/mm_types.h>
 
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -251,4 +252,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
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
index e14f360a7883..8344dc030823 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -834,6 +834,41 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void refresh_pmuserenr(void *mm)
+{
+	perf_switch_user_access(mm);
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
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
+		on_each_cpu(refresh_pmuserenr, mm, 1);
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
+		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1058,6 +1093,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
@@ -1218,6 +1255,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);
+
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = armv8pmu_event_is_64bit(event) ? 64 : 32;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
-- 
2.25.1

