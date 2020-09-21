Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39920271A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIUFzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUFzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:55:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D36C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:55:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so11346121qtw.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxSF9+zeCHDpAXSqQqGtwa+pugcgufUjLdRBQqS5IAA=;
        b=FT2bqJkiyBx/qzIeUC+uBjCWP5fwSxRd9xKptiiPAVxLTv+v5FocmB298lUZF7I4Ai
         yYOWD6WJSxCKpDwKSlUX+xjVfRMRs29uz1l+lmUNMT3q9TGzEE6PqtA45R7t+QjgfXrx
         r0aNNYNDu3jrKW95PInsOOn4akOOZW1HGraRRQKkOUZc3FbNQaWec9l6EsoiFYCKmlmI
         /IM1kBrClZppLKSIXQ+fWanOm0r2J1JBBOm3WuBfZQJUF/MXxQNhf11N6vAIW+0PM3jb
         LHXaTSEbFcp1sCGMN6JYokh8qAJceX00OlrZL0xyJohmxFwzk5Ij+symI2PoD/C1DxcI
         9Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxSF9+zeCHDpAXSqQqGtwa+pugcgufUjLdRBQqS5IAA=;
        b=IGoYoSmynyUE/wY10kxopJ8BgPQ40G/ve7syIVpnUdzo5QpvmgToiytjdden/oeJDZ
         wRkeyXVdrM+OFSVc+k7PEEhtipy3FHiWVMKMpouqn0RUTqCKjzrs1DwoT90AOh1Bk0TY
         1MCClD91P2Md907kgSQr1lMxjxunRmqSCEjeK1eTsXF2dVS9ob5CyV0PgJJaleEaw5Kp
         bVR61N2ZTki7F2Pn2pEmbrWDRZvMVD3RPwAzvQ/NJazX/vHailGJ0kYgO3qCWYcJQx5l
         Zqh7OpMmY/ezHOdzTSsxE8ugaJVRoW5s/b91aTTpSgYFzV18jOX3jy+8IelGXVFRqLCO
         hoIQ==
X-Gm-Message-State: AOAM531eKMARarXpbZi6NqdbNommUUrKs8hZhwdif1XIBHF8tD98qTPs
        ftFoICe5Xbwyy3dDkKFgVvXxwc05EjOaLjVZ7ABPHg==
X-Google-Smtp-Source: ABdhPJxAXj/UryK2YgMzyuntuFXES4mdnsrSvDB/G2b01lMhzI2BZ++4HBPKbDMCiiC1Co49OU52glmc6PDh06VvMr0=
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr32852515qti.50.1600667709839;
 Sun, 20 Sep 2020 22:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
In-Reply-To: <20200919110831.GD7462@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Sep 2020 07:54:58 +0200
Message-ID: <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jolsa@redhat.com,
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

On Sat, Sep 19, 2020 at 1:08 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com
> >
> > general protection fault, probably for non-canonical address 0xffff518084501e28: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: maybe wild-memory-access in range [0xfffaac042280f140-0xfffaac042280f147]
> > CPU: 0 PID: 17449 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:perf_misc_flags+0x125/0x150 arch/x86/events/core.c:2638
> > Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
>
> Hmm, so converting this back to opcodes with decodecode gives:
>
> Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
> All code
> ========
>    0:   e4 48                   in     $0x48,%al
>    2:   83 e6 03                and    $0x3,%esi
>    5:   41 0f 94 c4             sete   %r12b
>    9:   31 ff                   xor    %edi,%edi
>    b:   e8 95 fa 73 00          callq  0x73faa5
>   10:   bb 02 00 00 00          mov    $0x2,%ebx
>   15:   4c 29 e3                sub    %r12,%rbx
>   18:   49 81 c6 90 00 00 00    add    $0x90,%r14
>   1f:   4c 89 f0                mov    %r14,%rax
>   22:   48 c1 e8 00             shr    $0x0,%rax
>   26:   00 00                   add    %al,(%rax)
>   28:   00 38                   add    %bh,(%rax)
>   2a:*  00 74 08 4c             add    %dh,0x4c(%rax,%rcx,1)            <-- trapping instruction
>   2e:   89 f7                   mov    %esi,%edi
>   30:   e8 40 c0 b3 00          callq  0xb3c075
>   35:   41 8b 06                mov    (%r14),%eax
>   38:   83 e0 08                and    $0x8,%eax
>   3b:   48 c1 e0 0b             shl    $0xb,%rax
>   3f:   48                      rex.W
>
> and those ADDs before the rIP look real strange. Just as if something
> wrote 4 bytes of 0s there. And building your config with clang-10 gives
> around that area:
>
> ffffffff8101177c:       48 83 e6 03             and    $0x3,%rsi
> ffffffff81011780:       41 0f 94 c4             sete   %r12b
> ffffffff81011784:       31 ff                   xor    %edi,%edi
> ffffffff81011786:       e8 05 c9 73 00          callq  ffffffff8174e090 <__sanitizer_cov_trace_const_cmp8>
> ffffffff8101178b:       bb 02 00 00 00          mov    $0x2,%ebx
> ffffffff81011790:       4c 29 e3                sub    %r12,%rbx
> ffffffff81011793:       49 81 c6 90 00 00 00    add    $0x90,%r14
> ffffffff8101179a:       4c 89 f0                mov    %r14,%rax
> ffffffff8101179d:       48 c1 e8 03             shr    $0x3,%rax
> ffffffff810117a1:       42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
> ffffffff810117a6:       74 08                   je     ffffffff810117b0 <perf_misc_flags+0x130>
> ffffffff810117a8:       4c 89 f7                mov    %r14,%rdi
> ffffffff810117ab:       e8 20 75 b3 00          callq  ffffffff81b48cd0 <__asan_report_load8_noabort>
> ffffffff810117b0:       41 8b 06                mov    (%r14),%eax
> ffffffff810117b3:       83 e0 08                and    $0x8,%eax
> ffffffff810117b6:       48 c1 e0 0b             shl    $0xb,%rax
>
> and I can pretty much follow it instruction by instruction until I reach
> that SHR. Your SHR is doing a shift by 0 bytes and that already looks
> suspicious.
>
> After it, your output has a bunch of suspicious ADDs and mine has a CMP;
> JE instead. And that looks really strange too.
>
> Could it be that something has scribbled in guest memory and corrupted
> that area, leading to that strange discrepancy in the opcodes?

Hi Boris,

Memory corruption is definitely possible. There are hundreds of known
bugs that can potentially lead to silent memory corruptions, and some
observed to lead to silent memory corruptions.

However, these tend to produce crash signatures with 1-2 crashes.
While this has 6 and they look similar and all happened on the only
instance that uses clang. So my bet would be on
something-clang-related rather than a silent memory corruption.
+clang-built-linux
