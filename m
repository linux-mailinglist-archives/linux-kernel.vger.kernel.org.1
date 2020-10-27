Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2629CA07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831137AbgJ0USJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:18:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36310 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1831128AbgJ0USI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:18:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id r10so1363399plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1Sa4pOklTVSBDn1gBaNdBfK+3lXBzX6RjisxK7EZK0=;
        b=YWQRdPDOE/u+vucTsLTHMVDd0xCZ/ZqYuYBbMMaVwfrCEi30oBxPzNwfA+hIJg/kAi
         Hvpl9C5lBhGAl/BiWW0xixUeyIqHLqlZn4iRKvZITtltWdYUlHZge9jjfusHSv/UIOsP
         ThXOycdvIkrnLRN/h7K1b5dnl1PZQe1VrZFX46noaZVrULb79H1AvqQiGYbEOEW3iU+0
         Z3U8e4pC3Y/KLsiw+/pCXK3+u7MjzIBsSA7L3Sm6NcgtRWFkwaqK8NCUQmIn+7bJf1z1
         L2h9MUabimjWEHUS3n5gK2kd2WpDVvu2TSAZ1f2iq71hAT9rUsN64bMj98JX15V3bDqp
         EiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1Sa4pOklTVSBDn1gBaNdBfK+3lXBzX6RjisxK7EZK0=;
        b=htjkaiOkBUWqRIQiRWjiVKdEKLMM4AeWnqw0zugQRc3TubZfrL5QwtGmY904084KCu
         s4Knatuvxs3Ka6FiYkEFPx6fy/pNulMt85bzqtCPy89QA2sYMZqg7Wd/o/mhD19l4eQp
         47pQlfsrnozbmEBmcz7kh7F5z1c0qeS2YxGZ85JAnbT8M0ZZC1J/nTxLYAm0a0y542S9
         HsFHrO+Zb9PpoAb7/leFsmBTTuWY5ih6VWVt9Bd8kUpOVHqI7ijgBlTyua69v0z2V2Sc
         DdulhIrm5olhwE1W3eoPd8G94F7uobAg0PVEouTfF9VkDB19t+3SnocmrqM2MRrr5CZA
         L4mw==
X-Gm-Message-State: AOAM5321gnGx6IAkaTZoPm/SdP+lXJY7DhVFkkyC7AFkHpQboLY+yreA
        cBJT2HmJidz5ll809YM0cmFd7Wxic/ib//eubU35jg==
X-Google-Smtp-Source: ABdhPJywIjgcBV8qXcoNqM7Ed4H7EaNmCfoq2mAz/vgmUAzc6HfUFJTb7scXcDgK4JpIdX27+zaHnJ3FgMPaCTSILwc=
X-Received: by 2002:a17:902:8a8b:b029:d5:f871:92bd with SMTP id
 p11-20020a1709028a8bb02900d5f87192bdmr4163850plo.10.1603829886728; Tue, 27
 Oct 2020 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com> <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 13:17:55 -0700
Message-ID: <CAKwvOd=8YO3Vm0DuaWpDigMiwni+fVdrpagZtsROGziinjLvig@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 21:12, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 12:25 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > Hi Nick,
> > >
> > > CC Josh
> > >
> > > On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > > On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > > > > placement"), which is another red herring.
> > > > > > > >
> > > > > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > > > > causing the warning.
> > > >
> > > > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > > > missing from someone's KBUILD_CFLAGS.
> > > > But I don't see anything curious in kernel/bpf/Makefile, unless
> > > > cc-disable-warning is somehow broken.
> > >
> > > I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> > > with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
> > >
> > > Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> > > is generated.  Removing the __no_fgcse tag fixes that.
> >
> > That's weird.  I feel pretty strongly that unless we're working around
> > a well understood compiler bug with a comment that links to a
> > submitted bug report, turning off rando compiler optimizations is a
> > terrible hack for which one must proceed straight to jail; do not pass
> > go; do not collect $200.  But maybe I'd feel differently for this case
> > given the context of the change that added it.  (Ard mentions
> > retpolines+orc+objtool; can someone share the relevant SHA if you have
> > it handy so I don't have to go digging?)
>
> commit 3193c0836f203a91bef96d88c64cccf0be090d9c
> Author: Josh Poimboeuf <jpoimboe@redhat.com>
> Date:   Wed Jul 17 20:36:45 2019 -0500
>
>     bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
>
> has
>
> Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
>
> and mentions objtool and CONFIG_RETPOLINE.
>
> >  (I feel the same about there
> > being an empty asm(); statement in the definition of asm_volatile_goto
> > for compiler-gcc.h).  Might be time to "fix the compiler."
> >
> > (It sounds like Arvind is both in agreement with my sentiment, and has
> > the root cause).
> >
>
> I agree that the __no_fgcse hack is terrible. Does Clang support the
> following pragmas?
>
> #pragma GCC push_options
> #pragma GCC optimize ("-fno-gcse")
> #pragma GCC pop_options
>
> ?

Put it in godbolt.org.  Pretty sure it's `#pragma clang` though.
`#pragma GCC` might be supported in clang or silently ignored, but
IIRC pragmas were a bit of a compat nightmare.  I think Arnd wrote
some macros to set pragmas based on toolchain.  (Uses _Pragma, for
pragmas in macros, IIRC).

-- 
Thanks,
~Nick Desaulniers
