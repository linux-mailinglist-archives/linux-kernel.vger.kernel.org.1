Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49A27565D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIWKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:30:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:30:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d1300e5068c8a3292d31d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:e506:8c8a:3292:d31d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0C3F1EC0409;
        Wed, 23 Sep 2020 12:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600857015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QeE5wPLAtIBCyxy/tK03AVY/XVSUEjZ0YhJ2DYbcq1g=;
        b=a7FHINvw0Iz8zavQTKRuXc4UYccSt9jbCsZn9CKyy7QRl+vTAqy6IjBFzh0Ywi5uMq07up
        v0C7h9Pb4JyTKtCjHolVnf7n+HsM8NFBb2QpOqcKxqEOhFXDDseXA0+K7ww3/QLTTZuCwm
        qdqEm+vYEXxt/fjPBr1000jOpJcTOig=
Date:   Wed, 23 Sep 2020 12:30:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: invalid opcode in map_vdso
Message-ID: <20200923103008.GE28545@zn.tnic>
References: <00000000000096760d05aff79022@google.com>
 <CACT4Y+YGFtPCi3a-ByZGs1kCFfJOYv_AbkxOG=K_D4xh0r4okA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YGFtPCi3a-ByZGs1kCFfJOYv_AbkxOG=K_D4xh0r4okA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:19:40AM +0200, Dmitry Vyukov wrote:
> +clang-built-linux
> Looks like another one with kernel code overwrite in clang build.

Uuh, that's a nice and refreshing one - the pattern is not zeroes this
time

Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
All code
========
   0:   16                      (bad)  
   1:   48 89 ef                mov    %rbp,%rdi
   4:   48 8b 34 24             mov    (%rsp),%rsi
   8:   31 c9                   xor    %ecx,%ecx
   a:   e8 88 7c a7 00          callq  0xa77c97
   f:   eb 7a                   jmp    0x8b
  11:   4c 8b 74 24 28          mov    0x28(%rsp),%r14
  16:   43 80 3c 3e 00          cmpb   $0x0,(%r14,%r15,1)
  1b:   48 8b 5c 24 08          mov    0x8(%rsp),%rbx
  20:   74 08                   je     0x2a
  22:   4c 89 ef                mov    %r13,%rdi
  25:   e8 4d 77 70 70          callq  0x70707777
  2a:*  07                      (bad)           <-- trapping instruction
  2b:   20 05 00 00 49 03       and    %al,0x3490000(%rip)        # 0x3490031
  31:   6d                      insl   (%dx),%es:(%rdi)
  32:   00 48 89                add    %cl,-0x77(%rax)
  35:   e8 48 c1 e8 03          callq  0x3e8c182
  3a:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
  3f:   74                      .byte 0x74

Code starting with the faulting instruction
===========================================
   0:   07                      (bad)  
   1:   20 05 00 00 49 03       and    %al,0x3490000(%rip)        # 0x3490007
   7:   6d                      insl   (%dx),%es:(%rdi)
   8:   00 48 89                add    %cl,-0x77(%rax)
   b:   e8 48 c1 e8 03          callq  0x3e8c158
  10:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
  15:   74                      .byte 0x74

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
