Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAA26ABA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgIOSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgIOSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:09:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735CC06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:09:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so4091360otb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWsKZVXnxNV86nxwMhidD6aX4g78p96DDVvRBJQ0WvQ=;
        b=YL4lnyzmZd5+He9XW5TWnY6uXC8auCS2LLExUNUuAkOxQ+2OP1B/npG72oPLSORnMe
         5E6S6RhexCskZIWZqzDmFlyEQirknM5bnnFgnJq6c1QczIGd0EvX01F+JOXw/GVrHQGp
         XYNWaXby30pn0LJ8Q3I0a52EMAgGFQRkgxIV+fWOYoKDswruQlsuoGea1OeSU6yCWnB2
         4lyZs9Z2uAnoD4QsjXYXyyUoc7hJjHZ1JC6CH8rpNebS+R5v6b/DC2UsLVuYEV4nQZjl
         d/fYbu3uV2NAjmXsEk6tQ0rYW8z476sFWQpNp0uVmlXR9OyRSqA9FOgbzOD/VoXNTXsu
         gckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWsKZVXnxNV86nxwMhidD6aX4g78p96DDVvRBJQ0WvQ=;
        b=JlwjSFwRvVNQeMWUBoTuzmTDPQjeOM6hM5oZs4ESRHZ+kvZu1CswmXfvpGAAgsAR55
         7CkZOPWoZGjqPjGIYXeN4Ns7qaXW0NhIzDwLGp7J0Lj9ULunRbePwWEM+qLUyfR3+SG2
         ZfjZvMTiuHigp41F3+vi63vpDv/KB5fdz4L8YXuVqTcgAGTF+2Lc0C3+sEE3bxILx3i4
         RWWXsPyZ41oRGfFC4NtcS5yRCS+fiYvdi080eJWFLFAu0fm5bAY+hQpAlc9ku53oirv1
         pWZjAXenUiz3E3DLPk+foSWoyieo+dy5+mXST43z03eEsVXbm/h5MZqJStxASLafesIt
         vQ7w==
X-Gm-Message-State: AOAM5307zpuabnCFCtRBSTOdisKJyp2ejnfk9OiFXnOJ9B/h1aFNX7Hn
        zXN6GWF+3Kx51KyxtoFta6vk+b3JgA2eiqQcZqW+pw==
X-Google-Smtp-Source: ABdhPJyndAh+BoNT5R6UN7ovbelHC+ikcd786zj9o5UnXOwwuI2z5Dn3AmSTqowZkkDFxQuLQPdsBTqoY1Q+fAmzIS0=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr13003629otk.251.1600193367937;
 Tue, 15 Sep 2020 11:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic> <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
In-Reply-To: <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Sep 2020 20:09:16 +0200
Message-ID: <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Sep 15, 2020 at 12:02:48PM -0500, Josh Poimboeuf wrote:
> > > If somebody can share the .o file, I can take a look.
> >
> > If only I could reproduce...
> >
> > So I built:
> >
> > /home/share/src/llvm/tc-build/install/bin/clang-12 --version
> > ClangBuiltLinux clang version 12.0.0 (https://github.com/llvm/llvm-project 74a9c6d7e1c49cd0e3a8e8072b8aa03f7a84caff)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /home/share/src/llvm/tc-build/install/bin
> >
> > and I don't trigger that warning even with that compiler.
> >
> > What I do get is a lot of those pairs:
> >
> > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup

This one also appears with Clang 11. This is new I think because we
started emitting ASAN ctors for globals redzone initialization.

I think we really do not care about precise stack frames in these
compiler-generated functions. So, would it be reasonable to make
objtool ignore all *san.module_ctor and *san.module_dtor functions (we
have them for ASAN, TSAN, MSAN)?

Thanks,
-- Marco
