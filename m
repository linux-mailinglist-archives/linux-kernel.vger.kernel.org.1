Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4341A9A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408677AbgDOKcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408649AbgDOKbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AFDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4fhU/GP6InfHomurwz6ovTurFS0AMpyLweR/GVL6wAU=; b=YClPuaLzyWwtvgZWLKG+qD81iq
        M/IHQCZePl3GVG+B4CrtjXSNwrTekp+Vo3Rta5cczNsA9W1UJHU1A7OjB49Q04DbCAUtRrvbrN6KH
        UX8U6c/dYV1vIP8dKyGc4OZ3bm3K3Xm5GPwvZzbCzsrK7okTFi4DYc17mH32OSpaiqZ8fXpgyI1Gf
        wFHni0k+0tbkWK7unaZssaDrwhW82/WA3ZrrFofIyx7AcnjlKrwp2Le7goI7/8OWOznRR7fuqJwOo
        Xhli+a4mrieohPK9uaPLL/NOmu8FoelB0TNPWungtanHtHyhguyoi3LdUVfGDIY2onOlZiRrg9YT7
        UVp0rCIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOfKZ-0001oj-EK; Wed, 15 Apr 2020 10:31:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20E3F304D2B;
        Wed, 15 Apr 2020 12:31:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0975F2BC6F2FF; Wed, 15 Apr 2020 12:31:41 +0200 (CEST)
Date:   Wed, 15 Apr 2020 12:31:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     CodyYao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        cooperyan@zhaoxin.com, codyyao@zhaoxin.com
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
Message-ID: <20200415103141.GS20760@hirez.programming.kicks-ass.net>
References: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
 <20200415102340.GB20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415102340.GB20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:23:40PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 13, 2020 at 11:14:29AM +0800, CodyYao-oc wrote:
> > Zhaoxin CPU has provided facilities for monitoring performance
> > via PMU(Performance Monitor Unit), but the functionality is unused so far.
> > Therefore, add support for zhaoxin pmu to make performance related
> > hardware events available.
> > 
> > Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> 
> What's that reported-by thing? Did the robot complain you didn't have a
> PMU implementation?
> 
> Anyway, I've made the below changes to the patch.

In whole, the patch now looks like this. I've also added that event
table you provided last time to the Changelog.

---
Subject: x86/perf: Add hardware performance events support for Zhaoxin CPU.
From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
Date: Mon, 13 Apr 2020 11:14:29 +0800

From: CodyYao-oc <CodyYao-oc@zhaoxin.com>

Zhaoxin CPU has provided facilities for monitoring performance
via PMU (Performance Monitor Unit), but the functionality is unused so far.
Therefore, add support for zhaoxin pmu to make performance related
hardware events available.

The PMU is mostly an Intel Architectural PerfMon-v2 with a novel
errata for the ZXC line. It supports the following events:

  -----------------------------------------------------------------------------------------------------------------------------------
  Event                      | Event  | Umask |          Description
			     | Select |       |
  -----------------------------------------------------------------------------------------------------------------------------------
  cpu-cycles                 |  82h   |  00h  | unhalt core clock
  instructions               |  00h   |  00h  | number of instructions at retirement.
  cache-references           |  15h   |  05h  | number of fillq pushs at the current cycle.
  cache-misses               |  1ah   |  05h  | number of l2 miss pushed by fillq.
  branch-instructions        |  28h   |  00h  | counts the number of branch instructions retired.
  branch-misses              |  29h   |  00h  | mispredicted branch instructions at retirement.
  bus-cycles                 |  83h   |  00h  | unhalt bus clock
  stalled-cycles-frontend    |  01h   |  01h  | Increments each cycle the # of Uops issued by the RAT to RS.
  stalled-cycles-backend     |  0fh   |  04h  | RS0/1/2/3/45 empty
  L1-dcache-loads            |  68h   |  05h  | number of retire/commit load.
  L1-dcache-load-misses      |  4bh   |  05h  | retired load uops whose data source followed an L1 miss.
  L1-dcache-stores           |  69h   |  06h  | number of retire/commit Store,no LEA
  L1-dcache-store-misses     |  62h   |  05h  | cache lines in M state evicted out of L1D due to Snoop HitM or dirty line replacement.
  L1-icache-loads            |  00h   |  03h  | number of l1i cache access for valid normal fetch,including un-cacheable access.
  L1-icache-load-misses      |  01h   |  03h  | number of l1i cache miss for valid normal fetch,including un-cacheable miss.
  L1-icache-prefetches       |  0ah   |  03h  | number of prefetch.
  L1-icache-prefetch-misses  |  0bh   |  03h  | number of prefetch miss.
  dTLB-loads                 |  68h   |  05h  | number of retire/commit load
  dTLB-load-misses           |  2ch   |  05h  | number of load operations miss all level tlbs and cause a tablewalk.
  dTLB-stores                |  69h   |  06h  | number of retire/commit Store,no LEA
  dTLB-store-misses          |  30h   |  05h  | number of store operations miss all level tlbs and cause a tablewalk.
  dTLB-prefetches            |  64h   |  05h  | number of hardware pte prefetch requests dispatched out of the prefetch FIFO.
  dTLB-prefetch-misses       |  65h   |  05h  | number of hardware pte prefetch requests miss the l1d data cache.
  iTLB-load                  |  00h   |  00h  | actually counter instructions.
  iTLB-load-misses           |  34h   |  05h  | number of code operations miss all level tlbs and cause a tablewalk.
  -----------------------------------------------------------------------------------------------------------------------------------

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com
---
 arch/x86/events/Makefile               |    2 
 arch/x86/events/core.c                 |    4 
 arch/x86/events/perf_event.h           |   10 
 arch/x86/events/zhaoxin/Makefile       |    2 
 arch/x86/events/zhaoxin/core.c         |  613 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/perfctr-watchdog.c |    8 
 6 files changed, 639 insertions(+)
 create mode 100644 arch/x86/events/zhaoxin/Makefile
 create mode 100644 arch/x86/events/zhaoxin/core.c

--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -3,3 +3,5 @@ obj-y					+= core.o probe.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
+obj-$(CONFIG_CPU_SUP_CENTAUR)		+= zhaoxin/
+obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin/
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1839,6 +1839,10 @@ static int __init init_hw_perf_events(vo
 		err = amd_pmu_init();
 		x86_pmu.name = "HYGON";
 		break;
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		err = zhaoxin_pmu_init();
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -618,6 +618,7 @@ struct x86_pmu {
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
+			enabled_ack		:1,
 			counter_freezing	:1;
 	/*
 	 * sysfs attrs
@@ -1133,3 +1134,12 @@ static inline int is_ht_workaround_enabl
 	return 0;
 }
 #endif /* CONFIG_CPU_SUP_INTEL */
+
+#if ((defined CONFIG_CPU_SUP_CENTAUR) || (defined CONFIG_CPU_SUP_ZHAOXIN))
+int zhaoxin_pmu_init(void);
+#else
+static inline int zhaoxin_pmu_init(void)
+{
+	return 0;
+}
+#endif /*CONFIG_CPU_SUP_CENTAUR or CONFIG_CPU_SUP_ZHAOXIN*/
--- /dev/null
+++ b/arch/x86/events/zhaoxin/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= core.o
--- /dev/null
+++ b/arch/x86/events/zhaoxin/core.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Zhoaxin PMU; like Intel Architectural PerfMon-v2
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include <linux/nmi.h>
+
+#include <asm/cpufeature.h>
+#include <asm/hardirq.h>
+#include <asm/apic.h>
+
+#include "../perf_event.h"
+
+/*
+ * Zhaoxin PerfMon, used on zxc and later.
+ */
+static u64 zx_pmon_event_map[PERF_COUNT_HW_MAX] __read_mostly = {
+
+	[PERF_COUNT_HW_CPU_CYCLES]        = 0x0082,
+	[PERF_COUNT_HW_INSTRUCTIONS]      = 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+	[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
+	[PERF_COUNT_HW_BUS_CYCLES]        = 0x0083,
+};
+
+static struct event_constraint zxc_event_constraints[] __read_mostly = {
+
+	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
+	EVENT_CONSTRAINT_END
+};
+
+static struct event_constraint zxd_event_constraints[] __read_mostly = {
+
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* retired instructions */
+	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
+	FIXED_EVENT_CONSTRAINT(0x0083, 2), /* unhalted bus clock cycles */
+	EVENT_CONSTRAINT_END
+};
+
+static __initconst const u64 zxd_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0042,
+		[C(RESULT_MISS)] = 0x0538,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0043,
+		[C(RESULT_MISS)] = 0x0562,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0300,
+		[C(RESULT_MISS)] = 0x0301,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x030a,
+		[C(RESULT_MISS)] = 0x030b,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0042,
+		[C(RESULT_MISS)] = 0x052c,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0043,
+		[C(RESULT_MISS)] = 0x0530,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0564,
+		[C(RESULT_MISS)] = 0x0565,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x00c0,
+		[C(RESULT_MISS)] = 0x0534,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0700,
+		[C(RESULT_MISS)] = 0x0709,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+};
+
+static __initconst const u64 zxe_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0568,
+		[C(RESULT_MISS)] = 0x054b,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0669,
+		[C(RESULT_MISS)] = 0x0562,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0300,
+		[C(RESULT_MISS)] = 0x0301,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x030a,
+		[C(RESULT_MISS)] = 0x030b,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0568,
+		[C(RESULT_MISS)] = 0x052c,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0669,
+		[C(RESULT_MISS)] = 0x0530,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0564,
+		[C(RESULT_MISS)] = 0x0565,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x00c0,
+		[C(RESULT_MISS)] = 0x0534,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0028,
+		[C(RESULT_MISS)] = 0x0029,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+};
+
+static void zhaoxin_pmu_disable_all(void)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+}
+
+static void zhaoxin_pmu_enable_all(int added)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
+}
+
+static inline u64 zhaoxin_pmu_get_status(void)
+{
+	u64 status;
+
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
+
+	return status;
+}
+
+static inline void zhaoxin_pmu_ack_status(u64 ack)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
+}
+
+static inline void zxc_pmu_ack_status(u64 ack)
+{
+	/*
+	 * ZXC needs global control enabled in order to clear status bits.
+	 */
+	zhaoxin_pmu_enable_all(0);
+	zhaoxin_pmu_ack_status(ack);
+	zhaoxin_pmu_disable_all();
+}
+
+static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
+{
+	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	u64 ctrl_val, mask;
+
+	mask = 0xfULL << (idx * 4);
+
+	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	wrmsrl(hwc->config_base, ctrl_val);
+}
+
+static void zhaoxin_pmu_disable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+		zhaoxin_pmu_disable_fixed(hwc);
+		return;
+	}
+
+	x86_pmu_disable_event(event);
+}
+
+static void zhaoxin_pmu_enable_fixed(struct hw_perf_event *hwc)
+{
+	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	u64 ctrl_val, bits, mask;
+
+	/*
+	 * Enable IRQ generation (0x8),
+	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
+	 * if requested:
+	 */
+	bits = 0x8ULL;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
+		bits |= 0x2;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
+		bits |= 0x1;
+
+	bits <<= (idx * 4);
+	mask = 0xfULL << (idx * 4);
+
+	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	ctrl_val |= bits;
+	wrmsrl(hwc->config_base, ctrl_val);
+}
+
+static void zhaoxin_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+		zhaoxin_pmu_enable_fixed(hwc);
+		return;
+	}
+
+	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+}
+
+/*
+ * This handler is triggered by the local APIC, so the APIC IRQ handling
+ * rules apply:
+ */
+static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct perf_sample_data data;
+	struct cpu_hw_events *cpuc;
+	int handled = 0;
+	u64 status;
+	int bit;
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	zhaoxin_pmu_disable_all();
+	status = zhaoxin_pmu_get_status();
+	if (!status)
+		goto done;
+
+again:
+	if (x86_pmu.enabled_ack)
+		zxc_pmu_ack_status(status);
+	else
+		zhaoxin_pmu_ack_status(status);
+
+	inc_irq_stat(apic_perf_irqs);
+
+	/*
+	 * CondChgd bit 63 doesn't mean any overflow status. Ignore
+	 * and clear the bit.
+	 */
+	if (__test_and_clear_bit(63, (unsigned long *)&status)) {
+		if (!status)
+			goto done;
+	}
+
+	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
+		struct perf_event *event = cpuc->events[bit];
+
+		handled++;
+
+		if (!test_bit(bit, cpuc->active_mask))
+			continue;
+
+		x86_perf_event_update(event);
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+
+		if (!x86_perf_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
+	}
+
+	/*
+	 * Repeat if there is more work to be done:
+	 */
+	status = zhaoxin_pmu_get_status();
+	if (status)
+		goto again;
+
+done:
+	zhaoxin_pmu_enable_all(0);
+	return handled;
+}
+
+static u64 zhaoxin_pmu_event_map(int hw_event)
+{
+	return zx_pmon_event_map[hw_event];
+}
+
+static struct event_constraint *
+zhaoxin_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	if (x86_pmu.event_constraints) {
+		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			if ((event->hw.config & c->cmask) == c->code)
+				return c;
+		}
+	}
+
+	return &unconstrained;
+}
+
+PMU_FORMAT_ATTR(event,	"config:0-7");
+PMU_FORMAT_ATTR(umask,	"config:8-15");
+PMU_FORMAT_ATTR(edge,	"config:18");
+PMU_FORMAT_ATTR(inv,	"config:23");
+PMU_FORMAT_ATTR(cmask,	"config:24-31");
+
+static struct attribute *zx_arch_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_cmask.attr,
+	NULL,
+};
+
+static ssize_t zhaoxin_event_sysfs_show(char *page, u64 config)
+{
+	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT);
+
+	return x86_event_sysfs_show(page, config, event);
+}
+
+static const struct x86_pmu zhaoxin_pmu __initconst = {
+	.name			= "zhaoxin",
+	.handle_irq		= zhaoxin_pmu_handle_irq,
+	.disable_all		= zhaoxin_pmu_disable_all,
+	.enable_all		= zhaoxin_pmu_enable_all,
+	.enable			= zhaoxin_pmu_enable_event,
+	.disable		= zhaoxin_pmu_disable_event,
+	.hw_config		= x86_pmu_hw_config,
+	.schedule_events	= x86_schedule_events,
+	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
+	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.event_map		= zhaoxin_pmu_event_map,
+	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
+	.apic			= 1,
+	/*
+	 * For zxd/zxe, read/write operation for PMCx MSR is 48 bits.
+	 */
+	.max_period		= (1ULL << 47) - 1,
+	.get_event_constraints	= zhaoxin_get_event_constraints,
+
+	.format_attrs		= zx_arch_formats_attr,
+	.events_sysfs_show	= zhaoxin_event_sysfs_show,
+};
+
+static const struct { int id; char *name; } zx_arch_events_map[] __initconst = {
+	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
+	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
+	{ PERF_COUNT_HW_BUS_CYCLES, "bus cycles" },
+	{ PERF_COUNT_HW_CACHE_REFERENCES, "cache references" },
+	{ PERF_COUNT_HW_CACHE_MISSES, "cache misses" },
+	{ PERF_COUNT_HW_BRANCH_INSTRUCTIONS, "branch instructions" },
+	{ PERF_COUNT_HW_BRANCH_MISSES, "branch misses" },
+};
+
+static __init void zhaoxin_arch_events_quirk(void)
+{
+	int bit;
+
+	/* disable event that reported as not presend by cpuid */
+	for_each_set_bit(bit, x86_pmu.events_mask, ARRAY_SIZE(zx_arch_events_map)) {
+		zx_pmon_event_map[zx_arch_events_map[bit].id] = 0;
+		pr_warn("CPUID marked event: \'%s\' unavailable\n",
+			zx_arch_events_map[bit].name);
+	}
+}
+
+__init int zhaoxin_pmu_init(void)
+{
+	union cpuid10_edx edx;
+	union cpuid10_eax eax;
+	union cpuid10_ebx ebx;
+	struct event_constraint *c;
+	unsigned int unused;
+	int version;
+
+	pr_info("Welcome to zhaoxin pmu!\n");
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * hw_event or not.
+	 */
+	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+
+	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT - 1)
+		return -ENODEV;
+
+	version = eax.split.version_id;
+	if (version != 2)
+		return -ENODEV;
+
+	x86_pmu = zhaoxin_pmu;
+	pr_info("Version check pass!\n");
+
+	x86_pmu.version			= version;
+	x86_pmu.num_counters		= eax.split.num_counters;
+	x86_pmu.cntval_bits		= eax.split.bit_width;
+	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
+	x86_pmu.events_maskl		= ebx.full;
+	x86_pmu.events_mask_len		= eax.split.mask_length;
+
+	x86_pmu.num_counters_fixed = edx.split.num_counters_fixed;
+	x86_add_quirk(zhaoxin_arch_events_quirk);
+
+	switch (boot_cpu_data.x86) {
+	case 0x06:
+		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+
+			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
+
+			/* Clearing status works only if the global control is enable on zxc. */
+			x86_pmu.enabled_ack = 1;
+
+			x86_pmu.event_constraints = zxc_event_constraints;
+			zx_pmon_event_map[PERF_COUNT_HW_INSTRUCTIONS] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
+
+			pr_cont("ZXC events, ");
+			break;
+		}
+		return -ENODEV;
+
+	case 0x07:
+		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+			X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
+
+		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
+			X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
+
+		switch (boot_cpu_data.x86_model) {
+		case 0x1b:
+			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
+			       sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = zxd_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
+
+			pr_cont("ZXD events, ");
+			break;
+		case 0x3b:
+			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
+			       sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = zxd_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
+
+			pr_cont("ZXE events, ");
+			break;
+		default:
+			return -ENODEV;
+		}
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	x86_pmu.intel_ctrl = (1 << (x86_pmu.num_counters)) - 1;
+	x86_pmu.intel_ctrl |= ((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+
+	if (x86_pmu.event_constraints) {
+		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			c->weight += x86_pmu.num_counters;
+		}
+	}
+
+	return 0;
+}
+
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,6 +63,10 @@ static inline unsigned int nmi_perfctr_m
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
+		fallthrough;
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		return msr - MSR_ARCH_PERFMON_PERFCTR0;
 	}
 	return 0;
 }
@@ -92,6 +96,10 @@ static inline unsigned int nmi_evntsel_m
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
+		fallthrough;
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
 	}
 	return 0;
 
