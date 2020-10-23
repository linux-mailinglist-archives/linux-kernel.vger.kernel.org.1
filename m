Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A2967D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373722AbgJWALa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373715AbgJWAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:11:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:11:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 23so3858071ljv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLY21JX5I5QFlC2bkVrjYFHPFnXicdIVDS29HVXeTok=;
        b=ddTlNlNRb6Gcq+pCD2VGDDviUyFdWgS4SI2rZqCTe7qisSD40rk3KGt9veIrursLjL
         d9JYYxPwhKyRBZiDDXgH7+i9ioZ8pfkB5+In9+v4mNHAG0/A90ekmx23hwMClIRCkpK1
         XSJMBceXPy08U1FnD050q7PGqsmjLolxNxCak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLY21JX5I5QFlC2bkVrjYFHPFnXicdIVDS29HVXeTok=;
        b=PY1NlKrMhkeA2vOn5Kp9BhSA2P8d5RhQa1Y0rJ2paCRx1hok4lXfg+V7tcO2F5kZA/
         4zWhKjDorPKj/Rj4TVZgIpellkHng6vGmlX/m2QP+mauF37F9MNanfXlfeY+5JS+2RVR
         /JA1ROvS9gq3l8SsBC3ArXl5JNj5sZgP1Lu1WG08EBOMmkWnilvqKTEJPnO4YrLYbf5K
         JcLVxvAnZqfD5a3EYUym4AYra02k5thqFKFv3IAZ8eDzb6tIIdTN315z5iB/ijgvVkTk
         K8ncJUfl+e6zxv+qh96Ru6ITje/tlNzh1HmH+ecihbK/znVf6w4mUE3+L+wmlyny1Xfk
         0JLA==
X-Gm-Message-State: AOAM532+jc6FZq6PzGEkudg/ZEemePLUIz515FDG9lz+pk7TIrA4Y+3H
        5PSdr9QlzsW1nd7iredOu3+YQM3Ofmzk2A==
X-Google-Smtp-Source: ABdhPJxQHhNOAI/0/Qc7qhAM3UkK3z+Sd/hO8IECxZaOt47wV6IB0Pjx7gRQL45rV+bkI8O8XvBgrg==
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr1779212ljm.113.1603411886333;
        Thu, 22 Oct 2020 17:11:26 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y24sm411074lfy.194.2020.10.22.17.11.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 17:11:25 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h6so4448962lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:11:24 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1503603lff.105.1603411884054;
 Thu, 22 Oct 2020 17:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com> <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
In-Reply-To: <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Oct 2020 17:11:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
Message-ID: <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
Subject: Re: mmstress[1309]: segfault at 7f3d71a36ee8 ip 00007f3d77132bdf sp
 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        X86 ML <x86@kernel.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        zenglg.jy@cn.fujitsu.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Thanks. Very funky, but thanks. I've been running that commit on my
> machine for over half a year, and it still looks "trivially correct"
> to me, but let me go look at it one more time. Can't argue with a
> reliable bisect and revert..

Hmm. The fact that it only happens with KASAN makes me suspect it's
some bad interaction with the inline asm syntax change (and explains
why I've run with this for half a year without issues).

In particular, I wonder if it's that KASAN causes some reload pattern,
and the whole

     register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);
..
     asm volatile(.. "r" (__val_pu) ..)

thing causes problems. That's an ugly pattern, but it's written that
way to get gcc to handle the 64-bit case properly (with the value in
%rax:%rdx).

It turns out that the decode of the user-mode SIGSEGV code is a
variation of system calls, ie

   0: b8 18 00 00 00        mov    $0x18,%eax
   5: 0f 05                syscall
   7: 48 3d 01 f0 ff ff    cmp    $0xfffffffffffff001,%rax
   d: 73 01                jae    0x10
   f:* c3                    retq    <-- trapping instruction

or

   0: 41 52                push   %r10
   2: 52                    push   %rdx
   3: 4d 31 d2              xor    %r10,%r10
   6: ba 02 00 00 00        mov    $0x2,%edx
   b: be 80 00 00 00        mov    $0x80,%esi
  10: 39 d0                cmp    %edx,%eax
  12: 75 07                jne    0x1b
  14: b8 ca 00 00 00        mov    $0xca,%eax
  19: 0f 05                syscall
  1b: 89 d0                mov    %edx,%eax
  1d: 87 07                xchg   %eax,(%rdi)
  1f: 85 c0                test   %eax,%eax
  21: 75 f1                jne    0x14
  23:* 5a                    pop    %rdx <-- trapping instruction
  24: 41 5a                pop    %r10
  26: c3                    retq

so in both cases it looks like 'syscall' returned with a bad stack pointer.

Which is certainly a sign of some code generation issue.

Very annoying, because it probably means that it's compiler-specific
too. And that "syscall 018" looks very odd. I think that's
sched_yield() on x86-64, which doesn't have any __put_user() cases at
all..

Would you mind sending me the problematic vmlinux file in private (or,
likely better - a pointer to some place I can download it, it's going
to be huge).

                      Linus
