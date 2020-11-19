Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5421A2B94BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgKSOgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKSOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:36:22 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C83C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:36:21 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id x13so2912548qvk.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCARG4QZtMHnFpafj1OT+P5fHUKr/uQzChLy5RLnZB0=;
        b=Ke+b0AgHE803lafhEwwOjxoamU7d6CtbMuUxOt/Hi10Ppo5C29SltT+zO3DuyRWoch
         TcGVPN9NZCzCfFs1eGMLx+Q2nlRhfxYtgTxWSqAyTubwq8W1j0udwh1ylfpNswxIJnuC
         +lxC8xIoHmmuuOJX0GslUH9Y52nvTQWzHQW0kf9DIN98L6nz1/qJ998YQ8/YliqCuy7t
         GukyBTAwj/LUe+xjOmP0jkQZiXwLIYoUhrPHi7Wx+IzauHqwZQAuD6qG+RZ1oXg29SZp
         mIiRoeG7QE3k3kv+XUIwWH0l+BcSQlqF/21HQ01SzQS7kgwglFjJLOVz1cuE6p6f8CCs
         ITzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCARG4QZtMHnFpafj1OT+P5fHUKr/uQzChLy5RLnZB0=;
        b=IYCmeOYVy2oQqqgDGH4ts84lEisejdB2e4hLdiCczPpAsNXfAGxpVV4IX0y78AwQ3n
         7LkeIVs0tUbI0OMd/fT1D7pwoCI3AMy+gmcfXoVepjOp5Lk180f1iScHOHJS5zWayYEr
         J3X/JKIjHMKGDJ7kvaV+vXkHrgzcsQhIkJtkRWgV4qqt9kPURIGYtsJp3L2tfoP34Q6C
         eK0y58J98QEIGn/48P7TU+dJiWr4KC/6gne6b1ifn9uSZzOcyGsCpeD7S74XBNmBfqu5
         NJF1wx3htXUPqR5PqE6o1X/LdqvFg9F/0+sUbiSH6/plKhJHyP2LdJBgNhOIqNLkiucQ
         Om6A==
X-Gm-Message-State: AOAM533T/MdtcfIRP2Tb/m+NpXovurtoyKHj8lnfkT0v6wo8/OLpyh8D
        iqbjbRP7SoHtE38CWjS8Pokj1+xTVbQQLkNBV5xLIg==
X-Google-Smtp-Source: ABdhPJxzPN0p1iFCAS8pPEuTQYMaumL6n4V3vbLMNS9VlTg4kVv7qjyT0OnrIQ6hjB0wXxrw843YNS394hYLTgtOoV0=
X-Received: by 2002:a0c:e911:: with SMTP id a17mr11585880qvo.18.1605796580560;
 Thu, 19 Nov 2020 06:36:20 -0800 (PST)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
 <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
 <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
 <20201118142357.GW3121392@hirez.programming.kicks-ass.net>
 <1778f2e5-0a0c-2c6e-2c83-fe51d938e8a2@i-love.sakura.ne.jp>
 <20201118151038.GX3121392@hirez.programming.kicks-ass.net>
 <9bc4e07d-2a58-077b-b4c7-ab056ba33cf1@i-love.sakura.ne.jp>
 <CACT4Y+ZJNkssAQLuwfcKPTTKLZhHRAo0POGOMVsGFGizoHaNMg@mail.gmail.com>
 <CACT4Y+Zh10241gchu6e_=LwxPSEzXT-0HSmhnTtkXFZevKi_yQ@mail.gmail.com>
 <CACT4Y+a8TjV+Pe6mwne777RV+xB+aHT6GxuMLAVBn5mtK4P0Lw@mail.gmail.com>
 <CACT4Y+ZSsKjvojD8iFVFv9F5X5BvZR8vLyaKrgxUxyknma04Sg@mail.gmail.com>
 <5e8342c4-702f-80a9-e669-8a7386ce0da1@i-love.sakura.ne.jp>
 <CACT4Y+a4X4MNkWsvRySokKE=gO8AH1kegtUQk9T0M37EfWtN-w@mail.gmail.com> <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
In-Reply-To: <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Nov 2020 15:36:09 +0100
Message-ID: <CACT4Y+ZBVOHD79Mbdpmuxn6OC757BSA7p+JF_YNyUEVfvRFdGQ@mail.gmail.com>
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:30 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 2:45 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2020/11/19 22:06, Dmitry Vyukov wrote:
> > > >>>>
> > > >>>> I am trying to reproduce this locally first. syzbot caims it can
> > > >>>> reproduce it with a number of very simpler reproducers (like spawn
> > > >>>> process, unshare, create socket):
> > > >>>> https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc
> > > >>>>
> > > >>>> I see a very slow drift, but it's very slow, so get only to:
> > > >>>>  direct dependencies:                 22072 [max: 32768]
> > > >>>>
> > > >>>> But that's running a very uniform workload.
> > > >>>>
> > > >>>> However when I tried to cat /proc/lockdep to see if there is anything
> > > >>>> fishy already,
> > > >>>> I got this (on c2e7554e1b85935d962127efa3c2a76483b0b3b6).
> > > >>>>
> > > >>>> Some missing locks?
> > >
> > > Not a TOMOYO's bug. Maybe a lockdep's bug.
> > >
> > > >
> > > > But I don't know if it's enough to explain the overflow or not...
> > > >
> > >
> > > Since you can't hit the limit locally, I guess we need to ask syzbot to
> > > run massive testcases.
> >
> > I am trying to test the code that will do this. Otherwise we will get
> > days-long round-trips for stupid bugs. These files are also quite
> > huge, I afraid that may not fit into storage.
> >
> > So far I get to at most:
> >
> >  lock-classes:                         2901 [max: 8192]
> >  direct dependencies:                 25574 [max: 32768]
> >  dependency chains:                   40605 [max: 65536]
> >  dependency chain hlocks used:       176814 [max: 327680]
> >  stack-trace entries:                258590 [max: 524288]
> >
> > with these worst offenders:
> >
> > # egrep "BD: [0-9]" /proc/lockdep
> > 00000000df5b6792 FD:    2 BD: 1235 -.-.: &obj_hash[i].lock
> > 000000005dfeb73c FD:    1 BD: 1236 ..-.: pool_lock
> > 00000000b86254b1 FD:   14 BD: 1111 -.-.: &rq->lock
> > 00000000866efb75 FD:    1 BD: 1112 ....: &cfs_b->lock
> > 000000006970cf1a FD:    2 BD: 1126 ----: tk_core.seq.seqcount
> > 00000000f49d95b0 FD:    3 BD: 1180 -.-.: &base->lock
> > 00000000ba3f8454 FD:    5 BD: 1115 -.-.: hrtimer_bases.lock
> > 00000000fb340f16 FD:   16 BD: 1030 -.-.: &p->pi_lock
> > 00000000c9f6f58c FD:    1 BD: 1114 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
> > 0000000049d3998c FD:    1 BD: 1112 -.-.: &cfs_rq->removed.lock
> > 00000000fdf7f396 FD:    7 BD: 1112 -...: &rt_b->rt_runtime_lock
> > 0000000021aedb8d FD:    1 BD: 1113 -...: &rt_rq->rt_runtime_lock
> > 000000004e34c8d4 FD:    1 BD: 1112 ....: &cp->lock
> > 00000000b2ac5d96 FD:    1 BD: 1127 -.-.: pvclock_gtod_data
> > 00000000c5df4dc3 FD:    1 BD: 1031 ..-.: &tsk->delays->lock
> > 00000000fe623698 FD:    1 BD: 1112 -...:
> > per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)
> >
> >
> > But the kernel continues to crash on different unrelated bugs...
>
>
> Here is one successful sample. How do we debug it? What should we be
> looking for?
>
> p.s. it's indeed huge, full log was 11MB, this probably won't be
> chewed by syzbot.
> Peter, are these [hex numbers] needed? Could we strip them during
> post-processing? At first sight they look like derivatives of the
> name.

The worst back-edge offenders are:

00000000b445a595 FD:    2 BD: 1595 -.-.: &obj_hash[i].lock
0000000055ae0468 FD:    1 BD: 1596 ..-.: pool_lock
00000000b1336dc4 FD:    2 BD: 1002 ..-.: &zone->lock
000000009a0cabce FD:    1 BD: 1042 ...-: &____s->seqcount
000000001f2849b5 FD:    1 BD: 1192 ..-.: depot_lock
00000000d044255b FD:    1 BD: 1038 -.-.: &n->list_lock
000000005868699e FD:   17 BD: 1447 -.-.: &rq->lock
00000000bb52ab59 FD:    1 BD: 1448 ....: &cfs_b->lock
000000004f442fff FD:    2 BD: 1469 ----: tk_core.seq.seqcount
00000000c908cc32 FD:    3 BD: 1512 -.-.: &base->lock
00000000478677cc FD:    5 BD: 1435 -.-.: hrtimer_bases.lock
00000000b5b65cb1 FD:   19 BD: 1255 -.-.: &p->pi_lock
000000007f313bd5 FD:    1 BD: 1451 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
00000000bac5d8ed FD:    1 BD: 1004 ...-: &____s->seqcount#2
000000000f57e411 FD:    1 BD: 1448 -.-.: &cfs_rq->removed.lock
0000000013c1ab65 FD:    7 BD: 1449 -.-.: &rt_b->rt_runtime_lock
000000003bdf78f4 FD:    1 BD: 1450 -.-.: &rt_rq->rt_runtime_lock
00000000975d5b80 FD:    1 BD: 1448 ....: &cp->lock
000000002586e81b FD:    1 BD: 1471 -.-.: pvclock_gtod_data
00000000d03aed24 FD:    1 BD: 1275 ..-.: &tsk->delays->lock
000000001119414f FD:    1 BD: 1448 -...:
per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)
000000006f3d793b FD:    6 BD: 1449 -.-.: &ctx->lock
00000000f3f0190c FD:    9 BD: 1448 -...: &rq->lock/1
000000007410cf1a FD:    1 BD: 1448 -...: &rd->rto_lock

There are 19 with ~1500 incoming edges. So that's 20K.

In my local testing I was at around 20-something K and these worst
offenders were at ~1000 back edges.
Now they got to 1500, so that is what got us over the 32K limit, right?

Does this analysis make sense?

Any ideas what to do with these?
