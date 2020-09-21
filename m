Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C82732A1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgIUTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgIUTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:16:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600715815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uW3lQjFU0+ANDvrbM3MoWOzN+06qLh0fgkM/4cM1Dyk=;
        b=xjswdqnvrJLlutOTdEJ0c9QUDzCK32XrLfUV0noweMiwoQvsZzoXfvRkjzqBLc4JhG4VeO
        p4mTFX5H5Rc6M3R5VHSKs5Tsf28mV+gsHNoixBcF9gMynx5p7soLicvWxJOZdDARieV419
        Pqyk/69R5QRl4I8LTcmSMhm2q9F5aQRHx+BWbJTVfPVMCq3nOA8tdPTRVk710Xi8bqWmBk
        Jk6pzB3yfPtt6sAW9lwoWREdH4bxsQchVSVZMbnSak0ZhLKDI8CvhhHxZPnAF+zXnRlbwQ
        4fFjVKbq/DQHVUI0ZbHFeJ4wP+EtAd7VfooxFF3hm7xBrqCkHFRtlLEQGXQERw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600715815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uW3lQjFU0+ANDvrbM3MoWOzN+06qLh0fgkM/4cM1Dyk=;
        b=GYwGJFRwbnNxe262y6yIK7eogt03noVMkhMdZFlFecr57K2ettfPnWm5QPYvnI/H5MI5j3
        PuFQTRxrzHkHuxCQ==
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
In-Reply-To: <20200921163845.769861942@infradead.org>
References: <20200921163557.234036895@infradead.org> <20200921163845.769861942@infradead.org>
Date:   Mon, 21 Sep 2020 21:16:54 +0200
Message-ID: <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:
> Add the base migrate_disable() support (under protest).

:)

> +/*
> + * Migrate-Disable and why it is (strongly) undesired.
> + *
> + * The premise of the Real-Time schedulers we have on Linux
> + * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
> + * concurrently, provided there are sufficient runnable tasks, also known as
> + * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
> + * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
> + *
> + * The correctness of various scheduling models depends on this, but is it
> + * broken by migrate_disable() that doesn't imply preempt_disable(). Where
> + * preempt_disable() implies an immediate priority ceiling, preemptible
> + * migrate_disable() allows nesting.
> + *
> + * The worst case is that all tasks preempt one another in a migrate_disable()
> + * region and stack on a single CPU. This then reduces the available bandwidth
> + * to a single CPU. And since Real-Time schedulability theory considers the
> + * Worst-Case only, all Real-Time analysis shall revert to single-CPU
> + * (instantly solving the SMP analysis problem).

I'm telling you for years that SMP is the source of all evils and
NR_CPUS=0 is the ultimate solution of all problems. Paul surely
disagrees as he thinks that NR_CPUS<0 is the right thing to do.

But seriously, I completely understand your concern vs. schedulability
theories, but those theories can neither deal well with preemption
disable simply because you can create other trainwrecks when enough low
priority tasks run long enough in preempt disabled regions in
parallel. The scheduler simply does not know ahead how long these
sections will take and how many of them will run in parallel.

The theories make some assumptions about preempt disable and consider it
as temporary priority ceiling, but that's all assumptions as the bounds
of these operations simply unknown.

> + * The reason we have it anyway.
> + *
> + * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
> + * number of primitives into becoming preemptible, they would also allow
> + * migration. This turns out to break a bunch of per-cpu usage. To this end,
> + * all these primitives employ migirate_disable() to restore this implicit
> + * assumption.
> + *
> + * This is a 'temporary' work-around at best. The correct solution is getting
> + * rid of the above assumptions and reworking the code to employ explicit
> + * per-cpu locking or short preempt-disable regions.

What timeframe are you envisioning for 'temporary'? I assume something
which is closer to your retirement than to mine :)

> + * The end goal must be to get rid of migrate_disable(), alternatively we need
> + * a schedulability theory that does not depend on abritrary migration.

Finally something new the academics can twist their brain around :)

But as the kmap discussion has shown, the current situation of enforcing
preempt disable even on a !RT kernel is not pretty either. I looked at
quite some of the kmap_atomic() usage sites and the resulting
workarounds for non-preemptability are pretty horrible especially if
they do copy_from/to_user() or such in those regions. There is tons of
other code which really only requires migrate disable.

Thanks,

        tglx

