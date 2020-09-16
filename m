Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595A026C0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIPJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgIPJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:33:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8FDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:33:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id m12so6100444otr.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+69jB+wV3csf3KfbgPgpUDFiF1twt7Lc/K19h4NVXE8=;
        b=b9Tdi+x3m6RjXww5amVy4aWTXdBdze1nTwb8XGuGV06W6ssFDtYxk5tOh0IAs+vI0Y
         pEHO57Y6fkVbSK4Ucx5uW5zvUOHYxvQivuHXQkmDzF7HhdM0zZy/lKQVTEz0ecIwJqCj
         Ahq1ISaVydDGOpELkgZPJjIQN89s2A+N2H+HDwuxbZ9aewtS873PRzyq+1tOaeSRSKmu
         JyoSGYx0QzjA/oOG1Ozo8FoKAUYpOWemYOMlsULJXG843jt+DqIPZBXk1lO0FG7BNlMR
         bj470I6zMi+EnFyw5J34CTEfeRWJKpaQFKUo98HgBOEs8GeFK0LNJ7niaAOa0tPkiK5w
         hsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+69jB+wV3csf3KfbgPgpUDFiF1twt7Lc/K19h4NVXE8=;
        b=N5pimmIbpNuhBkUyF3w753VN3H4kAG+W0BoiWiL7nk6f/90wz+hu0UScleFdsQxpeb
         0obRgQD6eOrZfdGs/6RbiOQpDwzldnjecr+hQQMWL4QH1RPKZ8m1YURQKlYMgui8meTT
         Tag7hUbV/y194S2mTlZMFH8U9/WCSJCvPd6+kLTxMvwtnxWc14fgAeDuLGUA6SstGduZ
         3WGi/8iIlsiJ1rvIlaJrExnsQtU/pIPwKWMXbnp9BRB0a9WPsVjJIFLLBxxBWPBZV3Gp
         BiDoJqSA+ppA/RVQ+SQcLbqxsipVgJ7JFpV2b3Ocjy/+kIkJqMK+RQIVHrhSjPd2iGBP
         h8gg==
X-Gm-Message-State: AOAM532FlBxVfcvoMB8pURIDyhE4XIWnRmHqEIZYRLjm/os0miQnAl/b
        7ML5/Y+mZE/EFizC3YAJvM/TTYpYYVm75wWBIKC+fQ==
X-Google-Smtp-Source: ABdhPJzC3u0MfC7SFCZfdqlXndJgQubQG3xmNxCc/hFWxahQxzm9mxqCA8rt3vIszhKN4told+dhXtlQUN8VFgjYRjw=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr14889445otk.251.1600248832924;
 Wed, 16 Sep 2020 02:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net> <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
 <20200916090620.GN2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200916090620.GN2674@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 11:33:41 +0200
Message-ID: <CANpmjNPnnkfkRetEHWNwafP43qjbKypsWxLrBVidrzjrTOCFaQ@mail.gmail.com>
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

On Wed, 16 Sep 2020 at 11:06, <peterz@infradead.org> wrote:
> On Wed, Sep 16, 2020 at 10:46:41AM +0200, Marco Elver wrote:
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
>
> Not only fails, lockdep for example likes to store stack traces of
> various callsites etc.. Also perf (NMI) likes to think it can unwind at
> all times.

That's fair, and I would also prefer a proper fix. :-)

> > The "real" fix would be to teach the compilers about "frame pointer
> > save/setup" for generated functions, but I don't think that's
> > realistic.
>
> How is that unrealistic? If you build with framepointers enabled, the
> compiler is supposed to know about this stuff.

If it's a bug in current compilers, it'll be hard to get the fix into
those. My suspicion is there's a bug somewhere. We can try to make new
compiler versions do the right thing. Or maybe we're just missing some
flags, which would be nice. I'll investigate some more.

Thanks,
-- Marco
