Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFD2BA61D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgKTJ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKTJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:27:45 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:27:45 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so8288536qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHrywd/qnwXuoVgj7oMjqZiIjF0BFaOJ2U/YcQqX3iE=;
        b=e/oirgTqWA1Coz7p/iM5wb3i4y7ECKGh7c/wwJEi8a3AqVAjzMWAQJg5qnxX47FOot
         2nFsGaTbr1b2TbRDVa47npeff2VeHavSMM4dXGE/Muxdtc4Po3vu3GHKHv7561bs6/tT
         GHyzXsRpoov4jhaOcbwfMIf4MswEeJ/xaDOKxfqgnUzbl4jBpdlMlAye9Isx2/Q/a93W
         dHKe9wa2SJsstTKknw/anRa+a3Cyi1Gc8w+0RY+u5GgZeu1gAnX0Q+FReXGLlsCgdm25
         A66p9vLdi7gDzCZLPACElnkO6fcOExMgkCdsHtNr7sNc4yR+lhzSl49cwlOU6ZBbL1dk
         nzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHrywd/qnwXuoVgj7oMjqZiIjF0BFaOJ2U/YcQqX3iE=;
        b=IDrEdpcralCov0FkH2H8+NM7VsBagLL9lz2ousZApc9fDoGq829w94oHef62M2pe4v
         1pjt1XmtMw47t+6qQjpYiAbagQiOhv4RVc7XuHm7HsH+IhfMr/22dZuvvYPeyrQhKLCD
         0qFF6lltcs7PirWg52T5NDdPzAfy0HtISJhztg/4Xf9l9hMiolnmpdipPF/dj8lZ41uB
         TWY9IijDJPLAtHAyLzTHAm0HuUJwPOYPHYFhp+Ln7/2jI+pX2QmI4JO7wItvQB8yQ/Af
         RvLjRDNH1u/Cn+jUZ7JXj0t2IaV6AIgpTt96yMC/OwjE2mLK5fFzK+ST4RJ89JHkWrmS
         9x9g==
X-Gm-Message-State: AOAM531ymveOAHKCUafGkwZgw2Njsz4YkqFa6I/eJDcFi/h7+yt4Z8xp
        yMNu1ja/hQZEhngbqh1qsE31DdIMlKi7tXcuoqcWKw==
X-Google-Smtp-Source: ABdhPJy4/yP0veQ7n5JTClwg5htVPCYcENOfhj+Fvt8biy0g/Y/DizZNwlxKsM4iZmglGPSCIy2Fzbb53FrMQoCZOfo=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr16037274qkm.231.1605864464575;
 Fri, 20 Nov 2020 01:27:44 -0800 (PST)
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
 <CACT4Y+a4X4MNkWsvRySokKE=gO8AH1kegtUQk9T0M37EfWtN-w@mail.gmail.com>
 <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
 <CACT4Y+ZBVOHD79Mbdpmuxn6OC757BSA7p+JF_YNyUEVfvRFdGQ@mail.gmail.com>
 <CACT4Y+YdpbM44wbObS261CtvC3xfQTamKxkt9eFUwwKGYTELsw@mail.gmail.com> <CACT4Y+ZXKwgdML0FxfkXtDqiWWGK3m9bx_i_i+wbQXNh_t4sLA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZXKwgdML0FxfkXtDqiWWGK3m9bx_i_i+wbQXNh_t4sLA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 10:27:32 +0100
Message-ID: <CACT4Y+asqRbjaN9ras=P5DcxKgzsnV0fvV0tYb2VkT+P00pFvQ@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 10:22 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Nov 19, 2020 at 7:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > On Thu, Nov 19, 2020 at 2:45 PM Tetsuo Handa
> > > > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > > >
> > > > > > On 2020/11/19 22:06, Dmitry Vyukov wrote:
> > > > > > >>>>
> > > > > > >>>> I am trying to reproduce this locally first. syzbot caims it can
> > > > > > >>>> reproduce it with a number of very simpler reproducers (like spawn
> > > > > > >>>> process, unshare, create socket):
> > > > > > >>>> https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc
> > > > > > >>>>
> > > > > > >>>> I see a very slow drift, but it's very slow, so get only to:
> > > > > > >>>>  direct dependencies:                 22072 [max: 32768]
> > > > > > >>>>
> > > > > > >>>> But that's running a very uniform workload.
> > > > > > >>>>
> > > > > > >>>> However when I tried to cat /proc/lockdep to see if there is anything
> > > > > > >>>> fishy already,
> > > > > > >>>> I got this (on c2e7554e1b85935d962127efa3c2a76483b0b3b6).
> > > > > > >>>>
> > > > > > >>>> Some missing locks?
> > > > > >
> > > > > > Not a TOMOYO's bug. Maybe a lockdep's bug.
> > > > > >
> > > > > > >
> > > > > > > But I don't know if it's enough to explain the overflow or not...
> > > > > > >
> > > > > >
> > > > > > Since you can't hit the limit locally, I guess we need to ask syzbot to
> > > > > > run massive testcases.
> > > > >
> > > > > I am trying to test the code that will do this. Otherwise we will get
> > > > > days-long round-trips for stupid bugs. These files are also quite
> > > > > huge, I afraid that may not fit into storage.
> > > > >
> > > > > So far I get to at most:
> > > > >
> > > > >  lock-classes:                         2901 [max: 8192]
> > > > >  direct dependencies:                 25574 [max: 32768]
> > > > >  dependency chains:                   40605 [max: 65536]
> > > > >  dependency chain hlocks used:       176814 [max: 327680]
> > > > >  stack-trace entries:                258590 [max: 524288]
> > > > >
> > > > > with these worst offenders:
> > > > >
> > > > > # egrep "BD: [0-9]" /proc/lockdep
> > > > > 00000000df5b6792 FD:    2 BD: 1235 -.-.: &obj_hash[i].lock
> > > > > 000000005dfeb73c FD:    1 BD: 1236 ..-.: pool_lock
> > > > > 00000000b86254b1 FD:   14 BD: 1111 -.-.: &rq->lock
> > > > > 00000000866efb75 FD:    1 BD: 1112 ....: &cfs_b->lock
> > > > > 000000006970cf1a FD:    2 BD: 1126 ----: tk_core.seq.seqcount
> > > > > 00000000f49d95b0 FD:    3 BD: 1180 -.-.: &base->lock
> > > > > 00000000ba3f8454 FD:    5 BD: 1115 -.-.: hrtimer_bases.lock
> > > > > 00000000fb340f16 FD:   16 BD: 1030 -.-.: &p->pi_lock
> > > > > 00000000c9f6f58c FD:    1 BD: 1114 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
> > > > > 0000000049d3998c FD:    1 BD: 1112 -.-.: &cfs_rq->removed.lock
> > > > > 00000000fdf7f396 FD:    7 BD: 1112 -...: &rt_b->rt_runtime_lock
> > > > > 0000000021aedb8d FD:    1 BD: 1113 -...: &rt_rq->rt_runtime_lock
> > > > > 000000004e34c8d4 FD:    1 BD: 1112 ....: &cp->lock
> > > > > 00000000b2ac5d96 FD:    1 BD: 1127 -.-.: pvclock_gtod_data
> > > > > 00000000c5df4dc3 FD:    1 BD: 1031 ..-.: &tsk->delays->lock
> > > > > 00000000fe623698 FD:    1 BD: 1112 -...:
> > > > > per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)
> > > > >
> > > > >
> > > > > But the kernel continues to crash on different unrelated bugs...
> > > >
> > > >
> > > > Here is one successful sample. How do we debug it? What should we be
> > > > looking for?
> > > >
> > > > p.s. it's indeed huge, full log was 11MB, this probably won't be
> > > > chewed by syzbot.
> > > > Peter, are these [hex numbers] needed? Could we strip them during
> > > > post-processing? At first sight they look like derivatives of the
> > > > name.
> > >
> > > The worst back-edge offenders are:
> > >
> > > 00000000b445a595 FD:    2 BD: 1595 -.-.: &obj_hash[i].lock
> > > 0000000055ae0468 FD:    1 BD: 1596 ..-.: pool_lock
> > > 00000000b1336dc4 FD:    2 BD: 1002 ..-.: &zone->lock
> > > 000000009a0cabce FD:    1 BD: 1042 ...-: &____s->seqcount
> > > 000000001f2849b5 FD:    1 BD: 1192 ..-.: depot_lock
> > > 00000000d044255b FD:    1 BD: 1038 -.-.: &n->list_lock
> > > 000000005868699e FD:   17 BD: 1447 -.-.: &rq->lock
> > > 00000000bb52ab59 FD:    1 BD: 1448 ....: &cfs_b->lock
> > > 000000004f442fff FD:    2 BD: 1469 ----: tk_core.seq.seqcount
> > > 00000000c908cc32 FD:    3 BD: 1512 -.-.: &base->lock
> > > 00000000478677cc FD:    5 BD: 1435 -.-.: hrtimer_bases.lock
> > > 00000000b5b65cb1 FD:   19 BD: 1255 -.-.: &p->pi_lock
> > > 000000007f313bd5 FD:    1 BD: 1451 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
> > > 00000000bac5d8ed FD:    1 BD: 1004 ...-: &____s->seqcount#2
> > > 000000000f57e411 FD:    1 BD: 1448 -.-.: &cfs_rq->removed.lock
> > > 0000000013c1ab65 FD:    7 BD: 1449 -.-.: &rt_b->rt_runtime_lock
> > > 000000003bdf78f4 FD:    1 BD: 1450 -.-.: &rt_rq->rt_runtime_lock
> > > 00000000975d5b80 FD:    1 BD: 1448 ....: &cp->lock
> > > 000000002586e81b FD:    1 BD: 1471 -.-.: pvclock_gtod_data
> > > 00000000d03aed24 FD:    1 BD: 1275 ..-.: &tsk->delays->lock
> > > 000000001119414f FD:    1 BD: 1448 -...:
> > > per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)
> > > 000000006f3d793b FD:    6 BD: 1449 -.-.: &ctx->lock
> > > 00000000f3f0190c FD:    9 BD: 1448 -...: &rq->lock/1
> > > 000000007410cf1a FD:    1 BD: 1448 -...: &rd->rto_lock
> > >
> > > There are 19 with ~1500 incoming edges. So that's 20K.
> > >
> > > In my local testing I was at around 20-something K and these worst
> > > offenders were at ~1000 back edges.
> > > Now they got to 1500, so that is what got us over the 32K limit, right?
> > >
> > > Does this analysis make sense?
> > >
> > > Any ideas what to do with these?
> >
> > And here is a full dump for:
> > BUG: MAX_LOCKDEP_CHAINS too low!
>
> Attached a wrong one, here is the one with "BUG: MAX_LOCKDEP_CHAINS too low!".
>
> There are also some outliers with high FD count. But these mostly look
> fine too, just locks with high fan out
> (genl_mutex/deferred_process_work):
>
> $ egrep "FD: [0-9]" log42
> 00000000745aa345 FD: 1032 BD:   13 +.+.: cgroup_mutex
> 00000000cdf4d414 FD: 1193 BD:    8 ++++: pernet_ops_rwsem
> 00000000582c60d4 FD: 1707 BD:    1 +.+.: (wq_completion)events
> 000000003f5e465a FD: 1012 BD:   46 +.+.: rtnl_mutex
> 000000005c1c41b7 FD: 1041 BD:    1 ++++: cb_lock
> 000000001dea9384 FD: 1038 BD:    3 +.+.: genl_mutex
> 00000000d158b76e FD: 1483 BD:    2 +.+.: (delayed_fput_work).work
> 00000000caec859a FD: 1036 BD:    1 +.+.: (wq_completion)events_power_efficient
> 00000000e36b9bc8 FD: 1033 BD:    1 +.+.: blkcg_pol_register_mutex
> 00000000927de1d8 FD: 1013 BD:    2 +.+.: (linkwatch_work).work
> 00000000161fed05 FD: 1013 BD:    1 +.+.: dlci_ioctl_mutex
> 000000003b6f60a4 FD: 1194 BD:    1 +.+.: masq_mutex
> 0000000050f06ef0 FD: 1015 BD:    1 +.+.: (wq_completion)ipv6_addrconf
> 0000000022d8bdd2 FD: 1013 BD:    2 +.+.: (addr_chk_work).work
> 00000000208719ed FD: 1014 BD:    1 +.+.: br_ioctl_mutex
> 0000000034a64a9d FD: 1013 BD:    1 +.+.: vlan_ioctl_mutex
> 000000004bbb2b36 FD: 1013 BD:    2 +.+.: reg_work
> 00000000f3d10da2 FD: 1075 BD:    2 +.+.: (work_completion)(&fw_work->work)
> 00000000bf633318 FD: 1089 BD:    2 +.+.: &p->lock
> 00000000a04e4ca6 FD: 1342 BD:    4 +.+.: &sb->s_type->i_mutex_key#11
> 0000000074e4d032 FD: 1065 BD:    2 .+.+: sb_writers#7
> 000000005b21b2d8 FD: 1056 BD:    6 +.+.: &of->mutex
> 000000004e03ff55 FD: 1189 BD:    1 +.+.: &f->f_pos_lock
> 000000003c8d0466 FD: 1013 BD:    2 +.+.: (crda_timeout).work
> 00000000d7d5a678 FD: 1013 BD:    2 +.+.:
> (work_completion)(&(&ifa->dad_work)->work)
> 0000000085c47bd2 FD: 1013 BD:    2 +.+.: (reg_check_chans).work
> 0000000008a61c9f FD: 1065 BD:    2 .+.+: sb_writers#10
> 000000003728e6ec FD: 1065 BD:    1 .+.+: sb_writers#11
> 000000007fe449ca FD: 1035 BD:    1 ++++: &type->s_umount_key#43
> 0000000078ce5279 FD: 1013 BD:    2 +.+.: deferred_process_work
> 00000000c673625f FD: 1029 BD:    1 .+.+: kn->active#80
> 000000003734f752 FD: 1028 BD:    8 +.+.: nsim_bus_dev_list_lock
> 0000000085797ea4 FD: 1023 BD:   20 +.+.: devlink_mutex
> 0000000019a4328d FD: 1020 BD:    2 +.+.:
> (work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)
> 00000000615ae4c1 FD: 1018 BD:   22 +.+.: &nsim_dev->port_list_lock
> 00000000bf207b94 FD: 1039 BD:    2 +.+.: nlk_cb_mutex-GENERIC
> 00000000d0a722ec FD: 1015 BD:    1 +.+.: (wq_completion)cfg80211
> 00000000e2d69b1e FD: 1013 BD:   10 +.+.: (work_completion)(&rdev->event_work)
> 0000000094cc69ac FD: 1040 BD:    3 +.+.: &type->i_mutex_dir_key#6/1
> 00000000897451d9 FD: 1035 BD:    2 +.+.: &type->i_mutex_dir_key#7/1
> 000000008bade0a8 FD: 1014 BD:    1 +.+.: ppp_mutex
> 000000004f82d94d FD: 1196 BD:    1 +.+.: (wq_completion)netns
> 000000002d98bcf4 FD: 1195 BD:    2 +.+.: net_cleanup_work
> :00000000cade4b38 FD: 1343 BD:    1 .+.+: sb_writers#13
> 00000000530be43e FD: 1013 BD:    2 +.+.:
> (work_completion)(&(&rdev->dfs_update_channels_wk)->work)
> 0000000027cc2a05 FD: 1032 BD:    2 +.+.: (work_completion)(&map->work)


Peter, so far it looks like just a very large, but normal graph to me.
The cheapest from an engineering point of view solution would be just
to increase the constants. I assume a 2x increase should buy us lots
of time to overflow.
I can think of more elaborate solutions, e.g. using bitmasks to
represent hot leaf and top-level locks. But it will both increase the
resulting code complexity (no uniform representation anymore, all code
will need to deal with different representations) and require some
time investments (that I can't justify for me at least as compared to
just throwing a bit more machine memory at it). And in the end it
won't really reduce the size of the graph.
What do you think?
