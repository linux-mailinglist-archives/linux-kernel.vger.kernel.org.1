Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833B6210938
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgGAKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:25:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FB02067D;
        Wed,  1 Jul 2020 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593599137;
        bh=jhLhsiid/JHPTIQixozqrmVK7Z7yivTR5uDy/0fEI4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MIdgHcm8hZxwfkiuFehiZvcf3/Tr5GQA+93bWFROSIzCHdkqIW0C336sqCSrcoOe
         9IGFq8THz2jtH5mtcNylSPiv8N8xlfrvpic2hj5lk+Rk4Eb7rCXBL3olxKyBxMCDvy
         0GTZR7CuylPcMkoeFsVzizN2x+JiEUGVw6wBlss8=
Date:   Wed, 1 Jul 2020 11:25:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200701102531.GE14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
 <CABCJKudxmrSNNzgPkc4NHt71rfdjAqFbb9n49S4QBDZPQ52e0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudxmrSNNzgPkc4NHt71rfdjAqFbb9n49S4QBDZPQ52e0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:57:54PM -0700, Sami Tolvanen wrote:
> On Tue, Jun 30, 2020 at 12:47 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 30 Jun 2020 at 19:39, Will Deacon <will@kernel.org> wrote:
> > >
> > > When building with LTO, there is an increased risk of the compiler
> > > converting an address dependency headed by a READ_ONCE() invocation
> > > into a control dependency and consequently allowing for harmful
> > > reordering by the CPU.
> > >
> > > Ensure that such transformations are harmless by overriding the generic
> > > READ_ONCE() definition with one that provides acquire semantics when
> > > building with LTO.
> > >
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> > >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> > >  3 files changed, 65 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/arm64/include/asm/rwonce.h
> >
> > This seems reasonable, given we can't realistically tell the compiler
> > about dependent loads. What (if any), is the performance impact? I
> > guess this also heavily depends on the actual silicon.
> >
> > I do wonder, though, if there is some way to make the compiler do
> > something better for us. Clearly, implementing real
> > memory_order_consume hasn't worked out until today. But maybe the
> > compiler could promote dependent loads to acquires if it recognizes it
> > lost dependencies during optimizations. Just thinking out loud, it
> > probably still has some weird corner case that will break. ;-)
> >
> > The other thing is that I'd be cautious blaming LTO, as I tried to
> > summarize here:
> > https://lore.kernel.org/kernel-hardening/20200630191931.GA884155@elver.google.com/
> >
> > The main thing is that, yes, this might be something to be worried
> > about, but if we are worried about it, we need to be worried about it
> > in *all* builds (LTO or not). My guess is that's not acceptable. Would
> > it be better to just guard the promotion of READ_ONCE() to acquire
> > behind a config option like CONFIG_ACQUIRE_READ_DEPENDENCIES, and then
> > make LTO select that (or maybe leave it optional?). In future, for
> > very aggressive non-LTO compilers even, one may then also select that
> > if there is substantiated worry things do actually break.
> 
> I agree, a separate config option would be better here.
> 
> Also Will, the LTO patches use CONFIG_LTO_CLANG instead of CLANG_LTO.

D'oh, sorry. I'll fix that (I had that #ifdef commented out for my testing).

Will
