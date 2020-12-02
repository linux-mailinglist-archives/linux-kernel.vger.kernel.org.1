Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF92CCA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbgLBXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:13:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C78C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:12:57 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so6050pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9jFBwpHjkjyo4ON7zUJq2rQs7RnEAe0e25us37bEaw=;
        b=exzlbbkaw56WbUsNK/eHHzFl8U9wTTNchC8o6x9JHbIH1rQFaYFF22hWzycxg1xxVI
         aQ1hKL8u3RFzKE6lA3RYT9MwPRZwLkjyPegGh7T/5McSDDYQElKyQ33cOapjMU/hNuj3
         ybTkjxVQEgZhNcWdX3QxJTyAOk8FCeKe5vv/PZtLpcv3VupcLn/3pU1aexs5E64wUEvM
         VgdUH1BcvMWeWTzOcGlWZjR4l+qK9UMztipccXMzF5CyYRFC1lgyl7uL2L19hegHtxAm
         Y++vCdnGgkQYVB3SxyfZA1Z7qEMW+RPfMmG/k2/LL9+KfLiG9YaU+0adYuS7n7mYhD8A
         pPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9jFBwpHjkjyo4ON7zUJq2rQs7RnEAe0e25us37bEaw=;
        b=qzOx0EBw2osEFBy/C6ETUs6Q3hKFhqC+vvPR898KcmHfppc5WwFWSp48cTU+uIEcpo
         ivIAjlsZIvy6s+jliKisEq6UKURPjN0M9ittkWef4BPHz4mLmoWZ5U2XYQVhmlbQekvu
         76DTNOD0UQcSBKZpPtF7L59MaM5qBuHcHR0p0ZJEz+n8ICCpyjfQZaxKpqCZVZRLOeaE
         +D/YDvTLmFK8H3hSHQ9RyLK6h/EJH/Tg3q3NI6we0reqRtVe9FZO/zaIiY6VKa4C1kDP
         8A7jCb+5To2/jNQw7nhKwbTG0Ty+/KXTyMr1cx9uEJSLx8YUToMO8HmD02fMpPZH/PYx
         ePgA==
X-Gm-Message-State: AOAM533wKTGnk90845MMce6Y21dgVaSGiQ1pTKl4+cpGbnnNDc+KaPq0
        qWS9R3+WOlpZ7go471hPWCIACJTMwuBJOruTrHKDLg==
X-Google-Smtp-Source: ABdhPJxcjV4ywb3gx45tNhBGfWVwO1w2o1UKf0CTm2YylEz+tPKF6+CHVGu/enwaRsReTLo/JKSf2eJvdIua4HudhBM=
X-Received: by 2002:a63:8f4f:: with SMTP id r15mr488662pgn.381.1606950776375;
 Wed, 02 Dec 2020 15:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20201201032748.486928-1-masahiroy@kernel.org> <CAK7LNAR+rWTku5Lz+by3vEzsWNsdOpO30phkdwCvzJf28aXiUw@mail.gmail.com>
In-Reply-To: <CAK7LNAR+rWTku5Lz+by3vEzsWNsdOpO30phkdwCvzJf28aXiUw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Dec 2020 15:12:44 -0800
Message-ID: <CAKwvOdnRDC8tYx4H4ueTv44-+rdwevv+PNyEifzUcjqOjQTA8w@mail.gmail.com>
Subject: Re: [PATCH] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 7:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Dec 1, 2020 at 12:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> >
> > You can see it at https://godbolt.org/z/6ed1oW

(this link misses -gdwarf-4 for clang, but I think that's ok)

> >
> >   For gcc 4.5.3 pane,    line 37:    .value 0x4
> >   For clang 10.0.1 pane, line 117:   .short 4
> >
> > Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> > version, this cc-option is unneeded.
> >
> > Note
> > ----
> >
> > CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> >
> > As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> >
> >   ifdef CONFIG_DEBUG_INFO_DWARF4
> >   DEBUG_CFLAGS    += -gdwarf-4
> >   endif
> >
> > This flag is used when compiling *.c files.
> >
> > On the other hand, the assembler is always given -gdwarf-2.
> >
> >   KBUILD_AFLAGS   += -Wa,-gdwarf-2
> >
> > Hence, the debug info that comes from *.S files is always DWARF v2.
> > This is simply because GAS supported only -gdwarf-2 for a long time.
> >
> > Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> > And, also we have Clang integrated assembler. So, the debug info
> > for *.S files might be improved if we want.
> >
> > In my understanding, the current code is intentional, not a bug.
> >
> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  lib/Kconfig.debug | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index cb8ef4fd0d02..7f80c25497a1 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
> >
> >  config DEBUG_INFO_DWARF4
> >         bool "Generate dwarf4 debuginfo"
> > -       depends on $(cc-option,-gdwarf-4)
> >         help
> >           Generate dwarf4 debug info. This requires recent versions
> >           of gcc and gdb. It makes the debug information larger.
> > --
> > 2.27.
>
>
> Maybe, this can be squashed into Nick's patch.

I have no preference.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(I'll reroll this into my DWARFv5 series either way, but when/how you
merge this doesn't matter to me)

-- 
Thanks,
~Nick Desaulniers
