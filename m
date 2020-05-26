Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2D1C6402
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 00:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgEEWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 18:37:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:41850 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgEEWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:48 -0400
IronPort-SDR: +nfXYS2CX825FdMoo3q79NkBO/T3CZmiLCa8nqEdHhaH2GssJrC739TX03JcLcNriBrULPmOvh
 iCJCeHFWsgnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:47 -0700
IronPort-SDR: v3z4wtFgc7gq5p9ayLk7+mF6aGSjek3jhH5J3zByyQtXKlaZu4UFH+Q56KomwIREgeD/CpwNb8
 gBtyG//cuNDA==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410852"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:46 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 5/7] x86/resctrl: Maintain MBM counter width per resource
Date:   Tue,  5 May 2020 15:36:16 -0700
Message-Id: <e36743b9800f16ce600f86b89127391f61261f23.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the IA32_QM_CTR MSR,
and the first-generation MBM implementation uses 24 bit counters.
Software is required to poll at 1 second or faster to ensure that
data is retrieved before a counter rollover occurs more than once
under worst conditions.

As system bandwidths scale the software requirement is maintained with
the introduction of a per-resource enumerable MBM counter width.

In preparation for supporting hardware with an enumerable MBM counter
width the current globally static MBM counter width is moved to a
per-resource MBM counter width. Currently initialized to 24 always
to result in no functional change.

In essence there is one function, mbm_overflow_count() that needs to
know the counter width to handle rollovers. The static value
used within mbm_overflow_count() will be replaced with a value
discovered from the hardware. Support for learning the MBM counter
width from hardware is added in the change that follows.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 +++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  7 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 21 +++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 055c8613b531..934c8fb8a64a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -495,14 +495,16 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first)
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first)
 {
 	/*
 	 * setup the parameters to send to the IPI to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
+	rr->r = r;
 	rr->d = d;
 	rr->val = 0;
 	rr->first = first;
@@ -539,7 +541,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
-	mon_event_read(&rr, d, rdtgrp, evtid, false);
+	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.val & RMID_VAL_ERROR)
 		seq_puts(m, "Error\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3dd13f3a8b23..58b002c31655 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -87,6 +87,7 @@ union mon_data_bits {
 
 struct rmid_read {
 	struct rdtgroup		*rgrp;
+	struct rdt_resource	*r;
 	struct rdt_domain	*d;
 	int			evtid;
 	bool			first;
@@ -460,6 +461,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
+	unsigned int		mbm_width;
 	unsigned long		fflags;
 };
 
@@ -587,8 +589,9 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
 void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    struct rdt_domain *d);
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first);
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 773124b0e18a..df964c03f6c6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -214,9 +214,9 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr)
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 {
-	u64 shift = 64 - MBM_CNTR_WIDTH, chunks;
+	u64 shift = 64 - width, chunks;
 
 	chunks = (cur_msr << shift) - (prev_msr << shift);
 	return chunks >>= shift;
@@ -256,7 +256,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval);
+	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
@@ -278,7 +278,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
+	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks_bw += chunks;
 	m->chunks = m->chunks_bw;
 	cur_bw = (chunks * r->mon_scale) >> 20;
@@ -433,11 +433,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	}
 }
 
-static void mbm_update(struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 {
 	struct rmid_read rr;
 
 	rr.first = false;
+	rr.r = r;
 	rr.d = d;
 
 	/*
@@ -510,6 +511,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu = smp_processor_id();
 	struct list_head *head;
+	struct rdt_resource *r;
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -517,16 +519,18 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
+	r = &rdt_resources_all[RDT_RESOURCE_L3];
+
+	d = get_domain_from_cpu(cpu, r);
 	if (!d)
 		goto out_unlock;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(d, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp->mon.rmid);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(d, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp->mon.rmid);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
@@ -619,6 +623,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	r->mbm_width = MBM_CNTR_WIDTH;
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6276ae015945..d7cb5ab0d1f0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2472,7 +2472,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 			goto out_destroy;
 
 		if (is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, d, prgrp, mevt->evtid, true);
+			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 	kernfs_activate(kn);
 	return 0;
-- 
2.21.0

