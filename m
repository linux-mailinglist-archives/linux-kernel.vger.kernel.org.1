Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E585C218D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgGHQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:40:16 -0400
Received: from foss.arm.com ([217.140.110.172]:51294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730643AbgGHQkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:40:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F491396;
        Wed,  8 Jul 2020 09:40:12 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C8D03F68F;
        Wed,  8 Jul 2020 09:40:11 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v5 06/10] x86/resctrl: Use is_closid_match() in more places
Date:   Wed,  8 Jul 2020 16:39:25 +0000
Message-Id: <20200708163929.2783-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708163929.2783-1-james.morse@arm.com>
References: <20200708163929.2783-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdtgroup_tasks_assigned() and show_rdt_tasks() loop over threads testing
for a CTRL/MON group match by closid/rmid with the provided rdtgrp.
Further down the file are helpers to do this, move these further up and
make use of them here.

These helpers additionally check for alloc/mon capable. This is harmless
as rdtgroup_mkdir() tests these capable flags before allowing the config
directories to be created.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0398769b90f1..5ec0cf27b426 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -592,6 +592,18 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return ret;
 }
 
+static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_alloc_capable &&
+	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+}
+
+static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_mon_capable &&
+	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+}
+
 /**
  * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
  * @r: Resource group
@@ -607,8 +619,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			ret = 1;
 			break;
 		}
@@ -706,8 +717,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid))
+		if (is_closid_match(t, r) || is_rmid_match(t, r))
 			seq_printf(s, "%d\n", t->pid);
 	}
 	rcu_read_unlock();
@@ -2244,18 +2254,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_alloc_capable &&
-		(r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_mon_capable &&
-		(r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
-}
-
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
-- 
2.20.1

