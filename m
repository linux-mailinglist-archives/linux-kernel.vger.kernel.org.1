Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0626C88B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgIPSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIPSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:51:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:51:48 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y6so9285642oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+WHdAVlCFgmzmA4En+naGrx650M8JLZGe/WluGaEDs=;
        b=lj8dJnoA3xrSJ2YBKPebVeeBuv89rqEEAsJtRfCnSao4HUrQ647gf4uFB71PVkEjZ0
         +uo8TD1tORNtVjfcLbsDg889wC/fklYOQeiKxQb/2g/PUMW3oM0SBP/qPDSo5wl+8hso
         C5Uo6PP5phCYAMl8hjnD0M3H9ptqzMQgQqZFKzvaal8Lp427RDvKq+OspHo+5XkTkY91
         4iqw0vQSJ2VsBdGA7brjhfL07/VByMJR/08I/5yszf7dQiQLj1yKRCK2OI/Gtjzkr2c3
         4hd5A65XlHbZRaN/2YNrkFFLX2J9e4Vdy5JfiY+Es6STemIfptY2rum2eHcvpqKIQpnN
         NcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+WHdAVlCFgmzmA4En+naGrx650M8JLZGe/WluGaEDs=;
        b=cGdNqn+0RKZDsjEB7+INs2aFg6HtSwgMN6K6CVKZSrWnM05JxyhM2AEIyyTQmGhyNu
         q+E24YMs8FiDI67bbCN1c/pll+LHxFjz0z5RQXcRDqNgz+63udrcvux4qKmoh0r2EuU3
         1ThtrtZiOdxQNGNiFFgreZxPXlO3R/hgAgO5+1KkQZOmNu/pDSmiuU8OKDGsSfc5q3m2
         q28048UUFV/xu/3jQHebRKQRxS0gklorqfD5mPELutvVEXOSjfd2CbZJtSla0+IMu3lA
         WpSbvWdrvbLYToMQ4YSLUVvg+VAwI5++/P1/I1iVhlktd2eCR2Wa4RpUvS9iYdUlK9pZ
         cm9A==
X-Gm-Message-State: AOAM533+Y/itFIYKR7zlqPN2a0v2KQF+kBEytemKmg1XtRj1QiVgDDyh
        JEuUuh7nAFJ+mVgN5dj8AjfL7CLsWqacdwlxgGIQng==
X-Google-Smtp-Source: ABdhPJzhuvO7yNgPrTDT6VpAG/zR7iHLn6cCqd/OuSH+J9o8HT1uf/R/59XVFXUzFHxnx5ZILymDYAZstZk2k/RHNKk=
X-Received: by 2002:aca:3d07:: with SMTP id k7mr2932773oia.172.1600282306393;
 Wed, 16 Sep 2020 11:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net> <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
 <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 20:51:34 +0200
Message-ID: <CANpmjNPGZnwJVN6ZuBiRUocGPp8c3rnx1v7iGfYna9t8c3ty0w@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Nick Desaulniers <ndesaulniers@google.com>
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
        Daniel Kiss <daniel.kiss@arm.com>, momchil.velikov@arm.com,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 20:22, 'Nick Desaulniers' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Wed, Sep 16, 2020 at 1:46 AM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 16 Sep 2020 at 10:30, <peterz@infradead.org> wrote:
> > > On Tue, Sep 15, 2020 at 08:09:16PM +0200, Marco Elver wrote:
> > > > On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > > > > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > > > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > > > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > > > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > >
> > > > This one also appears with Clang 11. This is new I think because we
> > > > started emitting ASAN ctors for globals redzone initialization.
> > > >
> > > > I think we really do not care about precise stack frames in these
> > > > compiler-generated functions. So, would it be reasonable to make
> > > > objtool ignore all *san.module_ctor and *san.module_dtor functions (we
> > > > have them for ASAN, TSAN, MSAN)?
> > >
> > > The thing is, if objtool cannot follow, it cannot generate ORC data and
> > > our unwinder cannot unwind through the instrumentation, and that is a
> > > fail.
> > >
> > > Or am I missing something here?
> >
> > They aren't about the actual instrumentation. The warnings are about
> > module_ctor/module_dtor functions which are compiler-generated, and
> > these are only called on initialization/destruction (dtors only for
> > modules I guess).
> >
> > E.g. for KASAN it's the calls to __asan_register_globals that are
> > called from asan.module_ctor. For KCSAN the tsan.module_ctor is
> > effectively a noop (because __tsan_init() is a noop), so it really
> > doesn't matter much.
> >
> > Is my assumption correct that the only effect would be if something
> > called by them fails, we just don't see the full stack trace? I think
> > we can live with that, there are only few central places that deal
> > with ctors/dtors (do_ctors(), ...?).
> >
> > The "real" fix would be to teach the compilers about "frame pointer
> > save/setup" for generated functions, but I don't think that's
> > realistic.
>
> So this has come up before, specifically in the context of gcov:
> https://github.com/ClangBuiltLinux/linux/issues/955.
>
> I looked into this a bit, and IIRC, the issue was that compiler
> generated functions aren't very good about keeping track of whether
> they should or should not emit framepointer setup/teardown
> prolog/epilogs.  In LLVM's IR, -fno-omit-frame-pointer gets attached
> to every function as a function level attribute.
> https://godbolt.org/z/fcn9c6 ("frame-pointer"="all").
>
> There were some recent LLVM patches for BTI (arm64) that made some BTI
> related command line flags module level attributes, which I thought
> was interesting; I was wondering last night if -fno-omit-frame-pointer
> and maybe even the level of stack protector should be?  I guess LTO
> would complicate things; not sure it would be good to merge modules
> with different attributes; I'm not sure how that's handled today in
> LLVM.
>
> Basically, when the compiler is synthesizing a new function
> definition, it should check whether a frame pointer should be emitted
> or not.  We could do that today by maybe scanning all other function
> definitions for the presence of "frame-pointer"="all" fn attr,
> breaking early if we find one, and emitting the frame pointer setup in
> that case.  Though I guess it's "frame-pointer"="none" otherwise, so
> maybe checking any other fn def would be fine; I don't see any C fn
> attr's that allow you to keep frame pointers or not.  What's tricky is
> that the front end flag was resolved much earlier than where this code
> gets generated, so it would need to look for traces that the flag ever
> existed, which sounds brittle on paper to me.

Thanks for the summary -- yeah, that was my suspicion, that some
attribute was being lost somewhere. And I think if we generalize this,
and don't just try to attach "frame-pointer" attr to the function, we
probably also solve the BTI issue that Mark still pointed out with
these module_ctor/dtors.

I was trying to see if there was a generic way to attach all the
common attributes to the function generated here:
https://github.com/llvm/llvm-project/blob/master/llvm/lib/Transforms/Utils/ModuleUtils.cpp#L122
-- but we probably can't attach all attributes, and need to remove a
bunch of them again like the sanitizers (or alternatively just select
the ones we need). But, I'm still digging for the function that
attaches all the common attributes...

Thanks,
-- Marco
