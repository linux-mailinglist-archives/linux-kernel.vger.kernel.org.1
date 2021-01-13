Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70B12F518C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbhAMR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbhAMR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:56:56 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AFBC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:56:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i5so1983826pgo.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdbzlOMYwsTubQgSe6mBoJ6+hia91ZFPU20BGsDFUoQ=;
        b=d9NukwZOoMou7/rHsj7gPGN5tnrgFBWGbUcqD8IZyT4x9BrM6veojZwMNDiCOaZlz2
         Q8qeLlbNuLTeIxN7t5TLoyUqRYpWoj0FQIWdAnoEyZ2/UzYhZ4l1LfjHUeLlHM6Sei0E
         fItQTja5+rFXADf+CYgW3mBXY6sKqJvPYVouZGtGwMH1jhXDvYgyTq7Iv+O9QyGk0VJ/
         9mDpqGev6Z8W+5q0XKk9YY+/waeUBtRVUKJBbt4OzV70+d4gZCxWgRfZnuUvMeAgCwJy
         I11mFYSd/05W8sHCKx5XkTr0MF/c0u2lGWEyw0V0bMClNM+LEc0tPLtWOAVZvzghFdu+
         MQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdbzlOMYwsTubQgSe6mBoJ6+hia91ZFPU20BGsDFUoQ=;
        b=fgaCY3pogmDtCO9M5d9VUnFFsaGGh+plIR4QIBMQhf0M/QeGMQSi/50zgz+J740JJ+
         6IjHdoexAMOEFcUdJmF32g449OPgQTR24OGY1bWr2P7LdHTjoH1y0+0nFv9SH2o450lX
         ADeG8Qvj44sX/+W270XLK7nzzVik/NqiDvwgk6szXM7ZkLKNvNHdnsf0YjrIWGVgaiLA
         OdUhfRwudHJ5HhP/HW6nvSPOKTT4SfKul1cunlr9wYYR60HyxdbvF493Q4nJmrmDal7O
         UMWU4E5LXffU5yrxjvDplbgsNsMpwN+cNBR3u3E2xF0qhLbHvt1QSft/n2wMlztvgDXN
         RsxQ==
X-Gm-Message-State: AOAM533yjDCbgYuKNCCs3+KbKMdCLl5wmE1IU4FAPawDiK71f0PCo+2Y
        zruRo6OvPAH/5a2PB9BZswboKf4EZClWAQda1s8eyA==
X-Google-Smtp-Source: ABdhPJzM8mVIbU435tuWrbGKPlYhIHXJXKAi5M60RxYtuucg5oIRm1nTZEYGcP4R88CYWYdJC9UkLAXy6IIto5IzEp4=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr3198173pgm.10.1610560575782;
 Wed, 13 Jan 2021 09:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20210112115421.GB13086@zn.tnic> <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk> <20210113165923.acvycpcu5tzksbbi@treble>
In-Reply-To: <20210113165923.acvycpcu5tzksbbi@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jan 2021 09:56:04 -0800
Message-ID: <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
Subject: Re: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Jan 12, 2021 at 09:01:54PM +0000, Mark Brown wrote:
> > On Tue, Jan 12, 2021 at 11:46:24AM -0800, Nick Desaulniers wrote:
> >
> > This:
> >
> > > when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
> > > notes:
> >
> > >   So basically, you can use an .L symbol *inside* a function or a code
> > >   segment, you just can't use the .L symbol to contain the code using a
> > >   SYM_*_START/END annotation pair.
> >
> > is a stronger statement than this:
> >
> > > +  Developers should avoid using local symbol names that are prefixed with
> > > +  ``.L``, as this has special meaning for the assembler; a symbol entry will
> > > +  not be emitted into the symbol table. This can prevent ``objtool`` from
> > > +  generating correct unwind info. Symbols with STB_LOCAL binding may still be
> > > +  used, and ``.L`` prefixed local symbol names are still generally useable
> > > +  within a function, but ``.L`` prefixed local symbol names should not be used
> > > +  to denote the beginning or end of code regions via
> > > +  ``SYM_CODE_START_LOCAL``/``SYM_CODE_END``.
> >
> > and seems more what I'd expect - SYM_FUNC* is also affected for example.
> > Even though other usages are probably not very likely it seems better to
> > keep the stronger statement in case someone comes up with one, and to
> > stop anyone spending time wondering why only SYM_CODE_START_LOCAL is
> > affected.
>
> Agreed, I think the comment is misleading/wrong/unclear in multiple
> ways.  In most cases the use of .L symbols is still fine.  What's no
> longer fine is when they're used to contain code in any kind of
> START/END pair.

Apologies, that was not my intention.  I've sent a follow up in
https://lore.kernel.org/lkml/20210113174620.958429-1-ndesaulniers@google.com/T/#u
since BP picked up v3 in tip x86/entry:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/entry&id=bde718b7e154afc99e1956b18a848401ce8e1f8e

-- 
Thanks,
~Nick Desaulniers
