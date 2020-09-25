Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06D2786D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIYMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:17:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A24C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:17:09 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so1618370qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPvOJqW7rDrrdcx7Mo36ua8KWFrzhCpiIyO3GQAecDU=;
        b=HwQI/7vrF/B2/pPY0XBjxvLZG51EvWnmus/R+k+UCjZ+LRKZeBeRnIAj/8x/XcF6S8
         EWl6TQkB9T3Uc//5vEH8sAlowjm/5kOum4cSQHGalIARURx8jH5lUiSEuvOGBlL6X++4
         B6uPVMhzCcqeWmH0IAvLBj74gz6LT4gFL5/fvvXt+lwffNtJkVy2AHOGLH7MBjqS+CeG
         l0PAPe/w6QYsZE+ceVWA4ioMM6fV2sQn5avyAv6ngtN1v4KeCEr0toTY5XjE+/5RINjs
         c9lrP48dJofzVCKXPj/x0ao9GKwOiX9fh4Tdm+j0rm+Msj1o1hqsPZofXSyMR2+HFYx8
         ZNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPvOJqW7rDrrdcx7Mo36ua8KWFrzhCpiIyO3GQAecDU=;
        b=j6Eh/467THBrlAYEsrenFimxJdWRqDsExoFflDbPXQ2LFnXrQbCT0S9RXwfO8FHYmy
         u8QwLquoAkIT3nF6kHc8B0to44glKTMLE3yHzmzPdQggRy+ehmOzgCkyb4LpjVLMpj4C
         t5B1GD+Ohqz6fcLvgesCutggd5fvUb4rD93grGNPS6+hVB7fok96PT8KKqWQZ6Q9hXQw
         hrU5bdANFzJRGxJ2nRUMjCIUYVAAyXLQOwY80+hN4Ygdk/gVUJp8+nD0BFRbe8LdlT51
         1jeik54rx3aLwTbm1QcETv6XB/2McvsryRXz30nQgnIA3sgEIjg/b1WpEXknaq/vNH3F
         mALg==
X-Gm-Message-State: AOAM530YoGJBOuFG7vGPb5npC+q48/57C10C8oVH6BsAmP/S8y/pHSpk
        WVlUxDjPPQWvKfuCtJT/itEZRv3sXF3Tr8l1eIXdud3INcGLKg==
X-Google-Smtp-Source: ABdhPJwPLKN5HM5jM8CKd8R2eU3ge8VLTknuf+/1TtVgFyv6rtRu1Ea8CDVMYOUIJU4I2niocWd8mVOIKHY3C8r4kEA=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr4068508qtq.380.1601036228529;
 Fri, 25 Sep 2020 05:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000096760d05aff79022@google.com> <CACT4Y+YGFtPCi3a-ByZGs1kCFfJOYv_AbkxOG=K_D4xh0r4okA@mail.gmail.com>
 <20200923103008.GE28545@zn.tnic>
In-Reply-To: <20200923103008.GE28545@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Sep 2020 14:16:57 +0200
Message-ID: <CACT4Y+bRNgchFs_Wc4zLk+J=MjsTNEx2EvnbSpKtSi1R_YiPDQ@mail.gmail.com>
Subject: Re: invalid opcode in map_vdso
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Wed, Sep 23, 2020 at 12:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 23, 2020 at 11:19:40AM +0200, Dmitry Vyukov wrote:
> > +clang-built-linux
> > Looks like another one with kernel code overwrite in clang build.
>
> Uuh, that's a nice and refreshing one - the pattern is not zeroes this
> time
>
> Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
> All code
> ========
>    0:   16                      (bad)
>    1:   48 89 ef                mov    %rbp,%rdi
>    4:   48 8b 34 24             mov    (%rsp),%rsi
>    8:   31 c9                   xor    %ecx,%ecx
>    a:   e8 88 7c a7 00          callq  0xa77c97
>    f:   eb 7a                   jmp    0x8b
>   11:   4c 8b 74 24 28          mov    0x28(%rsp),%r14
>   16:   43 80 3c 3e 00          cmpb   $0x0,(%r14,%r15,1)
>   1b:   48 8b 5c 24 08          mov    0x8(%rsp),%rbx
>   20:   74 08                   je     0x2a
>   22:   4c 89 ef                mov    %r13,%rdi
>   25:   e8 4d 77 70 70          callq  0x70707777
>   2a:*  07                      (bad)           <-- trapping instruction
>   2b:   20 05 00 00 49 03       and    %al,0x3490000(%rip)        # 0x3490031
>   31:   6d                      insl   (%dx),%es:(%rdi)
>   32:   00 48 89                add    %cl,-0x77(%rax)
>   35:   e8 48 c1 e8 03          callq  0x3e8c182
>   3a:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
>   3f:   74                      .byte 0x74
>
> Code starting with the faulting instruction
> ===========================================
>    0:   07                      (bad)
>    1:   20 05 00 00 49 03       and    %al,0x3490000(%rip)        # 0x3490007
>    7:   6d                      insl   (%dx),%es:(%rdi)
>    8:   00 48 89                add    %cl,-0x77(%rax)
>    b:   e8 48 c1 e8 03          callq  0x3e8c158
>   10:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
>   15:   74                      .byte 0x74

There is strong indication that this is a manifestation of the same
problem we see in other crashes.
Let's make one canonical bug for this:

#syz dup: general protection fault in perf_misc_flags
