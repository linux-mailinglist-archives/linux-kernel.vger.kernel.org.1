Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDD29F3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJ2R4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:56:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJ2R4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:56:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2322C139F;
        Thu, 29 Oct 2020 10:56:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC9E3F66E;
        Thu, 29 Oct 2020 10:56:14 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.697960969@infradead.org> <jhja6w5ov4h.mognet@arm.com> <20201029174302.GV2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 17/19] sched: Add migrate_disable() tracepoints
In-reply-to: <20201029174302.GV2628@hirez.programming.kicks-ass.net>
Date:   Thu, 29 Oct 2020 17:56:12 +0000
Message-ID: <jhj5z6sq5kz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 17:43, Peter Zijlstra wrote:
> On Thu, Oct 29, 2020 at 04:27:26PM +0000, Valentin Schneider wrote:
>> Don't you want those directly after the ->migration_disabled write?
>> esp. for migrate_enable(), if that preempt_enable() leads to a context
>> switch then the disable->enable deltas won't reflect the kernel view.
>> 
>> That delta may indeed include the time it took to run the stopper and
>> fix the task's affinity on migrate_enable(), but it could include all
>> sorts of other higher-priority tasks.
>
> I can put them in the preempt_disable() section I suppose, but these
> tracers should be looking at task_sched_runtime(), not walltime, and
> then the preemption doesn't matter.
>

True. I was thinking of how to process it downstream, and the first thing
that came to mind was that rd->overutilized flag which we do monitor
fairly closely; however that is system-wide while migrate_disable() is
task-specific.

> Also, a distinct lack of actual users atm.. :/

If you'd rather ditch this one altogether until someone asks for it, that
also works for me.
