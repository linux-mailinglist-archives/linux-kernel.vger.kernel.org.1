Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BE29EAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2Lh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ2LgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:36:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9234FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:36:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMNg06TwCz9sSC;
        Thu, 29 Oct 2020 22:35:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603971378;
        bh=/bWxFtkcnR3hrEd2XbJrRVATAUV/nns9oZ79oXlWWZI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qEmzQJryIrXXvMFilHzdRLfCxqjaLw14CC76shLzlafg3MPoa7WBOwi3fxtkEoSTQ
         0xEp0E5qrjHLRnwWfF78HGCQdBSw6w0Vgegj8pgdzP9Yx3Wt1XapfMHsBWTTHcEaGq
         xTxkqA0xXrYuLSZSBWp/9YW/uD0WdEJlo5xD8eZo3BQZaHjuy7TrTLJMrqDHA4jQlN
         kJVN+jBD4yIhS6H4t0I7S8m1EWVxFGgWiiSTOmymGeCki5QJsbsnvYsIVa60c8yVuF
         vGOsVGY+8gtWfUIhsAk5Wo7V6PDNfbKW+uMMqDIrTMK+882wWiIPddMoAfYB8Jwnr5
         f6mq9Qu2c91hQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] powerpc: avoid broken GCC __attribute__((optimize))
In-Reply-To: <CAMj1kXHFS7BonvRaSYCn+1rTXKsT8qfQocRaYovj-BTNZw_qng@mail.gmail.com>
References: <20201028080433.26799-1-ardb@kernel.org> <CAMj1kXHFS7BonvRaSYCn+1rTXKsT8qfQocRaYovj-BTNZw_qng@mail.gmail.com>
Date:   Thu, 29 Oct 2020 22:35:48 +1100
Message-ID: <875z6tw9gr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:
> On Wed, 28 Oct 2020 at 09:04, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Commit 7053f80d9696 ("powerpc/64: Prevent stack protection in early boot")
>> introduced a couple of uses of __attribute__((optimize)) with function
>> scope, to disable the stack protector in some early boot code.
>>
>> Unfortunately, and this is documented in the GCC man pages [0], overriding
>> function attributes for optimization is broken, and is only supported for
>> debug scenarios, not for production: the problem appears to be that
>> setting GCC -f flags using this method will cause it to forget about some
>> or all other optimization settings that have been applied.
>>
>> So the only safe way to disable the stack protector is to disable it for
>> the entire source file.
>>
>> [0] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Arvind Sankar <nivedita@alum.mit.edu>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Fixes: 7053f80d9696 ("powerpc/64: Prevent stack protection in early boot")
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> Related discussion here:
>> https://lore.kernel.org/lkml/CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com/
>>
>> TL;DR using __attribute__((optimize("-fno-gcse"))) in the BPF interpreter
>> causes the compiler to forget about -fno-asynchronous-unwind-tables passed
>> on the command line, resulting in unexpected .eh_frame sections in vmlinux.
>>
>>  arch/powerpc/kernel/Makefile   | 3 +++
>>  arch/powerpc/kernel/paca.c     | 2 +-
>>  arch/powerpc/kernel/setup.h    | 6 ------
>>  arch/powerpc/kernel/setup_64.c | 2 +-
>>  4 files changed, 5 insertions(+), 8 deletions(-)

Thanks for the patch.

> FYI i was notified by one of the robots that I missed one occurrence
> of __nostackprotector in arch/powerpc/kernel/paca.c
>
> Let me know if I need to resend.

That's fine I'll fix it up when applying.

With the existing code, with STACKPROTECTOR_STRONG=y, I see two
functions in setup_64.c that are triggering stack protection. One is
__init, and the other takes no parameters and is not easily reachable
from userspace, so I don't think losing the stack canary on either of
those is a concern.

I don't see anything in paca.c triggering stack protection.

I don't think there's any evidence this is causing a bug for us, so I'll
plan to put this in next for v5.11.

cheers
