Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53292A0AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgJ3QM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:28 -0400
Received: from foss.arm.com ([217.140.110.172]:38906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgJ3QM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA0015BF;
        Fri, 30 Oct 2020 09:12:27 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3BA3F719;
        Fri, 30 Oct 2020 09:12:25 -0700 (PDT)
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
Subject: [PATCH 05/24] x86/resctrl: Pass the schema in resdir's private pointer
Date:   Fri, 30 Oct 2020 16:11:01 +0000
Message-Id: <20201030161120.227225-6-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving properties that resctrl exposes to user-space into the core
'fs' code, (e.g. the name of the schema), means some of the functions
that back the filesystem need the schema struct, but currently take the
resource.

Once the CDP resources are merged, the resource doesn't reflect the
right level of information.

For the info dirs that represent a control, the information needed
is in the schema, as this is how the resource is being used. For the
monitors, its the resource as L3CODE_MON doesn't make sense, and would
monitor data too.

This difference means the type of the private pointers varies
between control and monitor info dirs.

If the flags are RF_MON_INFO, its a struct rdt_resource. If the
flags are RF_CTRL_INFO, its a struct resctrl_schema. Nothing in
res_common_files[] has both flags.

Signed-off-by: James Morse <james.morse@arm.com>

---
Fake schema for monitors may simplify this if anyone thinks that is
preferable.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 37 +++++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f79a5e548138..cb16454a6b0e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -847,7 +847,8 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%d\n", resctrl_arch_get_num_closid(r));
 	return 0;
@@ -856,7 +857,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->default_ctrl);
 	return 0;
@@ -865,7 +867,8 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
 	return 0;
@@ -874,7 +877,8 @@ static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 				   struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->cache.shareable_bits);
 	return 0;
@@ -897,13 +901,14 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
 	/*
 	 * Use unsigned long even though only 32 bits are used to ensure
 	 * test_bit() is used safely.
 	 */
 	unsigned long sw_shareable = 0, hw_shareable = 0;
 	unsigned long exclusive = 0, pseudo_locked = 0;
+	struct rdt_resource *r = s->res;
 	struct rdt_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
@@ -975,7 +980,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.min_bw);
 	return 0;
@@ -1006,7 +1012,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.bw_gran);
 	return 0;
@@ -1015,7 +1022,8 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.delay_linear);
 	return 0;
@@ -1036,7 +1044,8 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
 		seq_puts(seq, "per-thread\n");
@@ -1769,14 +1778,14 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 	return ret;
 }
 
-static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
+static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
 	int ret;
 
 	kn_subdir = kernfs_create_dir(kn_info, name,
-				      kn_info->mode, r);
+				      kn_info->mode, priv);
 	if (IS_ERR(kn_subdir))
 		return PTR_ERR(kn_subdir);
 
@@ -1794,6 +1803,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
 	char name[32];
@@ -1809,9 +1819,10 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
-- 
2.28.0

