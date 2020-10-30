Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89322A0ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgJ3QMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgJ3QMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA2E165C;
        Fri, 30 Oct 2020 09:12:41 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60CF73F719;
        Fri, 30 Oct 2020 09:12:39 -0700 (PDT)
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
Subject: [PATCH 10/24] x86/resctrl: Move the schema names into struct resctrl_schema
Date:   Fri, 30 Oct 2020 16:11:06 +0000
Message-Id: <20201030161120.227225-11-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the names used for the schemata file out of the resource and
into struct resctrl_schema. This allows one resource to have two
different names, based on the other schema properties.

This patch copies the names, eventually resctrl will generate them.

Remove the arch code's max_name_width, this is now resctrl's
problem.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++-------
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 17 ++++++++++++-----
 include/linux/resctrl.h                   |  7 +++++++
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1ed5e04031e6..cda071009fed 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -37,10 +37,10 @@ DEFINE_MUTEX(rdtgroup_mutex);
 DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 /*
- * Used to store the max resource name width and max resource data width
+ * Used to store the max resource data width
  * to display the schemata in a tabular format
  */
-int max_name_width, max_data_width;
+int max_data_width;
 
 /*
  * Global boolean for rdt_alloc which is true if any
@@ -776,13 +776,8 @@ static int resctrl_offline_cpu(unsigned int cpu)
 static __init void rdt_init_padding(void)
 {
 	struct rdt_resource *r;
-	int cl;
 
 	for_each_alloc_capable_rdt_resource(r) {
-		cl = strlen(r->name);
-		if (cl > max_name_width)
-			max_name_width = cl;
-
 		if (r->data_width > max_data_width)
 			max_data_width = r->data_width;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a65ff53394ed..28d69c78c29e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -291,13 +291,11 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
-	struct rdt_resource *r;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	list_for_each_entry(s, &resctrl_all_schema, list) {
-		r = s->res;
-		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
+		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -391,7 +389,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val;
 
-	seq_printf(s, "%*s:", max_name_width, r->name);
+	seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
@@ -411,7 +409,6 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
 	int ret = 0;
 	u32 closid;
 
@@ -419,8 +416,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			list_for_each_entry(schema, &resctrl_all_schema, list) {
-				r = schema->res;
-				seq_printf(s, "%s:uninitialized\n", r->name);
+				seq_printf(s, "%s:uninitialized\n", schema->name);
 			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 27671a654f8b..5294ae0c3ed9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -248,7 +248,7 @@ struct rdtgroup {
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
-extern int max_name_width, max_data_width;
+extern int max_data_width;
 
 int __init rdtgroup_init(void);
 void __exit rdtgroup_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 311a3890bc53..48f4d6783647 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1440,8 +1440,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			rdt_last_cmd_puts("Cache domain offline\n");
 			ret = -ENODEV;
 		} else {
-			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->s->res->name);
+			seq_printf(s, "%*s:", RESCTRL_NAME_LEN,
+				   rdtgrp->plr->s->name);
 			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
@@ -1454,7 +1454,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		r = schema->res;
 
 		sep = false;
-		seq_printf(s, "%*s:", max_name_width, r->name);
+		seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
@@ -1827,7 +1827,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
@@ -2140,6 +2140,7 @@ static int create_schemata_list(void)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
+	int ret;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -2150,6 +2151,12 @@ static int create_schemata_list(void)
 		s->num_closid = resctrl_arch_get_num_closid(r);
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 
+		ret = snprintf(s->name, sizeof(s->name), r->name);
+		if (ret >= sizeof(s->name)) {
+			kfree(s);
+			return -EINVAL;
+		}
+
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_all_schema);
 	}
@@ -2794,7 +2801,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 */
 	tmp_cbm = d->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
 	d->have_new_ctrl = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8a12f4128209..9f71f0238239 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,11 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+/*
+ * The longest name we expect in the schemata file:
+ */
+#define RESCTRL_NAME_LEN	7
+
 enum resctrl_conf_type {
 	CDP_BOTH,
 	CDP_CODE,
@@ -172,12 +177,14 @@ struct rdt_resource {
 
 /**
  * @list:	Member of resctrl's schema list
+ * @names:	Name to use in "schemata" file
  * @conf_type:	Type of configuration, e.g. code/data/both
  * @res:	The rdt_resource for this entry
  * @num_closid	Number of CLOSIDs available for this resource
  */
 struct resctrl_schema {
 	struct list_head		list;
+	char				name[RESCTRL_NAME_LEN];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.28.0

