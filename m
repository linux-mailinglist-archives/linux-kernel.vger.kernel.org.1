Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58C926AEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIOUxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:53:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgIOUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:49:27 -0400
Received: from zn.tnic (p200300ec2f0e42002ec71013b50744b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:2ec7:1013:b507:44b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1D641EC0268;
        Tue, 15 Sep 2020 22:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600202960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vH46LhzdOZ1oCzajIbFfe30UVDSp308nP3FSPhHESeg=;
        b=DENOFQtQn88IXm7pPSvRYkvJK83BCfFBVVLbL8p63mlqbG5uJBoglLOaHYvbqHHiYAIPOs
        HMcCu4cVuiDb9gRKzxWrtWswW1/8XmFcuzV1AmY1DltbxrYRsyIjPdW14khiQMWh+4g+mA
        0RFQ+R6DpzaWvwMcaAAxmoA8k9t4rTw=
Date:   Tue, 15 Sep 2020 22:49:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915204912.GA14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:12:24PM -0700, Nick Desaulniers wrote:
>       1 warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction

That looks interesting. So your .o has:

00000000000004c0 <ist_exc_vmm_communication>:
 4c0:   55                      push   %rbp
 4c1:   48 89 e5                mov    %rsp,%rbp
 4c4:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 4cb:   31 c0                   xor    %eax,%eax
 4cd:   e8 00 00 00 00          callq  4d2 <ist_exc_vmm_communication+0x12>
 4d2:   0f 0b                   ud2    
 4d4:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
 4db:   00 00 00 00 
 4df:   90                      nop

 And the unreachable insn is at 0x4d2. The version I got when building with
 clang12 built from git of today is:

00000000000003e0 <ist_exc_vmm_communication>:
 3e0:   55                      push   %rbp
 3e1:   48 89 e5                mov    %rsp,%rbp
 3e4:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 3eb:   31 c0                   xor    %eax,%eax
 3ed:   e8 00 00 00 00          callq  3f2 <ist_exc_vmm_communication+0x12>
 3f2:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
 3f9:   00 00 00 00 
 3fd:   0f 1f 00                nopl   (%rax)

and that version is calling a bunch of NOPs.

gcc produces:

00000000000002aa <ist_exc_vmm_communication>:
 2aa:   55                      push   %rbp
 2ab:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 2b2:   48 89 e5                mov    %rsp,%rbp
 2b5:   e8 00 00 00 00          callq  2ba <ist_exc_vmm_communication+0x10>
 2ba:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

(Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should not be
 returning, ever. :-))

So what that call actually is, is:

# arch/x86/kernel/sev-es.c:1342:        panic("Can't handle #VC exception from unsupported context\n");
        call    panic   #

and the address of panic() gets fixed up by the linker into:

ffffffff83066dca <ist_exc_vmm_communication>:
ffffffff83066dca:       55                      push   %rbp
ffffffff83066dcb:       48 c7 c7 08 4f e2 83    mov    $0xffffffff83e24f08,%rdi
ffffffff83066dd2:       48 89 e5                mov    %rsp,%rbp
ffffffff83066dd5:       e8 52 23 ff ff          callq  ffffffff8305912c <panic>
ffffffff83066dda:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

But your compiler generates a call to UD2.

Interesting.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
