Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304D2FA07C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391923AbhARMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:53:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391902AbhARMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610974293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFFZ8+/lSS0CJf7x6IE5W6o4YuRr0PvV5pJGCgayEw4=;
        b=cd+KwWLgPWarEQFkIM5Iod2mb2N6cmWMAEA9nDzKgcNVH8TditJCHJpzfLGMzr90AY243t
        IFb7r7TuxCyePkGshSkqZvVqvrYdMLHJMAcaDwVF87tJEhoVZrBrXfUxkH13sCHbqfcnE6
        QoFvxzvSXSz7g0j/ulYj2s0L6UCTbQo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-4VZsZr5hOfWqW0eYMw0AaQ-1; Mon, 18 Jan 2021 07:51:32 -0500
X-MC-Unique: 4VZsZr5hOfWqW0eYMw0AaQ-1
Received: by mail-ed1-f72.google.com with SMTP id dh21so7787852edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFFZ8+/lSS0CJf7x6IE5W6o4YuRr0PvV5pJGCgayEw4=;
        b=QQKCcqZa/3mjNMc+zk5PnhkQk/VhgxFk1nrJPkwYee6VGiKZgyw5pa/uN52a87eKgG
         fM6i0KQrcWSRgmDQGOhdANgEIwUgIn/8xvkBCgFnGMrQ3z8FvuExM0CwoTPv9E3Kemb2
         r0XltMDGLWIsUpdF6KEPDSfufQwbkI4Hjdy1rPfen/e1Ww4SI9NDDzTXq1bf8Dpms17L
         pLYvR9kKddKQInlOmXJ70h/9rAx1o8bY84TxmYUTrhKw5koQBLEzSRUTE9eFj1sZxpyW
         0E+8x/J7QybpEAbebwTUnMSY6b6dZt99R/FvprBFOmhaK0gnlQQwMhTYA5jKP6HtMKkO
         JgUw==
X-Gm-Message-State: AOAM5302mxmimgvIMvZYN/CluDIjuUBPO+qoTk1GmQGypF7UoAVaOIYF
        ab2dZVRF1jRxBAKMJDUXOQF2a82gw0QVE8RRVvXxMVYypISKw7/OhV0xq3+lsfEErZqvLRsnff7
        MEJzTqsyPBSfc73EwBVGsUXHO
X-Received: by 2002:a17:906:4c48:: with SMTP id d8mr17057519ejw.358.1610974290228;
        Mon, 18 Jan 2021 04:51:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwp01eMBrLYYfp2GxCeFr6YXJANwVYpn+s/drkEARaone3Di2N7gtpe+cdTMGy9/z61GzmgKg==
X-Received: by 2002:a17:906:4c48:: with SMTP id d8mr17057503ejw.358.1610974289984;
        Mon, 18 Jan 2021 04:51:29 -0800 (PST)
Received: from x1.bristot.me (host-79-46-192-171.retail.telecomitalia.it. [79.46.192.171])
        by smtp.gmail.com with ESMTPSA id u2sm7618148edp.12.2021.01.18.04.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 04:51:29 -0800 (PST)
Subject: Re: [PATCH 3/6] sched/deadline: Allow DL tasks on empty (cgroup v2)
 cpusets
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
References: <cover.1610463999.git.bristot@redhat.com>
 <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
 <17db52d5-9967-969f-de03-ae6aec03c53e@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <0a5b196b-6ddf-5eb7-248f-da587f615559@redhat.com>
Date:   Mon, 18 Jan 2021 13:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <17db52d5-9967-969f-de03-ae6aec03c53e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 1:12 PM, Dietmar Eggemann wrote:
> On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:
>> cgroups v2 allows the cpuset controller to be enabled/disabled on
>> demand. On Fedora 32, cpuset is disabled by default. To enable it,
>> a user needs to:
>>
>>   # cd /sys/fs/cgroup/
>>   # echo +cpuset > cgroup.subtree_control
>>
>> Existing cgroups will expose the cpuset interface (e.g., cpuset.cpus
>> file). By default, cpuset.cpus has no CPU assigned, which means that
>> existing tasks will move to a cpuset without cpus.
>>
>> With that in mind, look what happens if a SCHED_DEADLINE task exists
>> on any cgroup (user.slice by default on Fedora):
>>
>> ----- %< -----
>>   # chrt -d --sched-period 1000000000 --sched-runtime 100000000 0 sleep 100 &
> 
> Like you mentioned above, to see the issue the DL task has to be moved
> into the cgroup (e.g. user.slice) here:
> 
> echo $PID > /sys/fs/cgroup/user.slice/cgroup.procs

Ops, I "forgot" to add this step because Fedora/systemd does it by default.

I will add this to the log.

>>   # cd /sys/fs/cgroup/
>>   # echo '+cpuset' > cgroup.subtree_control
>>   [   65.384041] BUG: unable to handle page fault for address: ffffffffb720f7e0
>>   [   65.384551] #PF: supervisor read access in kernel mode
>>   [   65.384923] #PF: error_code(0x0000) - not-present page
>>   [   65.385298] PGD 61a15067 P4D 61a15067 PUD 61a16063 PMD 800fffff9ddff062
>>   [   65.385781] Oops: 0000 [#1] SMP PTI
>>   [   65.386042] CPU: 0 PID: 799 Comm: sh Not tainted 5.10.0-rc3 #1
>>   [   65.386461] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
>>   [   65.387077] RIP: 0010:dl_task_can_attach+0x40/0x250
>>   [   65.387429] Code: 54 55 53 48 83 ec 18 48 89 3c 24 bf ff ff ff ff e8 05 a2 52 00
>>                        4c 63 f0 48 c7 c5 00 9e 02 00 4a 8b 04 f5 00 09 47 b6 48 89 ea
>>                        <4c> 8b a4 10 e0 09 00 00 49 8d 44 24 40 48 89 c7 48 89 44 24
>>                        08 e8
>>   [   65.388768] RSP: 0018:ffffaee8c056fcd8 EFLAGS: 00010283
>>   [   65.389148] RAX: ffffffffb71e5000 RBX: ffffaee8c056fdd0 RCX: 0000000000000040
>>   [   65.389661] RDX: 0000000000029e00 RSI: ffff9db202534e48 RDI: ffffffffb6d3a3e0
>>   [   65.390174] RBP: 0000000000029e00 R08: 0000000000000000 R09: 0000000000000004
>>   [   65.390686] R10: 0000000000000001 R11: 00000000ffa6fbff R12: ffffaee8c056fbf0
>>   [   65.391196] R13: ffff9db2024e1400 R14: 0000000000000004 R15: ffff9db20ebb31e0
>>   [   65.391710] FS:  00007f6df41b1740(0000) GS:ffff9db377c00000(0000) knlGS:0000000000000000
>>   [   65.392289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [   65.392705] CR2: ffffffffb720f7e0 CR3: 000000010680a003 CR4: 0000000000370ef0
>>   [   65.393220] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [   65.393732] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [   65.394244] Call Trace:
>>   [   65.394437]  cpuset_can_attach+0x8b/0x110
>>   [   65.394732]  cgroup_migrate_execute+0x70/0x430
>>   [   65.395057]  cgroup_update_dfl_csses+0x222/0x230
>>   [   65.395392]  cgroup_subtree_control_write+0x2c6/0x3c0
>>   [   65.395759]  kernfs_fop_write+0xce/0x1b0
>>   [   65.396048]  vfs_write+0xc2/0x230
>>   [   65.396291]  ksys_write+0x4f/0xc0
>>   [   65.396533]  do_syscall_64+0x33/0x40
>>   [   65.396797]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   [   65.397166] RIP: 0033:0x7f6df42a6537
>>   [   65.397428] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
>>                        1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05
>>                        <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
>>                        74 24
>>   [   65.398766] RSP: 002b:00007ffee4128018 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>   [   65.399838] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f6df42a6537
>>   [   65.400923] RDX: 0000000000000008 RSI: 000055b3f7e549e0 RDI: 0000000000000001
>>   [   65.402003] RBP: 000055b3f7e549e0 R08: 000000000000000a R09: 0000000000000007
>>   [   65.403082] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000008
>>   [   65.404156] R13: 00007f6df4378500 R14: 0000000000000008 R15: 00007f6df4378700
>>   [   65.405218] Modules linked in: <lots of modules>
>>   [   65.414172] CR2: ffffffffb720f7e0
>>   [   65.415117] ---[ end trace 2dbff1a688549e65 ]---
>> ----- >% -----
>>
>> That happens because on dl_task_can_attach():
>>         dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
>>
>> returns a non active cpu.
> 
> Since cs_cpus_allowed is empty dest_cpu should be an invalid CPU (>=
> nr_cpu_ids) here.

Correct, I will change the "non active" to "an invalid CPU (>= > nr_cpu_ids)"

>> Initially, I thought about returning an error and blocking the
>> operation. However, that is indeed not needed. The cpuset without
>> CPUs assigned will be a non-root cpuset, hence its cpu mask will
>> be the same as the root one. So, the bandwidth was already accounted,
>> and the task can proceed.
> 
> LGTM.
> 
> After the '/sys/fs/cgroup# echo '+cpuset' > cgroup.subtree_control':
> 
> root's cpuset.cpus.effective == user.slice's cpuset.cpus.effective

Good, thanks!

-- Daniel

>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Li Zefan <lizefan@huawei.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Valentin Schneider <valentin.schneider@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: cgroups@vger.kernel.org
>> ---
>>  kernel/sched/deadline.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 943aa32cc1bc..788a391657a5 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2871,6 +2871,13 @@ int dl_task_can_attach(struct task_struct *p,
>>  	bool overflow;
>>  	int ret;
>>  
>> +	/*
>> +	 * The cpuset has no cpus assigned, so the thread will not
>> +	 * change its affinity.
>> +	 */
>> +	if (cpumask_empty(cs_cpus_allowed))
>> +		return 0;
>> +
>>  	/*
>>  	 * The task is not moving to another root domain, so it is
>>  	 * already accounted.
>>
> 

