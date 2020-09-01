Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147A1259047
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgIAOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgIAOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:19:58 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC0C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:19:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x14so1278098oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYeT1kWREy9iw8RMXrMLIUajXpDFHqwarYEHBSXtPVs=;
        b=BkbvCa0wDTGiRy3Mtu7XIbr0k4OXQtL0lOVpT/ZRRe19u76OiPgHmLIKSd6BYGHbEZ
         9R0IChDbN7K3wFjdEcRCrvGObCHQ/voDFWWvrwae2UQ7JYrtGIofURnVNwWlq6ZVEWvU
         BzO25Fu6dIzqvQVPGfH2YvEGabB+dUM01uTuX5N5RqgtQd6qtC+qQzLvMukYIChXjPV8
         48L6U/cjB8NxihkEKwmw6cd9vppOYQar/UXGARV2JGfKaHgn+4rUA332WaZPdG0MClWE
         oEblIXKR0rBsfVuV8JfmA5xS7fJH6iWBXuDpH8quiyKztYmbkO+aRnzwNU2qc3zHDFkZ
         3Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYeT1kWREy9iw8RMXrMLIUajXpDFHqwarYEHBSXtPVs=;
        b=fp/1abAjgTXH1Ii413kgggQqDlHeRxmf8EwEwZ6XLoXa+2xFkQDLivmKQ75eCFjZks
         M0aAU9evz1x+/arm39rWTOQq+2Dy0AuouLbB5sr54fXRFepzrfJvP/jnE2B/k4/9zhlP
         5UH0KPH5CtDXzhXEKEiVQyjISlp90Ph7w21MbsxxYX7x3foLWW1wtlREkhSXz4rttTqi
         tSvKCWJjHUmMgiGZoJKkQukuyBu/Wfs5ttyBQ40Do6ixfpzmdYQYHhMRywLJepk/RuTv
         UlY/Yan5IiCfR7/yDjEsiA0AxbQpfi9FM4ynlogZxjicP1KljAITBnijIBjQn07OXjHX
         u8Eg==
X-Gm-Message-State: AOAM533JNr/RZRVXt1Hf4FqvctMm64YtMbmeKpcurGJLSZ/5k2lHzEN2
        fUKuLHK5InydbyT/h/EnjAY82fAOke4IUcpVBlA=
X-Google-Smtp-Source: ABdhPJxG3/HiNa+3SgPdltCpIDqdd48zpcgJbgavkTxTieZYdq02TFXosB+BEK5L9z8LDAXFi+ix5rZ6WehV1/B9UAA=
X-Received: by 2002:aca:e144:: with SMTP id y65mr1200583oig.101.1598969995921;
 Tue, 01 Sep 2020 07:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
 <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com>
 <CAKfTPtCTd5eihtcg=B0Gu3RUydbSgjurD1uHD3rEvbTV61nf6Q@mail.gmail.com>
 <CAPJCdBmzcmomLaxNyN=VJiOCxrqrYdeJ=N8YksJ8mVY-BGHASA@mail.gmail.com> <CAKfTPtBerqpbay-=2ws85K6hRJNXfsexaNpUyesz4OtZrZVRWQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBerqpbay-=2ws85K6hRJNXfsexaNpUyesz4OtZrZVRWQ@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 1 Sep 2020 22:19:45 +0800
Message-ID: <CAPJCdBkuENFgm0XAemZzNVOtTdkxEioyWkZH81pDuLfY8jJ-mQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 1 Sep 2020 at 21:04, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 1 Sep 2020 at 12:15, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Vincent
> >
> > Sorry for the late reply.:)
> >
> > On Fri, 28 Aug 2020 at 20:55, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Sun, 23 Aug 2020 at 09:33, Jiang Biao <benbjiang@gmail.com> wrote:
> > > >
> > > > Hi, Vincent and Peter
> > > >
> > > > On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> > > > > >
> > > > > > > That's been said, not compensating the vruntime for a sched_idle task
> > > > > > > makes sense for me. Even if that will only help for others task in the
> > > > > > > same cfs_rq
> > > > > >
> > > > > > Yeah, but it is worth the extra pointer chasing and branches?
> > > > >
> > > > > For that I let Jiang provides figures to show the worthful
> > > > Using the following configuration for rt-app,
> > > > {
> > > >         "tasks" : {
> > > >                 "task_other" : {
> > > >                         "instance" : 1, //only 1 instance to be easy to observe
> > > >                         "cpus" : [2],
> > > >                         "loop" : 2000,
> > > >                         "policy" : "SCHED_OTHER",
> > > >                         "run" : -1,  //make normal task 100% running
> > > >                         "priority" : 0,
> > > >                         "sleep" : 0
> > > >                 },
> > > >                 "task_idle" : {
> > > >                         "instance" : 1,
> > > >                         "cpus" : [2],
> > > >                         "loop" : 2000,
> > > >                         "policy" : "SCHED_IDLE",
> > > >                         "run" : 1, //only run 1us to avoid
> > > > blocking(always waiting for running), making check_preempt_wakeup
> > > > work(S->R switching)
> > > >                         "timer" : { "ref" : "unique2" , "period" :
> > > > 16000, "mode" : "absolute" }
> > > >                 }
> > > >         },
> > > >         "global" : {
> > > >                 "calibration" : "CPU0",
> > > >                 "default_policy" : "SCHED_OTHER",
> > > >                 "duration" : -1
> > > >         }
> > > > }
> > > > without the patch,
> > > >           <...>-39771 [002] d.h. 42478.177771: sched_wakeup:
> > > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > > >            <...>-39771 [002] d... 42478.190437: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > > >            <...>-39771 [002] d.h. 42478.193771: sched_wakeup:
> > > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > > >            <...>-39771 [002] d... 42478.206438: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > > >            <...>-39771 [002] d.h. 42478.209771: sched_wakeup:
> > > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > > >            <...>-39771 [002] d... 42478.222438: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > > >            <...>-39771 [002] d.h. 42478.225771: sched_wakeup:
> > > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > > >            <...>-39771 [002] d... 42478.238438: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > > > *task_idle*  preempts every 12ms because of the compensation.
> > > >
> > > > with the patch,
> > > >    task_other-0-27670 [002] d.h. 136785.278059: sched_wakeup:
> > > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > > >     task_other-0-27670 [002] d... 136785.293623: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > > >     task_other-0-27670 [002] d.h. 136785.294059: sched_wakeup:
> > > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > > >     task_other-0-27670 [002] d... 136785.317624: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > > >     task_other-0-27670 [002] d.h. 136785.326059: sched_wakeup:
> > > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > > >     task_other-0-27670 [002] d... 136785.341622: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > > >     task_other-0-27670 [002] d.h. 136785.342059: sched_wakeup:
> > > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > > >     task_other-0-27670 [002] d... 136785.365623: sched_switch:
> > > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > > > *task_idle* preempts every 24 or 16 ms.
> > > >
> > > > This patch could reduce the preempting frequency of task_idle, and
> > > > reduce the interference from SCHED_IDLE task.
> > >
> > > For this use case, the preemption is only 1us long. Is it a realistic
> > > problem use case ? your normal threads might be more impacted by tick,
> > Nop.
> > 1us is just to make the logic in place_entity() work. If the preemption is
> > longer, the IDLE task could not finish its work before being preempted back
> > by normal task, and the IDLE task would be always in RUNNING status from
> > then on. In that case place_entity() would never be reached because of the
> > RUNNING status.
>
> Yeah, I agree that the setup is the right one to check the worst
> wakeup pre emption period but it doesn't sound like a realistic
> problem
Indeed.

>
> Have you tried this with your system and does it improve anything ?
> Otherwise, I agree with Peter that it doesn't worth having an
> additional test in the wakeup path if it doesn't help any cases
We have not utilized SCHED_IDLE for running offline tasks, so we can
not give a realistic scenario for that.
So let's just forget about it for now.

Much appreciated for your time again. :)
Thx.
Regards,
Jiang
