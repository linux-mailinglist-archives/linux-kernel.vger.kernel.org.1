Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39FC26C01A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIPJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:06:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XGOGWszl2fZU1wbir3hgL3wXW46VrlHkuXhbLpO08Eo=; b=fEezQmk/8ai823rFebUytBjY5y
        IV44DUH8WhTUysiCTNpXhJu7FYGpDSlvp1wnKBDsHHQZ89iZcj4ZAg171aFSWMStaiuup8xI4Pyg6
        o+zYu2SNH2eV6u02z81xgGNIpfKxuD01zNPq+wsziSg/vUxSXZN2NZLuLFNvFjXtqpAYLGM/pvkv3
        qtqIKvHoohr9zqwH6nJQYm+ycf7H090vLu4oXnbPzBXH56+2HgSKbra1DpZ3JlEcUjiLTkHKAZWwl
        veIWBscVakesnjWOVUITVU+dwps9RZduAwty8pMPXNdfBipK+uk7A6RXQo20zZFpyKaEzBtQAyoSN
        n6uIFp7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kITOP-0006oH-Lj; Wed, 16 Sep 2020 09:06:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4050B3012DF;
        Wed, 16 Sep 2020 11:06:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3012A2149392C; Wed, 16 Sep 2020 11:06:20 +0200 (CEST)
Date:   Wed, 16 Sep 2020 11:06:20 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
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
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200916090620.GN2674@hirez.programming.kicks-ass.net>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net>
 <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:46:41AM +0200, Marco Elver wrote:
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

Not only fails, lockdep for example likes to store stack traces of
various callsites etc.. Also perf (NMI) likes to think it can unwind at
all times.

> The "real" fix would be to teach the compilers about "frame pointer
> save/setup" for generated functions, but I don't think that's
> realistic.

How is that unrealistic? If you build with framepointers enabled, the
compiler is supposed to know about this stuff.
