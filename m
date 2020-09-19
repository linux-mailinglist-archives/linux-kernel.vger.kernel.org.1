Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEF270D75
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgISLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:08:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISLIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:08:40 -0400
Received: from zn.tnic (p200300ec2f1f8f0083db9d23de894774.dip0.t-ipconnect.de [IPv6:2003:ec:2f1f:8f00:83db:9d23:de89:4774])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA7AE1EC047E;
        Sat, 19 Sep 2020 13:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600513718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EvMZssjBDbkfgjvcuPH/tClpNPpisRwOMo9RBFRWxYI=;
        b=G0CXeepq2KwIQDO4Z2K6gA8679DrHOHrwLE5q124c0L8gLOtVuihrariZvJYNfWUtK469R
        tBdBL6WmwHHrwhh12YiuDHMni/IAu8FhOMNGfk5OWtSOGtvziVOL5zDSguW6kZRBGbHuQx
        +Pf2IpgSi0fTXzJL8jFFURLMx4x0gj4=
Date:   Sat, 19 Sep 2020 13:08:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200919110831.GD7462@zn.tnic>
References: <00000000000052569205afa67426@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000052569205afa67426@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xffff518084501e28: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range [0xfffaac042280f140-0xfffaac042280f147]
> CPU: 0 PID: 17449 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:perf_misc_flags+0x125/0x150 arch/x86/events/core.c:2638
> Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48

Hmm, so converting this back to opcodes with decodecode gives:

Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
All code
========
   0:   e4 48                   in     $0x48,%al
   2:   83 e6 03                and    $0x3,%esi
   5:   41 0f 94 c4             sete   %r12b
   9:   31 ff                   xor    %edi,%edi
   b:   e8 95 fa 73 00          callq  0x73faa5
  10:   bb 02 00 00 00          mov    $0x2,%ebx
  15:   4c 29 e3                sub    %r12,%rbx
  18:   49 81 c6 90 00 00 00    add    $0x90,%r14
  1f:   4c 89 f0                mov    %r14,%rax
  22:   48 c1 e8 00             shr    $0x0,%rax
  26:   00 00                   add    %al,(%rax)
  28:   00 38                   add    %bh,(%rax)
  2a:*  00 74 08 4c             add    %dh,0x4c(%rax,%rcx,1)            <-- trapping instruction
  2e:   89 f7                   mov    %esi,%edi
  30:   e8 40 c0 b3 00          callq  0xb3c075
  35:   41 8b 06                mov    (%r14),%eax
  38:   83 e0 08                and    $0x8,%eax
  3b:   48 c1 e0 0b             shl    $0xb,%rax
  3f:   48                      rex.W

and those ADDs before the rIP look real strange. Just as if something
wrote 4 bytes of 0s there. And building your config with clang-10 gives
around that area:

ffffffff8101177c:       48 83 e6 03             and    $0x3,%rsi
ffffffff81011780:       41 0f 94 c4             sete   %r12b
ffffffff81011784:       31 ff                   xor    %edi,%edi
ffffffff81011786:       e8 05 c9 73 00          callq  ffffffff8174e090 <__sanitizer_cov_trace_const_cmp8>
ffffffff8101178b:       bb 02 00 00 00          mov    $0x2,%ebx
ffffffff81011790:       4c 29 e3                sub    %r12,%rbx
ffffffff81011793:       49 81 c6 90 00 00 00    add    $0x90,%r14
ffffffff8101179a:       4c 89 f0                mov    %r14,%rax
ffffffff8101179d:       48 c1 e8 03             shr    $0x3,%rax
ffffffff810117a1:       42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
ffffffff810117a6:       74 08                   je     ffffffff810117b0 <perf_misc_flags+0x130>
ffffffff810117a8:       4c 89 f7                mov    %r14,%rdi
ffffffff810117ab:       e8 20 75 b3 00          callq  ffffffff81b48cd0 <__asan_report_load8_noabort>
ffffffff810117b0:       41 8b 06                mov    (%r14),%eax
ffffffff810117b3:       83 e0 08                and    $0x8,%eax
ffffffff810117b6:       48 c1 e0 0b             shl    $0xb,%rax

and I can pretty much follow it instruction by instruction until I reach
that SHR. Your SHR is doing a shift by 0 bytes and that already looks
suspicious.

After it, your output has a bunch of suspicious ADDs and mine has a CMP;
JE instead. And that looks really strange too.

Could it be that something has scribbled in guest memory and corrupted
that area, leading to that strange discrepancy in the opcodes?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
