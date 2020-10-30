Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF532A0AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJ3QMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgJ3QMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33622150C;
        Fri, 30 Oct 2020 09:12:19 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537E13F719;
        Fri, 30 Oct 2020 09:12:17 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 03/24] x86/resctrl: Add resctrl_arch_get_num_closid()
Date:   Fri, 30 Oct 2020 16:10:59 +0000
Message-Id: <20201030161120.227225-4-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl chooses whether to enable CDP, once it does, half the number
of closid are available. MPAM doesn't behave like this, an in-kernel user
of MPAM could be 'using CDP' while resctrl is not.

To move the 'half the closids' behaviour to be part of the core code,
each schema would have a num_closids. This may be different from the
single resources num_closid if CDP is in use.

Add a helper to read the resource's num_closid, this should return the
number of closid that the resource supports, regardless of whether CDP
is in use.

For now return the hw_res->num_closid, which is already adjusted for CDP.
Once the CODE/DATA/BOTH resources are merged, resctrl can make the
adjustment when copying the value to the schema's num_closid.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  5 +++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++---------
 include/linux/resctrl.h                   |  3 +++
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 97040a54cc9a..5d5b566c4359 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -443,6 +443,11 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 	return NULL;
 }
 
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->num_closid;
+}
+
 void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2e7466659af3..14ea6a40993f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -286,12 +286,11 @@ int update_domains(struct rdt_resource *r, int closid)
 static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
-		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
+		if (!strcmp(resname, r->name) &&
+		     rdtgrp->closid < resctrl_arch_get_num_closid(r))
 			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -400,7 +399,6 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
-	struct rdt_hw_resource *hw_res;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -425,8 +423,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			for_each_alloc_enabled_rdt_resource(r) {
-				hw_res = resctrl_to_arch_res(r);
-				if (closid < hw_res->num_closid)
+				if (closid < resctrl_arch_get_num_closid(r))
 					show_doms(s, r, closid);
 			}
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b55861ff4e34..df10135f021e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -100,15 +100,13 @@ int closids_supported(void)
 
 static void closid_init(void)
 {
-	struct rdt_hw_resource *hw_res;
+	u32 rdt_min_closid = 32;
 	struct rdt_resource *r;
-	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
-		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
-	}
+	for_each_alloc_enabled_rdt_resource(r)
+		rdt_min_closid = min(rdt_min_closid,
+				     resctrl_arch_get_num_closid(r));
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
@@ -847,10 +845,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
-	struct rdt_hw_resource *hw_res;
 
-	hw_res = resctrl_to_arch_res(r);
-	seq_printf(seq, "%d\n", hw_res->num_closid);
+	seq_printf(seq, "%d\n", resctrl_arch_get_num_closid(r));
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f5af59b8f2a9..dfb0f32b73a1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -163,4 +163,7 @@ struct rdt_resource {
 
 };
 
+/* The number of closid supported by this resource regardless of CDP */
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
 #endif /* _RESCTRL_H */
-- 
2.28.0

