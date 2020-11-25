Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC52C35D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKYA4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgKYA4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:56:06 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65CF2151B;
        Wed, 25 Nov 2020 00:56:04 +0000 (UTC)
Date:   Tue, 24 Nov 2020 19:56:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "J. Avila" <elavila@google.com>
Cc:     mingo@redhat.com, gregkh@linuxfoundation.org,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Potential Issue in Tracing Ring Buffer
Message-ID: <20201124195602.0ac14dee@oasis.local.home>
In-Reply-To: <20201124223917.795844-1-elavila@google.com>
References: <20201124223917.795844-1-elavila@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 22:39:17 +0000
"J. Avila" <elavila@google.com> wrote:

> Hello,
> 
> In the ftrace logs we've collected internally, we have found that there are
> situations where time seems to go backwards; this breaks userspace tools which
> expect time to always go forward in these logs. For example, in this snippet
> from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
> John!), we see:
> 
>       android.bg-568     [002] dN.1        26247: rcu_utilization: Start context switch
>            <...>-589     [003] ....        26247: sys_enter: NR 73 (b400006f4898c520, 2, 0, 0, 0, 11)
>  PowerManagerSer-578     [001] d..2        26248: sched_switch: prev_comm=PowerManagerSer prev_pid=578 prev_prio=116 prev_state=S ==> next_comm=Binder:381_2 next_pid=395 next_prio=120
>       android.bg-568     [002] dN.1        26248: rcu_utilization: End context switch
>            <...>-589     [003] d..1        26249: rcu_utilization: Start context switch
>            <...>-589     [003] d..1        26250: rcu_utilization: End context switch
>     Binder:381_2-395     [001] ....        26251: sys_exit: NR 98 = 0
>       android.bg-568     [002] dN.2        26251: sched_stat_wait: comm=kworker/u16:3 pid=164 delay=0 [ns]
>            <...>-589     [003] d..2        26252: sched_stat_runtime: comm=statsd.writer pid=589 runtime=611094 [ns] vruntime=24367153868 [ns]
>       android.bg-568     [002] d..2        26254: sched_switch: prev_comm=android.bg prev_pid=568 prev_prio=130 prev_state=R+ ==> next_comm=kworker/u16:3 next_pid=164 next_prio=120
>    kworker/u16:3-164     [002] ....        26256: workqueue_execute_start: work struct 00000000ab3fe95e: function ufshcd_clk_scaling_resume_work
>     Binder:381_2-395     [001] ....        26257: sys_enter: NR 98 (b400006fb8984bf0, 89, 185c, 0, 0, ffffffff)
>     Binder:381_2-395     [001] d..1        26258: rcu_utilization: Start context switch
>    kworker/u16:3-164     [002] ....        26258: workqueue_execute_end: work struct 00000000ab3fe95e: function ufshcd_clk_scaling_resume_work
>     Binder:381_2-395     [001] d..1        26260: rcu_utilization: End context switch
>    kworker/u16:3-164     [002] d..1        26261: rcu_utilization: Start context switch
>     Binder:381_2-395     [001] d..2        26262: sched_stat_runtime: comm=Binder:381_2 pid=395 runtime=100989 [ns] vruntime=40144094287 [ns]
>    kworker/u16:3-164     [002] d..1        26263: rcu_utilization: End context switch
>    kworker/u16:3-164     [002] d..2        26237: sched_stat_runtime: comm=kworker/u16:3 pid=164 runtime=71614 [ns] vruntime=32851170186 [ns]
>    kworker/u16:3-164     [002] d..2        26240: sched_stat_wait: comm=android.bg pid=568 delay=99635 [ns]
>    kworker/u16:3-164     [002] d..2        26241: sched_switch: prev_comm=kworker/u16:3 prev_pid=164 prev_prio=120 prev_state=I ==> next_comm=android.bg next_pid=568 next_prio=130
> 
> In this trace, we switched the trace clock to counter to rule out hardware
> issues, but this has been seen with default settings as well. This is
> consistently reproducible - we see it regularly when collecting any trace for
> ~60 seconds. This seems like it could be a problem in the upstream code, as this
> kernel had no modifications made to the ftrace code. Is this a known problem in
> upstream? Is there any additional information I could provide to verify this is
> an upstream issue? Is anyone else observing this behavior, and if so, do they
> happen to be working on a fix? If not, do you have any pointers on how we can
> address this?
> 

Thanks for the report. 

I recently updated the time stamp code to allow for nesting of events
to work better, but the above trace doesn't look like it should be
hitting that path.

If you could use trace-cmd to extract a raw data file that exhibits
this behavior, and be able to supply that for me, I would be able to
look at the data structures underneath, and that would be helpful in
finding the cause.

In the mean time, could you check if you see this issue with commit
097350d1c6e1f5808cae142006f18a0bbc57018d.

Also what architecture was this running on? Arm? Arm64?

32 bit code does some funky things to handle atomic 64 bit updates.

> 
> [1] Taken from https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline

I'll take a look at this too.

Thanks!

-- Steve
