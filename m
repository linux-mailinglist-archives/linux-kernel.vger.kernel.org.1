Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA5C2C6144
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgK0JAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgK0JA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:00:29 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:00:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i199so3758129qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2keVCBoNEL2i/chTI8/TWvy++LJ9qFnLh0MA89GY3Xo=;
        b=YPCtfKBVp3+ZTX+60Yfgk8xF38iFEmHgD2CAjuDXW15VIgdObbPsV/kl4aWSNylBfV
         cze025GMSuQJAiFvYnTS3XmSF9W4ScY6vj7uYIyHELdKbX/2tVc0WO8YwYXdTk59d92n
         2kasc8VtKHwD7ortDp4Mwrh2QHKqtD/tN7Yy/x/Ksy4ghHM2X+qHP8XMMFBvhNDuCh1G
         dmjTwd+xQ3Ywrh5A2wjybiVMtScJt78V7mmIn/7kHtKilrZn4zTsRP38lyHMBrXsf52V
         09BO95C6JfdJ7ttlqU2VLAZ0ClfbmjfsXZ0oCA3PfEttW+r8DuGP4il/HChWBABEVPWG
         EB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2keVCBoNEL2i/chTI8/TWvy++LJ9qFnLh0MA89GY3Xo=;
        b=I8+hbWCkeGp8DJ5xVOKH09U0z71caXivipOirSliDDctEzeSQ0xtaJGLgKmFKlYL63
         sl3f9ukF8CmbFJuBjBi/JmZRvX9qDjWp241wkB92IaBwPAscizVo997eNu+kbRV2H5Ge
         T32VteG7G/pIRU6CiSQuBasuf7ieN4b6Vuf8RhHy3JMeSQUyw/0VnrNFMvH3GgS494oO
         x0XRfKXx8/npX0hNbI8T5ns9SJiOYSh7sZTE5vpAnJLOheZrO5oHAtvwWLfDnEU9bcyq
         Yr2HEt8EKThAtx3wHbOhs0mtGnHpjJowf+7qgB5vthvZKTxQY7d5YDYCyl4Goki0bbEF
         lh1w==
X-Gm-Message-State: AOAM5321E+DtDoz0k8KPorh6XYG5OT/9l6szVx9IPRpSRNeA3Z4yGEfQ
        Ck9xxaZPDGyvxsxSmuBFueX4f+ZDYBRezXtg/uX74g==
X-Google-Smtp-Source: ABdhPJysXzVbpc7tzq1GWWNggcfl45I5yliRXzbb5vkpjlL+J53tUFbsJNkXNlD3LMj02kTnHIWJddasasQhth99ET4=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr7557963qkc.350.1606467626962;
 Fri, 27 Nov 2020 01:00:26 -0800 (PST)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
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
 <CACT4Y+YdpbM44wbObS261CtvC3xfQTamKxkt9eFUwwKGYTELsw@mail.gmail.com>
 <CACT4Y+ZXKwgdML0FxfkXtDqiWWGK3m9bx_i_i+wbQXNh_t4sLA@mail.gmail.com>
 <CACT4Y+asqRbjaN9ras=P5DcxKgzsnV0fvV0tYb2VkT+P00pFvQ@mail.gmail.com> <4b89985e-99f9-18bc-0bf1-c883127dc70c@i-love.sakura.ne.jp>
In-Reply-To: <4b89985e-99f9-18bc-0bf1-c883127dc70c@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Nov 2020 10:00:15 +0100
Message-ID: <CACT4Y+Z=eEHz-MCf8GNxhx8f4asytfQ+2QUhA_0G+zbH2_D2Sg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 2:56 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/11/20 18:27, Dmitry Vyukov wrote:
> > Peter, so far it looks like just a very large, but normal graph to me.
> > The cheapest from an engineering point of view solution would be just
> > to increase the constants. I assume a 2x increase should buy us lots
> > of time to overflow.
> > I can think of more elaborate solutions, e.g. using bitmasks to
> > represent hot leaf and top-level locks. But it will both increase the
> > resulting code complexity (no uniform representation anymore, all code
> > will need to deal with different representations) and require some
> > time investments (that I can't justify for me at least as compared to
> > just throwing a bit more machine memory at it). And in the end it
> > won't really reduce the size of the graph.
> > What do you think?
> >
>
> Yes, I think it is a normal graph; simply syzkaller kernels tend to record
> a few times more dependencies than my idle kernel (shown bottom).
>
> Peter, you guessed that the culprit is sysfs at
> https://lkml.kernel.org/r/20200916115057.GO2674@hirez.programming.kicks-ass.net , but
> syzbot reported at https://syzkaller.appspot.com/text?tag=MachineInfo&x=99b8f2b092d9714f
> that "BUG: MAX_LOCKDEP_ENTRIES too low!" can occur on a VM with only 2 CPUs.
> Is your guess catching the culprit?
>
> We could improve a few locks, but as a whole we won't be able to afford keeping
> sum of individual dependencies under current threshold. Therefore, allow lockdep to
> tune the capacity and allow syzkaller to dump when reaching the capacity will be
> the way to go.
>
>
>
> # cat /proc/lockdep_stats
>  lock-classes:                         1236 [max: 8192]
>  direct dependencies:                  9610 [max: 32768]
>  indirect dependencies:               40401
>  all direct dependencies:            174635
>  dependency chains:                   11398 [max: 65536]
>  dependency chain hlocks used:        42830 [max: 327680]
>  dependency chain hlocks lost:            0
>  in-hardirq chains:                      61
>  in-softirq chains:                     414
>  in-process chains:                   10923
>  stack-trace entries:                 93041 [max: 524288]
>  number of stack traces:               4997
>  number of stack hash chains:          4292
>  combined max dependencies:       281074520
>  hardirq-safe locks:                     50
>  hardirq-unsafe locks:                  805
>  softirq-safe locks:                    146
>  softirq-unsafe locks:                  722
>  irq-safe locks:                        155
>  irq-unsafe locks:                      805
>  hardirq-read-safe locks:                 2
>  hardirq-read-unsafe locks:             129
>  softirq-read-safe locks:                11
>  softirq-read-unsafe locks:             123
>  irq-read-safe locks:                    11
>  irq-read-unsafe locks:                 129
>  uncategorized locks:                   224
>  unused locks:                            0
>  max locking depth:                      15
>  max bfs queue depth:                   215
>  chain lookup misses:                 11664
>  chain lookup hits:                37393935
>  cyclic checks:                       11053
>  redundant checks:                        0
>  redundant links:                         0
>  find-mask forwards checks:            1588
>  find-mask backwards checks:           1779
>  hardirq on events:                17502380
>  hardirq off events:               17502376
>  redundant hardirq ons:                   0
>  redundant hardirq offs:                  0
>  softirq on events:                   90845
>  softirq off events:                  90845
>  redundant softirq ons:                   0
>  redundant softirq offs:                  0
>  debug_locks:                             1
>
>  zapped classes:                          0
>  zapped lock chains:                      0
>  large chain blocks:                      1
> # awk ' { if ($2 == "OPS:") print $5" "$9 } ' /proc/lockdep | sort -rV | head -n 30
> 423 (wq_completion)events
> 405 (wq_completion)events_unbound
> 393 &f->f_pos_lock
> 355 &p->lock
> 349 sb_writers#3
> 342 sb_writers#6
> 338 &of->mutex
> 330 (work_completion)(&entry->work)
> 330 pernet_ops_rwsem
> 289 epmutex
> 288 &ep->mtx
> 281 tty_mutex
> 280 &tty->legacy_mutex
> 273 &tty->legacy_mutex/1
> 269 &tty->ldisc_sem
> 268 (wq_completion)ipv6_addrconf
> 266 (work_completion)(&(&ifa->dad_work)->work)
> 266 (linkwatch_work).work
> 266 (addr_chk_work).work
> 266 &ldata->atomic_read_lock
> 265 (work_completion)(&buf->work)
> 265 rtnl_mutex
> 263 &tty->atomic_write_lock
> 262 &buf->lock
> 261 &tty->termios_rwsem
> 242 &port->buf.lock/1
> 242 kn->active#40
> 241 &o_tty->termios_rwsem/1
> 240 registration_lock
> 239 &ldata->output_lock
> # awk ' { if ($2 == "OPS:") print $7" "$9 } ' /proc/lockdep | sort -rV | head -n 30
> 642 pool_lock
> 641 &obj_hash[i].lock
> 582 tk_core.seq.seqcount
> 561 hrtimer_bases.lock
> 560 &rt_rq->rt_runtime_lock
> 559 &rt_b->rt_runtime_lock
> 559 &cp->lock
> 559 &cfs_rq->removed.lock
> 559 &cfs_b->lock
> 558 &rq->lock
> 550 &tsk->delays->lock
> 549 &p->pi_lock
> 506 &base->lock
> 504 &n->list_lock
> 432 &____s->seqcount
> 404 &x->wait#10
> 401 &pool->lock
> 369 &zone->lock
> 330 rcu_node_0
> 326 &(kretprobe_table_locks[i].lock)
> 326 pgd_lock
> 324 &pgdat->lru_lock
> 323 lock#5
> 321 &page_wait_table[i]
> 319 ptlock_ptr(page)#2/1
> 318 ptlock_ptr(page)#2
> 316 &sem->wait_lock
> 316 &mm->page_table_lock
> 316 ptlock_ptr(page)
> 315 &anon_vma->rwsem

The latest syzbot logs now contain these dumps as well, if anybody is
interested in more:
https://syzkaller.appspot.com/bug?id=63fc8d0501c39609dd2f268e4190ec9a72619563
https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
