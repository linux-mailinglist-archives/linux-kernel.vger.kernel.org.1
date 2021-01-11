Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC92E2F228A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbhAKWRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbhAKWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:17:50 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FEC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:17:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a188so115710pfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMDxhrQVHVN144awFssHzxy+utkh0edTkpwVYmKHPTw=;
        b=ZatuqwkVZCkR7IJsjq87LaZSBaDEN+U2imRjSsYWP0gT0JS8MpQlkNbxvTE6KYQtSx
         RJ5eLFTnQqXPX9Uf5YFXZfvyTA8KR0IHnhfUeHxVoDZpkWtGPUWIHA6utqB7VZrMUlO5
         178GzJEaaFHVC3yUPHW2tjWehaY695KRNb2RPHs/wxLS/ov7aHcPxyJpLOM9lOafRpJJ
         ZduEw7aOH/hF2kugjUtO0VfJY+3pJOPvxubOKIArTlH6CtgLzfiNrgQnhrvhxhq2Ay+s
         iebY5NxYUNVfPbiOpTkGRRSjHZPVj5vvS9aFaHJKgEF9QIr+zJEpzYOzOpGVUY6qsa1s
         dCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMDxhrQVHVN144awFssHzxy+utkh0edTkpwVYmKHPTw=;
        b=JS+eEBmtKFIyTA1XgkGCt7Y0enifSikugAZIqUrATSyMJpXkp+EFgn4eM+gNRS8+25
         cPkJJXCHE6nnZ9rKJ1+748VYBjlkGmj/Y4TB1YWd40JumU2fvDYbpWG4STrVJhjgP2X5
         5E7hZWY7x8fsPU6smPoAwOQHT/RMCpx+9sE1o36NY43E2yhe9LcJCjYCW+Cssm2Vcgfx
         AGOunfdj+uxYRUIjbfOYXqsgriO/J/ifM47EyOca8EesuWTVHZB5QCjJDXA+CmfR7OBs
         tmXEkLcyoKhWK+5F4RHsaSfjpomL/udyNRPiCMLL4TIlOZUGmXU0RCAtwb6nHRJHe1R4
         +YqQ==
X-Gm-Message-State: AOAM530JuQTjKrWSQh9YK5UdZlwe28V34Ff87hI04yIbDN70Op4Jz7y3
        eQoYqGR7AAr0tZ0WsNdEZmqRx8sJERrwJNwK9iOo9g==
X-Google-Smtp-Source: ABdhPJymd0OWy+nqLQYE8Azvi4DAlpP+Mt6wH5x+x9jDdthhF1/xQuqwMrOKJqigxDbKaaFUGgEAt+06Lx8ywph3OZc=
X-Received: by 2002:a62:5ec5:0:b029:1ae:6847:fa02 with SMTP id
 s188-20020a625ec50000b02901ae6847fa02mr1477037pfb.61.1610403423618; Mon, 11
 Jan 2021 14:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106015810.5p6crnh7jqtmjtv4@treble> <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210111205814.m6bbvekdhqs7pnhr@google.com> <20210111220909.2wexjehwiria7jem@treble>
In-Reply-To: <20210111220909.2wexjehwiria7jem@treble>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Jan 2021 14:16:52 -0800
Message-ID: <CAFP8O3+KBi5beri4rzor8NrwxVej2SFF-dxOQX0OTBLXJ5engg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:09 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jan 11, 2021 at 12:58:14PM -0800, Fangrui Song wrote:
> > On 2021-01-11, Nick Desaulniers wrote:
> > > Arnd found a randconfig that produces the warning:
> > >
> > > arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
> > > offset 0x3e
> > >
> > > when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
> > > notes:
> > >
> > >  With the LLVM assembler stripping the .text section symbol, objtool
> > >  has no way to reference this code when it generates ORC unwinder
> > >  entries, because this code is outside of any ELF function.
> > >
> > > Fangrui notes that this optimization is helpful for reducing images size
> > > when compiling with -ffunction-sections and -fdata-sections. I have
> > > observerd on the order of tens of thousands of symbols for the kernel
> > > images built with those flags. A patch has been authored against GNU
> > > binutils to match this behavior, with a new flag
> > > --generate-unused-section-symbols=[yes|no].
> >
> > https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=d1bcae833b32f1408485ce69f844dcd7ded093a8
> > has been committed. The patch should be included in binutils 2.37.
> > The maintainers are welcome to the idea, but fixing all the arch-specific tests is tricky.
> >
> > H.J. fixed the x86 tests and enabled this for x86. When binutils 2.37
> > come out, some other architectures may follow as well.
> >
> > > We can omit the .L prefix on a label to emit an entry into the symbol
> > > table for the label, with STB_LOCAL binding.  This enables objtool to
> > > generate proper unwind info here with LLVM_IAS=1.
> >
> > Josh, I think objtool orc generate needs to synthesize STT_SECTION
> > symbols even if they do not exist in object files.
>
> I'm guessing you don't mean re-adding *all* missing STT_SECTIONs, as
> that would just be undoing these new assembler features.
>
> We could re-add STT_SECTION only when there's no other corresponding
> symbol associated with the code, but then objtool would have to start
> updating the symbol table (which right now it manages to completely
> avoid).  But that would only be for the niche cases, like
> 'SYM_CODE.*\.L' as you mentioned.
>
> I'd rather avoid making doing something so pervasive for such a small
> number of edge cases.  It's hopefully easier and more robust to just say
> "all code must be associated with a symbol".  I suspect we're already
> ~99.99% there anyway.
>
>   $ git grep -e 'SYM_CODE.*\.L'
>   arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
>   arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
>   arch/x86/entry/thunk_64.S:SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>   arch/x86/entry/thunk_64.S:SYM_CODE_END(.L_restore)
>   arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
>   arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
>   arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
>   arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
>   arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
>   arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
>   arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
>   arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)

I'd prefer that the assembly can continue using .L and does not know
the objtool limitation.
Assemblers normally drop .L symbols. These symbols are otherwise not useful.

However, if as you said, teaching objtool about synthesizing
STT_SECTION from section header table is difficult,
this patch looks fine to me.

Reviewed-by: Fangrui Song <maskray@google.com>

> Alternatively, the assemblers could add an option to only strip
> -ffunction-sections and -fdata-sections STT_SECTION symbols, e.g. leave
> ".text" and friends alone.

I forgot to mention that --generate-unused-section-symbols=[yes|no] is
not added to GNU as.
Making the assembler behavior dependent on -ffunction-sections is not
an option in both LLVM integrated assembler and GNU as.
