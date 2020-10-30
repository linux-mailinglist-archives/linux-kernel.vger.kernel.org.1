Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1202A01E3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgJ3Jx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Jx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:53:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:53:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i21so3542128qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=108EzPxn7j0K7nYYfC+roPMchwb0k82vUvNfcXPzB90=;
        b=ib+h24B9b9KdUN10KNR756AdJuKUUNBQqX7bUs3iY8fdy3FGBR1InXFLMYVtDBqpji
         C4nSoKWogiJYYvT9it6wOpqmyLz2OMFAavojaAExNShK0TBjjJrgzBucddUC/TQ5haQn
         n1ozS0HloIiIPGB3OCy3hTh1VDsSAgsqZkdoE7RZeXciHJflc3ViQPmTMxiU2CT4Ybrm
         pzxIbHLD59oqqpFVa++LeztU10iRLow0STS52dciWMmHAuQjXBPMKCqtP+Y8DLwC/Z/I
         8U6UZT7I2iTlV9uzyd9y1lK/saCqhhfh4jgjgmBDTU45Ld+KHqi+hqHzPl9k9s8IxTfM
         4Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=108EzPxn7j0K7nYYfC+roPMchwb0k82vUvNfcXPzB90=;
        b=erxLJeTDyBO6kt/sZlrkkJFxpqZsz1amcbqWLS7z8RDoKp82xcesGKGvtvU+AoIdov
         7J2l7dO49gwmPnyBh4zVTeFmOtfeJwssA2ixbzlKIF5pU5n06Dpsq1Ec1EdpihSI1hZ7
         rOMTEhntu3xutbazjMSeRWHgavwP8I3G6EOHv7dZ5CCOIPMOqpBgKK+/QpCzt3MjkqwD
         +fE/IAU2T7V2jYcF1w66tpcnDedynvR7WCx18gRj700MG8/YjnPRLTZQbSF7x012f7/s
         v6iGUBZ9zmyir9jO7YuiHMy+RviTVKBQi75RDLLGYAyBQxdnTEjNVtew/mUryJc9YHX4
         JP7w==
X-Gm-Message-State: AOAM5304RLrzggxgBXo8nMzhB5ruqxXdv5Kh0SV16qRZCSjZ2PvcYU+u
        VDbue/nVx9LKz1JxwlosqFj1RD7ZRDhz35T3POiqMg==
X-Google-Smtp-Source: ABdhPJxU+2ifbnq5tke4J0BG+Kx/CQVb1U9gaCgRZtmWGPbvZRUWISaC0glyUL87CS3NdsbrhLp2qT29KS2VfAlBPfY=
X-Received: by 2002:a37:9747:: with SMTP id z68mr1203000qkd.424.1604051635590;
 Fri, 30 Oct 2020 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c62c0205aa73a505@google.com> <CALOAHbDsDTmi6EpfDeg2UcCX-btfw+dzQ2T6iZWvHUhffU0dFQ@mail.gmail.com>
 <20200715160426.225feefb@canb.auug.org.au>
In-Reply-To: <20200715160426.225feefb@canb.auug.org.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Oct 2020 10:53:44 +0100
Message-ID: <CACT4Y+a6Z-8Vp4Z_0cqbckiCedQSGD=hp7n4o-CJzp8LKdMSNQ@mail.gmail.com>
Subject: Re: kernel panic: System is deadlocked on memory
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        syzbot <syzbot+98be80110b9043885626@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 8:04 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 15 Jul 2020 13:54:04 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 12:49 PM syzbot
> > <syzbot+98be80110b9043885626@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    d31958b3 Add linux-next specific files for 20200710
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11a2fe13100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=98be80110b9043885626
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101ec967100000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a77000900000
> > >
> > > The issue was bisected to:
> > >
> > > commit e642d9be463d02c735cd99a9a904063324ee03d6
> > > Author: Yafang Shao <laoar.shao@gmail.com>
> > > Date:   Fri Jul 10 04:58:08 2020 +0000
> > >
> > >     mm, oom: make the calculation of oom badness more accurate
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1432bd77100000
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1632bd77100000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1232bd77100000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+98be80110b9043885626@syzkaller.appspotmail.com
> > > Fixes: e642d9be463d ("mm, oom: make the calculation of oom badness more accurate")
> > >
> > > Out of memory and no killable processes...
> > > Kernel panic - not syncing: System is deadlocked on memory
> > > CPU: 0 PID: 6810 Comm: syz-executor919 Not tainted 5.8.0-rc4-next-20200710-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> > >  panic+0x2e3/0x75c kernel/panic.c:231
> > >  out_of_memory mm/oom_kill.c:1106 [inline]
> > >  out_of_memory.cold+0xa6/0x182 mm/oom_kill.c:1041
> > >  pagefault_out_of_memory+0x109/0x11c mm/oom_kill.c:1135
> > >  mm_fault_error+0x123/0x380 arch/x86/mm/fault.c:930
> > >  do_user_addr_fault+0x5f8/0xbf0 arch/x86/mm/fault.c:1317
> > >  handle_page_fault arch/x86/mm/fault.c:1351 [inline]
> > >  exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
> > >  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
> > > RIP: 0033:0x40154d
> > > Code: Bad RIP value.
> > > RSP: 002b:00007ffddf4649b0 EFLAGS: 00010202
> > > RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffffffffffffd
> > > RDX: 0000000000000001 RSI: 00007ffddf4665e0 RDI: ffffffffffffffff
> > > RBP: 00007ffddf4665e0 R08: 0000000000000000 R09: 0000000000000001
> > > R10: 0000000000000064 R11: 0000000000000246 R12: ffffffffffffffff
> > > R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> > > Kernel Offset: disabled
> > > Rebooting in 86400 seconds..
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > syzbot can test patches for this issue, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> >
> > Thanks for the report.
> > This issue has been already fixed by
> > "mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3", which
> > is already in the -next tree.
>
> #syz fix: mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3

The final patch title is:

#syz fix: mm, oom: make the calculation of oom badness more accurate


> --
> Cheers,
> Stephen Rothwell
