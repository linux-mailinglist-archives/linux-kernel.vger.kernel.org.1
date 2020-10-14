Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23B228E281
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgJNOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:51:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45729 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgJNOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:51:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id dg9so3390171edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=/4+iX2b6i5/F3AxsW9fsmkgw1iUKLfdA8V3n5nlXVTk=;
        b=D3WmZs+whL2fPoiuDavm3Clx9i+iL/zfLSIwcxEf2ylwJ60PSZdHOWxfMDBYQMl5yV
         KpqUTLRAzu+VomkV6Exooh/4CUMiqoNswNpTsusefX3Gt35zHcOCUgm2b7co8uzgvBaC
         YZavES4JxC+dfTImjC94JMbYVC6Baog3NxDCg2zGRIZNERsJE1X+F9rYWloqa/cPSPl4
         thfYCC58+GuNqM9XHw9dfK/FrB3ubKD1eUyr8XxPz3ZHvpFa9z5aybXiOVOWzsXXbiGK
         twUeSp/9O6OehFh6zf7qdNQIUO/f0uKD5AFflH0Ywu57f4XK+i7WVli18Pi/uWQmZlnp
         xM0g==
X-Gm-Message-State: AOAM533qvva4JNgnfORWrDs595EKbdzS0IFNSNNJguSDjGEtEqj8U1DI
        /GiqUzG7zA72pnsRW5SBG2wyfl1+2jwSxg==
X-Google-Smtp-Source: ABdhPJy4boWaAaNdV+SSlYO6UxUd69TfwCJwHlpWeCv1wr4t3WDLTd5NlUtpVdv+b08SxH3/QOMASA==
X-Received: by 2002:aa7:c38b:: with SMTP id k11mr5694435edq.33.1602687093821;
        Wed, 14 Oct 2020 07:51:33 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id z20sm1721507edq.90.2020.10.14.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 07:51:32 -0700 (PDT)
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
Message-ID: <87zh4ohnf9.derkling@matbug.net>
Date:   Wed, 14 Oct 2020 16:50:18 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 13, 2020 at 22:25:48 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...

Hi Dietmar,

> Hi Yun,
>
> On 12/10/2020 18:31, Yun Hsiang wrote:
>> If the user wants to stop controlling uclamp and let the task inherit
>> the value from the group, we need a method to reset.
>> 
>> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
>> sched_setattr syscall.
>
> before we decide on how to implement the 'uclamp user_defined reset'
> feature, could we come back to your use case in
> https://lkml.kernel.org/r/20201002053812.GA176142@ubuntu ?
>
> Lets just consider uclamp min for now. We have:
>
> (1) system-wide:
>
> # cat /proc/sys/kernel/sched_util_clamp_min
>
> 1024
>
> (2) tg (hierarchy) with top-app's cpu.uclamp.min to ~200 (20% of 1024):
>
> # cat /sys/fs/cgroup/cpu/top-app/cpu.uclamp.min
> 20
>
> (3) and 2 cfs tasks A and B in top-app:
>
> # cat /sys/fs/cgroup/cpu/top-app/tasks
>
> pid_A
> pid_B
>
> Then you set A and B's uclamp min to 100. A and B are now user_defined.
> A and B's effective uclamp min value is 100.
>
> Since the task uclamp min values (3) are less than (1) and (2), their
> uclamp min value is not affected by (1) or (2).
>
> If A doesn't want to control itself anymore, it can set its uclamp min
> to e.g. 300. Now A's effective uclamp min value is ~200, i.e. controlled
> by (2), the one of B stays 100.
>
> So the policy is:
>
> (a) If the user_defined task wants to control it's uclamp, use task
>     uclamp value less than the tg (hierarchy) (and the system-wide)
>     value.
>
> (b) If the user_defined task doesn't want to control it's uclamp
>     anymore, use a uclamp value greater than or equal the tg (hierarchy)
>     (and the system-wide) value.
>
> So where exactly is the use case which would require a 'uclamp
> user_defined reset' functionality?

Not sure what's the specific use-case Yun is after, but I have at least
one in my mind.

Let say a task does not need boost at all, independently from
the cgroup it's configured to run into. We can go on and set its task
specific value to util_min=0.

In this case, when the task is running alone on a CPU, it will get
always the minimum OPP, independently from its utilization.

Now, after a while (e.g. some special event happens) we want to relax
this constraint and allow the task to run:
  1. at whatever OPP is required by its utilization
  2. with any additional boost possibly enforced by its cgroup

Right now we have only quite cumbersome or hack solution:
  a) go check the current cgroup util_min value and set for the task
  something higher than that
  b) set task::util_min=1024 thus asking for the maximum possible boost

Solution a) is more code for userspace and it's also racy. Solution b)
is misleading since the task does not really want to run at 1024.
It's also potentially over-killing in case the task should be moved to
the root group, which is normally unbounded and thus the task will get
executed always at the max OPP without any specific reason why.

A simple _UCLAMP_RESET flag will allow user-space to easily switch a
tasks to the default behavior (follow utilization or recommended
boosts) which is what a task usually gets when it does not opt-in to
uclamp.

Looking forward to see if Yun has an even more specific use-case.

