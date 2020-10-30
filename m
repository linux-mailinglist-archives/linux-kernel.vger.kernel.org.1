Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF22A0AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJ3QMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:24 -0400
Received: from foss.arm.com ([217.140.110.172]:38884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgJ3QMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE6015A2;
        Fri, 30 Oct 2020 09:12:22 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5533F719;
        Fri, 30 Oct 2020 09:12:20 -0700 (PDT)
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
Subject: [PATCH 04/24] x86/resctrl: Add a separate schema list for resctrl
Date:   Fri, 30 Oct 2020 16:11:00 +0000
Message-Id: <20201030161120.227225-5-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support multiple architectures, the resctrl code needs to be split
into a 'fs' specific part in core code, and an arch-specific backend.

It should be difficult for the arch-specific backends to diverge,
supporting slightly different ABIs for user-space. For example,
generating, parsing and validating the schema configuration values
should be done in what becomes the core code to prevent divergence.
Today, the schema emerge from which entries in the rdt_resources_all
array the arch code has chosen to enable.

Start by creating a struct resctrl_schema, which will eventually hold
the name and pending configuration values for resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 +++++++++++++++++++++++++-
 include/linux/resctrl.h                |  9 ++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f7aab9245259..682e84aebd14 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -106,6 +106,7 @@ extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
+extern struct list_head resctrl_all_schema;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index df10135f021e..f79a5e548138 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
 
+/* list of entries for the schemata file */
+LIST_HEAD(resctrl_all_schema);
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -2117,6 +2120,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
+static int create_schemata_list(void)
+{
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (!s)
+			return -ENOMEM;
+
+		s->res = r;
+
+		INIT_LIST_HEAD(&s->list);
+		list_add(&s->list, &resctrl_all_schema);
+	}
+
+	return 0;
+}
+
+static void destroy_schemata_list(void)
+{
+	struct resctrl_schema *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &resctrl_all_schema, list) {
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2138,11 +2170,17 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_cdp;
 
+	ret = create_schemata_list();
+	if (ret) {
+		destroy_schemata_list();
+		goto out_mba;
+	}
+
 	closid_init();
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_mba;
+		goto out_schemata_free;
 
 	if (rdt_mon_capable) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2194,6 +2232,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_schemata_free:
+	destroy_schemata_list();
 out_mba:
 	if (ctx->enable_mba_mbps)
 		set_mba_sc(false);
@@ -2439,6 +2479,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	destroy_schemata_list();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index dfb0f32b73a1..de6cbc725753 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -163,6 +163,15 @@ struct rdt_resource {
 
 };
 
+/**
+ * @list:	Member of resctrl's schema list
+ * @res:	The rdt_resource for this entry
+ */
+struct resctrl_schema {
+	struct list_head		list;
+	struct rdt_resource		*res;
+};
+
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 
-- 
2.28.0

