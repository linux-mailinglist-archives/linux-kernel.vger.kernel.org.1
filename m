Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3712DDB82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgLQWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:32:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:41193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732093AbgLQWcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:32:36 -0500
IronPort-SDR: M/AweB77v9wpLNjUdE/MpSUpqtInQhkDK9SVBRfEXK97sJs5HuH3f5yTOFD7TJTg/N42ZrEkdU
 rc6CT+P+lFHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="154567844"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="154567844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:42 -0800
IronPort-SDR: /h7CkohHygaqnMedCl1EMetgbvcq2vwndt/lJfeUM7SRf71XhRD9gSciImykg1WkWFViXQl47V
 bSt4l/7YW58Q==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="387836637"
Received: from rchatre-mobl1.jf.intel.com ([10.54.70.7])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, shakeelb@google.com,
        valentin.schneider@arm.com, mingo@redhat.com, babu.moger@amd.com,
        james.morse@arm.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 3/4] x86/resctrl: Use task_curr() instead of task_struct->on_cpu to prevent unnecessary IPI
Date:   Thu, 17 Dec 2020 14:31:20 -0800
Message-Id: <e9e68ce1441a73401e08b641cc3b9a3cf13fe6d4.1608243147.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608243147.git.reinette.chatre@intel.com>
References: <cover.1608243147.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James reported in [1] that there could be two tasks running on the same CPU
with task_struct->on_cpu set. Using task_struct->on_cpu as a test if a task
is running on a CPU may thus match the old task for a CPU while the
scheduler is running and IPI it unnecessarily.

task_curr() is the correct helper to use. While doing so move the #ifdef
check of the CONFIG_SMP symbol to be a C conditional used to determine
if this helper should be used to ensure the code is always checked for
correctness by the compiler.

[1] https://lore.kernel.org/lkml/a782d2f3-d2f6-795f-f4b1-9462205fd581@arm.com

Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
V1->V2:
* New patch in series

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4042e1eb4f5d..9bd36210d220 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2319,19 +2319,15 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			t->closid = to->closid;
 			t->rmid = to->mon.rmid;
 
-#ifdef CONFIG_SMP
 			/*
-			 * This is safe on x86 w/o barriers as the ordering
-			 * of writing to task_cpu() and t->on_cpu is
-			 * reverse to the reading here. The detection is
-			 * inaccurate as tasks might move or schedule
-			 * before the smp function call takes place. In
-			 * such a case the function call is pointless, but
+			 * If the task is on a CPU, set the CPU in the mask.
+			 * The detection is inaccurate as tasks might move or
+			 * schedule before the smp function call takes place.
+			 * In such a case the function call is pointless, but
 			 * there is no other side effect.
 			 */
-			if (mask && t->on_cpu)
+			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
 				cpumask_set_cpu(task_cpu(t), mask);
-#endif
 		}
 	}
 	read_unlock(&tasklist_lock);
-- 
2.26.2

