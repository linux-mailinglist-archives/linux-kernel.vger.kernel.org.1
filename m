Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F64275339
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:31:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIWIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:31:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600849870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jp4jXfL6J+X4mp9KCIDFRHVsN9W3ceV+mfRTxAue2PI=;
        b=Xgq+B/l19RFNsrRVlZHrAx/6Z5CDNNboa+X54OjjKaZ1Dk9PwUlJjluFDHxEJiRrAl64iU
        ii3ZfICIUjyG1YgqWvf3YtfsMpBB7+21QVAfsdXMZHjvhNPeBG1nelwg83Q4M/qPfv22RT
        AFFSbre9WYyKCjnyGDn2xARUC+YGyyJBa+cGtmbU5VzkV/jJuLEfXi77u3g6qzAK+C3vcr
        6i850FnwkBka1gj5luWxwWVaxHPpj8fz7pZm4zQlwIrUbVQsNmdSPJ4HkIjpLUn4PewQ9A
        rk7pnTf62+9HgY4vAcvv9liJQwJgx4WpX/bhyYeo8X6APGBablfwikX3CHSsIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600849870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jp4jXfL6J+X4mp9KCIDFRHVsN9W3ceV+mfRTxAue2PI=;
        b=piPxlyJGDgkpALJH0ruTFc9v3I/f6Dnc9gylN6no46EkFK/ZcHKV/fVTLNgYlpIyqUhxoM
        udTJKho4QVZ1DKBg==
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
In-Reply-To: <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
References: <20200921163557.234036895@infradead.org> <20200921163845.769861942@infradead.org> <87v9g7aqjd.fsf@nanos.tec.linutronix.de> <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
Date:   Wed, 23 Sep 2020 10:31:10 +0200
Message-ID: <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21 2020 at 22:42, Daniel Bristot de Oliveira wrote:
> On 9/21/20 9:16 PM, Thomas Gleixner wrote:
>> On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:
>> But seriously, I completely understand your concern vs. schedulability
>> theories, but those theories can neither deal well with preemption
>> disable simply because you can create other trainwrecks when enough low
>> priority tasks run long enough in preempt disabled regions in
>> parallel. The scheduler simply does not know ahead how long these
>> sections will take and how many of them will run in parallel.
>> 
>> The theories make some assumptions about preempt disable and consider it
>> as temporary priority ceiling, but that's all assumptions as the bounds
>> of these operations simply unknown.
>
> Limited preemption is something that is more explored/well known than
> limited/arbitrary affinity - I even know a dude that convinced academics about
> the effects/properties of preempt disable on the PREEMPT_RT!

I'm sure I never met that guy.

> But I think that the message here is that: ok, migrate disable is better for the
> "scheduling latency" than preempt disable (preempt rt goal). But the
> indiscriminate usage of migrate disable has some undesired effects for "response
> time" of real-time threads (scheduler goal), so we should use it with caution -
> as much as we have with preempt disable. In the end, both are critical for
> real-time workloads, and we need more work and analysis on them both.
...
>> But as the kmap discussion has shown, the current situation of enforcing
>> preempt disable even on a !RT kernel is not pretty either. I looked at
>> quite some of the kmap_atomic() usage sites and the resulting
>> workarounds for non-preemptability are pretty horrible especially if
>> they do copy_from/to_user() or such in those regions. There is tons of
>> other code which really only requires migrate disable
>
> (not having an explicit declaration of the reason to disable preemption make
> these all hard to rework... and we will have the same with migrate disable.
> Anyways, I agree that disabling only migration helps -rt now [and I like
> that]... but I also fear/care for scheduler metrics on the long term... well,
> there is still a long way until retirement.)

Lets have a look at theory and practice once more:

1) Preempt disable

   Theories take that into account by adding a SHC ('Sh*t Happens
   Coefficient') into their formulas, but the practical effects cannot
   ever be reflected in theories accurately.

   In practice, preempt disable can cause unbound latencies and while we
   all agree that long preempt/interrupt disabled sections are bad, it's
   not really trivial to break these up without rewriting stuff from
   scratch. The recent discussion about unbound latencies in the page
   allocator is a prime example for that.

   The ever growing usage of per CPU storage is not making anything
   better and right now preempt disable is the only tool we have at the
   moment in mainline to deal with that.

   That forces people to come up with code constructs which are more
   than suboptimal both in terms of code quality and in terms of
   schedulability/latency. We've seen mutexes converted to spinlocks
   just because of that, conditionals depending on execution context
   which turns out to be broken and inconsistent, massive error handling
   trainwrecks, etc.

2) Migrate disable

   Theories do not know anything about it, but in the very end it's
   going to be yet another variant of SHC to be defined.

   In practice migrate disable could be taken into account on placement
   decisions, but yes we don't have anything like that at the moment.

   The theoretical worst case which forces all and everything on a
   single CPU is an understandable concern, but the practical relevance
   is questionable. I surely stared at a lot of traces on heavily loaded
   RT systems, but too many prempted migrate disabled tasks was truly
   never a practical problem. I'm sure you can create a workload
   scenario which triggers that, but then you always can create
   workloads which are running into the corner cases of any given
   system.

   The charm of migrate disable even on !RT is that it allows for
   simpler code and breaking up preempt disabled sections, which is IMO
   a clear win given that per CPU ness is not going away -unless the
   chip industry comes to senses and goes back to the good old UP
   systems which have natural per CPU ness :)

That said, let me paraphrase that dude you mentioned above:

 Theories are great and useful, but pragmatism has proven to produce
 working solutions even if they cannot work according to theory.

Thanks,

        tglx

        
