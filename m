Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180F2DA198
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503295AbgLNU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503198AbgLNU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:29 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eb5o+IWvAAKEECxOdG5acbIKfZvNgnR/VuaCDmxqgD8=;
        b=yiiIEutLWw4KkPI1PrsqvMuGQ/3i9zN9R8gbCH8AFG4emojOmnWWouL4huVphR0R+T+EPv
        eIk+PCtWq+yEY/yye76hzCSJtwNeEiPplZbbq7UX6Jlm7gwLMGJN4O6GsmdRgsFcscOHYr
        uMZaq4G4hSFfK1YrsqTFLJ3izg+pElPUYD1KHrveBLrNRvKkkBL//aTfwfxQhy/vbu6QiN
        +wZMtrWH1bdVwPKLLV0WgDG9IvfKUxW+JMsV4FFBZWcV4FMS8elm45s5ad9pCBrOTX71IN
        AhCjFVrOhK9Bs9lzH7ZbTHPBatIRHNsK/8WgYQbtbtO//BIRntOI45HC7hj6Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eb5o+IWvAAKEECxOdG5acbIKfZvNgnR/VuaCDmxqgD8=;
        b=RG2eeadPOFiifk2IhfnDloaeTuAYM92BcJQQQHux1kXWCcgl0429FpxPFMDnh8NQgK6vyG
        jK33YAeAyrQrm7Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/core for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733546.10793.8273660982632549351.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-12-14

up to:  c2208046bba6: perf/x86/intel: Add Tremont Topdown support


Perf updates:

 Core:
 
   - Better handling of page table leaves on archictectures which have
     architectures have non-pagetable aligned huge/large pages.  For such
     architectures a leaf can actually be part of a larger entry.

   - Prevent a deadlock vs. exec_update_mutex

 Architectures:

   - The related updates for page size calculation of leaf entries

   - The usual churn to support new CPUs

   - Small fixes and improvements all over the place

     

Thanks,

	tglx

------------------>
Gustavo A. R. Silva (3):
      kprobes/x86: Fix fall-through warnings for Clang
      perf/x86: Fix fall-through warnings for Clang
      uprobes/x86: Fix fall-through warnings for Clang

Kan Liang (11):
      perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
      perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
      powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE
      perf/x86/intel: Add Rocket Lake CPU support
      perf/x86/cstate: Add Rocket Lake CPU support
      perf/x86/msr: Add Rocket Lake CPU support
      perf/x86/intel/uncore: Add Rocket Lake support
      perf/x86/intel: Add event constraint for CYCLE_ACTIVITY.STALLS_MEM_ANY
      perf/x86/intel: Fix rtm_abort_event encoding on Ice Lake
      perf/x86/intel/lbr: Fix the return type of get_lbr_cycles()
      perf/x86/intel: Add Tremont Topdown support

Masami Hiramatsu (1):
      x86/kprobes: Restore BTF if the single-stepping is cancelled

Peter Zijlstra (7):
      perf,mm: Handle non-page-table-aligned hugetlbfs
      mm/gup: Provide gup_get_pte() more generic
      mm: Introduce pXX_leaf_size()
      perf/core: Fix arch_perf_get_page_size()
      arm64/mm: Implement pXX_leaf_size() support
      powerpc/8xx: Implement pXX_leaf_size() support
      sparc64/mm: Implement pXX_leaf_size() support

Stephane Eranian (1):
      perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE

peterz@infradead.org (1):
      perf: Break deadlock involving exec_update_mutex


 arch/arm64/include/asm/pgtable.h             |   4 +
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  23 ++++
 arch/powerpc/perf/core-book3s.c              |   6 +-
 arch/sparc/include/asm/pgtable_64.h          |  13 +++
 arch/sparc/mm/hugetlbpage.c                  |  19 +++-
 arch/x86/events/core.c                       |   2 +-
 arch/x86/events/intel/core.c                 |  20 +++-
 arch/x86/events/intel/cstate.c               |  19 ++--
 arch/x86/events/intel/ds.c                   |  11 +-
 arch/x86/events/intel/lbr.c                  |   2 +-
 arch/x86/events/intel/uncore.c               |   6 +
 arch/x86/events/intel/uncore_snb.c           |  20 +++-
 arch/x86/events/msr.c                        |   1 +
 arch/x86/events/perf_event.h                 |   2 +-
 arch/x86/kernel/kprobes/core.c               |   6 +
 arch/x86/kernel/uprobes.c                    |   2 +
 include/linux/perf_event.h                   |   6 +
 include/linux/pgtable.h                      |  71 ++++++++++++
 include/uapi/linux/perf_event.h              |   6 +-
 kernel/events/core.c                         | 160 +++++++++++++++++++++++----
 mm/gup.c                                     |  58 +---------
 21 files changed, 349 insertions(+), 108 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4ff12a7adcfd..c3b92a4503cf 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -407,6 +407,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
+#define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
@@ -503,6 +504,9 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_SECT)
 #define pmd_leaf(pmd)		pmd_sect(pmd)
 
+#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
+#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
+
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
 static inline bool pud_table(pud_t pud) { return true; }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1581204467e1..fcc48d590d88 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #define pte_mkhuge pte_mkhuge
+
+static inline unsigned long pgd_leaf_size(pgd_t pgd)
+{
+	if (pgd_val(pgd) & _PMD_PAGE_8M)
+		return SZ_8M;
+	return SZ_4M;
+}
+
+#define pgd_leaf_size pgd_leaf_size
+
+static inline unsigned long pte_leaf_size(pte_t pte)
+{
+	pte_basic_t val = pte_val(pte);
+
+	if (val & _PAGE_HUGE)
+		return SZ_512K;
+	if (val & _PAGE_SPS)
+		return SZ_16K;
+	return SZ_4K;
+}
+
+#define pte_leaf_size pte_leaf_size
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 08643cba1494..6586f7e71cfb 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2074,6 +2074,9 @@ static struct pmu power_pmu = {
 	.sched_task	= power_pmu_sched_task,
 };
 
+#define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
+				PERF_SAMPLE_PHYS_ADDR |		\
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -2129,8 +2132,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, ~0ULL, event->hw.last_period);
 
-		if (event->attr.sample_type &
-		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR_TYPE)
 			perf_get_data_addr(event, regs, &data.addr);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 7ef6affa105e..550d3904de65 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1121,6 +1121,19 @@ extern unsigned long cmdline_memory_size;
 
 asmlinkage void do_sparc64_fault(struct pt_regs *regs);
 
+#ifdef CONFIG_HUGETLB_PAGE
+
+#define pud_leaf_size pud_leaf_size
+extern unsigned long pud_leaf_size(pud_t pud);
+
+#define pmd_leaf_size pmd_leaf_size
+extern unsigned long pmd_leaf_size(pmd_t pmd);
+
+#define pte_leaf_size pte_leaf_size
+extern unsigned long pte_leaf_size(pte_t pte);
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ec423b5f17dd..ad4b42f04988 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -247,14 +247,17 @@ static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
 	return shift;
 }
 
-static unsigned int huge_tte_to_shift(pte_t entry)
+static unsigned long tte_to_shift(pte_t entry)
 {
-	unsigned long shift;
-
 	if (tlb_type == hypervisor)
-		shift = sun4v_huge_tte_to_shift(entry);
-	else
-		shift = sun4u_huge_tte_to_shift(entry);
+		return sun4v_huge_tte_to_shift(entry);
+
+	return sun4u_huge_tte_to_shift(entry);
+}
+
+static unsigned int huge_tte_to_shift(pte_t entry)
+{
+	unsigned long shift = tte_to_shift(entry);
 
 	if (shift == PAGE_SHIFT)
 		WARN_ONCE(1, "tto_to_shift: invalid hugepage tte=0x%lx\n",
@@ -272,6 +275,10 @@ static unsigned long huge_tte_to_size(pte_t pte)
 	return size;
 }
 
+unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift(*(pte_t *)&pud); }
+unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&pmd); }
+unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a88c94d65693..550c5e7002b9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1174,7 +1174,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		/* All the metric events are mapped onto the fixed counter 3. */
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
-		/* fall through */
+		fallthrough;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index af457f8cb29d..d4569bfa83e3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -257,7 +257,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x54, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x60, 0x8b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x04a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_TOTAL */
-	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
+	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.CYCLES_MEM_ANY */
+	INTEL_UEVENT_CONSTRAINT(0x14a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
 	INTEL_EVENT_CONSTRAINT(0xa3, 0xf),      /* CYCLE_ACTIVITY.* */
 	INTEL_EVENT_CONSTRAINT_RANGE(0xa8, 0xb0, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0xb7, 0xbd, 0xf),
@@ -1900,6 +1901,19 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_tnt,        "event=0x71,umask=0x0");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_tnt,        "event=0xc2,umask=0x0");
+EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_tnt,        "event=0x73,umask=0x6");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_tnt,        "event=0x74,umask=0x0");
+
+static struct attribute *tnt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_tnt),
+	EVENT_PTR(td_retiring_tnt),
+	EVENT_PTR(td_bad_spec_tnt),
+	EVENT_PTR(td_be_bound_tnt),
+	NULL,
+};
+
 static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff0ffffff9fffull, RSP_0),
@@ -5173,6 +5187,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		td_attr = tnt_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Tremont events, ");
 		name = "Tremont";
@@ -5442,6 +5457,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -5464,7 +5480,7 @@ __init int intel_pmu_init(void)
 		mem_attr = icl_events_attrs;
 		td_attr = icl_td_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
-		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
+		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4eb7ee5fed72..407eee5f6f95 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -51,46 +51,46 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL
+ *						ICL,TGL,RKL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT
+ *						KBL,CML,ICL,TGL,TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL,TNT
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL
+ *						KBL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Package (physical package)
  *
  */
@@ -649,6 +649,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b47cc4226934..afbf734e2ee3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -961,7 +961,8 @@ static void adaptive_pebs_record_size_update(void)
 
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
-				PERF_SAMPLE_TRANSACTION)
+				PERF_SAMPLE_TRANSACTION |		     \
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 
 static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 {
@@ -1337,6 +1338,10 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+#define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
+				 PERF_SAMPLE_PHYS_ADDR |	\
+				 PERF_SAMPLE_DATA_PAGE_SIZE)
+
 static void setup_pebs_fixed_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
@@ -1451,7 +1456,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	}
 
 
-	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
+	if ((sample_type & PERF_SAMPLE_ADDR_TYPE) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
 		data->addr = pebs->dla;
 
@@ -1579,7 +1584,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
 			data->data_src.val = get_data_src(event, meminfo->aux);
 
-		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..e2b0efcba101 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -919,7 +919,7 @@ static __always_inline bool get_lbr_predicted(u64 info)
 	return !(info & LBR_INFO_MISPRED);
 }
 
-static __always_inline bool get_lbr_cycles(u64 info)
+static __always_inline u16 get_lbr_cycles(u64 info)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
 	    !(x86_pmu.lbr_timed_lbr && info & LBR_INFO_CYC_CNT_VALID))
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 80d52cbe2fde..357258f82dc8 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1636,6 +1636,11 @@ static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
+	.cpu_init = tgl_uncore_cpu_init,
+	.pci_init = skl_uncore_pci_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1683,6 +1688,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index bbd1120ae161..098f893e2e22 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -60,7 +60,8 @@
 #define PCI_DEVICE_ID_INTEL_TGL_U3_IMC		0x9a12
 #define PCI_DEVICE_ID_INTEL_TGL_U4_IMC		0x9a14
 #define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
-
+#define PCI_DEVICE_ID_INTEL_RKL_1_IMC		0x4c43
+#define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -405,6 +406,12 @@ static struct intel_uncore_type *tgl_msr_uncores[] = {
 	NULL,
 };
 
+static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
 void tgl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = tgl_msr_uncores;
@@ -412,6 +419,7 @@ void tgl_uncore_cpu_init(void)
 	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
 	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
 enum {
@@ -926,6 +934,14 @@ static const struct pci_device_id icl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U2_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -1019,6 +1035,8 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
+	IMC_DEV(RKL_1_IMC, &icl_uncore_pci_driver),
+	IMC_DEV(RKL_2_IMC, &icl_uncore_pci_driver),
 	{  /* end marker */ }
 };
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 4be8f9cabd07..680404c58cb1 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -99,6 +99,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6a8edfe59b09..7895cf4c59a7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -132,7 +132,7 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 547c7abb39f5..a65e9e97857f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -864,6 +864,7 @@ static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 			p->ainsn.boostable = true;
 			goto no_change;
 		}
+		break;
 	default:
 		break;
 	}
@@ -937,6 +938,11 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * So clear it by resetting the current kprobe:
 		 */
 		regs->flags &= ~X86_EFLAGS_TF;
+		/*
+		 * Since the single step (trap) has been cancelled,
+		 * we need to restore BTF here.
+		 */
+		restore_btf();
 
 		/*
 		 * If the TF flag was set before the kprobe hit,
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..90f44f44c209 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1015,6 +1015,8 @@ int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
 		if (uprobe_post_sstep_notifier(regs))
 			ret = NOTIFY_STOP;
 
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 96450f6fb1de..9a38f579bc76 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1028,6 +1028,8 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				cgroup;
+	u64				data_page_size;
+	u64				code_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1585,4 +1587,8 @@ extern void __weak arch_perf_update_userpage(struct perf_event *event,
 					     struct perf_event_mmap_page *userpg,
 					     u64 now);
 
+#ifdef CONFIG_MMU
+extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 71125a4676c4..fefbbdbbb3f3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,61 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+/*
+ * WARNING: only to be used in the get_user_pages_fast() implementation.
+ *
+ * With get_user_pages_fast(), we walk down the pagetables without taking any
+ * locks.  For this we would like to load the pointers atomically, but sometimes
+ * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
+ * we do have is the guarantee that a PTE will only either go from not present
+ * to present, or present to not present or both -- it will not switch to a
+ * completely different present page without a TLB flush in between; something
+ * that we are blocking by holding interrupts off.
+ *
+ * Setting ptes from not present to present goes:
+ *
+ *   ptep->pte_high = h;
+ *   smp_wmb();
+ *   ptep->pte_low = l;
+ *
+ * And present to not present goes:
+ *
+ *   ptep->pte_low = 0;
+ *   smp_wmb();
+ *   ptep->pte_high = 0;
+ *
+ * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
+ * We load pte_high *after* loading pte_low, which ensures we don't see an older
+ * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
+ * picked up a changed pte high. We might have gotten rubbish values from
+ * pte_low and pte_high, but we are guaranteed that pte_low will not have the
+ * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
+ * operates on present ptes we're safe.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte;
+
+	do {
+		pte.pte_low = ptep->pte_low;
+		smp_rmb();
+		pte.pte_high = ptep->pte_high;
+		smp_rmb();
+	} while (unlikely(pte.pte_low != ptep->pte_low));
+
+	return pte;
+}
+#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+/*
+ * We require that the PTE can be read atomically.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	return ptep_get(ptep);
+}
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
@@ -1481,4 +1536,20 @@ typedef unsigned int pgtbl_mod_mask;
 #define pmd_leaf(x)	0
 #endif
 
+#ifndef pgd_leaf_size
+#define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)
+#endif
+#ifndef p4d_leaf_size
+#define p4d_leaf_size(x) P4D_SIZE
+#endif
+#ifndef pud_leaf_size
+#define pud_leaf_size(x) PUD_SIZE
+#endif
+#ifndef pmd_leaf_size
+#define pmd_leaf_size(x) PMD_SIZE
+#endif
+#ifndef pte_leaf_size
+#define pte_leaf_size(x) PAGE_SIZE
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b95d3c485d27..b15e3447cd9f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,8 +143,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -896,6 +898,8 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc568ca295bd..19ae6c931c52 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,8 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/highmem.h>
+#include <linux/pgtable.h>
 
 #include "internal.h"
 
@@ -1895,6 +1897,12 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		size += sizeof(data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		size += sizeof(data->data_page_size);
+
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		size += sizeof(data->code_page_size);
+
 	event->header_size = size;
 }
 
@@ -6931,6 +6939,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		perf_output_put(handle, data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		perf_output_put(handle, data->data_page_size);
+
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		perf_output_put(handle, data->code_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6988,6 +7002,93 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+/*
+ * Return the pagetable size of a given virtual address.
+ */
+static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
+{
+	u64 size = 0;
+
+#ifdef CONFIG_HAVE_FAST_GUP
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	pgdp = pgd_offset(mm, addr);
+	pgd = READ_ONCE(*pgdp);
+	if (pgd_none(pgd))
+		return 0;
+
+	if (pgd_leaf(pgd))
+		return pgd_leaf_size(pgd);
+
+	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
+	p4d = READ_ONCE(*p4dp);
+	if (!p4d_present(p4d))
+		return 0;
+
+	if (p4d_leaf(p4d))
+		return p4d_leaf_size(p4d);
+
+	pudp = pud_offset_lockless(p4dp, p4d, addr);
+	pud = READ_ONCE(*pudp);
+	if (!pud_present(pud))
+		return 0;
+
+	if (pud_leaf(pud))
+		return pud_leaf_size(pud);
+
+	pmdp = pmd_offset_lockless(pudp, pud, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (pmd_leaf(pmd))
+		return pmd_leaf_size(pmd);
+
+	ptep = pte_offset_map(&pmd, addr);
+	pte = ptep_get_lockless(ptep);
+	if (pte_present(pte))
+		size = pte_leaf_size(pte);
+	pte_unmap(ptep);
+#endif /* CONFIG_HAVE_FAST_GUP */
+
+	return size;
+}
+
+static u64 perf_get_page_size(unsigned long addr)
+{
+	struct mm_struct *mm;
+	unsigned long flags;
+	u64 size;
+
+	if (!addr)
+		return 0;
+
+	/*
+	 * Software page-table walkers must disable IRQs,
+	 * which prevents any tear down of the page tables.
+	 */
+	local_irq_save(flags);
+
+	mm = current->mm;
+	if (!mm) {
+		/*
+		 * For kernel threads and the like, use init_mm so that
+		 * we can find kernel memory.
+		 */
+		mm = &init_mm;
+	}
+
+	size = perf_get_pgtable_size(mm, addr);
+
+	local_irq_restore(flags);
+
+	return size;
+}
+
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
 struct perf_callchain_entry *
@@ -7023,7 +7124,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
-	if (sample_type & PERF_SAMPLE_IP)
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -7142,6 +7243,17 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 #endif
 
+	/*
+	 * PERF_DATA_PAGE_SIZE requires PERF_SAMPLE_ADDR. If the user doesn't
+	 * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
+	 * but the value will not dump to the userspace.
+	 */
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		data->data_page_size = perf_get_page_size(data->addr);
+
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		data->code_page_size = perf_get_page_size(data->ip);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
@@ -11720,24 +11832,6 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_task;
 	}
 
-	if (task) {
-		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
-		if (err)
-			goto err_task;
-
-		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
-		 * We must hold exec_update_mutex across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
-		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
-			goto err_cred;
-	}
-
 	if (flags & PERF_FLAG_PID_CGROUP)
 		cgroup_fd = pid;
 
@@ -11745,7 +11839,7 @@ SYSCALL_DEFINE5(perf_event_open,
 				 NULL, NULL, cgroup_fd);
 	if (IS_ERR(event)) {
 		err = PTR_ERR(event);
-		goto err_cred;
+		goto err_task;
 	}
 
 	if (is_sampling_event(event)) {
@@ -11864,6 +11958,24 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_context;
 	}
 
+	if (task) {
+		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
+		if (err)
+			goto err_file;
+
+		/*
+		 * Preserve ptrace permission check for backwards compatibility.
+		 *
+		 * We must hold exec_update_mutex across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+			goto err_cred;
+	}
+
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
 
@@ -12039,7 +12151,10 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (move_group)
 		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
-/* err_file: */
+err_cred:
+	if (task)
+		mutex_unlock(&task->signal->exec_update_mutex);
+err_file:
 	fput(event_file);
 err_context:
 	perf_unpin_context(ctx);
@@ -12051,9 +12166,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 	if (!event_file)
 		free_event(event);
-err_cred:
-	if (task)
-		mutex_unlock(&task->signal->exec_update_mutex);
 err_task:
 	if (task)
 		put_task_struct(task);
diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609..44b0c6b89602 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2085,62 +2085,6 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
 	put_page(page);
 }
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
-
-/*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
- *
- * Setting ptes from not present to present goes:
- *
- *   ptep->pte_high = h;
- *   smp_wmb();
- *   ptep->pte_low = l;
- *
- * And present to not present goes:
- *
- *   ptep->pte_low = 0;
- *   smp_wmb();
- *   ptep->pte_high = 0;
- *
- * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
- * We load pte_high *after* loading pte_low, which ensures we don't see an older
- * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
- * picked up a changed pte high. We might have gotten rubbish values from
- * pte_low and pte_high, but we are guaranteed that pte_low will not have the
- * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
- * operates on present ptes we're safe.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	pte_t pte;
-
-	do {
-		pte.pte_low = ptep->pte_low;
-		smp_rmb();
-		pte.pte_high = ptep->pte_high;
-		smp_rmb();
-	} while (unlikely(pte.pte_low != ptep->pte_low));
-
-	return pte;
-}
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-/*
- * We require that the PTE can be read atomically.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	return ptep_get(ptep);
-}
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 					    unsigned int flags,
 					    struct page **pages)
@@ -2166,7 +2110,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
-		pte_t pte = gup_get_pte(ptep);
+		pte_t pte = ptep_get_lockless(ptep);
 		struct page *head, *page;
 
 		/*

