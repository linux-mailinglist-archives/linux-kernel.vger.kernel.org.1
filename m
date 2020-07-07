Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3062217304
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGGPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:52:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95956C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:52:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so38615638qkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQclJ5Fj8Dlt20iD8aSoxbZRPYBYvZEt9bdhOxRNViU=;
        b=CaOe3szofMixqAhDk3f8DK9Y/2NqhT1Q8bv1KE9INCyEPdaGSJXoKrhdikAJBe+Jql
         tJscwsk6rwXQdyEMpPeVvuhNORPymIf9qGs5v6VhWddZYMDKstQbzX8P6kxnknarrtSu
         s+UrgZ2zWmfOyRG8QHl5h1AKf4/evo3dXbQiHrC+Gse7HhE0xqGj8SkG8cIGrZjgnFPq
         j9YHmHo10lcSKpx2obJCJtzKjogNP5eVr8vdbqqcLPjsx6qh0QFHwzy0W6+aDZ6pvF4Y
         qzQ2BxK7yIUg9/Zxg1X6XckVzVROG7CltQHah2PjWZBurWjfsOM267kItUGLGx/ymE4h
         uuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQclJ5Fj8Dlt20iD8aSoxbZRPYBYvZEt9bdhOxRNViU=;
        b=B7PbXpYP95oyHetrJqEAtULcdjJc2/uJamficb9cwBd26+XpHwdyw+4qDOUpvQgstR
         cdnysyESGqVQ8Mm+HuLcMPEjs4MQDTEas60MvbiPsGjep5blpA0on+dkAjPq3ksExadH
         ppHH+HtdxgV6ak7wCqTOCcZavU/1siCNfKbu4SrzoiauY74+8YdVd4ntrrGaBwYUY/U0
         6QyRP4QJPoiE8erw/uF8iv7CY3Rneb/VqvVbsaaWj+NRo9GXety0Tdxs0SH78aKy0lX5
         a45x4ZEopL8fICcgnQut8ELfhHIj0OaZqsmBBSmenWMBrXXKvm/0ky3NEFr/QTgjeqkE
         gATw==
X-Gm-Message-State: AOAM5315VBWVDfTshEJP7MwNIDoKf7e4Bj5zKATLtkCiG6biNlNudP5y
        3aVULlh9kjIINzTwW56SX1u+WpUC0NBAPvu8iyYgDw==
X-Google-Smtp-Source: ABdhPJxvAxPZdxmQ3itWj9twAgApKJBmCfnydSTkSYoJ/yKf+tzu///PxmIdhIMxLvMpiBuKq53QG7NyXwQBT/4twys=
X-Received: by 2002:a37:4851:: with SMTP id v78mr49971994qka.256.1594137120385;
 Tue, 07 Jul 2020 08:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000042f21905a991ecea@google.com> <20200704164522.GO9247@paulmck-ThinkPad-P72>
 <CACT4Y+Zs4TO9-XSZ7cRXFZVqRakS8WuSno2=dac6Gv2XmExbkA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zs4TO9-XSZ7cRXFZVqRakS8WuSno2=dac6Gv2XmExbkA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jul 2020 17:51:48 +0200
Message-ID: <CACT4Y+aMJRwQANQZ5Fr1RPZ6EOZ2zEPaZwMTndKJ+mTJ8o6b7Q@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 8:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Jul 4, 2020 at 6:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jul 03, 2020 at 04:31:22PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com
> >
> > Good catch!  A call to csd_lock_record() was on the wrong side of a
> > call to csd_unlock().
>
> Thanks for taking a look.
>
> > But is folded into another commit for bisectability reasons, so
> > "Reported-by" would not make sense.  I have instead added this to the
> > commit log:
> >
> > [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> > Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> > Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
>
> This should work, as far as I remember sybot looks for the email+hash
> anywhere in the commit.
> FWIW Tested-by can make sense as well.


Paul, there is also some spike of stalls in smp_call_function,
if you look at the top ones at:
https://syzkaller.appspot.com/upstream#open

Can these be caused by the same root cause?
I am not sure what trees the bug was/is present... This seems to only
happen on linux-next and nowhere else. But these stalls equally happen
on mainline...



> >                                                         Thanx, Paul
> >
> > > ==================================================================
> > > BUG: KASAN: stack-out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> > > Read of size 8 at addr ffffc90001727710 by task syz-executor.0/10721
> > >
> > > CPU: 1 PID: 10721 Comm: syz-executor.0 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> > >  print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
> > >  __kasan_report mm/kasan/report.c:513 [inline]
> > >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> > >  csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> > >  flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
> > >  __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
> > >  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
> > >  </IRQ>
> > >  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
> > >  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
> > >  sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
> > >  asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
> > > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
> > > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > > RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
> > > Code: 48 c7 c0 00 ff b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 9b 74 c8 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 fb 62 f9 65 8b 05 fe 73 15 78
> > > RSP: 0018:ffffc900016e7558 EFLAGS: 00000282
> > > RAX: 1ffffffff1369fe0 RBX: 0000000000000282 RCX: 0000000000000000
> > > RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
> > > RBP: ffffffff8cb02508 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000001 R11: 0000000000000000 R12: 1ffffffff19604a0
> > > R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
> > >  __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
> > >  debug_check_no_obj_freed+0x20c/0x41c lib/debugobjects.c:998
> > >  free_pages_prepare mm/page_alloc.c:1219 [inline]
> > >  __free_pages_ok+0x20b/0xc90 mm/page_alloc.c:1471
> > >  release_pages+0x5ec/0x17a0 mm/swap.c:880
> > >  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
> > >  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
> > >  tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
> > >  zap_pte_range mm/memory.c:1155 [inline]
> > >  zap_pmd_range mm/memory.c:1193 [inline]
> > >  zap_pud_range mm/memory.c:1222 [inline]
> > >  zap_p4d_range mm/memory.c:1243 [inline]
> > >  unmap_page_range+0x1e22/0x2b20 mm/memory.c:1264
> > >  unmap_single_vma+0x198/0x300 mm/memory.c:1309
> > >  unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
> > >  exit_mmap+0x2b1/0x530 mm/mmap.c:3165
> > >  __mmput+0x122/0x470 kernel/fork.c:1075
> > >  mmput+0x53/0x60 kernel/fork.c:1096
> > >  exit_mm kernel/exit.c:483 [inline]
> > >  do_exit+0xa8f/0x2a40 kernel/exit.c:793
> > >  do_group_exit+0x125/0x310 kernel/exit.c:904
> > >  get_signal+0x40b/0x1ee0 kernel/signal.c:2743
> > >  do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
> > >  exit_to_usermode_loop arch/x86/entry/common.c:218 [inline]
> > >  __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:252
> > >  do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:376
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > RIP: 0033:0x45cb29
> > > Code: Bad RIP value.
> > > RSP: 002b:00007fb154b96cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > > RAX: 0000000000000001 RBX: 000000000078bf08 RCX: 000000000045cb29
> > > RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000078bf0c
> > > RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
> > > R13: 00007ffd3933f26f R14: 00007fb154b979c0 R15: 000000000078bf0c
> > >
> > >
> > > Memory state around the buggy address:
> > >  ffffc90001727600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  ffffc90001727680: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
> > > >ffffc90001727700: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> > >                          ^
> > >  ffffc90001727780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  ffffc90001727800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ==================================================================
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > syzbot can test patches for this bug, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200704164522.GO9247%40paulmck-ThinkPad-P72.
