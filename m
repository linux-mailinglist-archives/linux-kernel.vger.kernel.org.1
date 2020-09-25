Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EF2784B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIYKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:07:55 -0400
Received: from foss.arm.com ([217.140.110.172]:40984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYKHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:07:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85E181045;
        Fri, 25 Sep 2020 03:07:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A06333F718;
        Fri, 25 Sep 2020 03:07:52 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200921163845.830487105@infradead.org> <jhj3637lzdm.mognet@arm.com> <20200925084339.GU2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <20200925084339.GU2628@hirez.programming.kicks-ass.net>
Date:   Fri, 25 Sep 2020 11:07:47 +0100
Message-ID: <jhj1riqmaoc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/09/20 09:43, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 08:59:33PM +0100, Valentin Schneider wrote:
>
>> > +	if (task_running(rq, p) || p->state == TASK_WAKING) {
>> > +
>> > +		task_rq_unlock(rq, p, rf);
>> > +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
>> > +
>>
>> Shouldn't we check for is_migrate_disabled(p) before doing any of that?
>> migration_cpu_stop() does check for it, is there something that prevents us
>> from acting on it earlier than that?
>
> Since migrate_disable() / ->migration_disabled is only touched from the
> current task, you can only reliably read it from the same CPU.
>
> Hence I only look at it when the stop task has pinned the task, because
> at that point I know it's stable.
>
> Doing it earlier gives races, races give me head-aches. This is a slow
> path, I don't care about performance.

Makes sense, thanks.
