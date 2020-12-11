Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9582D8031
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394122AbgLKUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:47:58 -0500
Received: from foss.arm.com ([217.140.110.172]:51820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390401AbgLKUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:47:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134DC1042;
        Fri, 11 Dec 2020 12:46:32 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377123F68F;
        Fri, 11 Dec 2020 12:46:30 -0800 (PST)
References: <cover.1607036601.git.reinette.chatre@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, shakeelb@google.com,
        mingo@redhat.com, babu.moger@amd.com, james.morse@arm.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/resctrl: Fix a few issues in moving a task to a resource group
In-reply-to: <cover.1607036601.git.reinette.chatre@intel.com>
Date:   Fri, 11 Dec 2020 20:46:27 +0000
Message-ID: <jhjk0tot6jg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Reinette,

On 03/12/20 23:25, Reinette Chatre wrote:
> Valentin's series in [2] ends by adding memory barriers to support the
> updating of the task_struct from one CPU and the usage of the task_struct data
> from another CPU. This work is still needed and as discussed with Valentin in
> that thread the work would be re-evaluated by him after seeing how this series
> turns out.
>

So the "problematic" pattern is still there: a context switch can happen
concurrently with a write to the switching-to-tasks's {closid, rmid}.
Accesses to these fields would thus need to be wrapped by READ_ONCE() &
WRITE_ONCE().

Thinking a bit more (too much?) about it, we could limit ourselves to
wrapping only reads not protected by the rdtgroup_mutex: the only two
task_struct {closid, rmid} writers are
- rdtgroup_move_task()
- rdt_move_group_tasks()
and they are both invoked while holding said mutex. Thus, a reader holding
the mutex cannot race with a write, so load tearing ought to be safe.

> [1]: https://lore.kernel.org/lkml/CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com/
> [2]: https://lore.kernel.org/lkml/20201123022433.17905-1-valentin.schneider@arm.com
>
> Fenghua Yu (3):
>   x86/resctrl: Move setting task's active CPU in a mask into helpers
>   x86/resctrl: Update PQR_ASSOC MSR synchronously when moving task to
>     resource group
>   x86/resctrl: Don't move a task to the same resource group
>
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 159 +++++++++++++------------
>  1 file changed, 82 insertions(+), 77 deletions(-)
>
>
> base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
