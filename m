Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1602B6B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKQRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:21:30 -0500
Received: from foss.arm.com ([217.140.110.172]:33408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgKQRVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:21:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBCC101E;
        Tue, 17 Nov 2020 09:21:29 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC9F13F718;
        Tue, 17 Nov 2020 09:21:28 -0800 (PST)
References: <20201117003123.GB3723@shao2-debian>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@lists.01.org>, lkp@intel.com
Subject: Re: 5b9f8ff7b3 ("sched/debug: Output SD flag names rather than .."): [  320.831182] BUG: KASAN: double-free or invalid-free in sd_ctl_doflags
In-reply-to: <20201117003123.GB3723@shao2-debian>
Date:   Tue, 17 Nov 2020 17:21:26 +0000
Message-ID: <jhjr1orx5k9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 17/11/20 00:31, kernel test robot wrote:
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit 5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a
> Author:     Valentin Schneider <valentin.schneider@arm.com>
> AuthorDate: Mon Aug 17 12:29:52 2020 +0100
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed Aug 19 10:49:48 2020 +0200
>
>     sched/debug: Output SD flag names rather than their values
>     
>     Decoding the output of /proc/sys/kernel/sched_domain/cpu*/domain*/flags has
>     always been somewhat annoying, as one needs to go fetch the bit -> name
>     mapping from the source code itself. This encoding can be saved in a script
>     somewhere, but that isn't safe from flags being added, removed or even
>     shuffled around.
>     
>     What matters for debugging purposes is to get *which* flags are set in a
>     given domain, their associated value is pretty much meaningless.
>     
>     Make the sd flags debug file output flag names.
>     
>     Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>     Link: https://lore.kernel.org/r/20200817113003.20802-7-valentin.schneider@arm.com
>
> 65c5e25316  sched/topology: Verify SD_* flags setup when sched_debug is on
> 5b9f8ff7b3  sched/debug: Output SD flag names rather than their values
> 3cea11cd5e  Linux 5.10-rc2
> +-------------------------------------------------+------------+------------+-----------+
> |                                                 | 65c5e25316 | 5b9f8ff7b3 | v5.10-rc2 |
> +-------------------------------------------------+------------+------------+-----------+
> | boot_successes                                  | 824        | 523        | 322       |
> | boot_failures                                   | 491        | 331        | 145       |
> | WARNING:at_mm/usercopy.c:#usercopy_warn         | 439        | 292        | 143       |
> | RIP:usercopy_warn                               | 439        | 292        | 143       |
> | INFO:rcu_sched_self-detected_stall_on_CPU       | 38         | 22         |           |
> | RIP:iov_iter_copy_from_user_atomic              | 26         | 15         |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c0:#] | 6          | 3          |           |
> | Kernel_panic-not_syncing                        | 39         | 23         |           |
> | RIP:ftrace_likely_update                        | 33         | 19         |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c6:#] | 5          | 3          |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c4:#] | 10         | 4          |           |
> | WARNING:kernel_stack                            | 3          | 1          |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c2:#] | 6          | 2          |           |
> | RIP:init_numa_balancing                         | 1          |            |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c5:#] | 5          | 2          |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c7:#] | 3          | 3          |           |
> | RIP:default_idle                                | 2          | 2          |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c3:#] | 4          | 4          |           |
> | BUG:kernel_hang_in_boot_stage                   | 8          | 1          | 1         |
> | WARNING:at_fs/read_write.c:#vfs_copy_file_range | 1          |            |           |
> | RIP:vfs_copy_file_range                         | 1          |            |           |
> | invoked_oom-killer:gfp_mask=0x                  | 0          | 1          |           |
> | Mem-Info                                        | 0          | 2          |           |
> | BUG:KASAN:double-free_or_invalid-free_in_s      | 0          | 10         | 1         |
> | RIP:_raw_spin_unlock_irq                        | 0          | 1          |           |
> | BUG:kernel_reboot-without-warning_in_test_stage | 0          | 1          |           |
> | BUG:soft_lockup-CPU##stuck_for#s![trinity-c1:#] | 0          | 1          |           |
> | canonical_address#:#[##]                        | 0          | 1          |           |
> | RIP:write_port                                  | 0          | 1          |           |
> +-------------------------------------------------+------------+------------+-----------+
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>

This has been fixed by Colin, and is in v5.10-rc4:

8d4d9c7b4333 ("sched/debug: Fix memory corruption caused by multiple small reads of flags")

Thanks.
