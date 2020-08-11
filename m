Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D92421F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 23:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHKV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:29:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10761C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wxZR/gjBlYyvU4B4UnrTgxXpJrJ5D0dMaAco8Bf6D5c=; b=qdgp2xuIWZv6AnTssXB0ZewXqP
        8t3QxINokttEb6CyQ0ibx5nix9zdlZ1/ZWDH2UgNsgGvr5wJgJQ52mPFFObMJh8STosWe9717j06d
        sNHFB2zKO+VzBFKzMuB4nY2wf9VLPkaCaiJUPG2m4Q5vrlWQWzeo+7MILDGcf9rN4NSP2BGDJoSB7
        LZLaT3kyyGSG9TUMVOc6giGtiJJE1fxkzbLc5Lh4YVWZITEc4BhcSD3IInzAINKNkasDZGw/fCYsY
        cV1SP1XJDHI0vKyg/GCcj6CoajiHauM1VZxBn6g2GV2uJsu1eo3CmyOATzB+5dw3sQs0EcAo9o1lg
        wuBivVog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5bpX-0008T1-EM; Tue, 11 Aug 2020 21:29:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88ACC980C68; Tue, 11 Aug 2020 23:29:08 +0200 (CEST)
Date:   Tue, 11 Aug 2020 23:29:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811212908.GB5637@worktop.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <20200811175912.GF2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811175912.GF2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:59:12PM +0200, peterz@infradead.org wrote:
> On Tue, Aug 11, 2020 at 06:01:35PM +0200, Jessica Yu wrote:
> 
> > > > On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
> > > > >   [33] .plt              PROGBITS         0000000000000340  00035c80
> > > > >        0000000000000001  0000000000000000 WAX       0     0     1
> > > > >   [34] .init.plt         NOBITS           0000000000000341  00035c81
> > > > >        0000000000000001  0000000000000000  WA       0     0     1
> > > > >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
> > > > >        0000000000000001  0000000000000000 WAX       0     0     1
> 
> > Interesting, my cross-compiled modules do not have the executable flag -
> > 
> >  [38] .plt              NOBITS           0000000000000340  00038fc0
> >       0000000000000001  0000000000000000  WA       0     0     1
> >  [39] .init.plt         NOBITS           0000000000000341  00038fc0
> >       0000000000000001  0000000000000000  WA       0     0     1
> >  [40] .text.ftrace_tram NOBITS           0000000000000342  00038fc0
> >       0000000000000001  0000000000000000  WA       0     0     1
> 
> > I'm a bit confused about what NOLOAD actually implies in this context. From the
> > ld documentation - "The `(NOLOAD)' directive will mark a section to not be
> > loaded at run time." But these sections are marked SHF_ALLOC and are referenced
> > to in the module plt code. Or does it just tell the linker to not initialize it?
> 
> Yeah, that confusion is wide-spread, so much so that bfd-ld and gold,
> both in bintils, had different behaviour at some point.
> 
> Anyway, another clue is that your build has all NOBITS, while Mauro's
> build has PROGBITS for the broken sections.
> 
> Anyway, my gcc-10.1/binutils-2.34 cross tool chain (from k.org)
> generates the same as Jessica's too. I wonder if binutils-2.35 is
> wonky...

When I use the Debian provided cross compiler which uses:

  binutils-aarch64-linux-gnu           2.35-1

I do indeed see the same thing Mauro does, which seems to suggest
there's something really dodgy with that toolchain. Some tools person
should have a look.

