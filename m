Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00126BFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgIPIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIPIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:46:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24DFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:46:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so5932374otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFHlsqUTp6bF1BGPzUjg3LJj5CvZI8A5XHbHTxJpfjI=;
        b=s3aJCgj3o2+HOyPW2y5oQ6FHm99qHE3quyCn9AiqVXCY29lH7v25P4pV3RaBzYr6tI
         TXsfCsViS30UfmXp9txl1r1XYHoJgUKcr2i0ukFwUOgdjpL8t96JsBVxl1rMyQ7G7TZL
         tz5nog7zbQMP0vGP2MFs1KLVoqnyTD3Qc5KXgpr9B9GZFSRwIDLz3ATpV344qAa5G9u7
         K41LFww87ee6HgxlRrG87o8HJCTj/uJhboUgZozUgkj1oTAyrTJ6hdFoTmTX/QyIvJhi
         t1kUldhN7ncNvR9yn63zkry9G6szzV1kc+pC7ZvAYdJZbhGo8Ta3Lkq8iHsP1qBCUxr+
         MKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFHlsqUTp6bF1BGPzUjg3LJj5CvZI8A5XHbHTxJpfjI=;
        b=I8yNlo6buy1W7wtoD6SWZBpoCM/gb0TTnFPD+yecv6Br5SsKgwmy3NAOjJTAyqqFOy
         cMz0Hc5tXSunVK+/RppcKpMTEnszT8efzdPVy25I9ZKXMO/htKOS1lwWkaK8gIngEIcf
         ub3RI2Fj+gS5IUOD4I32Dktz/zWwTMALIsm5NtP6n3v6bqoyayjPAXzbglbz8R1RwVL2
         Xf1CDQpci4mDD3b1jeetJXS2mAkHIrx+DKEzj57SqZXgzEb/c1dUeACM8/tsGo+pWerN
         Yi1C+ovkYTxvIdqdPuu0CZDZcNB4NQl8Uil/SNaFkNIOQ4J6itLORzuPTrVlItMEU3K6
         ruKA==
X-Gm-Message-State: AOAM531KHQd+q+AyGr4Qv5T+xFA28wJumMsUXo8B50eSsdG2tS9vedka
        IjW4NmUlvu/QTpYOBg1qJwiwELYm1j/tfXWtb+Uhcw==
X-Google-Smtp-Source: ABdhPJxtpLioQG/Z3NDJwdR4UBTH2EAWi1MSqQgFDS5qx+9E3jTvri8hk9NLITZf4bPTuyioP0r1Q9SVhKuxiHLkINg=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr2793069otn.233.1600246013074;
 Wed, 16 Sep 2020 01:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com> <20200916083032.GL2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200916083032.GL2674@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 10:46:41 +0200
Message-ID: <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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

On Wed, 16 Sep 2020 at 10:30, <peterz@infradead.org> wrote:
> On Tue, Sep 15, 2020 at 08:09:16PM +0200, Marco Elver wrote:
> > On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
>
> > > > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> >
> > This one also appears with Clang 11. This is new I think because we
> > started emitting ASAN ctors for globals redzone initialization.
> >
> > I think we really do not care about precise stack frames in these
> > compiler-generated functions. So, would it be reasonable to make
> > objtool ignore all *san.module_ctor and *san.module_dtor functions (we
> > have them for ASAN, TSAN, MSAN)?
>
> The thing is, if objtool cannot follow, it cannot generate ORC data and
> our unwinder cannot unwind through the instrumentation, and that is a
> fail.
>
> Or am I missing something here?

They aren't about the actual instrumentation. The warnings are about
module_ctor/module_dtor functions which are compiler-generated, and
these are only called on initialization/destruction (dtors only for
modules I guess).

E.g. for KASAN it's the calls to __asan_register_globals that are
called from asan.module_ctor. For KCSAN the tsan.module_ctor is
effectively a noop (because __tsan_init() is a noop), so it really
doesn't matter much.

Is my assumption correct that the only effect would be if something
called by them fails, we just don't see the full stack trace? I think
we can live with that, there are only few central places that deal
with ctors/dtors (do_ctors(), ...?).

The "real" fix would be to teach the compilers about "frame pointer
save/setup" for generated functions, but I don't think that's
realistic.

Thanks,
-- Marco
