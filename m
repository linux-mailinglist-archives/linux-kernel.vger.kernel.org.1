Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6272D5853
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgLJKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgLJKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:36:06 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72637C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:35:25 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id q25so4381673otn.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RukmWBs4EfbLw0LKaTCMp0B3EXWkv2oBBxKfL580zU=;
        b=uDiLP1wYcE9UmvvTYXhC5JIDwo+LQWZeD2fr5epM0u9E1IzSNpg1NPLfZ9TVwwXKwF
         1BSJIxzxoztwnyKZl99AqGJXlcHHqC2fs6ErngxFlCT3uolFecw7Sxuhl90u9tKiEGa1
         PLT0TZuLiKogwqtmNiNjCaBREwkn+01EwN51r1G9aEnRP7AxbO9WRPxFtb7swsVTBD/Y
         iTUJ5Zk6zgH9vrGPP4ArGCUfYXYh+frIM5l3RH+ZB2Gj21tNYS5Zy+zrFUdMylfodxxp
         PEaI6ElWWSyh33x/5X2+IUpnMnYpTw2njb2YreHN8RPpxVjTpTUbdxbh+tBrwRrrFNnU
         I06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RukmWBs4EfbLw0LKaTCMp0B3EXWkv2oBBxKfL580zU=;
        b=TyHhGn3BuRz7mXvTZ8i5RlvXTC+HUcbDH7lm3N/BCpfY/C16fpfhySUlc0vE/DwoUB
         sYIv5iAYjQtcMpEDgYyM+W85evHdSZAaFilQlIFOSQCB4HBXswhx1MfmNz9yrB8EvRMn
         bXxvilV7z4An2+0DDlHHy/N4K3MtIi4mC5XqyoTCtqr6N0g4wpPey39f5D09nmKnC8Ty
         jpsrukFGDTn+dI0CDplE81UuYWAsPNhxGWsS5nMAJjhoV4/KhFF4rxmRSYXvv8PzJlic
         hNvoHxT2uUhG4DtUhQqzb7NtzvGK9Cy8DBWFeYOz/l1I921mLw0pqW6QqEFkkLWyurrz
         Ak2Q==
X-Gm-Message-State: AOAM531wSpqZ0wVweyD3I5I5MvsjIh8eI71Tm6AZea1MLOKZfDK1Wzk/
        zkq97HfHg5aEti5P9HktmPGU8t4R6sxzNw+XVHjhww==
X-Google-Smtp-Source: ABdhPJycKdjKTL2dh65CQcw/pTA/yRKXlCjFRKiP5WuAvGLF+seANJig67Ue6XexBob1Bj00O9+g7tyJ/jNyCtJvlwo=
X-Received: by 2002:a9d:6199:: with SMTP id g25mr5221108otk.17.1607596524684;
 Thu, 10 Dec 2020 02:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
 <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
In-Reply-To: <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Dec 2020 11:35:11 +0100
Message-ID: <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 11:21, Marco Elver <elver@google.com> wrote:
> On Tue, 1 Dec 2020 at 21:00, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Tue, Dec 1, 2020 at 7:21 AM Marco Elver <elver@google.com> wrote:
> > > The C11 _Static_assert() keyword may be used at module scope, and we
> > > need to teach genksyms about it to not abort with an error. We currently
> > > have a growing number of static_assert() (but also direct usage of
> > > _Static_assert()) users at module scope:
> > >
> > >         git grep -E '^_Static_assert\(|^static_assert\(' | grep -v '^tools' | wc -l
> > >         135
> > >
> > > More recently, when enabling CONFIG_MODVERSIONS with CONFIG_KCSAN, we
> > > observe a number of warnings:
> > >
> > >         WARNING: modpost: EXPORT symbol "<..all kcsan symbols..>" [vmlinux] [...]
> > >
> > > When running a preprocessed source through 'genksyms -w' a number of
> > > syntax errors point at usage of static_assert()s. In the case of
> > > kernel/kcsan/encoding.h, new static_assert()s had been introduced which
> > > used expressions that appear to cause genksyms to not even be able to
> > > recover from the syntax error gracefully (as it appears was the case
> > > previously).
> > >
> > > Therefore, make genksyms ignore all _Static_assert() and the contained
> > > expression. With the fix, usage of _Static_assert() no longer cause
> > > "syntax error" all over the kernel, and the above modpost warnings for
> > > KCSAN are gone, too.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Ah, genksyms...if only there were a library that we could use to parse
> > C code...:P
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Which tree would this go into?
>
> It'd be good if this problem could be fixed for 5.11.

[+Cc everyone returned by 'get_maintainers.pl scripts/genksyms']

It looks like there's no clear MAINTAINER for this. :-/
It'd still be good to fix this for 5.11.

Thanks,
-- Marco
