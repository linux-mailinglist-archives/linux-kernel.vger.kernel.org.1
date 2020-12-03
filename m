Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A32CE2A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgLCX06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:26:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:51637 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbgLCX05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:26:57 -0500
IronPort-SDR: Yf3+dfZKvDd7PQ1wdGguBXRe58ifEQg3rFmmswoH4WGR8u5oeDzaZXbNPc33pKfbhfZVEtgxVi
 ounzaDpjtgdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="172512667"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="172512667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 15:26:17 -0800
IronPort-SDR: vftLmPPF3Qnay6GIz6pnN6spag9yV5Oj/5MHQL5lEzVzPKira7RPf4hAEUSofjowxoI/NOeCr7
 YN5WCiC1upcQ==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="482158928"
Received: from rchatre-mobl1.jf.intel.com ([10.54.70.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 15:26:16 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, shakeelb@google.com,
        valentin.schneider@arm.com, mingo@redhat.com, babu.moger@amd.com,
        james.morse@arm.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/3] x86/resctrl: Fix a few issues in moving a task to a resource group
Date:   Thu,  3 Dec 2020 15:25:47 -0800
Message-Id: <cover.1607036601.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user writes a task id to the resctrl "tasks" file the task will be
moved to the resource group to which the destination "tasks" file belongs.
Primarily this includes updating the task's closid and rmid in its task_struct
and, for a running task, setting these new values in the PQR_ASSOC register
that reflects the active closid and rmid on a CPU.

Moving a task to a new resource group is currently accomplished by
updating its task_struct and queueing the work that updates the PQR_ASSOC
register. This queued work will be run as soon as possible if the task is
running or if the task is not running the queued work will be run when the task
exits the kernel and returns to user mode (task_work_add(...,..., TWA_RESUME)).

Updating the PQR_ASSOC MSR as soon as possible on the CPU a moved task
is running is the right thing to do. Queueing work for a task that is
not running is unnecessary (the PQR_ASSOC MSR is already updated when the
task is scheduled in) and causing system resource waste with the way in
which it is implemented: Work to update the PQR_ASSOC register is queued
every time the user writes a task id to the "tasks" file, even if the task
already belongs to the resource group. This could result in multiple pending
work items associated with a single task even if they are all identical and
even though only a single update with most recent values is needed.
Specifically, even if a task is moved between different resource groups
while it is sleeping, then it is only the last move that is relevant but
yet a work item is queued during each move.
This unnecessary queueing of work items could result in significant system
resource waste, especially on tasks sleeping for a long time. For example,
as demonstrated by Shakeel Butt in [1] writing the same task id to the
"tasks" file can quickly consume significant memory. The same problem
(wasted system resources) occurs when moving a task between different
resource groups. As pointed out by Valentin Schneider in [2] there is an
additional issue with the way in which the queueing of work is done in that
the task_struct update is currently done after the work is queued, resulting
in a race with the register update possibly done before the data needed
by the update is available.

This series fixes all the above issues related to the queueing of the updates
to the PQR_ASSOC register.

There is already a way in which resctrl moves tasks that can guide towards
a solution. Within resctrl tasks are also moved between resource groups when
a resource group is removed, also an action initiated by the user with "rmdir"
of the resource group directory. In this case resctrl moves all tasks belonging
to the removed group to the default resource group (in the case of a control
group) or the parent resource group (in the case of a monitor resource
group). These task moves are handled synchronously by resctrl with an
immediate update of the PQR_ASSOC register on the CPU the task is currently
running.

This fix follows the same update mechanism used as when resource groups are
removed. The task's closid and rmid is updated in its task_struct as
before. Instead of queueing work to update the PQR_ASSOC register with the
new values this update is done immediately on the CPU where the task is
currently running. If the task is not running there is no action since the
register will be updated when the task is scheduled in.

After patch 1 does some preparations, patch 2 updates
the PQR_ASSOC MSR in synchronous way instead of in a callback.
Patch 3 fixes the issue of unnecessary work when a task move is not needed
(when user writes a task id to a "tasks" file to which it already belongs)
by adding sanity checking to avoid costly move operations in the same resource
group.

Valentin's series in [2] ends by adding memory barriers to support the
updating of the task_struct from one CPU and the usage of the task_struct data
from another CPU. This work is still needed and as discussed with Valentin in
that thread the work would be re-evaluated by him after seeing how this series
turns out.

[1]: https://lore.kernel.org/lkml/CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/20201123022433.17905-1-valentin.schneider@arm.com

Fenghua Yu (3):
  x86/resctrl: Move setting task's active CPU in a mask into helpers
  x86/resctrl: Update PQR_ASSOC MSR synchronously when moving task to
    resource group
  x86/resctrl: Don't move a task to the same resource group

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 159 +++++++++++++------------
 1 file changed, 82 insertions(+), 77 deletions(-)


base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
2.26.2

