Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82B284F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJFQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:11:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42868 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:11:09 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 096GAdjf005889;
        Tue, 6 Oct 2020 18:10:39 +0200
Date:   Tue, 6 Oct 2020 18:10:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "'Nick Clifton'" <nickc@redhat.com>,
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
Message-ID: <20201006161039.GF5822@1wt.eu>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
 <20201006144302.GY2628@hirez.programming.kicks-ass.net>
 <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
 <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
 <20201006155052.GJ29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006155052.GJ29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 08:50:52AM -0700, Paul E. McKenney wrote:
> Comparing 25+ assembly languages to but two compilers most definitely
> motivates looking hard at doing something with the compilers.

+1, especially since the kernel is not special; anyone working with
threads faces the same issues in userland, which are often hidden
behind the implicit whole-memory clobbers of certain operations or
the call to mutex manipulation functions, but which become a reality
again as soon as you go slightly away from these and try to use
lockless mechanisms.

Willy
