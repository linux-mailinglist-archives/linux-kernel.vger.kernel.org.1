Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0295F273A16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgIVFPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgIVFPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:15:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:15:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so14622409qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GEkgC4MisQHmLtToGlXORaPrjFHWcS5S9kF092Mfg4=;
        b=fAM7c17YZWeWPlxJMOd3o8R70v/T7qURiARmnHgyftbdzCWEyFBoY5aV3Yu7hC1KED
         DNhsscAYZyZv0/1gJKvabcEvsysESc7GVjzp277rPWkkZcq/Dwx66HCsC4XJmZtvu0FD
         LkPdw/hpK0MGj2/7dhoTOsFv81rgkmkj22AAnEyV4Tkbb21BXmFAQrpURBdGoDs/601u
         nmT8VmXGejqVxsxLpsTSEwZXJfXcGDhihLpJvAwapiUGMJR8513fESUjpxn6I9Zgd87i
         mxMmXJoEes07DdCyenQITGOssz+pEnMacq4RHwwy83PLgp/dBQud9hFkAjeHDn4Nq/Ko
         d8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GEkgC4MisQHmLtToGlXORaPrjFHWcS5S9kF092Mfg4=;
        b=SuqSH75fxrChsZ8FofMRq6leC1t2W/ybCaOOrQeUjMxGBvmpLE654a5A2vEb5eRVFv
         aPCcPRpWUqo1P0+G7SH1dQtSIUvkK5TnzBNzKXjVNCaoDKlduL/0nepyUgNvQaSqKcE6
         m6/i8iEkTK5/7q0KBMqxVs7geTFcvK0q8+EFLiC4YJXapZd7Gvb3hvLql/TRkOt5UVyQ
         jPtNzpbW7InWQzMRibRrUs9fEzFta5ppGWwkHu5Zsyppleqx5j2Y8XwL/cZ0xbj1mjxI
         agqeis+MadvcYLCvt87a4qybjSXkJqwj/ADwL/LlJcqSOJUqP+yLQqiF/4LJNJGQCNGx
         W9sg==
X-Gm-Message-State: AOAM532zthyyNenjqDOqHmXmdrtRz1RIzsOwQ3XvUfYzkQnytSSRqqDJ
        84ltdi1p3cXErEMs/R9HGPJIpoDywO8qZLrcgIcRLA==
X-Google-Smtp-Source: ABdhPJxtaKZqlmxuk3uaK5MdEnpDZS/56D2rgVs5husmf2oH8V4TwoSV+5/CYfrpxWHs7j7gpaXB6QR8XqVuRRBjQ5I=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr3078597qto.158.1600751734348;
 Mon, 21 Sep 2020 22:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com> <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
In-Reply-To: <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Sep 2020 07:15:22 +0200
Message-ID: <CACT4Y+YqwHk97gF2YaE30rVBq2O9djuuh2ru7yuqOkttGz0Kbw@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:59 PM 'Nick Desaulniers' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, Sep 21, 2020 at 1:09 AM 'Dmitry Vyukov' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 7:54 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Sep 19, 2020 at 1:08 PM Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> > > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com
> > > > >
> > > > > general protection fault, probably for non-canonical address 0xffff518084501e28: 0000 [#1] PREEMPT SMP KASAN
> > > > > KASAN: maybe wild-memory-access in range [0xfffaac042280f140-0xfffaac042280f147]
> > > > > CPU: 0 PID: 17449 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > RIP: 0010:perf_misc_flags+0x125/0x150 arch/x86/events/core.c:2638
> > > > > Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
> > > >
> > > > Hmm, so converting this back to opcodes with decodecode gives:
> > > >
> > > > Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
> > > > All code
> > > > ========
> > > >    0:   e4 48                   in     $0x48,%al
> > > >    2:   83 e6 03                and    $0x3,%esi
> > > >    5:   41 0f 94 c4             sete   %r12b
> > > >    9:   31 ff                   xor    %edi,%edi
> > > >    b:   e8 95 fa 73 00          callq  0x73faa5
> > > >   10:   bb 02 00 00 00          mov    $0x2,%ebx
> > > >   15:   4c 29 e3                sub    %r12,%rbx
> > > >   18:   49 81 c6 90 00 00 00    add    $0x90,%r14
> > > >   1f:   4c 89 f0                mov    %r14,%rax
> > > >   22:   48 c1 e8 00             shr    $0x0,%rax
> > > >   26:   00 00                   add    %al,(%rax)
> > > >   28:   00 38                   add    %bh,(%rax)
> > > >   2a:*  00 74 08 4c             add    %dh,0x4c(%rax,%rcx,1)            <-- trapping instruction
> > > >   2e:   89 f7                   mov    %esi,%edi
> > > >   30:   e8 40 c0 b3 00          callq  0xb3c075
> > > >   35:   41 8b 06                mov    (%r14),%eax
> > > >   38:   83 e0 08                and    $0x8,%eax
> > > >   3b:   48 c1 e0 0b             shl    $0xb,%rax
> > > >   3f:   48                      rex.W
> > > >
> > > > and those ADDs before the rIP look real strange. Just as if something
> > > > wrote 4 bytes of 0s there. And building your config with clang-10 gives
> > > > around that area:
> > > >
> > > > ffffffff8101177c:       48 83 e6 03             and    $0x3,%rsi
> > > > ffffffff81011780:       41 0f 94 c4             sete   %r12b
> > > > ffffffff81011784:       31 ff                   xor    %edi,%edi
> > > > ffffffff81011786:       e8 05 c9 73 00          callq  ffffffff8174e090 <__sanitizer_cov_trace_const_cmp8>
> > > > ffffffff8101178b:       bb 02 00 00 00          mov    $0x2,%ebx
> > > > ffffffff81011790:       4c 29 e3                sub    %r12,%rbx
> > > > ffffffff81011793:       49 81 c6 90 00 00 00    add    $0x90,%r14
> > > > ffffffff8101179a:       4c 89 f0                mov    %r14,%rax
> > > > ffffffff8101179d:       48 c1 e8 03             shr    $0x3,%rax
> > > > ffffffff810117a1:       42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
> > > > ffffffff810117a6:       74 08                   je     ffffffff810117b0 <perf_misc_flags+0x130>
> > > > ffffffff810117a8:       4c 89 f7                mov    %r14,%rdi
> > > > ffffffff810117ab:       e8 20 75 b3 00          callq  ffffffff81b48cd0 <__asan_report_load8_noabort>
> > > > ffffffff810117b0:       41 8b 06                mov    (%r14),%eax
> > > > ffffffff810117b3:       83 e0 08                and    $0x8,%eax
> > > > ffffffff810117b6:       48 c1 e0 0b             shl    $0xb,%rax
> > > >
> > > > and I can pretty much follow it instruction by instruction until I reach
> > > > that SHR. Your SHR is doing a shift by 0 bytes and that already looks
> > > > suspicious.
> > > >
> > > > After it, your output has a bunch of suspicious ADDs and mine has a CMP;
> > > > JE instead. And that looks really strange too.
> > > >
> > > > Could it be that something has scribbled in guest memory and corrupted
> > > > that area, leading to that strange discrepancy in the opcodes?
>
> Right, the two sequences above look almost the same, except those 4
> bytes of zeros (the disassembler gets confused about the rest, but
> it's the same byte sequence otherwise).  Are the two disassemblies a
> comparison of the code at runtime vs. compile-time?  If so, how did
> you disassemble the runtime code?  If runtime and compile time differ,
> I suspect some kind of runtime patching.  I wonder if we calculated
> the address of a static_key wrong (asm goto).  What function am I
> looking at the disassembly of?  perf_misc_flags() in
> arch/x86/events/core.c? With this config?
> https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62

Hi Nick,

Yes, it should be this config. Borislav looked at the crash in the
first email in the thread and that's the config provided there. If
syzbot provides a crash and a config, these always match.

And the exact compiler used to produce the build is this:
compiler:       clang version 10.0.0
(https://github.com/llvm/llvm-project/
c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
https://storage.googleapis.com/syzkaller/clang_install_c2443155.tar.gz


> (though I
> don't see _any_ asm goto in the IR for this file built with this
> config).  If this is deterministically reproducible, I suppose we
> could set a watchpoint on the address being overwritten?
>
> (Un-interestingly, I do get a panic trying to boot that config in
> qemu, unless I bump the VMs RAM up.)
>
> > >
> > > Hi Boris,
> > >
> > > Memory corruption is definitely possible. There are hundreds of known
> > > bugs that can potentially lead to silent memory corruptions, and some
> > > observed to lead to silent memory corruptions.
> > >
> > > However, these tend to produce crash signatures with 1-2 crashes.
> > > While this has 6 and they look similar and all happened on the only
> > > instance that uses clang. So my bet would be on
> > > something-clang-related rather than a silent memory corruption.
> > > +clang-built-linux
> >
> >
> > general protection fault in pvclock_gtod_notify (2) looks somewhat similar:
> >  - only clang
> >  - gpf in systems code
> >  - happened few times
> >
> > https://syzkaller.appspot.com/bug?extid=1dccfcb049726389379c
> > https://groups.google.com/g/syzkaller-bugs/c/0eUUkjFKrBg/m/nGfTjIfCBAAJ
>
> Dmitry,
> Is there an easy way for me to get from
> https://syzkaller.appspot.com/upstream to <list of clang specific
> failures>?  ctrl+f, `clang`, returns nothing on that first link; it
> seems the compiler version is only included in the email?
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAKwvOdmKcn%3DFNzwtBZ8z0evLz4BXgWtsoz9%2BQTC6GLqtNp1bXg%40mail.gmail.com.
