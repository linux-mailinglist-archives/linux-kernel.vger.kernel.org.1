Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5772F2504
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbhALAjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:39:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbhALAjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:39:24 -0500
Received: from zn.tnic (p200300ec2f088f0064dd88f751605e0c.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:64dd:88f7:5160:5e0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 337F81EC04CB;
        Tue, 12 Jan 2021 01:38:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610411923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7qCToIItDiX616kW0snCkYrX5Hh3lczpxY8UpXzRiL4=;
        b=qELD7kpeooLqFfuuHKSuAc2XCS7HDR9jqeC2SUdlNfQuB/NfL5Azb15dNOn7ToNeRuHEV6
        3GUcHJ+5JZojNiGYvXNLSpY7kkYWnamrAd0/n3xdklB98i26HJZh8RHLPbj3x0vS4igzNd
        FeEIq0eM0QaOmYz3vtmY5rWZaF1hL4A=
Date:   Tue, 12 Jan 2021 01:38:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112003839.GL25645@zn.tnic>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111203807.3547278-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:38:06PM -0800, Nick Desaulniers wrote:
> Arnd found a randconfig that produces the warning:
> 
> arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
> offset 0x3e
> 
> when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
> notes:
> 
>   With the LLVM assembler stripping the .text section symbol, objtool
>   has no way to reference this code when it generates ORC unwinder
>   entries, because this code is outside of any ELF function.
> 
> Fangrui notes that this optimization is helpful for reducing images size
> when compiling with -ffunction-sections and -fdata-sections. I have
> observerd on the order of tens of thousands of symbols for the kernel
> images built with those flags. A patch has been authored against GNU
> binutils to match this behavior, with a new flag
> --generate-unused-section-symbols=[yes|no].
> 
> We can omit the .L prefix on a label to emit an entry into the symbol
> table for the label, with STB_LOCAL binding.  This enables objtool to
> generate proper unwind info here with LLVM_IAS=1.
> 
> Cc: Fangrui Song <maskray@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1209
> Link: https://reviews.llvm.org/D93783
> Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
> Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v2 -> v3:
> * rework to use STB_LOCAL rather than STB_GLOBAL by dropping .L prefix,
>   as per Josh.

Ok so I read a bit around those links above...

Are you trying to tell me here that we can't use .L-prefixed local
labels anymore because, well, clang's assembler is way too overzealous
when stripping symbols to save whopping KiBs of memory?!

Btw Josh made sense to me when asking for a flag or so to keep .text.

And I see --generate-unused-section-symbols=[yes|no] for binutils.

So why isn't there a patch using that switch on clang too instead of the
kernel having to dance yet again for some tool?

:-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
