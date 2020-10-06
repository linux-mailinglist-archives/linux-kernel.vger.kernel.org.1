Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F34284F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFPux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:50:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6D9206F7;
        Tue,  6 Oct 2020 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601999452;
        bh=TvsmiV/kSOvronREsSY7zNuUQtF9sAQYhFLAvwcc/zM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mgun+BsV0rA//Mmwh1vjYZyTT/goSPLAA0MxqRsT/l2oqR+gtwtp0c5jg2hOB52uR
         SzXifAaaipWIEg/iikustBTW7/VcVATWPUPNxBbV6/gRR2ExABbi0SYG1bzcZvRr/M
         VBASUoxzgwXcNq7k2l7rBUZH5UETU+OkxnpK5w4k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1DD363520A89; Tue,  6 Oct 2020 08:50:52 -0700 (PDT)
Date:   Tue, 6 Oct 2020 08:50:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Nick Clifton' <nickc@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201006155052.GJ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
 <20201006144302.GY2628@hirez.programming.kicks-ass.net>
 <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
 <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 03:37:24PM +0000, David Laight wrote:
> >   My suggestion as an alternative is to use assembler instead.
> >   That way you can guarantee that you get the instructions you
> >   want in the order that you want them.  It should be fairly
> >   straightforward to create a macro or inline function that
> >   contains the necessary code and this can be done once and
> >   then used wherever the functionality is required.
> 
> C exists because K&R got fed up of writing pdp-11 assembler.
> Compared to some modern ones it is nice and easy to write
> (I'm old enough to have used pdp-11.)
> 
> You can't put control dependencies inside C asm statements.

What David said!

And not only are modern machine languages quite complex and strange
compared to that of the PDP-11, but writing core Linux-kernel code
in assembler requires writing it 25 times, once for each of the
supported architectures.  And even that is an underestimate because
some architectures have multiple variants, for but one example, arm's
multiple instruction sets.

Comparing 25+ assembly languages to but two compilers most definitely
motivates looking hard at doing something with the compilers.

							Thanx, Paul
