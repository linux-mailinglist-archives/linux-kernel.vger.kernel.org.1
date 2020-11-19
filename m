Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE442B9412
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKSOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:05:50 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1856C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:05:49 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e14so2867389qve.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwhLnjKmfO1PcOKwdzaacmsqx0wVjbnjomFHjf3z3Tg=;
        b=bsolWNpnC/pFsB2MhVRbEL4kOuL05TlE0WZO3+bEQaXyw/4UbaDjBM31NbhYhfB+pS
         tMnjYDqXpRNr4w3tgS09iW7o4lduc7MQqsrYC7Cquh892dqLLHU2/L9K6TUoNXrW+50Q
         z/yLtLNriJ3Qy47EX7h798dDkssO2KZ8smLd5JHSKwwC7cXyJtqsdH8lk+nuXS88PW0f
         E/6roR4XJV0NfrHEAhKD+wGnT1Vp+bimxmSfRgUj6JgToFxnAIwSbIb3W/RamXtIO2nB
         sZqWVEkNCzsen6Ir2//77SlMRUbXmTLqgOdDFm4Gv3L0txNIoyGb8MFxNxtLTKr38t7/
         xO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwhLnjKmfO1PcOKwdzaacmsqx0wVjbnjomFHjf3z3Tg=;
        b=bEL9Rx4QgTeR7OsFw9VGRNrZbSqNifNQUQVViZiKVYuuYZzEghKe4AsXlzaUhFsgPm
         IfsmIIdmru+/D2mogWXb1ISZRtiWdmvU8tU0kPbBxGNx6FEIiUhQ2Yurv1nSmu9De4xI
         oWoIppP9uXl9YI7lX0hag5JN4x530zLZBnpHhjfUJwjI+Smp6Gpbe+DTDLzbB8vMao2R
         VTdiCEPYbfWLX1V/UIPLmVX/aI0nlgWZuxSknr0BaiUXQuBWqfISiuu3Ezpg+K1BEfrT
         Lwk5bqbhwHGXTJTF+jAeOtvDdmEcQ7xeY6IQa3ccSsMwoEa2BOHxYNi7vkPXs4aq9iX2
         aaZQ==
X-Gm-Message-State: AOAM531D0jSBMRsFLospPb5BbteZH9j/2iUnQpAzqfdfObunoNYNQ6v2
        hJGFEsLGPjlvJw26Np/yssMeB5PIM6nv3yGfIv00ug==
X-Google-Smtp-Source: ABdhPJwhiueb4S7wo/k5WyWEVz3WPmf0oZ/uGmB9NjIGdbn0kh5S8id46EnwssgGjSPwche/7WG9CC2iNmc2G2RtpQQ=
X-Received: by 2002:a05:6214:12ed:: with SMTP id w13mr10766898qvv.23.1605794748624;
 Thu, 19 Nov 2020 06:05:48 -0800 (PST)
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
 <CACT4Y+ZSsKjvojD8iFVFv9F5X5BvZR8vLyaKrgxUxyknma04Sg@mail.gmail.com> <5e8342c4-702f-80a9-e669-8a7386ce0da1@i-love.sakura.ne.jp>
In-Reply-To: <5e8342c4-702f-80a9-e669-8a7386ce0da1@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Nov 2020 15:05:36 +0100
Message-ID: <CACT4Y+a4X4MNkWsvRySokKE=gO8AH1kegtUQk9T0M37EfWtN-w@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 2:45 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/11/19 22:06, Dmitry Vyukov wrote:
> >>>>
> >>>> I am trying to reproduce this locally first. syzbot caims it can
> >>>> reproduce it with a number of very simpler reproducers (like spawn
> >>>> process, unshare, create socket):
> >>>> https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc
> >>>>
> >>>> I see a very slow drift, but it's very slow, so get only to:
> >>>>  direct dependencies:                 22072 [max: 32768]
> >>>>
> >>>> But that's running a very uniform workload.
> >>>>
> >>>> However when I tried to cat /proc/lockdep to see if there is anything
> >>>> fishy already,
> >>>> I got this (on c2e7554e1b85935d962127efa3c2a76483b0b3b6).
> >>>>
> >>>> Some missing locks?
>
> Not a TOMOYO's bug. Maybe a lockdep's bug.
>
> >
> > But I don't know if it's enough to explain the overflow or not...
> >
>
> Since you can't hit the limit locally, I guess we need to ask syzbot to
> run massive testcases.

I am trying to test the code that will do this. Otherwise we will get
days-long round-trips for stupid bugs. These files are also quite
huge, I afraid that may not fit into storage.

So far I get to at most:

 lock-classes:                         2901 [max: 8192]
 direct dependencies:                 25574 [max: 32768]
 dependency chains:                   40605 [max: 65536]
 dependency chain hlocks used:       176814 [max: 327680]
 stack-trace entries:                258590 [max: 524288]

with these worst offenders:

# egrep "BD: [0-9]" /proc/lockdep
00000000df5b6792 FD:    2 BD: 1235 -.-.: &obj_hash[i].lock
000000005dfeb73c FD:    1 BD: 1236 ..-.: pool_lock
00000000b86254b1 FD:   14 BD: 1111 -.-.: &rq->lock
00000000866efb75 FD:    1 BD: 1112 ....: &cfs_b->lock
000000006970cf1a FD:    2 BD: 1126 ----: tk_core.seq.seqcount
00000000f49d95b0 FD:    3 BD: 1180 -.-.: &base->lock
00000000ba3f8454 FD:    5 BD: 1115 -.-.: hrtimer_bases.lock
00000000fb340f16 FD:   16 BD: 1030 -.-.: &p->pi_lock
00000000c9f6f58c FD:    1 BD: 1114 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
0000000049d3998c FD:    1 BD: 1112 -.-.: &cfs_rq->removed.lock
00000000fdf7f396 FD:    7 BD: 1112 -...: &rt_b->rt_runtime_lock
0000000021aedb8d FD:    1 BD: 1113 -...: &rt_rq->rt_runtime_lock
000000004e34c8d4 FD:    1 BD: 1112 ....: &cp->lock
00000000b2ac5d96 FD:    1 BD: 1127 -.-.: pvclock_gtod_data
00000000c5df4dc3 FD:    1 BD: 1031 ..-.: &tsk->delays->lock
00000000fe623698 FD:    1 BD: 1112 -...:
per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)


But the kernel continues to crash on different unrelated bugs...
