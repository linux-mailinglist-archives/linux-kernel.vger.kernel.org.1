Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAED28657F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgJGRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgJGRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:11:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC5621775;
        Wed,  7 Oct 2020 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602090668;
        bh=Q/SeNQlpma2QgtnPxD9Oeo195rXtJWRkFMLd4Ccsk7I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VTi8JK423f8kusfHNAuAZiB9RWqC8f4FjfPzwDCcJHe41WddgDmti4dpdZgVWdV1d
         FvyIi+Aq/l2drHrZHyzk2CVE377Wzi71lrbo5JYjL2+vOGf4wwxI67+TNtcCt9Wo+c
         6COtjB1bJNl//Qx4MHfKN79CLs8/8tOMNvfFyrLU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 00AAD3522FA4; Wed,  7 Oct 2020 10:11:07 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:11:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201007171107.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
 <20201007093243.GB2628@hirez.programming.kicks-ass.net>
 <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
 <20201007115054.GD2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007115054.GD2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:50:54PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 12:20:41PM +0200, Florian Weimer wrote:
> > * Peter Zijlstra:

[ . . . ]

> > >> I think in GCC, they are called __atomic_load_n(foo, __ATOMIC_RELAXED)
> > >> and __atomic_store_n(foo, __ATOMIC_RELAXED).  GCC can't optimize relaxed
> > >> MO loads and stores because the C memory model is defective and does not
> > >> actually guarantee the absence of out-of-thin-air values (a property it
> > >> was supposed to have).
> > >
> > > AFAIK people want to get that flaw in the C memory model fixed (which to
> > > me seemd like a very good idea).
> > 
> > It's been a long time since people realized that this problem exists,
> > with several standard releases since then.
> 
> I've been given to believe it is a hard problem. Personally I hold the
> opinion that prohibiting store speculation (of all kinds) is both
> necesary and sufficient to avoid OOTA. But I have 0 proof for that.

There are proofs for some definitions of store speculation, for example,
as proposed by Demsky and Boehm [1] and as prototyped by Demsky's student,
Peizhao Ou [2].  But these require marking all accesses and end up being
optimized variants of acquire load and release store.  One optimization
is that if you have a bunch of loads followed by a bunch of stores,
the compiler can emit a single memory-barrier instruction between the
last load and the first store.

I am not a fan of this approach.

Challenges include:

o	Unmarked accesses.  Compilers are quite aggressive about
	moving normal code.

o	Separately compiled code.  For example, does the compiler have
	unfortunatel optimization opportunities when "volatile if" 
	appears in one translation unit and the dependent stores in
	some other translation unit?

o	LTO, as has already been mentioned in this thread.

Probably other issues as well, but a starting point.

							Thanx, Paul

[1]	https://dl.acm.org/doi/10.1145/2618128.2618134
	"Outlawing ghosts: avoiding out-of-thin-air results"
	Hans-J. Boehm and Brian Demsky.

[2]	https://escholarship.org/uc/item/2vm546k1
	"An Initial Study of Two Approaches to Eliminating Out-of-Thin-Air
	Results" Peizhao Ou.
