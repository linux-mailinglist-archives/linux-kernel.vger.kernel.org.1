Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A126D22C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQESC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQESA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:18:00 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 00:18:00 EDT
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D90C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 21:11:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f18so377408pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmyX2VLobpv/xATMsYUo+l7NUXTBFoGrvmN52O6thLs=;
        b=lcsH9qwkyJ9NoFMQZlnkNjj8icmjbwz2Lc3VTP1SatT/qhvQBMfjwxWVerrHHnmqGv
         U6UH3hb4CGk+qrClM0i7mFJyoJ7oFIByfOVwufro+2Uegyav6IcbCpBplMPD+0WbfkRm
         z9USYGNAsrPerw+7O0X0gJ+E/S38dYgJqNgaKXtpQs4iGmZIeo9TXoxqa8aVDQbfsv5Z
         6TCylw4A4/X9jgG8bZKiQGp/I1zR6KylvW0DpSo6hFtMc9Zt3qeMIrsOTxmyLzYWdA/M
         glK9aTgFgIclXpwlV7LjLai7h6Q1cT+Gk6zBF+06rnoHd2xDdsaTfcvKH3g5iheWEiu9
         Y6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmyX2VLobpv/xATMsYUo+l7NUXTBFoGrvmN52O6thLs=;
        b=lb0uufc4VuE2W7clDfYl1k5EIhQGHdGdK7HNV2uwTEsjHbi6zXIsHHTYsJFuqFvYNg
         CIEpToE0cqXzrM+w6pN3ZRBfGgHBZvYw8Q9FN0hVJ3e+lfE6keQXYCNwuD1eXn+eaKxG
         DY6uWCsFzX1DHe91e5G6mH1y6+ERBhKPObwjGWwfRicI5S4GP8Kd4QTCBAK6ThhVB6A8
         d4X0Z3NTOAMF8G3BDmvROQ4VKNI8eDX9UjZj9bvbuzibUnsZdb8BJMqR+5BwVhVwLK92
         VKlJud8fXJsqciUzbY5l1V8Bkt0kPhVUrFSS13eeUUBV8/67KBbE35vy6u1TPzXjgmlg
         ZjQg==
X-Gm-Message-State: AOAM532Q0zt9y6CMYryTmkBpI2pRZTk8oiCaPdw5qb5gmclS8eg+igQU
        zklWwEpa6/z0B3X/AlA45YyNdA==
X-Google-Smtp-Source: ABdhPJxlOP9vclvqlo+8plR7qtECxlulAMgiD3ZAGtc1DTH4EGK2UkV+X0Viir4pahu7OAtKoxw6Qw==
X-Received: by 2002:a63:5f87:: with SMTP id t129mr2413690pgb.288.1600315914506;
        Wed, 16 Sep 2020 21:11:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id a13sm15937462pgq.41.2020.09.16.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 21:11:53 -0700 (PDT)
Date:   Wed, 16 Sep 2020 21:11:50 -0700
From:   Fangrui Song <maskray@google.com>
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200917041150.3xfmi5pqyd7qm2fg@google.com>
References: <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net>
 <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
 <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
 <CANpmjNPGZnwJVN6ZuBiRUocGPp8c3rnx1v7iGfYna9t8c3ty0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANpmjNPGZnwJVN6ZuBiRUocGPp8c3rnx1v7iGfYna9t8c3ty0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16, 'Marco Elver' via Clang Built Linux wrote:
>On Wed, 16 Sep 2020 at 20:22, 'Nick Desaulniers' via kasan-dev
><kasan-dev@googlegroups.com> wrote:
>>
>> On Wed, Sep 16, 2020 at 1:46 AM Marco Elver <elver@google.com> wrote:
>> >
>> > On Wed, 16 Sep 2020 at 10:30, <peterz@infradead.org> wrote:
>> > > On Tue, Sep 15, 2020 at 08:09:16PM +0200, Marco Elver wrote:
>> > > > On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> > > > > On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
>> > >
>> > > > > > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
>> > > > > > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
>> > > > > > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
>> > > > > > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
>> > > > > > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
>> > > > > > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
>> > > >
>> > > > This one also appears with Clang 11. This is new I think because we
>> > > > started emitting ASAN ctors for globals redzone initialization.
>> > > >
>> > > > I think we really do not care about precise stack frames in these
>> > > > compiler-generated functions. So, would it be reasonable to make
>> > > > objtool ignore all *san.module_ctor and *san.module_dtor functions (we
>> > > > have them for ASAN, TSAN, MSAN)?
>> > >
>> > > The thing is, if objtool cannot follow, it cannot generate ORC data and
>> > > our unwinder cannot unwind through the instrumentation, and that is a
>> > > fail.
>> > >
>> > > Or am I missing something here?
>> >
>> > They aren't about the actual instrumentation. The warnings are about
>> > module_ctor/module_dtor functions which are compiler-generated, and
>> > these are only called on initialization/destruction (dtors only for
>> > modules I guess).
>> >
>> > E.g. for KASAN it's the calls to __asan_register_globals that are
>> > called from asan.module_ctor. For KCSAN the tsan.module_ctor is
>> > effectively a noop (because __tsan_init() is a noop), so it really
>> > doesn't matter much.
>> >
>> > Is my assumption correct that the only effect would be if something
>> > called by them fails, we just don't see the full stack trace? I think
>> > we can live with that, there are only few central places that deal
>> > with ctors/dtors (do_ctors(), ...?).
>> >
>> > The "real" fix would be to teach the compilers about "frame pointer
>> > save/setup" for generated functions, but I don't think that's
>> > realistic.
>>
>> So this has come up before, specifically in the context of gcov:
>> https://github.com/ClangBuiltLinux/linux/issues/955.
>>
>> I looked into this a bit, and IIRC, the issue was that compiler
>> generated functions aren't very good about keeping track of whether
>> they should or should not emit framepointer setup/teardown
>> prolog/epilogs.  In LLVM's IR, -fno-omit-frame-pointer gets attached
>> to every function as a function level attribute.
>> https://godbolt.org/z/fcn9c6 ("frame-pointer"="all").
>>
>> There were some recent LLVM patches for BTI (arm64) that made some BTI
>> related command line flags module level attributes, which I thought
>> was interesting; I was wondering last night if -fno-omit-frame-pointer
>> and maybe even the level of stack protector should be?  I guess LTO
>> would complicate things; not sure it would be good to merge modules
>> with different attributes; I'm not sure how that's handled today in
>> LLVM.
>>
>> Basically, when the compiler is synthesizing a new function
>> definition, it should check whether a frame pointer should be emitted
>> or not.  We could do that today by maybe scanning all other function
>> definitions for the presence of "frame-pointer"="all" fn attr,
>> breaking early if we find one, and emitting the frame pointer setup in
>> that case.  Though I guess it's "frame-pointer"="none" otherwise, so
>> maybe checking any other fn def would be fine; I don't see any C fn
>> attr's that allow you to keep frame pointers or not.  What's tricky is
>> that the front end flag was resolved much earlier than where this code
>> gets generated, so it would need to look for traces that the flag ever
>> existed, which sounds brittle on paper to me.
>
>Thanks for the summary -- yeah, that was my suspicion, that some
>attribute was being lost somewhere. And I think if we generalize this,
>and don't just try to attach "frame-pointer" attr to the function, we
>probably also solve the BTI issue that Mark still pointed out with
>these module_ctor/dtors.
>
>I was trying to see if there was a generic way to attach all the
>common attributes to the function generated here:
>https://github.com/llvm/llvm-project/blob/master/llvm/lib/Transforms/Utils/ModuleUtils.cpp#L122
>-- but we probably can't attach all attributes, and need to remove a
>bunch of them again like the sanitizers (or alternatively just select
>the ones we need). But, I'm still digging for the function that
>attaches all the common attributes...
>
>Thanks,
>-- Marco

Speaking of gcov, do people know whether frame pointers in
kernel's libgcov implementation help?

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94394 "random kernel panic during collecting kernel code coverage"
