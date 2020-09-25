Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3672786D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgIYMQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgIYMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:16:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:16:52 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so1620096qtw.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj8q/FmKHez+RTbwD6ILhswoO9AT2WUVK36Z22rgM2w=;
        b=csEiWKAcvCoyvrzIOwPH8wOw8v/sryK3+tQ5j9HAgezvyCgtQIbEmcqMoOqKuv78Xc
         sD6rYIEaGXMaZV38e6l8WjPm9gxacuO7Dz0L3rNxqwYm+ZY+vZFL7TX59ydTFAmiGXs2
         Gtis6n7xAkIGIybeHbFKI5Brs53tcueWNm4UQLMCcgtE/I/49TIOY5hkGk1XWe0yencj
         5OlrYUiqMfCqb+0ySGTYL3A7hrW973YtuEEtov09xEIZbDCuSj3+L3iEC/1sBQdri1iV
         ijSGue/Wk0M9bEVJQsw3/2iG58Rpq+YMwn/iLwdUgnnY2bwg1MCUaUR672edZM4I6QZb
         JRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj8q/FmKHez+RTbwD6ILhswoO9AT2WUVK36Z22rgM2w=;
        b=VAPAzQydkLmJNSfTPr3MMvoeY1cQccEvu62yykq8vh6B+8pCGkeXnM+nthqAzx/iVh
         mjBy2/A7QoH2000Wt/K9qhvjEvYOAtovyUhEBm5ikiVaX7LyGjqizE0R2ksIkZvr+5am
         gpzLESyWrxZoqAg36O+tcLxWt0O4J5r9sa+88RFpJpYaRGGXYO9rWy9GHWWOyjfkzBO5
         2ZQcqosQ/aV0dbgy6F/x131ZBXTU5mzqPty9L3flVftRyPzJIT2DU7ezszCCFRi/frHb
         jpMO08Uu4lvpVU+VJ5T71NmfvATVKl7NX++ArRMdfY/WLZkGMN9EwhF2Pvp9mI3q/BM7
         5ESw==
X-Gm-Message-State: AOAM531Cvgm3M+LouDSXDIC5xIKMY6f5TwGKnD0/F7/8aHsp13sARYlZ
        KFbck8OniJa54FeD1Cv1pAEGXuJYIFcYCoz6ToHTig==
X-Google-Smtp-Source: ABdhPJwykq10gwhARiFWS7CFyOwUxgC37iVBpIDYTCSIJ4kymr6LAGCorB5zH7RCTWDAjzCWQEFgqGRpZz8HUkMfIZw=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr4027042qto.158.1601036211095;
 Fri, 25 Sep 2020 05:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000643b2605afd064d7@google.com> <CACT4Y+aVj9QkKdPHFVAJNvHu+RKX5SxYTV1p=TTND+upJ818aw@mail.gmail.com>
In-Reply-To: <CACT4Y+aVj9QkKdPHFVAJNvHu+RKX5SxYTV1p=TTND+upJ818aw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Sep 2020 14:16:40 +0200
Message-ID: <CACT4Y+bTZVpLDQJtZmyzCDL_deyXixmvcf=6rO6Xm-h4b5zC_w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in map_vdso
To:     syzbot <syzbot+9d25c706da4558b9f11a@syzkaller.appspotmail.com>
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

On Mon, Sep 21, 2020 at 12:35 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Sep 21, 2020 at 12:34 PM syzbot
> <syzbot+9d25c706da4558b9f11a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=162d70d3900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9d25c706da4558b9f11a
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9d25c706da4558b9f11a@syzkaller.appspotmail.com
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0002) - not-present page
> > PGD 0 P4D 0
> > Oops: 0002 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 5029 Comm: systemd-rfkill Not tainted 5.9.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:map_vdso+0x1ea/0x270 arch/x86/entry/vdso/vma.c:308
> > Code: 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 00 00 00 00 20 05 00 00 49 03 <6d> 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 ef e8 ae 64
> > RSP: 0018:ffffc90016bafb98 EFLAGS: 00010282
> > RAX: 00000000ab3c6738 RBX: ffff888056ebc538 RCX: ffff888093622440
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffff888056ebc480 R08: ffffffff81912471 R09: fffffbfff131e57c
> > R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007fffda9dc000
> > R13: ffff888093622868 R14: 1ffff110126c450d R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000008fac6000 CR4: 00000000001526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  load_elf_binary+0x2e90/0x48a0 fs/binfmt_elf.c:1221
> >  search_binary_handler fs/exec.c:1819 [inline]
> >  exec_binprm fs/exec.c:1860 [inline]
> >  bprm_execve+0x919/0x1500 fs/exec.c:1931
> >  do_execveat_common+0x487/0x5f0 fs/exec.c:2026
> >  do_execve fs/exec.c:2094 [inline]
> >  __do_sys_execve fs/exec.c:2170 [inline]
> >  __se_sys_execve fs/exec.c:2165 [inline]
> >  __x64_sys_execve+0x8e/0xa0 fs/exec.c:2165
> >  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x7f8127340647
> > Code: Bad RIP value.
> > RSP: 002b:00007ffc7b57dbf8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> > RAX: ffffffffffffffda RBX: 000055a0c9286d40 RCX: 00007f8127340647
> > RDX: 000055a0c9307440 RSI: 000055a0c91cd210 RDI: 000055a0c924e9a0
> > RBP: 00007ffc7b57dd60 R08: 000000000000fe00 R09: 0000000000000030
> > R10: 000055a0c9239740 R11: 0000000000000246 R12: 000055a0c91e1228
> > R13: 0000000000000000 R14: 000055a0c91cd210 R15: 00007ffc7b57de40
> > Modules linked in:
> > CR2: 0000000000000000
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> Another clang-only crash that may be related to these ones:
>
> https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> https://syzkaller.appspot.com/bug?extid=1dccfcb049726389379c

There is strong indication that this is a manifestation of the same
problem we see in other crashes.
Let's make one canonical bug for this:

#syz dup: general protection fault in perf_misc_flags
