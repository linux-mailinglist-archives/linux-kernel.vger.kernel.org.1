Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7730B2753EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIWJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:03:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWJDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:03:44 -0400
Received: from zn.tnic (p200300ec2f0d1300e5068c8a3292d31d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:e506:8c8a:3292:d31d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A7B11EC0286;
        Wed, 23 Sep 2020 11:03:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600851823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5y0yEgZ5tV+QcahBXtAX02EmqN9T8yvCetF3399N5r0=;
        b=qx2Y+7fsY28Q95lSrTI2F8Zaqn5TkAEG0aAjmwtovvEVcvVFGMk6kvu5rjnZyLkX1iw//T
        BePUYvRhKe6Y7+qInCPI9kzaNZvwdOcarlribSEJZhZRiAdZDjEbRjeZaEgpb0X1rEbVkW
        l8DOT/8qo2qyPw9Pq8jMtj9xl8qiePM=
Date:   Wed, 23 Sep 2020 11:03:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200923090336.GD28545@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic>
 <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:56:04AM -0700, Nick Desaulniers wrote:
> So I think there's an issue with "deterministically reproducible."
> The syzcaller report has:
> > > Unfortunately, I don't have any reproducer for this issue yet.

Yeah, Dmitry gave two other links of similar reports, the first one
works for me:

https://syzkaller.appspot.com/bug?extid=1dccfcb049726389379c

and that one doesn't have a reproducer either. The bytes look familiar
though:

Code: c1 e8 03 42 80 3c 20 00 74 05 e8 79 7a a7 00 49 8b 47 10 48 89 05 f6 d8 ef 09 49 8d 7f 08 48 89 f8 48 c1 e8 03 42 80 3c 00 00 <00> 00 e8 57 7a a7 00 49 8b 47 08 48 89 05 dc d8 ef 09 49 8d 7f 18
All code
========
   0:   c1 e8 03                shr    $0x3,%eax
   3:   42 80 3c 20 00          cmpb   $0x0,(%rax,%r12,1)
   8:   74 05                   je     0xf
   a:   e8 79 7a a7 00          callq  0xa77a88
   f:   49 8b 47 10             mov    0x10(%r15),%rax
  13:   48 89 05 f6 d8 ef 09    mov    %rax,0x9efd8f6(%rip)        # 0x9efd910
  1a:   49 8d 7f 08             lea    0x8(%r15),%rdi
  1e:   48 89 f8                mov    %rdi,%rax
  21:   48 c1 e8 03             shr    $0x3,%rax
  25:   42 80 3c 00 00          cmpb   $0x0,(%rax,%r8,1)
  2a:*  00 00                   add    %al,(%rax)               <-- trapping instruction
  2c:   e8 57 7a a7 00          callq  0xa77a88
  31:   49 8b 47 08             mov    0x8(%r15),%rax
  35:   48 89 05 dc d8 ef 09    mov    %rax,0x9efd8dc(%rip)        # 0x9efd918
  3c:   49 8d 7f 18             lea    0x18(%r15),%rdi

4 zero bytes again. And that .config has kasan stuff enabled too so
could the failure be related to having kasan stuff enabled and it
messing up offsets?

That is, provided this is the mechanism how it would happen. We still
don't know what and when wrote those zeroes in there. Not having a
reproducer is nasty but looking at those reports above and if I'm
reading this correctly, rIP points to

RIP: 0010:update_pvclock_gtod arch/x86/kvm/x86.c:1743 [inline]

each time and the URL says they're 9 crashes total. And each have
happened at that rIP. So all we'd need is set a watchpoint when that
address is being written and dump stuff.

Dmitry, can the syzkaller do debugging stuff like that?

> Following my hypothesis about having a bad address calculation; the
> tricky part is I'd need to look through the relocations and try to see
> if any could resolve to the address that was accidentally modified.  I
> suspect objtool could be leveraged for that;

If you can find this at compile time...

> maybe it could check whether each `struct jump_entry`'s `target`
> member referred to either a NOP or a CMP, and error otherwise? (Do we
> have other non-NOP or CMP targets? IDK)

Follow jump_label_transform() - it does verify what it is going to
patch. And while I'm looking at this, I realize that the jump labels
patch 5 bytes but the above zeroes are 4 bytes. In the other opcode
bytes I decoded it is 4 bytes too. So this might not be caused by the
jump labels patching...

> This hypothesis might also be incorrect, and thus would be chasing a
> red herring...not really sure how else to pursue debugging this.

Yeah, this one is tricky to debug.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
