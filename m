Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE732A0ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJ3QMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgJ3QMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109F81650;
        Fri, 30 Oct 2020 09:12:36 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C503F719;
        Fri, 30 Oct 2020 09:12:33 -0700 (PDT)
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
Subject: [PATCH 08/24] x86/resctrl: Walk the resctrl schema list instead of an arch list
Date:   Fri, 30 Oct 2020 16:11:04 +0000
Message-Id: <20201030161120.227225-9-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that resctrl has its own list of resources it is using, walk that
list instead of the architectures list. This means resctrl has somewhere
to keep schema properties with the resource that is using them.

Most users of for_each_alloc_enabled_rdt_resource() are per-schema,
and also want a schema property, like the conf_type. Switch these to
walk the schema list. Schema were only created for alloc_enabled
resources so these two lists are currently equivalent.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 ++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++++-------
 include/linux/resctrl.h                   |  5 +--
 4 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 8ac104c634fe..d3f9d142f58a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -57,9 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
 	if (d->have_new_ctrl) {
@@ -125,10 +126,11 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
@@ -160,12 +162,12 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
 	 */
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
 		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
 		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_puts("Overlaps with other group\n");
@@ -185,9 +187,10 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r,
+static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
@@ -213,7 +216,8 @@ static int parse_line(char *line, struct rdt_resource *r,
 		if (d->id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, r, d))
+
+			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				/*
@@ -289,10 +293,12 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
 		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
-			return parse_line(tok, r, rdtgrp);
+			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -301,6 +307,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
+	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
@@ -331,8 +338,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, list)
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		list_for_each_entry(dom, &s->res->domains, list)
 			dom->have_new_ctrl = false;
 	}
 
@@ -353,7 +360,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -375,8 +383,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
+	struct rdt_resource *r = schema->res;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
@@ -409,8 +418,10 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-			for_each_alloc_enabled_rdt_resource(r)
+			list_for_each_entry(schema, &resctrl_all_schema, list) {
+				r = schema->res;
 				seq_printf(s, "%s:uninitialized\n", r->name);
+			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
 				rdt_last_cmd_clear();
@@ -425,9 +436,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_all_schema, list) {
-				r = schema->res;
 				if (closid < schema->num_closid)
-					show_doms(s, r, closid);
+					show_doms(s, schema, closid);
 			}
 		}
 	} else {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6c87a81946b1..1e1f2493a87f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -384,9 +384,9 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
@@ -483,7 +483,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  unsigned long cbm);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 628e5eb4d7a9..592a517afd6a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1223,7 +1223,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 /**
  * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
- * @r: Resource to which domain instance @d belongs.
+ * @s: Schema for the resource to which domain instance @d belongs.
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
  * @closid: Intended closid for @cbm.
@@ -1241,9 +1241,10 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
  *
  * Return: true if CBM overlap detected, false if there is no overlap
  */
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
@@ -1272,17 +1273,20 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
+			if (rdtgroup_cbm_overlaps(s, d,
+						  hw_dom->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1414,6 +1418,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
+	struct resctrl_schema *schema;
 	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -1445,7 +1450,9 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(schema, &resctrl_all_schema, list) {
+		r = schema->res;
+
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -2730,11 +2737,12 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
  * Set the RDT domain up to start off with all usable allocations. That is,
  * all shareable and unused bits. All-zero CBM is invalid.
  */
-static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
+static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
 	struct rdt_domain *d_cdp = NULL;
+	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
@@ -2804,13 +2812,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
-static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
+static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &r->domains, list) {
-		ret = __init_one_rdt_domain(d, r, closid);
+	list_for_each_entry(d, &s->res->domains, list) {
+		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
 	}
@@ -2832,14 +2840,18 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 /* Initialize the RDT group's allocations. */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	int ret;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA) {
 			rdtgroup_init_mba(r);
 		} else {
-			ret = rdtgroup_init_cat(r, rdtgrp->closid);
+			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 20d8b6dd4af4..8a12f4128209 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -115,6 +115,7 @@ struct resctrl_membw {
 };
 
 struct rdt_parse_data;
+struct resctrl_schema;
 
 /**
  * @rid:		The index of the resource
@@ -162,7 +163,7 @@ struct rdt_resource {
 	u32			default_ctrl;
 	const char		*format_str;
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct rdt_resource *r,
+						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
@@ -171,7 +172,7 @@ struct rdt_resource {
 
 /**
  * @list:	Member of resctrl's schema list
- * @cdp_type:	Whether this entry is for code/data/both
+ * @conf_type:	Type of configuration, e.g. code/data/both
  * @res:	The rdt_resource for this entry
  * @num_closid	Number of CLOSIDs available for this resource
  */
-- 
2.28.0

