Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB32A0DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgJ3Spq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:45:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:56882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3Spq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:45:46 -0400
IronPort-SDR: aO7ULQQA/RZXSAal60z3fIJ+r9rLQFWWMgFKnohTCJeBVPpMkT6b0hoVXcCZAbPYpAlyuqe+aQ
 RJkMa1DlpGgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="148506876"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="148506876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:45:46 -0700
IronPort-SDR: 3ahx2GKN/xdAL/+2IHK8awgXWKZkKus9sR4KcfmtSkrdox5j/9J+5KXXh4/W54Sc3vJ3KaJirZ
 pYqanAfU9+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="319406882"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2020 11:45:42 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, willemb@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 1/3] x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount leak
Date:   Sat, 31 Oct 2020 03:10:53 +0800
Message-Id: <1604085053-31639-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
References: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem reported growing of kernfs_node_cache entries in slabtop when
repeatedly creating and removing resctrl subdirectories as well as when
repeatedly mounting and unmounting resctrl filesystem.

On resource group (control as well as monitoring) creation via a mkdir
an extra kernfs_node reference is obtained to ensure that the rdtgroup
structure remains accessible for the rdtgroup_kn_unlock() calls where it
is removed on deletion. The kernfs_node reference count is dropped by
kernfs_put() in rdtgroup_kn_unlock().

With the above explaining the need for one kernfs_get()/kernfs_put()
pair in resctrl there are more places where a kernfs_node reference is
obtained without a corresponding release. The excessive amount of
reference count on kernfs nodes will never be dropped to 0 and the
kernfs nodes will never be freed in the call paths of rmdir and umount.
It leads to reference count leak and kernfs_node_cache memory leak.

Remove the superfluous kernfs_get() calls and expand the existing
comments surrounding the remaining kernfs_get()/kernfs_put() pair that
remains in use.

Superfluous kernfs_get() calls are removed from two areas:

  (1) In call paths of mount and mkdir, when kernfs nodes for "info",
  "mon_groups" and "mon_data" directories and sub-directories are
  created, the reference count of newly created kernfs node is set to 1.
  But after kernfs_create_dir() returns, superfluous kernfs_get() are
  called to take an additional reference.

  (2) kernfs_get() calls in rmdir call paths.

Cc: stable@vger.kernel.org
Fixes: 17eafd076291 ("x86/intel_rdt: Split resource group removal in two")
Fixes: 4af4a88e0c92 ("x86/intel_rdt/cqm: Add mount,umount support")
Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Fixes: c7d9aac61311 ("x86/intel_rdt/cqm: Add mkdir support for RDT monitoring")
Fixes: 5dc1d5c6bac2 ("x86/intel_rdt: Simplify info and base file lists")
Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
Fixes: 4e978d06dedb ("x86/intel_rdt: Add "info" files to resctrl file system")
Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++--------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..2ab1266a5f14 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1769,7 +1769,6 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 	if (IS_ERR(kn_subdir))
 		return PTR_ERR(kn_subdir);
 
-	kernfs_get(kn_subdir);
 	ret = rdtgroup_kn_set_ugid(kn_subdir);
 	if (ret)
 		return ret;
@@ -1792,7 +1791,6 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	kn_info = kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
 	if (IS_ERR(kn_info))
 		return PTR_ERR(kn_info);
-	kernfs_get(kn_info);
 
 	ret = rdtgroup_add_files(kn_info, RF_TOP_INFO);
 	if (ret)
@@ -1813,12 +1811,6 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
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
@@ -1847,12 +1839,6 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
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
@@ -2139,13 +2125,11 @@ static int rdt_get_tree(struct fs_context *fc)
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
 
@@ -2499,11 +2483,6 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
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
@@ -2838,8 +2817,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	/*
 	 * kernfs_remove() will drop the reference count on "kn" which
 	 * will free it. But we still need it to stick around for the
-	 * rdtgroup_kn_unlock(kn} call below. Take one extra reference
-	 * here, which will be dropped inside rdtgroup_kn_unlock().
+	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
+	 * which will be dropped inside rdtgroup_kn_unlock().
 	 */
 	kernfs_get(kn);
 
@@ -3049,11 +3028,6 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
 	list_del(&rdtgrp->mon.crdtgrp_list);
 
-	/*
-	 * one extra hold on this, will drop when we kfree(rdtgrp)
-	 * in rdtgroup_kn_unlock()
-	 */
-	kernfs_get(kn);
 	kernfs_remove(rdtgrp->kn);
 
 	return 0;
@@ -3065,11 +3039,6 @@ static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
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
1.8.3.1

