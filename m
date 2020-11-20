Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719452BAB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgKTODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:03:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287AC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:03:41 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so8568054wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoGES5JnpzdJHEq/vqglQmICNCpPQHRF+Aicnxqj2bQ=;
        b=pELj+m5x/RnFxR+lyP7d1gNnv9sT6BsZgJ8RLgFFJ6gId8UFiSODdgskgYQjDtD78s
         +QhHwHXZV2EcXMBW1QAS/OE4cvKOGJkfuwRC2tksmmoXRmkg8Lcn4nCNegrMXEdwK1wE
         cF3XkZGFS/WMXpv37UC8rUjY5xpy2v6SROSEBIF068ZqkH4+f20nF1lDF3uKYBQtNhp5
         xrQQ0h47cc4ORpQYPvJTre8E1ktVv+Kmxm6Vcq1hPWbgaix4p5qEV2WCq4v2JZ7h6Dp7
         vHmm3Ri/E4a0ZuUHPKgwXIFnI7N8WwDzmM+fN/iiUkWbnkFztbAka0s7qmSDAqB68QK5
         VDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoGES5JnpzdJHEq/vqglQmICNCpPQHRF+Aicnxqj2bQ=;
        b=hQnNzwUdwmjDrKa6wiLn92wVVE1YcQXWLLeoVryierydKDgjy2CqkzyqyqWQ7HKqEv
         r0JYEtN7By4GOZDT2o4qG876RHQyEDZfs0vdUjwL6SBYD42q6XBYWkMOrjY+NU6nQCMD
         0eQrNeUKPx6wm5bV3vwfuBhq517+dK3A80RjXQJURsmHJwX+mF1GNUyGfROVfh2pkhxu
         4nnmn7zMJARuMW0+x8OrwoNpjDQ6fJDHdWPvzq7lzSrSv2DB/FoL6Pfmr6ceR8gXKNAk
         8FrA6rwwBLgA4EX7e2IEvu4+xnr4fU/R50/MIsmNLfgDc2JoSJ4woMJvp6bLBOr85FDL
         lNEw==
X-Gm-Message-State: AOAM532O0swSDzjz5WOradvbatmRycK6hCB8WZRm7o6cA79I0h0uoh4t
        3u3ZrU51IDKpTHHvgtdoj2pfrQ==
X-Google-Smtp-Source: ABdhPJxSaWgS9aonVFKG1iViswburju76VkmVzWzOuTtdPo4kcZnsj4lV8n715/ZQK8YaNrskWaQnA==
X-Received: by 2002:a1c:f017:: with SMTP id a23mr10277443wmb.56.1605881019458;
        Fri, 20 Nov 2020 06:03:39 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id x2sm4946040wru.44.2020.11.20.06.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 06:03:37 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:03:32 +0100
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120140332.GA3120165@elver.google.com>
References: <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120103031.GB2328@C02TD0UTHF1T.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:30AM +0000, Mark Rutland wrote:
> On Thu, Nov 19, 2020 at 10:53:53PM +0000, Will Deacon wrote:
> > On Thu, Nov 19, 2020 at 01:35:12PM -0800, Paul E. McKenney wrote:
> > > On Thu, Nov 19, 2020 at 08:38:19PM +0100, Marco Elver wrote:
> > > > On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > > I can try bisection again, or reverting some commits that might be
> > > > > > suspicious? But we'd need some selection of suspicious commits.
> > > > > 
> > > > > The report claims that one of the rcu_node ->lock fields is held
> > > > > with interrupts enabled, which would indeed be bad.  Except that all
> > > > > of the stack traces that it shows have these locks held within the
> > > > > scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> > > > > try_invoke_on_locked_down_task() with irqs disabled" but without the
> > > > > "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> > > > > commit, I understand why.  With both, I don't see how this happens.
> > > > 
> > > > I'm at a loss, but happy to keep bisecting and trying patches. I'm also
> > > > considering:
> > > > 
> > > > 	Is it the compiler? Probably not, I tried 2 versions of GCC.
> > > > 
> > > > 	Can we trust lockdep to precisely know IRQ state? I know there's
> > > > 	been some recent work around this, but hopefully we're not
> > > > 	affected here?
> > > > 
> > > > 	Is QEMU buggy?
> > > > 
> > > > > At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> > > > > calls at various points in that code, as shown in the patch below.
> > > > > 
> > > > > At this point, I would guess that your first priority would be the
> > > > > initial bug rather than this following issue, but you never know, this
> > > > > might well help diagnose the initial bug.
> > > > 
> > > > I don't mind either way. I'm worried deadlocking the whole system might
> > > > be worse.
> > > 
> > > Here is another set of lockdep_assert_irqs_disabled() calls on the
> > > off-chance that they actually find something.
> > 
> > FWIW, arm64 is known broken wrt lockdep and irq tracing atm. Mark has been
> > looking at that and I think he is close to having something workable.
> > 
> > Mark -- is there anything Marco and Paul can try out?
> 
> I initially traced some issues back to commit:
> 
>   044d0d6de9f50192 ("lockdep: Only trace IRQ edges")
> 
> ... and that change of semantic could cause us to miss edges in some
> cases, but IIUC mostly where we haven't done the right thing in
> exception entry/return.
> 
> I don't think my patches address this case yet, but my WIP (currently
> just fixing user<->kernel transitions) is at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/irq-fixes
> 
> I'm looking into the kernel<->kernel transitions now, and I know that we
> mess up RCU management for a small window around arch_cpu_idle, but it's
> not immediately clear to me if either of those cases could cause this
> report.

Thank you -- I tried your irq-fixes, however that didn't seem to fix the
problem (still get warnings and then a panic). :-/

| [  118.375217] Testing all events: OK
| [  174.878839] Running tests again, along with the function tracer
| [  174.894781] Running tests on all trace events:
| [  174.906734] Testing all events: 
| [  176.204533] hrtimer: interrupt took 9035008 ns
| [  286.788330] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 10s!
| [  286.883216] Showing busy workqueues and worker pools:
| [  286.899647] workqueue events: flags=0x0
| [  286.920606]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  286.933010]     pending: vmstat_shepherd
| [  644.323445] INFO: task kworker/u2:1:107 blocked for more than 12 seconds.
| [  649.448126]       Not tainted 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #17
| [  656.619598] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
| [  660.623500] task:kworker/u2:1    state:R stack:    0 pid:  107 ppid:     2 flags:0x00000428
| [  671.587980] Call trace:
| [  674.885884]  __switch_to+0x148/0x1f0
| [  675.267490]  __schedule+0x2dc/0x9a8
| [  677.748050]  schedule+0x4c/0x100
| [  679.223880]  worker_thread+0xe8/0x510
| [  680.663844]  kthread+0x13c/0x188
| [  681.663992]  ret_from_fork+0x10/0x34
| [  684.493389] 
| [  684.493389] Showing all locks held in the system:
| [  688.554449] 4 locks held by swapper/0/1:
| [  691.747079] 1 lock held by khungtaskd/23:
| [  692.525727]  #0: ffffa1ebd7ff1420 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x34/0x198
| [  704.403177] 
| [  704.630928] =============================================
| [  704.630928] 
| [  706.168072] Kernel panic - not syncing: hung_task: blocked tasks
| [  706.172894] CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #17
| [  706.178507] Hardware name: linux,dummy-virt (DT)
| [  706.182658] Call trace:
| [  706.186231]  dump_backtrace+0x0/0x240
| [  706.190124]  show_stack+0x34/0x88
| [  706.193917]  dump_stack+0x140/0x1bc
| [  706.197728]  panic+0x1e4/0x494
| [  706.201440]  watchdog+0x668/0xbe8
| [  706.205238]  kthread+0x13c/0x188
| [  706.208991]  ret_from_fork+0x10/0x34
| [  706.214532] Kernel Offset: 0x21ebc5a00000 from 0xffff800010000000
| [  706.219014] PHYS_OFFSET: 0xffffad8a80000000
| [  706.223148] CPU features: 0x0240022,61806082
| [  706.227149] Memory Limit: none
| [  706.233359] ---[ end Kernel panic - not syncing: hung_task: blocked tasks ]---

Thanks,
-- Marco
