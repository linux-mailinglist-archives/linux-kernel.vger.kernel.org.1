Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6215A2733B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIUUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgIUUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600720968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oYHyWb2FTOS7oezvvbUZlKv/01GvhNvR455FrkGl+A=;
        b=MmoBW+9nKL5am/LHWoH140Wgaeu09mZtbCf2qlFu2bO2a21WbDRNCGjOTg87eqVxtN46Dt
        8PA9jArbWCctYfl8D9wl2+LRXgY6z33KBdLdlRZk+03+asbCcfQcEACXqk8rxjsBC5l6RJ
        k+YY2hUo2OPr7jOtHT2wMZBWg941ws8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-jO8Q3G40PmKBJjU_2uz-jQ-1; Mon, 21 Sep 2020 16:42:46 -0400
X-MC-Unique: jO8Q3G40PmKBJjU_2uz-jQ-1
Received: by mail-ed1-f70.google.com with SMTP id y15so5132666edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oYHyWb2FTOS7oezvvbUZlKv/01GvhNvR455FrkGl+A=;
        b=AIQ4wM/z3I7Jz2TmBJuh5UKYc0tR1vIj+H45IL9z7wOcPI/iLrrBU4gjeyIEn+lwJu
         fI/Rt/hddsyfu8BsjsJbQEW3jBAOctPYDGUZG+HgFw+ASf8ReJvbRyR17+Q+gZG7hJKq
         4yDJ5H4CwAjDcTgbH7jN2JzFph+l8gz8QZs5HwbgyZlr2LB2mtjTCGN6M1hGvovXAJIO
         MqGpay2H52BfPXkL4sDCg+mUcLVRvRSeLxEJazIhHBGR8mDG9swdjDsgcFeX7knYYGfL
         tr5Egfintqe1NgkCBMkxi2Gyhxz9vfqX68SCkZ0kydKHyM9/h3bE/xhlFNU8po4EBQqW
         HinQ==
X-Gm-Message-State: AOAM533Y2vuFZunBmeLMMFrWCtpwDvVPG7mA0HNSdRThQScvTkNmx4Ud
        9mqfRgylVNWAo4NejeZ6rfEXNgRrZAryohFYSo2F4MdryzVby5g/XUD3F4SBq7Z1d61dRNJxZvL
        aVRs7uFwcA8FLXAUwqDWafh2A
X-Received: by 2002:a17:906:cf8b:: with SMTP id um11mr1394691ejb.540.1600720965149;
        Mon, 21 Sep 2020 13:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8Xxy62FIgFpAvJ4dk4Zp20n2kB9ic2UK8eAe3UX0qfw228NZ5R3T+V7OtAAyzdU6jd6Ui6w==
X-Received: by 2002:a17:906:cf8b:: with SMTP id um11mr1394680ejb.540.1600720964893;
        Mon, 21 Sep 2020 13:42:44 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id s7sm9690602ejd.103.2020.09.21.13.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 13:42:44 -0700 (PDT)
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
Date:   Mon, 21 Sep 2020 22:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 9:16 PM, Thomas Gleixner wrote:
> On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:
>> Add the base migrate_disable() support (under protest).
> 
> :)
> 
>> +/*
>> + * Migrate-Disable and why it is (strongly) undesired.
>> + *
>> + * The premise of the Real-Time schedulers we have on Linux
>> + * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
>> + * concurrently, provided there are sufficient runnable tasks, also known as
>> + * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
>> + * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
>> + *
>> + * The correctness of various scheduling models depends on this, but is it
>> + * broken by migrate_disable() that doesn't imply preempt_disable(). Where
>> + * preempt_disable() implies an immediate priority ceiling, preemptible
>> + * migrate_disable() allows nesting.
>> + *
>> + * The worst case is that all tasks preempt one another in a migrate_disable()
>> + * region and stack on a single CPU. This then reduces the available bandwidth
>> + * to a single CPU. And since Real-Time schedulability theory considers the
>> + * Worst-Case only, all Real-Time analysis shall revert to single-CPU
>> + * (instantly solving the SMP analysis problem).
> 
> I'm telling you for years that SMP is the source of all evils and
> NR_CPUS=0 is the ultimate solution of all problems. Paul surely
> disagrees as he thinks that NR_CPUS<0 is the right thing to do.

And I would not need to extend the model!

> But seriously, I completely understand your concern vs. schedulability
> theories, but those theories can neither deal well with preemption
> disable simply because you can create other trainwrecks when enough low
> priority tasks run long enough in preempt disabled regions in
> parallel. The scheduler simply does not know ahead how long these
> sections will take and how many of them will run in parallel.
> 
> The theories make some assumptions about preempt disable and consider it
> as temporary priority ceiling, but that's all assumptions as the bounds
> of these operations simply unknown.

Limited preemption is something that is more explored/well known than
limited/arbitrary affinity - I even know a dude that convinced academics about
the effects/properties of preempt disable on the PREEMPT_RT!

But I think that the message here is that: ok, migrate disable is better for the
"scheduling latency" than preempt disable (preempt rt goal). But the
indiscriminate usage of migrate disable has some undesired effects for "response
time" of real-time threads (scheduler goal), so we should use it with caution -
as much as we have with preempt disable. In the end, both are critical for
real-time workloads, and we need more work and analysis on them both.

>> + * The reason we have it anyway.
>> + *
>> + * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
>> + * number of primitives into becoming preemptible, they would also allow
>> + * migration. This turns out to break a bunch of per-cpu usage. To this end,
>> + * all these primitives employ migirate_disable() to restore this implicit
>> + * assumption.
>> + *
>> + * This is a 'temporary' work-around at best. The correct solution is getting
>> + * rid of the above assumptions and reworking the code to employ explicit
>> + * per-cpu locking or short preempt-disable regions.
> 
> What timeframe are you envisioning for 'temporary'? I assume something
> which is closer to your retirement than to mine :)

/me counts how many years he still needs to wait for the retirement.

> 
>> + * The end goal must be to get rid of migrate_disable(), alternatively we need
>> + * a schedulability theory that does not depend on abritrary migration.
> 
> Finally something new the academics can twist their brain around :)

Like if there was not enough already :-)

> But as the kmap discussion has shown, the current situation of enforcing
> preempt disable even on a !RT kernel is not pretty either. I looked at
> quite some of the kmap_atomic() usage sites and the resulting
> workarounds for non-preemptability are pretty horrible especially if
> they do copy_from/to_user() or such in those regions. There is tons of
> other code which really only requires migrate disable
(not having an explicit declaration of the reason to disable preemption make
these all hard to rework... and we will have the same with migrate disable.
Anyways, I agree that disabling only migration helps -rt now [and I like
that]... but I also fear/care for scheduler metrics on the long term... well,
there is still a long way until retirement.)

Thanks!
-- Daniel

> Thanks,
> 
>         tglx
> 

