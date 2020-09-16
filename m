Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB68126BF50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIPIaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIPIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:30:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHHY9c/6O+Ni91iKJG2q/1GSjFd3jc5M8UDRptkyw7M=; b=o3PNTI1Ba8j5mF2bzU+XilaYbm
        ghyjuNQRVxu22Nro4tbWX2mWt69ayH4wOKlBZNLfSuFpQN0/P4+HjVpyh6PpZdyNQOoYpH4liCVus
        D4moMZN18Yb2QcEvUOtLZv4pcm3pDGipkNkoX1mXDiku9UXPJDQhVOeyNrRZpjs62YYadk33O3EpP
        jFuKK8K2/ENbRx2nveFP34naeI6DJfdONsgNrPGMjK3+r87j48uCOn9mWw/FwJntfMLFUtCXfEtaA
        ZqqZSzBrITojSdYbLqd4WyiJXPV0oRvjSxhuKtYDj8qSP0l1f9IZpPBKc9+R6O7B/CTOPo5pzNRfQ
        vMEXnXeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kISpo-0000n5-I0; Wed, 16 Sep 2020 08:30:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1A923050F0;
        Wed, 16 Sep 2020 10:30:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C9392127D319; Wed, 16 Sep 2020 10:30:32 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:30:32 +0200
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
Message-ID: <20200916083032.GL2674@hirez.programming.kicks-ass.net>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:09:16PM +0200, Marco Elver wrote:
> On Tue, 15 Sep 2020 at 19:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:

> > > init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> > > certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> > > certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> 
> This one also appears with Clang 11. This is new I think because we
> started emitting ASAN ctors for globals redzone initialization.
> 
> I think we really do not care about precise stack frames in these
> compiler-generated functions. So, would it be reasonable to make
> objtool ignore all *san.module_ctor and *san.module_dtor functions (we
> have them for ASAN, TSAN, MSAN)?

The thing is, if objtool cannot follow, it cannot generate ORC data and
our unwinder cannot unwind through the instrumentation, and that is a
fail.

Or am I missing something here?
