Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D72F2506
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbhALAmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbhALAmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:42:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD5AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:42:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cq1so367726pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fORzdtbKexeYqZL9m64WT6sjX1DlAcK6JwMJGQMmjlk=;
        b=fo+rEysuJyf4ZITtyTozq3it3PcTTBbuodQUwamVrJYt3/7mSbVLFozB6DbThv6Pp0
         LUZo9qaeQHO5sGBqkVgpA7VeHhNkBtw46MR5A6qC9vaIeHDxyb3bJFy53OQG3FlZJm2W
         u0LGNZ8YiZVPY+/fnj6DBB2YBKWkfcc0jm0Ljdo2pAIJ1uSlSznOAXoTZROF20fv1oj6
         vBwTTbI5OhnHBsSvpj6ztS8NBdvYeJYFxuphlRlJkDCH3w2hJc0zU+ske7bOVjmvUcIY
         kQYFd4GbTEzA47Fhh7tSn0HI2cjioWUBIb1sKrkNpfDLXei+5kDvWsaaxMEwsrcnjSf6
         VNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fORzdtbKexeYqZL9m64WT6sjX1DlAcK6JwMJGQMmjlk=;
        b=jAvFH9qQDjP6Bj2jHpOByw3uNLgrqO8pBcp9ozqdYlfFkb+8UeW5rzKMcuA4dNpVeB
         Npav12Qj1Zi9FbX+F0ZFrqSpj9T4bthvr9dM8ZSigU0oxtO4tYrId9mw4ZE0u/KJWQP6
         hUzqwoR4Ls1osAUMeer5iprp3fmrf9yZoKZNMsvTCaoVnH1rh4N+mhF91NVqJ4C3IpiF
         72BNl1tcCkpi3R8kjv2nRebn7i1yejAEtpqYaHUdiYjtkqHR7tkXfCDgYbYOqkJRA+ge
         sxdp1Aya4SpLCuWKy5sw+mX+Z7m8Og8En9qIMQBDBy/zYj/arc4y5MjQb9JugO/o8SWY
         0kgQ==
X-Gm-Message-State: AOAM533KJdNQAvT25m0NB519f7WeQPjDEZGJUZzo5b3XWpH8hIz4zvzH
        H8zY/aZIOC1Eo3vdALZjexCkfTufhHrtFLN1O9wysg==
X-Google-Smtp-Source: ABdhPJzdcpGfjUqbLAhmqkk0+hvwq15v9CubqNg159EKcPvIRQqlphklsWmDOgTWDnP94WCVRrVxyEaaL2MO5Anj9Yw=
X-Received: by 2002:a17:90a:6c25:: with SMTP id x34mr1543495pjj.47.1610412124034;
 Mon, 11 Jan 2021 16:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20210106015810.5p6crnh7jqtmjtv4@treble> <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic>
In-Reply-To: <20210112003839.GL25645@zn.tnic>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Jan 2021 16:41:52 -0800
Message-ID: <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 4:38 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 11, 2021 at 12:38:06PM -0800, Nick Desaulniers wrote:
> > Arnd found a randconfig that produces the warning:
> >
> > arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
> > offset 0x3e
> >
> > when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
> > notes:
> >
> >   With the LLVM assembler stripping the .text section symbol, objtool
> >   has no way to reference this code when it generates ORC unwinder
> >   entries, because this code is outside of any ELF function.
> >
> > Fangrui notes that this optimization is helpful for reducing images size
> > when compiling with -ffunction-sections and -fdata-sections. I have
> > observerd on the order of tens of thousands of symbols for the kernel
> > images built with those flags. A patch has been authored against GNU
> > binutils to match this behavior, with a new flag
> > --generate-unused-section-symbols=[yes|no].
> >
> > We can omit the .L prefix on a label to emit an entry into the symbol
> > table for the label, with STB_LOCAL binding.  This enables objtool to
> > generate proper unwind info here with LLVM_IAS=1.
> >
> > Cc: Fangrui Song <maskray@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1209
> > Link: https://reviews.llvm.org/D93783
> > Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
> > Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes v2 -> v3:
> > * rework to use STB_LOCAL rather than STB_GLOBAL by dropping .L prefix,
> >   as per Josh.
>
> Ok so I read a bit around those links above...
>
> Are you trying to tell me here that we can't use .L-prefixed local
> labels anymore because, well, clang's assembler is way too overzealous
> when stripping symbols to save whopping KiBs of memory?!

To be fair: we cannot use .L-prefixed local because of the objtool limitation.
The LLVM integrated assembler behavior is a good one and binutils
global maintainers have agreed so H.J. went ahead and implemented it
for GNU as x86.

> Btw Josh made sense to me when asking for a flag or so to keep .text.
>
> And I see --generate-unused-section-symbols=[yes|no] for binutils.
>
> So why isn't there a patch using that switch on clang too instead of the
> kernel having to dance yet again for some tool?

--generate-unused-section-symbols=[yes|no] as an assembler option has
been rejected.


> :-\
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
