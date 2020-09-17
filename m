Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5A26DDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgIQONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:13:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:3609 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgIQOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:11:21 -0400
IronPort-SDR: xRba3P1aG6f9M1MhdoTvBA5L6zBSzt1JOF9KEJGunELK5FbdqrhkmwbVYQr79ps+MAqytmIu8a
 u2JiYXKPUmzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="244532739"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="244532739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 06:53:38 -0700
IronPort-SDR: +QqhgvkKsljeNUk3Wd/nPO7tBE5BDNd5o4dFRuRYr3NhJogV9WGrTI0BI8AipcEFEUA2E6vbEc
 V+DYEwlRK+8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="380543127"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga001.jf.intel.com with ESMTP; 17 Sep 2020 06:53:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Thu, 17 Sep 2020 06:52:34 -0700
Message-Id: <20200917135237.2857-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917135237.2857-1-kan.liang@linux.intel.com>
References: <20200917135237.2857-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf can report both virtual addresses and physical addresses,
but not the MMU page size. Without the MMU page size information of the
utilized page, users cannot decide whether to promote/demote large pages
to optimize memory usage.

Add a new sample type for the data MMU page size.

Current perf already has a facility to collect data virtual addresses.
A page walker is required to walk the pages tables and calculate the
MMU page size from a given virtual address.

On some platforms, e.g., X86, the page walker is invoked in an NMI
handler. So the page walker must be NMI-safe and low overhead. Besides,
the page walker should work for both user and kernel virtual address.
The existing generic page walker, e.g., walk_page_range_novma(), is a
little bit complex and doesn't guarantee the NMI-safe. The follow_page()
is only for user-virtual address.

Add a new function perf_get_page_size() to walk the page tables and
calculate the MMU page size. In the function:
- Interrupts have to be disabled to prevent any teardown of the page
  tables.
- The MMU page size is calculated from the page table level.
The method should work for all architectures, but it has only been
verified on X86. Should there be some architectures, which support perf,
where the method doesn't work, it can be fixed later separately.
Reporting the wrong page size would not be fatal for the architecture.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |   1 +
 include/uapi/linux/perf_event.h |   4 +-
 kernel/events/core.c            | 103 ++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d279b97f..7e3785dd27d9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1034,6 +1034,7 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				cgroup;
+	u64				data_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..cc6ea346e9f9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,8 +143,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -896,6 +897,7 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 45edb85344a1..dc0ae692e32b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/highmem.h>
 
 #include "internal.h"
 
@@ -1894,6 +1895,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		size += sizeof(data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		size += sizeof(data->data_page_size);
+
 	event->header_size = size;
 }
 
@@ -6937,6 +6941,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		perf_output_put(handle, data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		perf_output_put(handle, data->data_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6994,6 +7001,94 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+#ifdef CONFIG_MMU
+
+/*
+ * Return the MMU page size of a given virtual address
+ */
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return 0;
+
+	if (p4d_leaf(*p4d))
+		return 1ULL << P4D_SHIFT;
+
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud))
+		return 0;
+
+	if (pud_leaf(*pud))
+		return 1ULL << PUD_SHIFT;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return 0;
+
+	if (pmd_leaf(*pmd))
+		return 1ULL << PMD_SHIFT;
+
+	pte = pte_offset_map(pmd, addr);
+	if (!pte_present(*pte)) {
+		pte_unmap(pte);
+		return 0;
+	}
+
+	pte_unmap(pte);
+	return PAGE_SIZE;
+}
+
+#else
+
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+#endif
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
+	size = __perf_get_page_size(mm, addr);
+
+	local_irq_restore(flags);
+
+	return size;
+}
+
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
 struct perf_callchain_entry *
@@ -7149,6 +7244,14 @@ void perf_prepare_sample(struct perf_event_header *header,
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
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
-- 
2.17.1

