Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F62DDB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgLQWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:32:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:41193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbgLQWcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:32:21 -0500
IronPort-SDR: njfbTzmIjVQgnXXRnVFiEJM6c1lGSP468MIt74u9FczkUs4KDhogZgoLAUOYsS8LrA4/KVAUIO
 V4Qwc8OVxprg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="154567840"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="154567840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:41 -0800
IronPort-SDR: sf4eoyKznatGMqWdZGfMliFsG+gFS5zmLurPMo6Zk/5f4O3OLDh1C7+APALFVlTZjeqRO9lerf
 8Yt+wi6TM2LQ==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="387836623"
Received: from rchatre-mobl1.jf.intel.com ([10.54.70.7])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 14:31:40 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, shakeelb@google.com,
        valentin.schneider@arm.com, mingo@redhat.com, babu.moger@amd.com,
        james.morse@arm.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 0/4] x86/resctrl: Fix a few issues in moving a task to a resource group
Date:   Thu, 17 Dec 2020 14:31:17 -0800
Message-Id: <cover.1608243147.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 submission at:
https://lore.kernel.org/lkml/cover.1607036601.git.reinette.chatre@intel.com/

Changes since v1:
* Collect Reviewed-by tags.
* Stop using task_struct->on_cpu and use existing task_curr() helper
  instead. (James) This has two consequences:
  * The reason task_struct->on_cpu is no longer used is because it may
    trigger unnecessary IPI. Add a new fix patch that replaces
    task_struct->on_cpu in existing usages with task_curr(). (James)
  * The original first patch that introduced some helpers that used
    task_struct->on_cpu is removed. task_curr() is used directly in
    new version without additional helpers.
* Improve subject line of original patch #2 (now patch #1). (James)
* Use IS_ENABLED() instead of #ifdef to check for Kconfig symbol. (James)
* Remove check for impossible condition. Resource groups are only created
  of type RDTCTRL_GROUP or RDTMON_GROUP, there is no purpose to check for a
  third group type. This unnecessary check was added in this series but
  unrelated to this fix, removing this check maintains original behavior.
  This is a change that merges feedback from both James and Valentin about
  this snippet.
* Re-evaluation of memory barriers by Valentin is complete:
  * Include barrier() after closid/rmid are written before using task_curr()
    to decide if task needs interrupting. (Valentin)
  * Add new patch from Valentin that prevents load/store tearing if a task is
    moved while it is scheduled. (Valentin)
  * Fixup subject line x86/intel_rdt -> x86/resctrl. (Reinette)
* Highlighting an update to cover letter below: Patch 3 and Patch 4 from
  this version do not meet the criteria in stable-kernel-rules.rst of
  "It must fix a real bug that bothers people ..." and thus do not contain
  a Fixes tag nor are they Cc'd to stable.

---

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

* Patch 1 updates the PQR_ASSOC MSR in synchronous way instead of in a callback.
* Patch 2 fixes the issue of unnecessary work when a task move is not needed
  (when user writes a task id to a "tasks" file to which it already belongs)
  by adding sanity checking to avoid costly move operations in the same resource
  group.
* Patch 3 replaces remaining usages of task_struct->on_cpu with * task_curr().
* Patch 4 prevents load/store tearing if a task is moved while
  it is scheduled. (Valentin)

Patch 3 and Patch 4 do not meet the criteria in
stable-kernel-rules.rst of "It must fix a real bug that bothers people ..."
and thus do not contain a Fixes tag nor are they submitted to stable.

[1]: https://lore.kernel.org/lkml/CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/20201123022433.17905-1-valentin.schneider@arm.com

Fenghua Yu (2):
  x86/resctrl: Use IPI instead of task_work_add() to update PQR_ASSOC
    MSR
  x86/resctrl: Don't move a task to the same resource group

Reinette Chatre (1):
  x86/resctrl: Use task_curr() instead of task_struct->on_cpu to prevent
    unnecessary IPI

Valentin Schneider (1):
  x86/resctrl: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid & .closid

 arch/x86/include/asm/resctrl.h         |  11 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 143 +++++++++++--------------
 2 files changed, 70 insertions(+), 84 deletions(-)


base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.26.2

