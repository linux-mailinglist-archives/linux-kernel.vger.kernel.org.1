Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579C52BFE26
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKWCY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:24:56 -0500
Received: from foss.arm.com ([217.140.110.172]:51724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgKWCY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:24:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B37781042;
        Sun, 22 Nov 2020 18:24:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 650CC3F70D;
        Sun, 22 Nov 2020 18:24:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     James Morse <James.Morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/3] x86/intel_rdt: Check monitor group vs control group membership earlier
Date:   Mon, 23 Nov 2020 02:24:31 +0000
Message-Id: <20201123022433.17905-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123022433.17905-1-valentin.schneider@arm.com>
References: <20201123022433.17905-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A task can only be moved between monitor groups if both groups belong to
the same control group. This is checked fairly late however: by that time
we already have appended a task_work() callback, the execution of which
will be useless (there are no closid/rmid updates to handle, barring
concurrent writes).

Check the validity of the move earlier to save any kzalloc() /
task_work_add() if it wasn't going to be necessary.

Reviewed-by: James Morse <James.Morse@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..b6b5b95df833 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -581,12 +581,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 			tsk->closid = rdtgrp->closid;
 			tsk->rmid = rdtgrp->mon.rmid;
 		} else if (rdtgrp->type == RDTMON_GROUP) {
-			if (rdtgrp->mon.parent->closid == tsk->closid) {
-				tsk->rmid = rdtgrp->mon.rmid;
-			} else {
-				rdt_last_cmd_puts("Can't move task to different control group\n");
-				ret = -EINVAL;
-			}
+			tsk->rmid = rdtgrp->mon.rmid;
 		}
 	}
 	return ret;
@@ -673,9 +668,19 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	rcu_read_unlock();
 
 	ret = rdtgroup_task_write_permission(tsk, of);
-	if (!ret)
-		ret = __rdtgroup_move_task(tsk, rdtgrp);
+	if (ret)
+		goto out;
 
+	if (rdtgrp->type == RDTMON_GROUP &&
+	    rdtgrp->mon.parent->closid != tsk->closid) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = __rdtgroup_move_task(tsk, rdtgrp);
+
+out:
 	put_task_struct(tsk);
 	return ret;
 }
-- 
2.27.0

