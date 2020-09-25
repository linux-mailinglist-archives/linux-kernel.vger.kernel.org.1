Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8E2786DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgIYMSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:18:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:18:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so1597418qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8a19FXNzKqvEixFU+m36wpRItWj8u2wTqxM18S6EfU=;
        b=GNXVQSKCMdhEiIik2g47PsE2Arm1Bi1qGNG9111OntixR5px3G8kLofOMkKOoH40Bq
         RNM0vuHmF5TXAcVuZfVOJ/wH698xDq1XZZGGnvgFoRnAvmdUiNTT6m2HAVJaDfdP1A4D
         FWK/sQ8E75nsyKhdJqn2PBla2BjfdUPkhVMbBPyFzZ/i0bL8NkecSwOFjqp80BhcDm7H
         h6jO7UjzaM27hcuPDvERJUzDiu0BnNMgiTTI+qt3gpPRw1J1Q9qNG+GaB6hrZDiNV50C
         ZWOYdJCoGlE/EsH75P6YM+VGNvWQNRMLHjYaVFJjjAMN+L64h0HTf8ci4pC6Kni4jcyz
         PgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8a19FXNzKqvEixFU+m36wpRItWj8u2wTqxM18S6EfU=;
        b=TjGuxD83jy0JP5WJb/Hk/0Ab+KtDfl8DBz9Z8TAXG76KZt07jtcZhpAMAd5zM+9Sjp
         CheK79Q45kYxSQsf85+ER0M1jboKVMyzugwkml+840DZO7M6DEB3STXyC9mFTl9sKoea
         3CAp5GiT1sheH7bkVwcdF3XJ7atkqb1DA4av03243UA/ZuYBpRHecHS/iiQNcZ2gdrRI
         i8BmsVI1ao4v6GMzhFmwmOIJlkzZZGWaPb8t+z4Cfb6obgv/4y3uJWP+vEaSt6JcjlXs
         RJmdiKvSgEKtoRHKZwPWZHooDlgUr+05cZYjCGtfiYLCH8zsYnKhf0W/Bq/WbEJ0odAb
         tpnQ==
X-Gm-Message-State: AOAM530b/OUyb9CpYgY5gU3aejKo0dpGxiSYu45fMYphQfSeJ3vqR9xu
        emhTYHVaXkIzdGYzP/nryTRV2SrTavP1Zyi9RC5myA==
X-Google-Smtp-Source: ABdhPJzbVvaB0/z/SpqDeVNOCfZlsAY83PD3xZAyYZRcRcYmHG/6RQFv7opJAqFhixo5622udb4r1SLg+5P5n1XmOOA=
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr4148622qti.50.1601036281241;
 Fri, 25 Sep 2020 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002d3bc705b00c04fa@google.com>
In-Reply-To: <0000000000002d3bc705b00c04fa@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Sep 2020 14:17:50 +0200
Message-ID: <CACT4Y+aRiHs1sK2GaaQqKzKEHvEXzL_g+wFtyt70F5ttrM7NKg@mail.gmail.com>
Subject: Re: KASAN: user-memory-access Read in vdso_fault
To:     syzbot <syzbot+fe2a9f19481e3bfed524@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:42 AM syzbot
<syzbot+fe2a9f19481e3bfed524@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1077ecc3900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a9f19481e3bfed524
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fe2a9f19481e3bfed524@syzkaller.appspotmail.com

There is strong indication that this is a manifestation of the same
problem we see in other crashes.
Let's make one canonical bug for this:

#syz dup: general protection fault in perf_misc_flags

> ==================================================================
> BUG: KASAN: user-memory-access in vdso_fault+0xc1/0x1b0 arch/x86/entry/vdso/vma.c:67
> Read of size 8 at addr 000000001953fc48 by task systemd-udevd/9883
>
> CPU: 0 PID: 9883 Comm: systemd-udevd Not tainted 5.9.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>  __kasan_report mm/kasan/report.c:517 [inline]
>  kasan_report+0x151/0x1d0 mm/kasan/report.c:530
>  vdso_fault+0xc1/0x1b0 arch/x86/entry/vdso/vma.c:67
>  __do_fault+0x138/0x3b0 mm/memory.c:3450
>  do_read_fault+0x5a6/0x9e0 mm/memory.c:3843
>  do_fault mm/memory.c:3971 [inline]
>  handle_pte_fault mm/memory.c:4211 [inline]
>  __handle_mm_fault mm/memory.c:4346 [inline]
>  handle_mm_fault+0x1d73/0x29a0 mm/memory.c:4444
>  do_user_addr_fault+0x515/0xa90 arch/x86/mm/fault.c:1372
>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
>  exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
> RIP: 0033:0x7ffedaddb630
> Code: Bad RIP value.
> RSP: 002b:00007ffedad997b8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000015
> RDX: 0000000058585858 RSI: 0000000000000000 RDI: 00007ffedad997e0
> RBP: 0000000000000000 R08: 000000000000fefe R09: 0000000000000030
> R10: 0000000000000000 R11: 0000000000000206 R12: 000055e855d83675
> R13: 00007ffedad99938 R14: 0000000000080000 R15: 000055e855d83660
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002d3bc705b00c04fa%40google.com.
