Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138C26C879
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIPSu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgIPSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:22:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BBFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:22:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k13so3639039plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4+iKrUyandKRtKRuuCLFiJQwudPWpGc6jdXc33Pspo=;
        b=uaTByqfCsUMo8FMT0PNRX4i1IRe4HkN132nFE+RceVu4vFVrRVf9xOkEYpQpLHzh8D
         QFnJqR4JiXXY4J51F2cmSCK2q9n/H4Ib8BdauCd5rdDAc+NPUbDdLtzrCZUhuy0LZNLg
         7W4lfxBfDT5shWBzO4EgsV+FDNCKhJbBnM4LCU7lfHsEP2afKa5PPNOpc9lFJsNtIwYN
         zKt/N/DoZmMAsdEZyAgA1hL+NlXeWeJLO2D4xtRG9qufBH6z9G2t7QYNLSzeVtR7QXuS
         2qh20qXdF9SwJMmtZK/CjSACyU1YjROTHzDcRZngr9TroYcTMawgIqYR0IR/ufMAGTzq
         ApuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4+iKrUyandKRtKRuuCLFiJQwudPWpGc6jdXc33Pspo=;
        b=TldlkCAU7JbuKMv/p/q5H0ICs9cXum+9U6xZO/N+Rkb8p50O2HW+XqvBWnPAR8P2ga
         g1Ok/sImcuAEaThgtDISgXHTEh1JZ00eB7+hhEcjEqugOCfUPRn/VRf4/UHZSbaFrcLG
         0k9YhU1ICSOBCMaOaTB8lOcDKVPSZjusLiZrPeDy0EWnG0YxijXs0xqO1Wj/YU+Bnl6s
         +bfh2foQfJFreF6mKZYHXhKr1f6xDQnlxNGB7qXMOT0BV+s5vdmmRk63g9Kc9JaiCnve
         U9QWAmMnbgyrhOE5OxL+B02Cru7wXeFnzolzxIQyD8Fj4IrgSUoEKeYKHiPjbof3UvE7
         Zcsg==
X-Gm-Message-State: AOAM531ZDxiGvp/oiq7NMOOHQK5j4te1LoLL7aVazbuEymC1oYzgoQYs
        KJrwVRsziyLEb0NJ7FdC6WKA0zLkvGwkJyPowkuoyA==
X-Google-Smtp-Source: ABdhPJxk8tl1AP0cQ7ebkBwwyeBvjbhzxjlgn5J1mf2qh7/EgT/XpqPEnHQwwc7j/X2xrUF0jUNM4DAXf+ViZ7edTkY=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr4866165pjy.25.1600280533846;
 Wed, 16 Sep 2020 11:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net> <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
In-Reply-To: <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Sep 2020 11:22:02 -0700
Message-ID: <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Daniel Kiss <daniel.kiss@arm.com>, momchil.velikov@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:46 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 16 Sep 2020 at 10:30, <peterz@infradead.org> wrote:
> > On Tue, Sep 15, 2020 at 08:09:16PM +0200, Marco Elver wrote:
> > > On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > > > > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > >
> > > This one also appears with Clang 11. This is new I think because we
> > > started emitting ASAN ctors for globals redzone initialization.
> > >
> > > I think we really do not care about precise stack frames in these
> > > compiler-generated functions. So, would it be reasonable to make
> > > objtool ignore all *san.module_ctor and *san.module_dtor functions (we
> > > have them for ASAN, TSAN, MSAN)?
> >
> > The thing is, if objtool cannot follow, it cannot generate ORC data and
> > our unwinder cannot unwind through the instrumentation, and that is a
> > fail.
> >
> > Or am I missing something here?
>
> They aren't about the actual instrumentation. The warnings are about
> module_ctor/module_dtor functions which are compiler-generated, and
> these are only called on initialization/destruction (dtors only for
> modules I guess).
>
> E.g. for KASAN it's the calls to __asan_register_globals that are
> called from asan.module_ctor. For KCSAN the tsan.module_ctor is
> effectively a noop (because __tsan_init() is a noop), so it really
> doesn't matter much.
>
> Is my assumption correct that the only effect would be if something
> called by them fails, we just don't see the full stack trace? I think
> we can live with that, there are only few central places that deal
> with ctors/dtors (do_ctors(), ...?).
>
> The "real" fix would be to teach the compilers about "frame pointer
> save/setup" for generated functions, but I don't think that's
> realistic.

So this has come up before, specifically in the context of gcov:
https://github.com/ClangBuiltLinux/linux/issues/955.

I looked into this a bit, and IIRC, the issue was that compiler
generated functions aren't very good about keeping track of whether
they should or should not emit framepointer setup/teardown
prolog/epilogs.  In LLVM's IR, -fno-omit-frame-pointer gets attached
to every function as a function level attribute.
https://godbolt.org/z/fcn9c6 ("frame-pointer"="all").

There were some recent LLVM patches for BTI (arm64) that made some BTI
related command line flags module level attributes, which I thought
was interesting; I was wondering last night if -fno-omit-frame-pointer
and maybe even the level of stack protector should be?  I guess LTO
would complicate things; not sure it would be good to merge modules
with different attributes; I'm not sure how that's handled today in
LLVM.

Basically, when the compiler is synthesizing a new function
definition, it should check whether a frame pointer should be emitted
or not.  We could do that today by maybe scanning all other function
definitions for the presence of "frame-pointer"="all" fn attr,
breaking early if we find one, and emitting the frame pointer setup in
that case.  Though I guess it's "frame-pointer"="none" otherwise, so
maybe checking any other fn def would be fine; I don't see any C fn
attr's that allow you to keep frame pointers or not.  What's tricky is
that the front end flag was resolved much earlier than where this code
gets generated, so it would need to look for traces that the flag ever
existed, which sounds brittle on paper to me.
-- 
Thanks,
~Nick Desaulniers
