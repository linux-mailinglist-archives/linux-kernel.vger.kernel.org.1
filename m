Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D32A0DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgJ3Sqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:46:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:55824 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgJ3Sqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:46:49 -0400
IronPort-SDR: 5RdDYp2/4nekBTIfpNd+E/rPdnAOdXZpIdPV/tuzSfZJTGXgscXCQrBs5+F1HCA3lmH4WxivYW
 7WJw/5w8AJcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="167867924"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="167867924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:46:49 -0700
IronPort-SDR: CxI4++dy6xNLjXQ1eliPP+ULjLkv9VenjUz2MEomy6R6lGg/tUP70pr3wzj0VrW/3M5w3ZZE5b
 LIkXptnFE72Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351958990"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 11:46:46 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, willemb@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 3/3] x86/resctrl: Clean up unused function parameter in rmdir path
Date:   Sat, 31 Oct 2020 03:11:57 +0800
Message-Id: <1604085117-31778-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
References: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit
("x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount leak")

removed superfluous kernfs_get() calls in rdtgroup_ctrl_remove() and
rdtgroup_rmdir_ctrl(). That change resulted in an unused function
parameter to these two functions.

Clean up the unused function parameter in rdtgroup_ctrl_remove(),
rdtgroup_rmdir_mon() and their callers rdtgroup_rmdir_ctrl() and
rdtgroup_rmdir().

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6f4ca4bea625..b1bba837bd11 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3018,8 +3018,7 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	return -EPERM;
 }
 
-static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
-			      cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
 	int cpu;
@@ -3051,8 +3050,7 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	return 0;
 }
 
-static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
-				struct rdtgroup *rdtgrp)
+static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 {
 	rdtgrp->flags = RDT_DELETED;
 	list_del(&rdtgrp->rdtgroup_list);
@@ -3061,8 +3059,7 @@ static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
 	return 0;
 }
 
-static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
-			       cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	int cpu;
 
@@ -3089,7 +3086,7 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
-	rdtgroup_ctrl_remove(kn, rdtgrp);
+	rdtgroup_ctrl_remove(rdtgrp);
 
 	/*
 	 * Free all the child monitor group rmids.
@@ -3126,13 +3123,13 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	    rdtgrp != &rdtgroup_default) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
-			ret = rdtgroup_ctrl_remove(kn, rdtgrp);
+			ret = rdtgroup_ctrl_remove(rdtgrp);
 		} else {
-			ret = rdtgroup_rmdir_ctrl(kn, rdtgrp, tmpmask);
+			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
 		}
 	} else if (rdtgrp->type == RDTMON_GROUP &&
 		 is_mon_groups(parent_kn, kn->name)) {
-		ret = rdtgroup_rmdir_mon(kn, rdtgrp, tmpmask);
+		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
 	} else {
 		ret = -EPERM;
 	}
-- 
1.8.3.1

