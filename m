Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5682C8F29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgK3U2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgK3U2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:28:08 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10DC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:27:28 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y10so20060518ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Xk0oYhlswqryaWdafHrq35t1o1ARd6p1Zczec+BswM=;
        b=RgBXm8NC/aNTMJm72p+zc/YYQ7GGw/e8E2hcEotUIFFUKcCPwE6oIC5GZu18LY5dvY
         GbrWhhT258oH34WUwOkhlsXUSvzn5qAluukWLCwO9VGfJphhjoFsBxhhMxghlSm6biLg
         IczNuUs4F/8FB+3DZNd6yf4RM3N4LUDWaKnqMa20YcVz5kQJyI4/XiGhGfa82mZrM9D5
         UpsVHg4GlRsbajEt/EUdEsxPdXTUuFqdKOBDVXk9ZHWMXT6s2b3hJhhtZkI50lvZ2yGi
         lLpFgbWGjwB2QN4UaL/APERs+Yj0RhX7xM2VCRjsCFDiwRQNzq9KVERPRNg2j7Cw1OyS
         AC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Xk0oYhlswqryaWdafHrq35t1o1ARd6p1Zczec+BswM=;
        b=NDbcQX6Q5VLKkpisAnlAbNrSA0Unn1yCKXmV13Q1N9Kt7jl1HKN8pwFj+JV2NgyZWF
         /9E4mDLYTE5y7AwKQHtsXCrb926UdmjcdRZg+oCu3do/3e88PQTvzmQD6B4VeJULNdR4
         +EemgSxIb+DQQNOuNjl7A/iuCfbmI7Nyle088Oi0Vp1ZvB05ab9jJ3x0/gx6wnUUdBLt
         /RXDt01pvLHv7YLmLTH5xfH496W6fPUzZPRUbYLsmgVMbwWXqppvJCXKJ4M33KMLcK6e
         j1/oiH9IefTcvuGVlwxdlUOCd8tihBmbhXvfH0oAnAoxnKZopnAQ93Jh+g8tEZLj5XqT
         SZrw==
X-Gm-Message-State: AOAM532f/rnCvnGBr0JfdLbiIsJtlIxdJXKC4NlfsUJdfg5CnBOg7s4W
        rT3zfE/zuiiZeH7nndtx7zLBZ4ZmETC1uT1q8sYaQw==
X-Google-Smtp-Source: ABdhPJz2GMuQe7wuvwAFqtljOdlhB13pj8DuBvSYYa+MfVPXYTe4bFpaYDD8qV7ftJAPZyST4UE/U4fKDFF4749vGSk=
X-Received: by 2002:a2e:a404:: with SMTP id p4mr10657312ljn.420.1606768046555;
 Mon, 30 Nov 2020 12:27:26 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAST0Ma4bGGOA_HATzYAmRhZG=x_X=8p_9dKGX7bYc2FMA@mail.gmail.com>
 <20201104005343.4192504-1-ndesaulniers@google.com> <20201104005343.4192504-4-ndesaulniers@google.com>
 <CAK7LNAT5MQqUddv+QbFu5ToLBK3eUPArHSBR=5AOS3ONtMqKaw@mail.gmail.com>
In-Reply-To: <CAK7LNAT5MQqUddv+QbFu5ToLBK3eUPArHSBR=5AOS3ONtMqKaw@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 30 Nov 2020 12:27:14 -0800
Message-ID: <CAFP8O3Ki9HoqcV450fn29fBOWAbmuGAdB6USLz8pGsW4Vzf7sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Kbuild: make DWARF version a choice
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:05 AM Masahiro Yamada <masahiroy@kernel.org> wro=
te:
>
> On Wed, Nov 4, 2020 at 9:53 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> > explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> > way that's forward compatible with existing configs, and makes adding
> > future versions more straightforward.
> >
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile          | 14 ++++++++------
> >  lib/Kconfig.debug | 19 +++++++++++++++----
> >  2 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 75b1a3dcbf30..e23786a4c1c7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -826,12 +826,14 @@ else
> >  DEBUG_CFLAGS   +=3D -g
> >  endif
> >
> > -ifndef LLVM_IAS
> > -KBUILD_AFLAGS  +=3D -Wa,-gdwarf-2
> > -endif
> > -
> > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > -DEBUG_CFLAGS   +=3D -gdwarf-4
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) :=3D 2
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) :=3D 4
> > +DEBUG_CFLAGS   +=3D -gdwarf-$(dwarf-version-y)
> > +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
> > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > +dwarf-aflag    :=3D $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-versio=
n-y))
> > +DEBUG_CFLAGS   +=3D $(dwarf-aflag)
>
> This changes the behavior.
>
> For the Dwarf-2 case,
>
> Previously, -gdwarf-2 was passed to $(CC),
> so the debug info was generated by gcc.
>
> Now, -Wa,-gdwarf-2 is passed to $(CC).
> -gdwarf-2 is handled by GNU as.
> So, the source info points to /tmp/<hash>.s
> instead of the original .c file.
>
>
>
> Handling the Dwarf capability is very complicated.
>
> Are you still working for v3?
>
>
>
> > +KBUILD_AFLAGS  +=3D $(dwarf-aflag)
> >  endif
> >
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 83a860126897..03c494eefabd 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -256,14 +256,25 @@ config DEBUG_INFO_SPLIT
> >           to know about the .dwo files and include them.
> >           Incompatible with older versions of ccache.
> >
> > +choice
> > +       prompt "DWARF version"
> > +       help
> > +         Which version of DWARF debug info to emit.
> > +
> > +config DEBUG_INFO_DWARF2
> > +       bool "Generate DWARF v2 debuginfo"
> > +       help
> > +         Generate DWARF v2 debug info.
> > +
> >  config DEBUG_INFO_DWARF4
> >         bool "Generate dwarf4 debuginfo"
> >         depends on $(cc-option,-gdwarf-4)
> >         help
> > -         Generate dwarf4 debug info. This requires recent versions
> > -         of gcc and gdb. It makes the debug information larger.
> > -         But it significantly improves the success of resolving
> > -         variables in gdb on optimized code.
> > +         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb =
7.0+.
> > +         It makes the debug information larger, but it significantly
> > +         improves the success of resolving variables in gdb on optimiz=
ed code.
> > +
> > +endchoice # "DWARF version"
> >
> >  config DEBUG_INFO_BTF
> >         bool "Generate BTF typeinfo"
> > --
> > 2.29.1.341.ge80a0c044ae-goog


We can bump -Wa,-gdwarf-2 to -Wa,-gdwarf-3 since GNU actually emits
DWARF v3 DW_AT_ranges (see
https://sourceware.org/bugzilla/show_bug.cgi?id=3D26850 )
This can avoid the `warning: DWARF2 only supports one section per
compilation unit` warning for Clang.

Deleting -Wa,-gdwarf-2 also sounds good to me if people can verify
their debugging experience is not regressed (I believe it is useless).


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
