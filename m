Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32902A0ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJ3QMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:33 -0400
Received: from foss.arm.com ([217.140.110.172]:38934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgJ3QMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F87715EC;
        Fri, 30 Oct 2020 09:12:30 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD603F719;
        Fri, 30 Oct 2020 09:12:28 -0700 (PDT)
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
Subject: [PATCH 06/24] x86/resctrl: Store the effective num_closid in the schema
Date:   Fri, 30 Oct 2020 16:11:02 +0000
Message-Id: <20201030161120.227225-7-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_schema holds properties that vary with the style of configuration
that resctrl applies to a resource.

Once the arch code has a single resource per cache that can be configured,
resctrl will need to keep track of the num_closid itself.

Add num_closid to resctrl_schema. Change callers like
rdtgroup_schemata_show() to walk the schema instead.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 11 +++++------
 include/linux/resctrl.h                   |  2 ++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 14ea6a40993f..8ac104c634fe 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -286,11 +286,12 @@ int update_domains(struct rdt_resource *r, int closid)
 static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		if (!strcmp(resname, r->name) &&
-		     rdtgrp->closid < resctrl_arch_get_num_closid(r))
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
+		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -399,6 +400,7 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
+	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -422,8 +424,9 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			}
 		} else {
 			closid = rdtgrp->closid;
-			for_each_alloc_enabled_rdt_resource(r) {
-				if (closid < resctrl_arch_get_num_closid(r))
+			list_for_each_entry(schema, &resctrl_all_schema, list) {
+				r = schema->res;
+				if (closid < schema->num_closid)
 					show_doms(s, r, closid);
 			}
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cb16454a6b0e..1bd785b1920c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -103,13 +103,12 @@ int closids_supported(void)
 
 static void closid_init(void)
 {
+	struct resctrl_schema *s;
 	u32 rdt_min_closid = 32;
-	struct rdt_resource *r;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r)
-		rdt_min_closid = min(rdt_min_closid,
-				     resctrl_arch_get_num_closid(r));
+	list_for_each_entry(s, &resctrl_all_schema, list)
+		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
@@ -848,9 +847,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
-	struct rdt_resource *r = s->res;
 
-	seq_printf(seq, "%d\n", resctrl_arch_get_num_closid(r));
+	seq_printf(seq, "%d\n", s->num_closid);
 	return 0;
 }
 
@@ -2142,6 +2140,7 @@ static int create_schemata_list(void)
 			return -ENOMEM;
 
 		s->res = r;
+		s->num_closid = resctrl_arch_get_num_closid(r);
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_all_schema);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index de6cbc725753..b32152968bca 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -166,10 +166,12 @@ struct rdt_resource {
 /**
  * @list:	Member of resctrl's schema list
  * @res:	The rdt_resource for this entry
+ * @num_closid	Number of CLOSIDs available for this resource
  */
 struct resctrl_schema {
 	struct list_head		list;
 	struct rdt_resource		*res;
+	u32				num_closid;
 };
 
 /* The number of closid supported by this resource regardless of CDP */
-- 
2.28.0

