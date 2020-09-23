Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13CD275699
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIWKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600858289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OC2O2DoOY0KMGyObxVQAo0Uij0rpoLYc/hXdGCD+bU=;
        b=dmOrHWwhxywrp8PvpFCqiU+PhN96x9cEnkWD3IoiXxu49xOkazE3m42JjdivEM83hI0rwY
        pdi9wdeGnAof7x4OQ7dXANjOnHeF0rFObhi9fiNzG5Ik+xPpOhprZIYdi0wxq6mVxn3Co2
        VNL/IhMQPwxBYEJwy253RmDO1/Jkr0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-SFUHRdzpPKKdIIu7lbq1_w-1; Wed, 23 Sep 2020 06:51:26 -0400
X-MC-Unique: SFUHRdzpPKKdIIu7lbq1_w-1
Received: by mail-wm1-f71.google.com with SMTP id w3so2074087wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OC2O2DoOY0KMGyObxVQAo0Uij0rpoLYc/hXdGCD+bU=;
        b=ub3cZSu0baUUioivOr2P1Ced++NH21Zztc6be3+Da6lZFMPkvj42N5+3DZuHx61pR7
         3JdVMp31qn5NcQDD9gFauLjqcFNy6ovsFGQHBDni0h1lfbvZhQk8aGr2wu44r3oLIB2n
         b3+7p77yqkvEtqa1kbdu2rwtF8nk2FUJieg0CH37HN776qs++CEjs/jTEcVDD//IeegP
         pjTWMSm6q5b0hAEIxYPE7758nPSMGDkA6UF7LHRoVs3VVxGj/ha88qQYk9J+0N4jQUee
         Kbhg0gg5PIT2U03fRO6G7lYAQipUQbMYA29+rapb/L9VKyguiZndq0myK/9QsYL514JH
         hRaw==
X-Gm-Message-State: AOAM531qZI17583IW+a7Vi65Nt22arQznQsUGuym+P3RAmroZKaQRwjl
        7ekamZ0hzLT1Vu+ttZkRlfSHrSw3tj8nSqL9toQ5m/1TlsZvARR8KbSLeSco7GJXL/lbHJ9ABHd
        iRGNxfHyVRDAb2HJ4Wgm0jozZ
X-Received: by 2002:adf:ff90:: with SMTP id j16mr132451wrr.105.1600858284996;
        Wed, 23 Sep 2020 03:51:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxa/EDkoMZnw1R6lYbf+uHBFXWDsyieyUifli4TttxYJebQYn87Q2UVYxOzC+bAom07a7xDg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr132421wrr.105.1600858284682;
        Wed, 23 Sep 2020 03:51:24 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id s26sm8099798wmh.44.2020.09.23.03.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 03:51:23 -0700 (PDT)
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vincent.donnefort@arm.com
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
 <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
 <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <75f402b9-5819-c070-111c-fcf37ca90d31@redhat.com>
Date:   Wed, 23 Sep 2020 12:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 10:31 AM, Thomas Gleixner wrote:
> On Mon, Sep 21 2020 at 22:42, Daniel Bristot de Oliveira wrote:
>> On 9/21/20 9:16 PM, Thomas Gleixner wrote:
>>> On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:
>>> But seriously, I completely understand your concern vs. schedulability
>>> theories, but those theories can neither deal well with preemption
>>> disable simply because you can create other trainwrecks when enough low
>>> priority tasks run long enough in preempt disabled regions in
>>> parallel. The scheduler simply does not know ahead how long these
>>> sections will take and how many of them will run in parallel.
>>>
>>> The theories make some assumptions about preempt disable and consider it
>>> as temporary priority ceiling, but that's all assumptions as the bounds
>>> of these operations simply unknown.
>>
>> Limited preemption is something that is more explored/well known than
>> limited/arbitrary affinity - I even know a dude that convinced academics about
>> the effects/properties of preempt disable on the PREEMPT_RT!
> 
> I'm sure I never met that guy.

It is a funny Italian/Brazilian dude....

>> But I think that the message here is that: ok, migrate disable is better for the
>> "scheduling latency" than preempt disable (preempt rt goal). But the
>> indiscriminate usage of migrate disable has some undesired effects for "response
>> time" of real-time threads (scheduler goal), so we should use it with caution -
>> as much as we have with preempt disable. In the end, both are critical for
>> real-time workloads, and we need more work and analysis on them both.
> ...
>>> But as the kmap discussion has shown, the current situation of enforcing
>>> preempt disable even on a !RT kernel is not pretty either. I looked at
>>> quite some of the kmap_atomic() usage sites and the resulting
>>> workarounds for non-preemptability are pretty horrible especially if
>>> they do copy_from/to_user() or such in those regions. There is tons of
>>> other code which really only requires migrate disable
>>
>> (not having an explicit declaration of the reason to disable preemption make
>> these all hard to rework... and we will have the same with migrate disable.
>> Anyways, I agree that disabling only migration helps -rt now [and I like
>> that]... but I also fear/care for scheduler metrics on the long term... well,
>> there is still a long way until retirement.)
> 
> Lets have a look at theory and practice once more:
> 
> 1) Preempt disable
> 
>    Theories take that into account by adding a SHC ('Sh*t Happens
>    Coefficient') into their formulas, but the practical effects cannot
>    ever be reflected in theories accurately.

It depends, an adequate theory will have the correct balance between SHC and
precision. The idea is to precisely define the behavior as much as possible,
trying to reduce the SHC.

>    In practice, preempt disable can cause unbound latencies and while we
>    all agree that long preempt/interrupt disabled sections are bad, it's
>    not really trivial to break these up without rewriting stuff from
>    scratch. The recent discussion about unbound latencies in the page
>    allocator is a prime example for that.

Here we need to separate two contexts: the synchronization and the code contexts.

At the synchronization level the preempt_disable() is bounded [1]:

The PREEMPT_RT can have only *1* preempt_disable()/enable() not to schedule
section (the worst (SHC)) before starting the process of calling the scheduler.
So the SHC factor is then reduced to the code context [2].

The SHC is in the code context, and it is mitigated by the constant monitoring
of the code sections via tests.

>    The ever growing usage of per CPU storage is not making anything
>    better and right now preempt disable is the only tool we have at the
>    moment in mainline to deal with that.
> 
>    That forces people to come up with code constructs which are more
>    than suboptimal both in terms of code quality and in terms of
>    schedulability/latency. We've seen mutexes converted to spinlocks
>    just because of that, conditionals depending on execution context
>    which turns out to be broken and inconsistent, massive error handling
>    trainwrecks, etc.

I see and agree with you on this point.

> 2) Migrate disable
> 
>    Theories do not know anything about it, but in the very end it's
>    going to be yet another variant of SHC to be defined.

I agree. There are very few things known at this point. However, we can take as
exercise the example that Peter mentioned:

CPU 0					CPU 1
thread on migrate_disable():		high prio thread
 -> preempted!
    -> migrate_dsaible()
       -> preempted!			
		...
          migrate_disable()		leaves the CPU
	  SH happens			IDLE
		...			IDLE
	unfold all on this CPU.		IDLE (decades of ...)


So, at synchronization level... migrate_disable() is not bounded by a
constant as preempt_disable() does. That is the difference that worries peter,
and it is valid from both points of view (theoretical and practical).

>    In practice migrate disable could be taken into account on placement
>    decisions, but yes we don't have anything like that at the moment.

Agreed... we can mitigate that! that is a nice challenge!

>    The theoretical worst case which forces all and everything on a
>    single CPU is an understandable concern, but the practical relevance
>    is questionable. I surely stared at a lot of traces on heavily loaded
>    RT systems, but too many prempted migrate disabled tasks was truly
>    never a practical problem. I'm sure you can create a workload
>    scenario which triggers that, but then you always can create
>    workloads which are running into the corner cases of any given
>    system.

I see your point! and I agree it is a corner case. But... that is what we have
to deal with in RT scheduling, and such discussions are good for RT Linux, at
least to raise the attention to a point that might need to be constantly
monitored and not abused (like preempt_disable for RT).

>    The charm of migrate disable even on !RT is that it allows for
>    simpler code and breaking up preempt disabled sections, which is IMO
>    a clear win given that per CPU ness is not going away -unless the
>    chip industry comes to senses and goes back to the good old UP
>    systems which have natural per CPU ness :)
> 
> That said, let me paraphrase that dude you mentioned above:
> 
>  Theories are great and useful, but pragmatism has proven to produce
>  working solutions even if they cannot work according to theory.

I agree! The way that Linux advances as RTOS is shown to be effective. So
effective that people want more and more. And we can always show later that the
path that Linux took is right in theory! Like that dude did....

But at the same time, we can take advantage of scenarios we can predict being
hard for the future and try to mitigate/isolate them to avoid them. I can't
argue against that either.

At the end, it seems that the decision here is about which hard problem we will
have to deal in the future. [ As I said yesterday, I will have to deal with
migrate_disable anyway because of RT, so I do not have a way out anyway.]

Thanks!
-- Daniel

> Thanks,
> 
>         tglx
> 
>         
> 

For the wider audience
[1] https://bit.ly/33PsV0N
[2] there are other scenarios too, demonstrated in the paper, but here we are
discussing only about preempt_disable() postponing the __scheduler().

