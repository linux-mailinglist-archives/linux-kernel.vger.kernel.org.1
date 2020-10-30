Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27A2A0ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3QMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:35 -0400
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgJ3QMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330CB161B;
        Fri, 30 Oct 2020 09:12:33 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5150B3F719;
        Fri, 30 Oct 2020 09:12:31 -0700 (PDT)
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
Subject: [PATCH 07/24] x86/resctrl: Label the resources with their configuration type
Date:   Fri, 30 Oct 2020 16:11:03 +0000
Message-Id: <20201030161120.227225-8-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the name for the schema can be generated, the type of the
configuration being applied to the resource needs to be known. Label
all the entries in rdt_resources_all[], and copy that value in to struct
resctrl_schema.

Subsequent patches will generate the schema names in what will become
the fs code. Eventually the fs code will generate pairs of CODE/DATA if
the platform supports CDP for this resource.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
 include/linux/resctrl.h                | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5d5b566c4359..1ed5e04031e6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -62,6 +62,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
@@ -81,6 +82,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3DATA,
 			.name			= "L3DATA",
@@ -100,6 +102,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3CODE,
 			.name			= "L3CODE",
@@ -119,6 +122,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
@@ -138,6 +142,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2DATA,
 			.name			= "L2DATA",
@@ -157,6 +162,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2CODE,
 			.name			= "L2CODE",
@@ -176,6 +182,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_MBA] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 682e84aebd14..6c87a81946b1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -367,6 +367,7 @@ struct rdt_parse_data {
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  */
 struct rdt_hw_resource {
+	enum resctrl_conf_type	conf_type;
 	struct rdt_resource     resctrl;
 
 	int			num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1bd785b1920c..628e5eb4d7a9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2141,6 +2141,7 @@ static int create_schemata_list(void)
 
 		s->res = r;
 		s->num_closid = resctrl_arch_get_num_closid(r);
+		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_all_schema);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b32152968bca..20d8b6dd4af4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,12 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+enum resctrl_conf_type {
+	CDP_BOTH,
+	CDP_CODE,
+	CDP_DATA,
+};
+
 /**
  * struct rdt_domain - group of cpus sharing an RDT resource
  * @list:		all instances of this resource
@@ -165,11 +171,13 @@ struct rdt_resource {
 
 /**
  * @list:	Member of resctrl's schema list
+ * @cdp_type:	Whether this entry is for code/data/both
  * @res:	The rdt_resource for this entry
  * @num_closid	Number of CLOSIDs available for this resource
  */
 struct resctrl_schema {
 	struct list_head		list;
+	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
 };
-- 
2.28.0

