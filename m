Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CC2B930F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKSNGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:06:43 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD00C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:06:43 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so4229536qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dH/lJ5LGlOQEA0LHPfM2oq1R1owBXitRnTpU2gzTFBk=;
        b=mYKzOlti7ci3kTWMSNmAoxq95ntmgYD8otP9PD8d7BLv6njbKJKQKqXBxB7JdDbxh5
         b5VZHPKSXCY7WXP91S5JaIFgwL/o0xiAu7D3VZRyksng2srRPM10ejACFH/bLcC3jKfB
         pYI6QbORmUUWqiyWDZjfvLxsMZC3/0piJe8s7z234Js4Uew4uL4Olgvjv9Lj3ZG8vr/W
         n1StT7UTVQ7E76LIeGcOV6YHdLN6LbufbtMa+zSLLJjh8/CiG2voWgJQ4lY6IgjLOfTu
         ftsyw9bZvKY73rjHjxcJghGiP2yuwXzggbuG+WHoEw95Pow9bTMDJrjOfqLsnNd+tCGa
         ClHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH/lJ5LGlOQEA0LHPfM2oq1R1owBXitRnTpU2gzTFBk=;
        b=W//6sQE70xJsSyJuHbU7ntslOT4iYNrN2Lxy9ouae2ugKIcrJYwLr0jbYwsOw5XzY7
         G9Sozg9KaFQZE0lv/CUn86ZVL8Gnxjj+4yY1gA9wWMISZmvOn/W9NnzuGa9kWaIQZhd1
         XdU+RMR8Z9INSTE3StHRbOvhF3FH4x5NTTRptJ1FBSzaaWbanAXWu88DNpwa+Xf6+PoD
         4WjeqrmyP9l9ShZANtO4rA40GRC7V3az2nL9FQKD1fcUDd63A91RtsPbnzI6vJX268xn
         tSUK1/CJMf4SaR91ZXPjkjUmrfzRJVwOOHA1eyR8qgB2HGzsn6RkQOcokCRMBFde3+Dy
         9yow==
X-Gm-Message-State: AOAM530aIZpbujoAhgvVaoUcS2Ayu5rF/G0ojlMygEah8edtzEiPMhOU
        T+RDKTXIid2sfvaM5cyZEpSh66N1cOEQEoa/CEJP9Q==
X-Google-Smtp-Source: ABdhPJx+ILLD+1369ge5qlkuHrKGAB9cAo/e+aaTxBG4GEeD39m8hCoBLPjd792mJvWbSvdGD1gsJjKS4dUhoGtpgQ8=
X-Received: by 2002:aed:2664:: with SMTP id z91mr9372365qtc.290.1605791202534;
 Thu, 19 Nov 2020 05:06:42 -0800 (PST)
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
 <CACT4Y+Zh10241gchu6e_=LwxPSEzXT-0HSmhnTtkXFZevKi_yQ@mail.gmail.com> <CACT4Y+a8TjV+Pe6mwne777RV+xB+aHT6GxuMLAVBn5mtK4P0Lw@mail.gmail.com>
In-Reply-To: <CACT4Y+a8TjV+Pe6mwne777RV+xB+aHT6GxuMLAVBn5mtK4P0Lw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Nov 2020 14:06:31 +0100
Message-ID: <CACT4Y+ZSsKjvojD8iFVFv9F5X5BvZR8vLyaKrgxUxyknma04Sg@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 1:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Nov 19, 2020 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Wed, Nov 18, 2020 at 4:32 PM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > >
> > > > On 2020/11/19 0:10, Peter Zijlstra wrote:
> > > > > On Wed, Nov 18, 2020 at 11:30:05PM +0900, Tetsuo Handa wrote:
> > > > >> The problem is that we can't know what exactly is consuming these resources.
> > > > >> My question is do you have a plan to make it possible to know what exactly is
> > > > >> consuming these resources.
> > > > >
> > > > > I'm pretty sure it's in /proc/lockdep* somewhere.
> > > >
> > > > OK. Then...
> > > >
> > > > Dmitry, can you update syzkaller to dump /proc/lockdep* before terminating as
> > > > a crash as soon as encountering one of
> > > >
> > > >   BUG: MAX_LOCKDEP_ENTRIES too low!
> > > >   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > >   BUG: MAX_LOCKDEP_CHAINS too low!
> > > >   BUG: MAX_LOCKDEP_KEYS too low!
> > > >   WARNING in print_bfs_bug
> > > >
> > > > messages?
> > > >
> > > > On 2020/09/16 21:14, Dmitry Vyukov wrote:
> > > > > On Wed, Sep 16, 2020 at 1:51 PM <peterz@infradead.org> wrote:
> > > > >>
> > > > >> On Wed, Sep 16, 2020 at 01:28:19PM +0200, Dmitry Vyukov wrote:
> > > > >>> On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
> > > > >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > >>>>
> > > > >>>> Hello. Can we apply this patch?
> > > > >>>>
> > > > >>>> This patch addresses top crashers for syzbot, and applying this patch
> > > > >>>> will help utilizing syzbot's resource for finding other bugs.
> > > > >>>
> > > > >>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > > > >>>
> > > > >>> Peter, do you still have concerns with this?
> > > > >>
> > > > >> Yeah, I still hate it with a passion; it discourages thinking. A bad
> > > > >> annotation that blows up the lockdep storage, no worries, we'll just
> > > > >> increase this :/
> > > > >>
> > > > >> IIRC the issue with syzbot is that the current sysfs annotation is
> > > > >> pretty terrible and generates a gazillion classes, and syzbot likes
> > > > >> poking at /sys a lot and thus floods the system.
> > > > >>
> > > > >> I don't know enough about sysfs to suggest an alternative, and haven't
> > > > >> exactly had spare time to look into it either :/
> > > > >>
> > > > >> Examples of bad annotations is getting every CPU a separate class, that
> > > > >> leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
> > > > >> only a single nesting level).
> > > > >
> > > > > Maybe on "BUG: MAX_LOCKDEP_CHAINS too low!" we should then aggregate,
> > > > > sort and show existing chains so that it's possible to identify if
> > > > > there are any worst offenders and who they are.
> > > > >
> > > > > Currently we only have a hypothesis that there are some worst
> > > > > offenders vs lots of normal load. And we can't point fingers which
> > > > > means that, say, sysfs, or other maintainers won't be too inclined to
> > > > > fix anything.
> > > > >
> > > > > If we would know for sure that lock class X is guilty. That would make
> > > > > the situation much more actionable.
> > >
> > > I am trying to reproduce this locally first. syzbot caims it can
> > > reproduce it with a number of very simpler reproducers (like spawn
> > > process, unshare, create socket):
> > > https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc
> > >
> > > I see a very slow drift, but it's very slow, so get only to:
> > >  direct dependencies:                 22072 [max: 32768]
> > >
> > > But that's running a very uniform workload.
> > >
> > > However when I tried to cat /proc/lockdep to see if there is anything
> > > fishy already,
> > > I got this (on c2e7554e1b85935d962127efa3c2a76483b0b3b6).
> > >
> > > Some missing locks?
> > >
> > > ==================================================================
> > > BUG: KASAN: use-after-free in string_nocheck lib/vsprintf.c:611 [inline]
> > > BUG: KASAN: use-after-free in string+0x39c/0x3d0 lib/vsprintf.c:693
> > > Read of size 1 at addr ffff888295833740 by task less/1855
> > >
> > > CPU: 0 PID: 1855 Comm: less Tainted: G        W         5.10.0-rc4+ #68
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x107/0x163 lib/dump_stack.c:118
> > >  print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
> > >  __kasan_report mm/kasan/report.c:545 [inline]
> > >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
> > >  string_nocheck lib/vsprintf.c:611 [inline]
> > >  string+0x39c/0x3d0 lib/vsprintf.c:693
> > >  vsnprintf+0x71b/0x14f0 lib/vsprintf.c:2618
> > >  seq_vprintf fs/seq_file.c:398 [inline]
> > >  seq_printf+0x195/0x240 fs/seq_file.c:413
> > >  print_name+0x98/0x1d0 kernel/locking/lockdep_proc.c:50
> > >  l_show+0x111/0x2c0 kernel/locking/lockdep_proc.c:82
> > >  seq_read_iter+0xae4/0x10c0 fs/seq_file.c:268
> > >  proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:310
> > >  call_read_iter include/linux/fs.h:1897 [inline]
> > >  new_sync_read+0x41e/0x6e0 fs/read_write.c:415
> > >  vfs_read+0x35c/0x570 fs/read_write.c:496
> > >  ksys_read+0x12d/0x250 fs/read_write.c:634
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > RIP: 0033:0x7f1d48906310
> > > Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8
> > > ff eb ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d
> > > 01 f04
> > > RSP: 002b:00007fff8ad3f048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > > RAX: ffffffffffffffda RBX: 0000000000ae0ec0 RCX: 00007f1d48906310
> > > RDX: 0000000000002000 RSI: 0000000000ae0eec RDI: 0000000000000004
> > > RBP: 0000000000072000 R08: 0000000000000038 R09: 0000000001000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a6d7f0
> > > R13: 0000000000000000 R14: 0000000000000039 R15: 0000000000ae0ec0
> > >
> > > Allocated by task 2828:
> > >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> > >  kasan_set_track mm/kasan/common.c:56 [inline]
> > >  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
> > >  kmalloc include/linux/slab.h:557 [inline]
> > >  kzalloc include/linux/slab.h:664 [inline]
> > >  tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
> > >  tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
> > >  tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
> > >  tomoyo_path_perm+0x368/0x400 security/tomoyo/file.c:831
> > >  tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
> > >  security_path_symlink+0xdf/0x150 security/security.c:1110
> > >  do_symlinkat+0x123/0x2c0 fs/namei.c:3985
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Freed by task 2828:
> > >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> > >  kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
> > >  kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
> > >  __kasan_slab_free+0x102/0x140 mm/kasan/common.c:422
> > >  slab_free_hook mm/slub.c:1544 [inline]
> > >  slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1577
> > >  slab_free mm/slub.c:3142 [inline]
> > >  kfree+0xdb/0x360 mm/slub.c:4124
> > >  tomoyo_path_perm+0x3b0/0x400 security/tomoyo/file.c:840
> > >  tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
> > >  security_path_symlink+0xdf/0x150 security/security.c:1110
> > >  do_symlinkat+0x123/0x2c0 fs/namei.c:3985
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > The buggy address belongs to the object at ffff888295833740
> > >  which belongs to the cache kmalloc-32 of size 32
> > > The buggy address is located 0 bytes inside of
> > >  32-byte region [ffff888295833740, ffff888295833760)
> > > The buggy address belongs to the page:
> > > page:00000000706b2f94 refcount:1 mapcount:0 mapping:0000000000000000
> > > index:0x0 pfn:0x295833
> > > flags: 0x57ffe0000000200(slab)
> > > raw: 057ffe0000000200 ffffea0004adca40 0000000200000002 ffff888100041a00
> > > raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
> > > page dumped because: kasan: bad access detected
> > >
> > > Memory state around the buggy address:
> > >  ffff888295833600: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> > >  ffff888295833680: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> > > >ffff888295833700: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> > >                                            ^
> > >  ffff888295833780: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
> > >  ffff888295833800: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> > > ==================================================================
> >
> >
> > Trying again I wasn't able to reproduce the drift.
> > Then I realized that running that simple workload I am getting a mix of:
> > [ 1459.589213][ T3142] WARNING: CPU: 1 PID: 3142 at
> > drivers/net/bonding/bond_main.c:4310
> > bond_update_slave_arr+0xcaf/0x10c0
> > [  222.027968][ T8662] BUG: sleeping function called from invalid
> > context at net/mac80211/sta_info.c:1962
> > which torns off lockdep completely.
> > Perhaps it would be useful to add ON/OFF status to lockdep_stats.
>
> I can reproduce slow drift by running just:
>
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sched.h>
> int main() {
>     for (int i = 0; i < 16; i++) {
>         if (fork() == 0) {
>             for (;;) {
>                 unshare(CLONE_NEWNET);
>             }
>         }
>     }
>     sleep(1<<20);
> }
>
>  lock-classes:                         1765 [max: 8192]
>  direct dependencies:                 12882 [max: 32768]
>  dependency chains:                   16841 [max: 65536]
>  dependency chain hlocks used:        65720 [max: 327680]
>  stack-trace entries:                141213 [max: 524288]
> ...
>  lock-classes:                         1768 [max: 8192]
>  direct dependencies:                 13048 [max: 32768]
>  dependency chains:                   17144 [max: 65536]
>  dependency chain hlocks used:        67194 [max: 327680]
>  stack-trace entries:                143043 [max: 524288]
> ...
>  lock-classes:                         1768 [max: 8192]
>  direct dependencies:                 13056 [max: 32768]
>  dependency chains:                   17173 [max: 65536]
>  dependency chain hlocks used:        67353 [max: 327680]
>  stack-trace entries:                143138 [max: 524288]
> ...
>  lock-classes:                         1770 [max: 8192]
>  direct dependencies:                 13072 [max: 32768]
>  dependency chains:                   17232 [max: 65536]
>  dependency chain hlocks used:        67604 [max: 327680]
>  stack-trace entries:                143390 [max: 524288]


Part of this can be explained by non-deterministically taken
scheduler/kmalloc lock.
These are slowly taken in more and more random places:

root@syzkaller:~# egrep "BD:  [4-9]" /proc/lockdep
0000000095032c93 FD:    2 BD:  822 -.-.: &obj_hash[i].lock
00000000b7a46d70 FD:    1 BD:  823 ..-.: pool_lock
0000000083d7269e FD:    2 BD:  518 ..-.: &zone->lock
000000002ccb1edd FD:    1 BD:  526 ...-: &____s->seqcount
0000000084e3526f FD:    1 BD:  586 -.-.: depot_lock
00000000902ec5bd FD:    1 BD:  495 ..-.: &n->list_lock
0000000090368662 FD:   13 BD:  747 -.-.: &rq->lock
00000000584dac99 FD:    1 BD:  748 ....: &cfs_b->lock
0000000040e6e0e2 FD:   18 BD:  471 -.-.: &pool->lock
00000000463b385b FD:   20 BD:  402 -.-.: &pool->lock/1
00000000cc84b7dd FD:    1 BD:  407 -.-.: rcu_node_0
000000001c39e710 FD:    2 BD:  759 ----: tk_core.seq.seqcount
000000001666d8c1 FD:    3 BD:  782 -.-.: &base->lock
00000000c2cc6df8 FD:   22 BD:  426 +.+.: sysctl_lock
00000000ce7f6164 FD:    5 BD:  750 -.-.: hrtimer_bases.lock
000000004d814e16 FD:   33 BD:  425 +.+.: &dentry->d_lock
000000006bce20c6 FD:   15 BD:  650 -.-.: &p->pi_lock
00000000b0649d65 FD:    1 BD:  750 -.-.: &per_cpu_ptr(group->pcpu, cpu)->seq
00000000565db0bb FD:   16 BD:  472 ..-.: wq_mayday_lock
00000000b2aab64b FD:    1 BD:  748 -.-.: &cfs_rq->removed.lock
00000000fca10e98 FD:    7 BD:  748 -...: &rt_b->rt_runtime_lock
000000009ecec09b FD:    1 BD:  749 -...: &rt_rq->rt_runtime_lock
0000000049455d82 FD:    1 BD:  748 ....: &cp->lock
00000000680101ba FD:    2 BD:  429 +.+.: &____s->seqcount#4
0000000096be0d2b FD:    1 BD:  406 ..-.: quarantine_lock
000000009ca236d8 FD:   21 BD:  438 ....: krc.lock
00000000362192dc FD:   16 BD:  426 ....: &wq
000000001680ad80 FD:    6 BD:  426 +.+.: &dentry->d_lock/1
00000000d7e85735 FD:    1 BD:  760 -.-.: pvclock_gtod_data
00000000553448d2 FD:   16 BD:  439 ....: &pgdat->kswapd_wait
00000000ad927e1a FD:   16 BD:  474 ....: &x->wait#12
0000000032646360 FD:   16 BD:  402 -.-.: &rcu_state.expedited_wq
00000000463b551e FD:    1 BD:  651 ..-.: &tsk->delays->lock
0000000036b1c7d2 FD:   16 BD:  426 ....: &wq#2
000000007211be38 FD:    1 BD:  427 +.+.: &lru->node[i].lock
000000002e97aa5e FD:    1 BD:  426 ....: &wq#3
000000000c53876e FD:    4 BD:  427 +.+.: &dentry->d_lock/2
00000000fb45c9bd FD:    3 BD:  428 +.+.: &dentry->d_lock/3
000000009f8394cb FD:    1 BD:  430 +.+.: &____s->seqcount#4/1
00000000439f870a FD:    1 BD:  426 ....: &wq#4

And diffing samples I see how they slowly creep.

But I don't know if it's enough to explain the overflow or not...
