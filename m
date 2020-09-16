Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E476E26BF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIPIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIPIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:32:53 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:32:53 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so304594ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gutnwyq/fY1R+B0kj3zMSfdQMIw4d9tjzY6YslUPxq0=;
        b=PS2WB70x9ySf7kxgHgUr09U5FuNJgjvgaH7MMVEi0w25wj+geORkHkwqZc6VzcevOQ
         hCiEAnLVhUXjSlfOS/9LyAWzsln3c5crRxRoQqAuBiTozsIvZrtIZiM8OPXSSAy9Vae7
         OMDs11gtOlkCkG/6Uw/jn9znWaF+uoVU/C8MX31oKa9yxTGAe460K1qfCI8awGr7H8z3
         6k+OgXFK6UAPvAOVBG0ab6JFxnyX6o+ajKqqqNU8mHtleCW4IaanfL2KUVXoPA9N90ZA
         qgRYedd2f9Q0CTxAQi3665Ew2/NkBkKd0kVGjtH4Awdg11uBiQ484d2fJCsAhk4O2Zlx
         Meug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gutnwyq/fY1R+B0kj3zMSfdQMIw4d9tjzY6YslUPxq0=;
        b=NCIVszuu68OZrdON6YF0xs20WlFqtBKF5g+CrtPe7XLa2m66Nc3IejPPrwE662iLAg
         yNYmz7Xvv5WBNPLVS4SsgLJ7HDRqiPRSTPe7RorSlDBhcEeo97X6SQM2sv7bkpt3zOeU
         Ttm0h4xfq9tKaDcGJXXXO9/VJftwN4DMigTjmOx3ZnFD+eMvyhGwcm9+P7FA3GWyYLHA
         2UL38SjwjOR+34S6Hz6GGi2tlJ4SM64cA7J6tdMRSsLQyEN4Dq09dL0R151Q3FNkYWMl
         1YprzbqM4LKUcBb4kLg/hKvsYtPKtc/FpMEySnot04XJD88LmxwfMUOcY0Qdu8FCI88f
         SPMA==
X-Gm-Message-State: AOAM530/gwKu+CSV8gg4g6wfedb3u6I76iy1eFF74tWe7M/OfaLZxarK
        BA/G4kU+X5ZbwfCaTh+F6j0Lg/EekeVHM8bVa7oPdw==
X-Google-Smtp-Source: ABdhPJwe6y4pKih3pRHaHK/yYYM4kOk8WdhzR+Jnvf9pdfuOu3tT6QfG19o4rzngArJRA/kONhSAKRQW+ccjYcRX+jI=
X-Received: by 2002:a05:6830:1e8c:: with SMTP id n12mr16510993otr.17.1600245172173;
 Wed, 16 Sep 2020 01:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com> <202009141509.CDDC8C8@keescook>
 <20200915102458.GA1650630@google.com> <CANpmjNOTcS_vvZ1swh1iHYaRbTvGKnPAe4Q2DpR1MGhk_oZDeA@mail.gmail.com>
 <20200915120105.GA2294884@google.com> <CANpmjNPpq7LfTHYesz2wTVw6Pqv0FQ2gc-vmSB6Mdov+XWPZiw@mail.gmail.com>
 <20200916074027.GA2946587@google.com>
In-Reply-To: <20200916074027.GA2946587@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 10:32:40 +0200
Message-ID: <CANpmjNMT9-a8qKZSvGWBPAb9x9y1DkrZMSvHGq++_TcEv=7AuA@mail.gmail.com>
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
        David Brazdil <dbrazdil@google.com>, broonie@kernel.org,
        Fangrui Song <maskray@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 09:40, George Popescu <georgepope@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 07:32:28PM +0200, Marco Elver wrote:
> > On Tue, 15 Sep 2020 at 14:01, George Popescu <georgepope@google.com> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 01:18:11PM +0200, Marco Elver wrote:
> > > > On Tue, 15 Sep 2020 at 12:25, George Popescu <georgepope@google.com> wrote:
> > > > > On Mon, Sep 14, 2020 at 03:13:14PM -0700, Kees Cook wrote:
> > > > > > On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> > > > > > > From: George Popescu <georgepope@google.com>
> > > > > > >
> > > > > > > When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> > > > > > > the handler call, preventing it from printing any information processed
> > > > > > > inside the buffer.
> > > > > > > For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> > > > > > > -fsanitize=local-bounds, and the latter adds a brk after the handler
> > > > > > > call
> > > > > >
> > > > > This would mean losing the local-bounds coverage. I tried to  test it without
> > > > > local-bounds and with a locally defined array on the stack and it works fine
> > > > > (the handler is called and the error reported). For me it feels like
> > > > > --array-bounds and --local-bounds are triggered for the same type of
> > > > > undefined_behaviours but they are handling them different.
> > > >
> > > > Does -fno-sanitize-trap=bounds help?>
> > >
> > > I tried replacing it with:
> > >       ifdef CONFIG_CC_IS_CLANG
> > >             CFLAGS_UBSAN += $(call cc-option, -fno-sanitize-trap=bounds)
> > >             CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> > >       else
> > >             CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> > >       endif
> > >
> > > The code traps.
> >
> > What's your config? Do you have CONFIG_UBSAN_TRAP=y? If so, you have 2
> > options: honor UBSAN_TRAP and crash the kernel, or have a
> > 'CFLAGS_REMOVE_... = -fsanitize-undefined-trap-on-error' for the files
> > where you can't deal with traps>
>
> I don't have CONFIG_UBSAN_TRAP=y. My .config is:
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_UBSAN_KCOV_BROKEN=y
> CONFIG_UBSAN_MISC=y
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_TEST_UBSAN=m

Your full config would be good, because it includes compiler version etc.
