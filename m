Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89D52C78A5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 11:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgK2Kjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 05:39:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:48524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgK2Kjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 05:39:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A531AC2E;
        Sun, 29 Nov 2020 10:38:49 +0000 (UTC)
Date:   Sun, 29 Nov 2020 11:38:44 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.10-rc6
Message-ID: <20201129103844.GA12056@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent fixes which accumulated this last week.

Thx.

---
The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc6

for you to fetch changes up to 25bc65d8ddfc17cc1d7a45bd48e9bdc0e729ced3:

  x86/mce: Do not overwrite no_way_out if mce_end() fails (2020-11-27 17:38:36 +0100)

----------------------------------------------------------------
- Two resctrl fixes to prevent refcount leaks when manipulating the
  resctrl fs (Xiaochen Shen)

- Correct prctl(PR_GET_SPECULATION_CTRL) reporting (Anand K Mistry)

- A fix to not lose already seen MCE severity which determines whether
  the machine can recover (Gabriele Paoloni)

----------------------------------------------------------------
Anand K Mistry (1):
      x86/speculation: Fix prctl() when spectre_v2_user={seccomp,prctl},ibpb

Gabriele Paoloni (1):
      x86/mce: Do not overwrite no_way_out if mce_end() fails

Xiaochen Shen (2):
      x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount leak
      x86/resctrl: Add necessary kernfs_put() calls to prevent refcount leak

 arch/x86/kernel/cpu/bugs.c             |  4 +--
 arch/x86/kernel/cpu/mce/core.c         |  6 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 ++++++++++++++--------------------
 3 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 581fb7223ad0..d41b70fe4918 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -739,11 +739,13 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
+		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 			static_branch_enable(&switch_mm_always_ibpb);
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
 			break;
 		case SPECTRE_V2_USER_CMD_PRCTL:
 		case SPECTRE_V2_USER_CMD_AUTO:
@@ -757,8 +759,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
 			static_key_enabled(&switch_mm_always_ibpb) ?
 			"always-on" : "conditional");
-
-		spectre_v2_user_ibpb = mode;
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..32b7099e3511 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1384,8 +1384,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
-			no_way_out = worst >= MCE_PANIC_SEVERITY;
+		if (mce_end(order) < 0) {
+			if (!no_way_out)
+				no_way_out = worst >= MCE_PANIC_SEVERITY;
+		}
 	} else {
 		/*
 		 * If there was a fatal machine check we should have
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..6f4ca4bea625 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -507,6 +507,24 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/**
+ * rdtgroup_remove - the helper to remove resource group safely
+ * @rdtgrp: resource group to remove
+ *
+ * On resource group creation via a mkdir, an extra kernfs_node reference is
+ * taken to ensure that the rdtgroup structure remains accessible for the
+ * rdtgroup_kn_unlock() calls where it is removed.
+ *
+ * Drop the extra reference here, then free the rdtgroup structure.
+ *
+ * Return: void
+ */
+static void rdtgroup_remove(struct rdtgroup *rdtgrp)
+{
+	kernfs_put(rdtgrp->kn);
+	kfree(rdtgrp);
+}
+
 struct task_move_callback {
 	struct callback_head	work;
 	struct rdtgroup		*rdtgrp;
@@ -529,7 +547,7 @@ static void move_myself(struct callback_head *head)
 	    (rdtgrp->flags & RDT_DELETED)) {
 		current->closid = 0;
 		current->rmid = 0;
-		kfree(rdtgrp);
+		rdtgroup_remove(rdtgrp);
 	}
 
 	if (unlikely(current->flags & PF_EXITING))
@@ -1769,7 +1787,6 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 	if (IS_ERR(kn_subdir))
 		return PTR_ERR(kn_subdir);
 
-	kernfs_get(kn_subdir);
 	ret = rdtgroup_kn_set_ugid(kn_subdir);
 	if (ret)
 		return ret;
@@ -1792,7 +1809,6 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	kn_info = kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
 	if (IS_ERR(kn_info))
 		return PTR_ERR(kn_info);
-	kernfs_get(kn_info);
 
 	ret = rdtgroup_add_files(kn_info, RF_TOP_INFO);
 	if (ret)
@@ -1813,12 +1829,6 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 			goto out_destroy;
 	}
 
-	/*
-	 * This extra ref will be put in kernfs_remove() and guarantees
-	 * that @rdtgrp->kn is always accessible.
-	 */
-	kernfs_get(kn_info);
-
 	ret = rdtgroup_kn_set_ugid(kn_info);
 	if (ret)
 		goto out_destroy;
@@ -1847,12 +1857,6 @@ mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
 	if (dest_kn)
 		*dest_kn = kn;
 
-	/*
-	 * This extra ref will be put in kernfs_remove() and guarantees
-	 * that @rdtgrp->kn is always accessible.
-	 */
-	kernfs_get(kn);
-
 	ret = rdtgroup_kn_set_ugid(kn);
 	if (ret)
 		goto out_destroy;
@@ -2079,8 +2083,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
 			rdtgroup_pseudo_lock_remove(rdtgrp);
 		kernfs_unbreak_active_protection(kn);
-		kernfs_put(rdtgrp->kn);
-		kfree(rdtgrp);
+		rdtgroup_remove(rdtgrp);
 	} else {
 		kernfs_unbreak_active_protection(kn);
 	}
@@ -2139,13 +2142,11 @@ static int rdt_get_tree(struct fs_context *fc)
 					  &kn_mongrp);
 		if (ret < 0)
 			goto out_info;
-		kernfs_get(kn_mongrp);
 
 		ret = mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
 			goto out_mongrp;
-		kernfs_get(kn_mondata);
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
 	}
 
@@ -2357,7 +2358,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 		if (atomic_read(&sentry->waitcount) != 0)
 			sentry->flags = RDT_DELETED;
 		else
-			kfree(sentry);
+			rdtgroup_remove(sentry);
 	}
 }
 
@@ -2399,7 +2400,7 @@ static void rmdir_all_sub(void)
 		if (atomic_read(&rdtgrp->waitcount) != 0)
 			rdtgrp->flags = RDT_DELETED;
 		else
-			kfree(rdtgrp);
+			rdtgroup_remove(rdtgrp);
 	}
 	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
 	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
@@ -2499,11 +2500,6 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
-	/*
-	 * This extra ref will be put in kernfs_remove() and guarantees
-	 * that kn is always accessible.
-	 */
-	kernfs_get(kn);
 	ret = rdtgroup_kn_set_ugid(kn);
 	if (ret)
 		goto out_destroy;
@@ -2838,8 +2834,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	/*
 	 * kernfs_remove() will drop the reference count on "kn" which
 	 * will free it. But we still need it to stick around for the
-	 * rdtgroup_kn_unlock(kn} call below. Take one extra reference
-	 * here, which will be dropped inside rdtgroup_kn_unlock().
+	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
+	 * which will be dropped by kernfs_put() in rdtgroup_remove().
 	 */
 	kernfs_get(kn);
 
@@ -2880,6 +2876,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 out_idfree:
 	free_rmid(rdtgrp->mon.rmid);
 out_destroy:
+	kernfs_put(rdtgrp->kn);
 	kernfs_remove(rdtgrp->kn);
 out_free_rgrp:
 	kfree(rdtgrp);
@@ -2892,7 +2889,7 @@ static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
 {
 	kernfs_remove(rgrp->kn);
 	free_rmid(rgrp->mon.rmid);
-	kfree(rgrp);
+	rdtgroup_remove(rgrp);
 }
 
 /*
@@ -3049,11 +3046,6 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
 	list_del(&rdtgrp->mon.crdtgrp_list);
 
-	/*
-	 * one extra hold on this, will drop when we kfree(rdtgrp)
-	 * in rdtgroup_kn_unlock()
-	 */
-	kernfs_get(kn);
 	kernfs_remove(rdtgrp->kn);
 
 	return 0;
@@ -3065,11 +3057,6 @@ static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
 	rdtgrp->flags = RDT_DELETED;
 	list_del(&rdtgrp->rdtgroup_list);
 
-	/*
-	 * one extra hold on this, will drop when we kfree(rdtgrp)
-	 * in rdtgroup_kn_unlock()
-	 */
-	kernfs_get(kn);
 	kernfs_remove(rdtgrp->kn);
 	return 0;
 }

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
