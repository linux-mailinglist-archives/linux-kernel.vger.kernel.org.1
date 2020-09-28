Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB227A6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1FY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1FY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:24:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD2C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:24:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 16so8981758qkf.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFW6bpWzzIDGMh7PAvsAkdqysEqSmYeLkv4Dt9tJcO0=;
        b=tBBRIcmJaIHeu70frWxCk0gF6qmn8/1IBrMd9T84h3rV7BxELZ5+Fk+2mdk0oohGHp
         VCPa5G7Oo3u7caD1MeNCOfcw8D/PQuzRiFsKHuHX1VrVf7dI5s+a6Un4jD5DGjPNwXWz
         9i1f48G0YOJcLPTg353azRtqQ5MlIPwl62eDQjIKs9M6iKWQgX2GHKe0ZBXqgRgebi45
         5C/lwF5IMBj6GjV16rR13UUXsf1bKabl9Fsyr3pryK2n2tQiKdNQWGQ6u3UdFkGQp3Ns
         TNR/69FeFo0RBCILj/H0OQgpgutnhXVkwxjUfN5ASZQgKjB4avRJiaVL/KcHn+7GdsHt
         HCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFW6bpWzzIDGMh7PAvsAkdqysEqSmYeLkv4Dt9tJcO0=;
        b=VT+onDdj/cKq1Tz/ASF1uS+QWr4fyuDjXx43ikd4fGfDSUbSPGgBXG+dgi1fJIxVdY
         orVYqb1+Cr46T+rFErj5IFOnKWzmOJ4B0f4CuSsvczdt5RUNRmwkfRt5Dzv1OEQtiZnr
         /Af9knFcIk0D2MucKiVcu21WwyWur4ev4UvdAM7HBEboVtcidxDLoY530vsnAYfpQ1Mr
         vUhz2GC2Jw1jAv/F06ua9qYWsYoMriTyh95XNRA+9PyNW/kqmM9eMyOLAGmAac/5Ishg
         8Yi1y+BfmcQ08zSWcWJQHEtwRGxGxRPDkw40YCjIaJP45WMB4S/LPLOe8IdxXTEgogTV
         Y7CA==
X-Gm-Message-State: AOAM531Ps++8yzbFjNsaP1onccMj0/Ot4qWHurIVcjAG0CwqsjcgQU0t
        cBmYHLrJGr/IWX+jT7H4vgYcrQo1cqdKgi/ftQz5Hw==
X-Google-Smtp-Source: ABdhPJy5uq7dVkHfKy1oO95QjTieF3L405pq1+tj3+gkWAy3giYcGjCfaccTgSKLAFmcUYVqeOY5jqQxDhG0uFyAWlk=
X-Received: by 2002:a37:a785:: with SMTP id q127mr10193348qke.256.1601270666383;
 Sun, 27 Sep 2020 22:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a0f4f05ad5d1743@google.com>
In-Reply-To: <0000000000008a0f4f05ad5d1743@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 07:24:15 +0200
Message-ID: <CACT4Y+Z9qJQkBqg5x9vjXpivanNWuaYUgcVp22qB9RMXJeg74g@mail.gmail.com>
Subject: Re: general protection fault in map_vdso_randomized
To:     syzbot <syzbot+6719f65e8a293105edcc@syzkaller.appspotmail.com>
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

On Fri, Aug 21, 2020 at 8:10 AM syzbot
<syzbot+6719f65e8a293105edcc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4b6c093e Merge tag 'block-5.9-2020-08-14' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179f99f6900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a98b778f5fca0653
> dashboard link: https://syzkaller.appspot.com/bug?extid=6719f65e8a293105edcc
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6719f65e8a293105edcc@syzkaller.appspotmail.com

#syz dup: general protection fault in perf_misc_flags

> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 27621 Comm: modprobe Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:map_vdso_randomized+0x64/0x160 arch/x86/entry/vdso/vma.c:364
> Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc9000ab57c10 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88804e0963c0 RCX: 1ffffffff1080a60
> RDX: 0000000000006000 RSI: 0000000000000001 RDI: ffff88804e0967e8
> RBP: ffff88801459b000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000160 R12: ffffffff884052e0
> R13: ffff8880a69cf950 R14: 00007faba47c2c20 R15: ffff8880a5cb4400
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007faba49e6fc0 CR3: 0000000031b89000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  load_elf_binary+0x22d4/0x47c0 fs/binfmt_elf.c:1221
>  search_binary_handler fs/exec.c:1819 [inline]
>  exec_binprm fs/exec.c:1860 [inline]
>  bprm_execve+0x936/0x1b10 fs/exec.c:1931
>  kernel_execve+0x370/0x460 fs/exec.c:2080
>  call_usermodehelper_exec_async+0x27a/0x500 kernel/umh.c:101
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace f344c46c1e164ddf ]---
> RIP: 0010:map_vdso_randomized+0x64/0x160 arch/x86/entry/vdso/vma.c:364
> Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc9000ab57c10 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88804e0963c0 RCX: 1ffffffff1080a60
> RDX: 0000000000006000 RSI: 0000000000000001 RDI: ffff88804e0967e8
> RBP: ffff88801459b000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000160 R12: ffffffff884052e0
> R13: ffff8880a69cf950 R14: 00007faba47c2c20 R15: ffff8880a5cb4400
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc99314e38 CR3: 0000000031b89000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008a0f4f05ad5d1743%40google.com.
