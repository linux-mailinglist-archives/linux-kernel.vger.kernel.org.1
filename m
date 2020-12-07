Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F72D110B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLGMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLGMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:53:02 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFFC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:52:16 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 11so12298229oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyGMufKhn3rdsN41H0khe/e5DDZRz7d+ODZIwycAubY=;
        b=CuoNQ1ZHRqc6zbhbK1YP+GZ7ktFO9Q/lyYuaIY4Jz3ZhK9OGgVPErHX95W8Ll0n2zI
         ge/Sf2P9PW26px7hU6YIIUfuUtpFMLgxMacRHFFSqWy8nqIW5dmrOMVICwubhJRZpdeh
         drywPQLLnE8sxP6kcz/T4gyRS02WTuGOxFKGIg5oYxm/A4VnwM9lOE1ZGmDR4pWpZ1/n
         Xph4GXlObo2q28Jp8ESDYHfAX3GvvAEt+uFK8E3U7RPDI+DADPi/KEM2VJBucZsddtPk
         nlhcTXUY3l8V+SfpnmKqHhAkwVEFcWYkKGkEahH5bweWejzM8IR/xV4WtSRnCTaay3AH
         XS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyGMufKhn3rdsN41H0khe/e5DDZRz7d+ODZIwycAubY=;
        b=UovMa/8mhMbq6+VAyKWYfCCvEUKo84UDqup+B7oMmYR+jYTysn3rWrIqRbv5Hy8Vcv
         IChnDM00m3wgWRpoXke0g8e9iWvl5S+HSnpoes2A6CZCLQtzSG0xQnMFOey5oOmV6qFS
         taXMK3Dzj/qSJ7Ws7R9y5eoLRv/UlvKGC6vG21+OjdIHvgAe2w58T88lzjOYXnT+UkBR
         7A13dujqWj1E6HpAs7jFY2foK9yjAukyMXYbCXwB7jKwtwA3MZO4o3YPl+U2nbCKFJ5i
         RUey8PNWSe2bUsrZ7U3w52reN+kPvownEBRjPI3TaLp+eyJdtiYT2jX3OrrHMspCF/LE
         rGLQ==
X-Gm-Message-State: AOAM531IZNrkDnVHIGt/7R1L+pyM8ElCeJ8QUWu2idLy++DnleOgyHHA
        o3EWc8hdtdD90Waov30htcI3z4U2SFkGZUY8RXfTWA==
X-Google-Smtp-Source: ABdhPJxVprKjmUCG8roIE9AUOYm4iqNmTYeBhRe9Vvez95kN2cFuEgYeLI/drFAYcAWr2iHleQglU518kMx4cKrEm88=
X-Received: by 2002:a9d:6199:: with SMTP id g25mr2798381otk.17.1607345535306;
 Mon, 07 Dec 2020 04:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20201204210000.660293c6@canb.auug.org.au> <20201204211923.a88aa12dc06b61780282dd1b@linux-foundation.org>
 <CACT4Y+bYVC=r+bPF7MziOZpJCYqrUj7CFt47Z5PSWjohZLYm+w@mail.gmail.com> <CACT4Y+bPPSQ1OgZ1NmUckOO2=07RE3C=deW6BpF0cOR9wnJsoA@mail.gmail.com>
In-Reply-To: <CACT4Y+bPPSQ1OgZ1NmUckOO2=07RE3C=deW6BpF0cOR9wnJsoA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Dec 2020 13:52:03 +0100
Message-ID: <CANpmjNObNia7mFFJDz6ofG06QOTzad=iU=b_C=E97nV2hB-hng@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm tree
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 13:38, 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Mon, Dec 7, 2020 at 1:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > Hi all,
> > > >
> > > > After merging the akpm tree, today's linux-next build (powerpc
> > > > allyesconfig) produced warnings like this:
> > > >
> > > > kernel/kcov.c:296:14: warning: conflicting types for built-in function '__sanitizer_cov_trace_switch'; expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
> > > >   296 | void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
> > > >       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Odd.  clang wants that signature, according to
> > > https://clang.llvm.org/docs/SanitizerCoverage.html.  But gcc seems to
> > > want a different signature.  Beats me - best I can do is to cc various
> > > likely culprits ;)
> > >
> > > Which gcc version?  Did you recently update gcc?
> > >
> > > > ld: warning: orphan section `.data..Lubsan_data177' from `arch/powerpc/oprofile/op_model_pa6t.o' being placed in section `.data..Lubsan_data177'
> > > >
> > > > (lots of these latter ones)
> > > >
> > > > I don't know what produced these, but it is in the akpm-current or
> > > > akpm trees.
> >
> > I can reproduce this in x86_64 build as well but only if I enable
> > UBSAN as well. There were some recent UBSAN changes by Kees, so maybe
> > that's what affected the warning.
> > Though, the warning itself looks legit and unrelated to UBSAN. In
> > fact, if the compiler expects long and we accept u64, it may be broken
> > on 32-bit arches...
>
> No, I think it works, the argument should be uint64.
>
> I think both gcc and clang signatures are correct and both want
> uint64_t. The question is just how uint64_t is defined :) The old
> printf joke that one can't write portable format specifier for
> uint64_t.
>
> What I know so far:
> clang 11 does not produce this warning even with obviously wrong
> signatures (e.g. short).
> I wasn't able to trigger it with gcc on 32-bits at all. KCOV is not
> supported on i386 and on arm I got no warnings even with obviously
> wrong signatures (e.g. short).
> Using "(unsigned long val, void *cases)" fixes the warning on x86_64.
>
> I am still puzzled why gcc considers this as a builtin because we
> don't enable -fsanitizer-coverage on this file. I am also puzzled how
> UBSAN affects things.

It might be some check-for-builtins check gone wrong if it enables any
one of the sanitizers. That would be confirmed if it works with

UBSAN_SANITIZE_kcov.o := n

> We could change the signature to long, but it feels wrong/dangerous
> because the variable should really be 64-bits (long is broken on
> 32-bits).
> Or we could introduce a typedef that is long on 64-bits and 'long
> long' on 32-bits.
