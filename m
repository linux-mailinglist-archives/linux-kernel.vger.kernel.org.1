Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0872F6045
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbhANLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbhANLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B20C0613D3;
        Thu, 14 Jan 2021 03:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UU0k9SPmZjW9mEpf/D9xPCViNO9X7LPn56+qCj377sI=; b=RPtXD4Mfl2So3qrv+fI7pONRpU
        PeHSiy+AJ9GY0HmiHVWfmqFeMOQdQibiEmNFtFRTu01v/IYs494TP+o3Wd7/GuqHOKo7JaiCKTD8O
        yDcOvlwtoeOC8RUc+z+FgeqJyLxBLCQNnlkhCZibtIpaVl9cGtk9AxM7F5tA7tGRhs+CVd0edBr+1
        XRz1tmjtAO1SYVSFYkfKI4hljvmw3xCDvQbVD2SFGvKVlHuBm7SFw5MlgTcv28AtUbJ9MtoCljYC0
        I6L+lx2RzmwlUTl3AIFIcKFz+k++aPcITbCJwcmMtDiYVyhCfrbN+R/SxT7JXtokSO+WkHGKOZU71
        cQVzwDgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l00vo-00007b-MY; Thu, 14 Jan 2021 11:36:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E7CF3059DE;
        Thu, 14 Jan 2021 12:36:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 027302BECE8A7; Thu, 14 Jan 2021 12:36:45 +0100 (CET)
Date:   Thu, 14 Jan 2021 12:36:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
Message-ID: <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk>
 <20210113165923.acvycpcu5tzksbbi@treble>
 <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
 <20210114103928.GB12284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114103928.GB12284@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:39:28AM +0100, Borislav Petkov wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Tue, 12 Jan 2021 11:46:24 -0800
> Subject: [PATCH] x86/entry: Emit a symbol for register restoring thunk
> 
> Arnd found a randconfig that produces the warning:
> 
>   arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
>   offset 0x3e
> 
> when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
> notes:
> 
>   With the LLVM assembler not generating section symbols, objtool has no
>   way to reference this code when it generates ORC unwinder entries,
>   because this code is outside of any ELF function.
> 
>   The limitation now being imposed by objtool is that all code must be
>   contained in an ELF symbol.  And .L symbols don't create such symbols.
> 
>   So basically, you can use an .L symbol *inside* a function or a code
>   segment, you just can't use the .L symbol to contain the code using a
>   SYM_*_START/END annotation pair.
> 
> Fangrui notes that this optimization is helpful for reducing image size
> when compiling with -ffunction-sections and -fdata-sections. I have
> observed on the order of tens of thousands of symbols for the kernel
> images built with those flags.
> 
> A patch has been authored against GNU binutils to match this behavior
> of not generating unused section symbols ([1]), so this will
> also become a problem for users of GNU binutils once they upgrade to 2.36.
> 
> Omit the .L prefix on a label so that the assembler will emit an entry
> into the symbol table for the label, with STB_LOCAL binding. This
> enables objtool to generate proper unwind info here with LLVM_IAS=1 or
> GNU binutils 2.36+.
> 
>  [ bp: Massage commit message. ]
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And while looking, I suppose we can delete the put_ret_addr_in_rdi crud,
but that's another patch.
