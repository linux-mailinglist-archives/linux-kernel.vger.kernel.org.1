Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8926A40F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIOLXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIOLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:18:37 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F04C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:18:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c13so3407004oiy.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsszHnIr30DAX2BPN/LLCsGS7XfGFhrJzeIuxHrcQeU=;
        b=CBedkHDFIyVGiS3Lx+LWTTvlrVQleDAbgic65e4G96FygTtFkMq914TzMOizRIfuPu
         VCbrwdf+0Q2W/F6W7QKym3P+PeHZw6YQMv459vgtmYNXak396wDwGu+380xAhvQTTE8g
         cWAhxwGXZy9JeRgQPKzXzVW0Ui5AKbuSNXqrDhdPEdIWztw6jdLvOBnhnCGTgBz7ggsZ
         PNDCgLnt2yO51Qj7Jjvh3lTiGwqUVWZRI0yi/SjHdL6/cmqNRv/6Cj9p0MsPaaMHwvdU
         1UD8hq2A8HEs9bROX2DjA+jGrSF1AbVbsvsoY/jZ6vh2Ph2wC0uBgAwS7gblNOLHA+PZ
         ZHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsszHnIr30DAX2BPN/LLCsGS7XfGFhrJzeIuxHrcQeU=;
        b=hc14dBEn7yjJ9pze5ivvUGXABmGdQzj2JRxrkSU02DcHmWbLbqAHCAtBEzVvDZTDE9
         acqlc5yczaY7J/LIiEASp6akH/j/0I6O1nlHtoNdTpDF3NXbNIZfOupMuEr01u/Eb5rn
         K2mPEEya17ruEIebogqYlb2ifd3TymJTJ2KIh/ynOUyQkf7xYUs3i1qDFv0Kjp5nCzwE
         XxAVSsMGgGdFQnmfM5aJKKvGikxJkJDwnEW+S1ricPdhHy0MpTjSvxM2W4Znqfw+zWG+
         OsI8YsIA3Zl8+zpfCeivejUX3jEx45/9YKPlQeUurrOWs7qq44blVghAwxPsJlRU6anS
         bEow==
X-Gm-Message-State: AOAM530eaEzM9hkXutY2NUfnLet2vFegnV/nisQHHxeqqycH7TTN6Kpv
        SO7SNGBrEP5keySUIZ/9G7MAGCvzTlPXYGgpTiA6IQ==
X-Google-Smtp-Source: ABdhPJxxyr3+yo6yQC3hYUIK/C90MlSgyTKxpkX4r5dqGfnI8B0pV1KvA3KhUXz1Pv6WLnJNX2Q1yKRy1KUwXPG9yYM=
X-Received: by 2002:aca:54d1:: with SMTP id i200mr2939948oib.172.1600168702680;
 Tue, 15 Sep 2020 04:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com> <202009141509.CDDC8C8@keescook>
 <20200915102458.GA1650630@google.com>
In-Reply-To: <20200915102458.GA1650630@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Sep 2020 13:18:11 +0200
Message-ID: <CANpmjNOTcS_vvZ1swh1iHYaRbTvGKnPAe4Q2DpR1MGhk_oZDeA@mail.gmail.com>
Subject: Re: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
To:     George Popescu <georgepope@google.com>
Cc:     Kees Cook <keescook@chromium.org>, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 12:25, George Popescu <georgepope@google.com> wrote:
> On Mon, Sep 14, 2020 at 03:13:14PM -0700, Kees Cook wrote:
> > On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> > > From: George Popescu <georgepope@google.com>
> > >
> > > When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> > > the handler call, preventing it from printing any information processed
> > > inside the buffer.
> > > For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> > > -fsanitize=local-bounds, and the latter adds a brk after the handler
> > > call
> >
> > That sounds like a compiler bug?

> Actually in clang 12 documentation is written that -fsanitize=bounds
> expands to that. GCC  doesn't have those two options, only the
> -fsanitize=bounds which looks similar to -fsanitize=array-bounds from
> clang. So I don't see it as a compiler bug, just a misuse of flags.

Clang just allows to be more selective, but ultimately we want to
cover as many bug-classes as possible. There is little point in giving
up checks with Clang just because GCC doesn't implement them. If there
are other valid reasons to give it up, that's fine, but so far it
seems we never ran into the issue you ran into -- which is also a bit
odd, because I do see in the instrumentation passes that
fsanitize=bounds emits traps sometimes.

[...]
> > >  ifdef CONFIG_UBSAN_BOUNDS
> > > -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> > > +      # For Clang -fsanitize=bounds translates to -fsanitize=array-bounds and
> > > +      # -fsanitize=local-bounds; the latter adds a brk right after the
> > > +      # handler is called.
> > > +      ifdef CONFIG_CC_IS_CLANG
> > > +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=array-bounds)
> >
> > This would mean losing the local-bounds coverage? Isn't that for locally
> > defined arrays on the stack?

> This would mean losing the local-bounds coverage. I tried to  test it without
> local-bounds and with a locally defined array on the stack and it works fine
> (the handler is called and the error reported). For me it feels like
> --array-bounds and --local-bounds are triggered for the same type of
> undefined_behaviours but they are handling them different.

Does -fno-sanitize-trap=bounds help?

Thanks,
-- Marco
