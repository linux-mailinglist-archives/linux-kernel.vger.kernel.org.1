Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73C281602
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbgJBPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:04:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781CC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 08:04:06 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so1488541oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OT/4n2wS86BoiTVC/dLrqPVRF45rG7BZbw8GfdvQDw=;
        b=iV1InCDdPT45RkQ7sZ8mc6cT/xKxfIoMyV/vowBXBMoLl2m1kAnQKjipJuYCKiS88S
         hBDeBCAbpAZ0fnoDZuqNhRkyfRzPW3Y//6yg3lzayB7E4YIGTQjEebwmGjyw0kyf8vX9
         l73xb7h+VIbzzceJ6jNlB+i97Z0PjJWNUryfoF7sWqZRV31i1+Yr0nzDFYH5zVr7Bl54
         e27PUL0USC6QXqyHS2aTmh5uIsL5njMMsLVrijQ85r+071niOiAdzonKapjz7tX2y+6Z
         DilHLmIUs98MdrarrkMdJ+iJKI8dMMUUFVdTANajoNpkJ10hEmzODGB/M06HcP50p1DB
         iaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OT/4n2wS86BoiTVC/dLrqPVRF45rG7BZbw8GfdvQDw=;
        b=oCVF79A+VAS9F6TgKt4C01zMSFT8pBgQ+BNe32I086QPKN248VEKJ2ZftlB++wilbU
         On1zWOJmFBPsE6OWJEKNRYkv/C/iKPA67tfHrBHgtGdypLwYOFzl/D81SN2GEROVdvTZ
         woMVlY/S1xKEi8VLM3mmzUgm3SH1MxRxD+NkxJyxEfRYZgdZk31WjASWFV4WVWBogVhN
         ZX8de1/Bk7WUT8+vlomTm+6cJQPoDJVdXM/y5xz5KthI44PLd1GwsQj+poSju4GmoOb/
         Z22LdW2ojSjXGyMQDl3D2e0rIrryM0rvaud6C6UoG2/22dBLR0MRLrVVyQkbo+Rew4th
         VyhQ==
X-Gm-Message-State: AOAM533uJn8Xwzw45xM+HIFsYMT//wphRVlb+G6DIIdgDi2rqZDgzNx8
        FUwEP4UlYNbGpy6pogPNjfVj8Gv2SoMiNlTrqp5Bgw==
X-Google-Smtp-Source: ABdhPJwvgINkz+XJYCLwm568Iu1c+D20UBL6OzCbGUjPWGg1MtUjajtfVWBwinmo+yMWIZbIn4YgDoh9wciHQjF0cjs=
X-Received: by 2002:a54:468f:: with SMTP id k15mr1518233oic.121.1601651045524;
 Fri, 02 Oct 2020 08:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200922074330.2549523-1-georgepope@google.com> <CA+DmFKDMZPef9+f4xPWMQ2mgdHPSUBmYZ3X=bS6s8XudetmW5g@mail.gmail.com>
In-Reply-To: <CA+DmFKDMZPef9+f4xPWMQ2mgdHPSUBmYZ3X=bS6s8XudetmW5g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Oct 2020 17:03:54 +0200
Message-ID: <CANpmjNP7ucEfdfuU_Ch7ukdF3HS5z0rPkG=pgrdK16S=--z-WA@mail.gmail.com>
Subject: Re: [PATCH v3] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
To:     George Popescu <georgepope@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        George Popescu <georgepope@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 at 16:43, George Popescu <georgepope@google.com> wrote:
>
> Is this patch ready to be merged?

Andrew already picked this up and it's in the -mm tree:
https://lore.kernel.org/mm-commits/20200922170717.qhs0j%25akpm@linux-foundation.org/

You have to wait for the next merge window, which will likely start in
1.5 weeks (or, on Monday, but unlikely:
https://lwn.net/Articles/832733/).

Thanks,
-- Marco

> Best regards,
> George
>
>
> On Tue, Sep 22, 2020 at 10:43 AM George-Aurelian Popescu
> <georgepope@google.com> wrote:
> >
> > From: George Popescu <georgepope@android.com>
> >
> > When the kernel is compiled with Clang, -fsanitize=bounds expands to
> > -fsanitize=array-bounds and -fsanitize=local-bounds.
> >
> > Enabling -fsanitize=local-bounds with Clang has the unfortunate
> > side-effect of inserting traps; this goes back to its original intent,
> > which was as a hardening and not a debugging feature [1]. The same feature
> > made its way into -fsanitize=bounds, but the traps remained. For that
> > reason, -fsanitize=bounds was split into 'array-bounds' and
> > 'local-bounds' [2].
> >
> > Since 'local-bounds' doesn't behave like a normal sanitizer, enable
> > it with Clang only if trapping behaviour was requested by
> > CONFIG_UBSAN_TRAP=y.
> >
> > Add the UBSAN_BOUNDS_LOCAL config to Kconfig.ubsan to enable the
> > 'local-bounds' option by default when UBSAN_TRAP is enabled.
> >
> > [1] http://lists.llvm.org/pipermail/llvm-dev/2012-May/049972.html
> > [2] http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html
> >
> > Suggested-by: Marco Elver <elver@google.com>
> > Reviewed-by: David Brazdil <dbrazdil@google.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Signed-off-by: George Popescu <georgepope@android.com>
> >
> > ---
> > v2: changed the name of the config, in Kconfig, to UBSAN_LOCAL_BOUNDS
> > ---
> > v3: added Reviewed-by tag
> > ---
> >  lib/Kconfig.ubsan      | 14 ++++++++++++++
> >  scripts/Makefile.ubsan | 10 +++++++++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 774315de555a..58f8d03d037b 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -47,6 +47,20 @@ config UBSAN_BOUNDS
> >           to the {str,mem}*cpy() family of functions (that is addressed
> >           by CONFIG_FORTIFY_SOURCE).
> >
> > +config UBSAN_LOCAL_BOUNDS
> > +       bool "Perform array local bounds checking"
> > +       depends on UBSAN_TRAP
> > +       depends on CC_IS_CLANG
> > +       depends on !UBSAN_KCOV_BROKEN
> > +       help
> > +         This option enables -fsanitize=local-bounds which traps when an
> > +         exception/error is detected. Therefore, it should be enabled only
> > +         if trapping is expected.
> > +         Enabling this option detects errors due to accesses through a
> > +         pointer that is derived from an object of a statically-known size,
> > +         where an added offset (which may not be known statically) is
> > +         out-of-bounds.
> > +
> >  config UBSAN_MISC
> >         bool "Enable all other Undefined Behavior sanity checks"
> >         default UBSAN
> > diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> > index 27348029b2b8..4e3fff0745e8 100644
> > --- a/scripts/Makefile.ubsan
> > +++ b/scripts/Makefile.ubsan
> > @@ -4,7 +4,15 @@ ifdef CONFIG_UBSAN_ALIGNMENT
> >  endif
> >
> >  ifdef CONFIG_UBSAN_BOUNDS
> > -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> > +      ifdef CONFIG_CC_IS_CLANG
> > +            CFLAGS_UBSAN += -fsanitize=array-bounds
> > +      else
> > +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> > +      endif
> > +endif
> > +
> > +ifdef CONFIG_UBSAN_LOCAL_BOUNDS
> > +      CFLAGS_UBSAN += -fsanitize=local-bounds
> >  endif
> >
> >  ifdef CONFIG_UBSAN_MISC
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
