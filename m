Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6D26939D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgINRhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgINM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:27:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1EC035430
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:23:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so13202593qtj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ss/SJTzMTJ6NYsdm+9+ea3ztoCizcQb7pDEcNQl4ncE=;
        b=uBVbEj6Cdt5Xpcoc/QjsSCWjRuOYPppGUAMQswNE6iEFdkkPE7hYc7MVjS0Jt6LzKQ
         B4jEtW8FBqlKL5wlwDGAj0hO7YwPyaxny0w52rRjrC157LQncmTgyYMLZQ8L1h1Ndc0e
         LAAo3MLRN2X1sxX84qh1DMTZLlRqY0+F0peD43rp+jW6hOXX4HuUB/uqZZxoBOwjgFQ3
         5fymYQbfDFpyOVqsn8Bc7EhFVZlQtDotvB00B9Ao5X4qYV6Qsehr4PWxwpVNo6No2RtC
         /31kJ118bZF91QlPr+WDPOM61Oaa4RLlZ8kvIGMxyQTYYXEd3KAk3yi2esRX5WXiqlIo
         1I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ss/SJTzMTJ6NYsdm+9+ea3ztoCizcQb7pDEcNQl4ncE=;
        b=hOJZ1Rsg82JA8iNTQQhvB4OsjsEAGbu+8Boh5POZRDAoGAu6DSONkvfiISeF1rjQLT
         4lUKUXqe04mI34FYZjqxNEWIysuRxg2E3Oveak/62F2ebH7S23PAF2MJzx0jG2nGXC/W
         GUdS/7TLESeJA0q/csxNu7OoPGtmueHUHNMiTgK9elGTWYJhrSjLZrnfySyYgjzUxrMf
         uJyIp50av66pmsGttZyhZ5pWjrN7n+I2LbWpLIS5eI6RliB9tlPXHmG9uBahml7q0MUZ
         mxKBGv0EpJ7BPnYZm++MC86/uixphJeUWobPy5TUqXPtK6XPGzDJNodGWotwCoTKKs4F
         7MLA==
X-Gm-Message-State: AOAM533uN9z0JC1vG2H0v5DzPvmU+EYuwPPeH01ercuc22y1JKc2jmxb
        Dccbb0/NmtS71B3g5oZoILZx/gZ5zpNbXHCPq8bMZg==
X-Google-Smtp-Source: ABdhPJxyjqA5/R/K1Ry2BRSKLbc2E5dnKKVFUC6+i55LxxvnYq/h93UjdlUviTAEWQYcvD5A4YkOQyPSGwYZekqeE2U=
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr474696qti.50.1600086193654;
 Mon, 14 Sep 2020 05:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000005f0b605af42ab4e@google.com> <87zh5stv04.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zh5stv04.fsf@x220.int.ebiederm.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Sep 2020 14:23:01 +0200
Message-ID: <CACT4Y+ZcrHFS45-NFxZKWdoesCdLwk-_1YvMJr01FRL1sG-ZeQ@mail.gmail.com>
Subject: Re: KASAN: unknown-crash Read in do_exit
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 2:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> syzbot <syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
>
> Skimming the code it appears this is a feature not a bug.
>
> The stack_not_used code deliberately reads the unused/unitiailized
> portion of the stack, to see if that part of the stack was used.
>
> Perhaps someone wants to make this play nice with KASAN?
>
> KASAN should be able to provide better information than reading the
> stack to see if it is still zeroed out.
>
> Eric

Hi Eric,

Thanks for looking into this.

There may be something else in play here. Unused parts of the stack
are supposed to have zero shadow. The stack instrumentation code
assumes that. If there is some garbage left in the shadow (like these
"70 07 00 00 77" in this case), then it will lead to very obscure
false positives later (e.g. some out-of-bounds on stack which can't be
explained easily).
If some code does something like "jongjmp", then we should clear the
stack at the point of longjmp. I think we did something similar for
something called jprobles, but jprobes were removed at some point.

Oh, wait, the reproducer uses /dev/fb. And as far as I understand
/dev/fd smashes kernel memory left and right. So most likely it's some
wild out of bounds write in /dev/fb.

> > HEAD commit:    729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=170a7cf1900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae84069cff753e94bf
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10642545900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141f2bed900000
> >
> > Bisection is inconclusive: the issue happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b9ffcd900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1479ffcd900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1079ffcd900000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: unknown-crash in stack_not_used include/linux/sched/task_stack.h:101 [inline]
> > BUG: KASAN: unknown-crash in check_stack_usage kernel/exit.c:692 [inline]
> > BUG: KASAN: unknown-crash in do_exit+0x24a6/0x29f0 kernel/exit.c:849
> > Read of size 8 at addr ffffc9000cf30130 by task syz-executor624/10359
> >
> > CPU: 1 PID: 10359 Comm: syz-executor624 Not tainted 5.9.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
> >  __kasan_report mm/kasan/report.c:513 [inline]
> >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> >  stack_not_used include/linux/sched/task_stack.h:101 [inline]
> >  check_stack_usage kernel/exit.c:692 [inline]
> >  do_exit+0x24a6/0x29f0 kernel/exit.c:849
> >  do_group_exit+0x125/0x310 kernel/exit.c:903
> >  get_signal+0x428/0x1f00 kernel/signal.c:2757
> >  arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
> >  exit_to_user_mode_loop kernel/entry/common.c:159 [inline]
> >  exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:190
> >  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x446b99
> > Code: Bad RIP value.
> > RSP: 002b:00007f70f5ed9d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> > RAX: 0000000000002878 RBX: 00000000006dbc58 RCX: 0000000000446b99
> > RDX: 9999999999999999 RSI: 0000000000000000 RDI: 0000020002004ffc
> > RBP: 00000000006dbc50 R08: ffffffffffffffff R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc5c
> > R13: 00007f70f5ed9d20 R14: 00007f70f5ed9d20 R15: 000000000000002d
> >
> >
> > Memory state around the buggy address:
> >  ffffc9000cf30000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffc9000cf30080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>ffffc9000cf30100: 00 00 00 00 00 00 70 07 00 00 77 00 00 00 00 00
> >                                      ^
> >  ffffc9000cf30180: 00 00 70 07 00 00 70 07 00 00 00 00 77 00 70 07
> >  ffffc9000cf30200: 00 70 07 00 77 00 00 00 00 00 70 07 00 00 00 00
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
