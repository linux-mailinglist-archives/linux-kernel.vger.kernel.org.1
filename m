Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CD27543F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIWJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIWJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:19:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E379C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:19:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so22077548qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwLKEMZq2g3KXgWN/NS+95Zv72nRgO61juiwlvI19SE=;
        b=I5h4NcId0sThPhlUXKa0DycECD5K5xoqB21Gr+EQ7C0KFTff/DjCk1WYbjDtKHd77G
         hoUvMy5FlW//OGSrsMLK2y51/3RTUr8FuN1Jzg/YjjVef5ntnvu9zp2Cpo0+ZebRU07f
         9VDMz49ksF5kPgmDeBhx5HX7fs4SZXQdkHrVvrd3Rkxmg7ih7mgC9VMu7W8oGg13sMNa
         blhpGRO3TQIYXnwiAbpkTGfTslyZaVUpdhoIzaCJGbLGsgqTqUkyIcG3V6ExEftixIUL
         j2EesSbIh3tIGIxZ9Oq4kpJNCwlbKzVvvz+qT5sz4J38NdZq10itugDxJWPUWefwouOV
         mGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwLKEMZq2g3KXgWN/NS+95Zv72nRgO61juiwlvI19SE=;
        b=arr4CXEL8E+JHOlU2Q65sJggEESeC9Jp75YypZWwQLz0nYPEQ7/D8uc1ry1vfJ3piJ
         uhWSQk9odI6asMUKGathzSI6FKTrD8nGwEyUSWMRYi5inFNcLw8KrX+R4wRLDbRvcyJ6
         Ekqz6q02WbCu8drgMAlTt/rt+kxUZgXhJ6VHAth/PbrqoEJ2EIrDshletK3XRGMFMRTE
         xJLxwWfPY3CN6yXr6AmkEnj6XxxDRJr7ZTXFgFs98bicl3KEIfESxuKbl6E7zxx+9yOg
         HgnOx8Fqe3o7wS+g7VYh9bTyOpuHS5T0G5edwUx3Pspwi432hO68+pCGfBzr9XF1sVXT
         aNzA==
X-Gm-Message-State: AOAM530NKjSYHrwTcBGTemkvocU7VjM5RX90xZ/Ov9g7VQdiL4C6DEws
        ffYdt4+q7h6TFE893XTsHp2s2BYxAsY6juYP5+cg/w==
X-Google-Smtp-Source: ABdhPJyvNSvl2ZnKDo7Y3idic2oph8XV3FAEqb7ulnF0IqxO8tnU/9hHxIbhuHjUov9a+tVfQXdC3M7XXj5GkFS5N5I=
X-Received: by 2002:a37:9b82:: with SMTP id d124mr9180680qke.8.1600852791197;
 Wed, 23 Sep 2020 02:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000096760d05aff79022@google.com>
In-Reply-To: <00000000000096760d05aff79022@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Sep 2020 11:19:40 +0200
Message-ID: <CACT4Y+YGFtPCi3a-ByZGs1kCFfJOYv_AbkxOG=K_D4xh0r4okA@mail.gmail.com>
Subject: Re: invalid opcode in map_vdso
To:     syzbot <syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:18 AM syzbot
<syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1553eff1900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> dashboard link: https://syzkaller.appspot.com/bug?extid=9cf5373b0e15476f39a2
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com
>
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 16405 Comm: modprobe Not tainted 5.9.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:map_vdso+0x1e3/0x270 arch/x86/entry/vdso/vma.c:308
> Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
> RSP: 0018:ffffc90006167b98 EFLAGS: 00010246
> RAX: ffff8880a7db8420 RBX: ffff88809d5fd7f8 RCX: ffff8880a811a040
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88809d5fd740 R08: ffffffff81912471 R09: fffffbfff131e57c
> R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007ffea1107000
> R13: ffff8880a811a468 R14: 1ffff1101502348d R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f33d09f8fc0 CR3: 0000000097210000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  load_elf_binary+0x2e90/0x48a0 fs/binfmt_elf.c:1221
>  search_binary_handler fs/exec.c:1819 [inline]
>  exec_binprm fs/exec.c:1860 [inline]
>  bprm_execve+0x919/0x1500 fs/exec.c:1931
>  kernel_execve+0x871/0x970 fs/exec.c:2080
>  call_usermodehelper_exec_async+0x204/0x330 kernel/umh.c:101
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace 8d12c4aa58699b40 ]---
> RIP: 0010:map_vdso+0x1e3/0x270 arch/x86/entry/vdso/vma.c:308
> Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
> RSP: 0018:ffffc90006167b98 EFLAGS: 00010246
> RAX: ffff8880a7db8420 RBX: ffff88809d5fd7f8 RCX: ffff8880a811a040
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88809d5fd740 R08: ffffffff81912471 R09: fffffbfff131e57c
> R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007ffea1107000
> R13: ffff8880a811a468 R14: 1ffff1101502348d R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f33d09f8fc0 CR3: 0000000097210000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

+clang-built-linux
Looks like another one with kernel code overwrite in clang build.
