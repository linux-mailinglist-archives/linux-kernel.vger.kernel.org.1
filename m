Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF186284FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:31:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A795206D4;
        Tue,  6 Oct 2020 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602001902;
        bh=UpTHNxjdnsj8TgKoTSSXVTK2r7XIFDxf771SyhlBE+U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=003U3PkvGOfhsJOMBHouRbSNQ669xi3ttbviOpgNQfrtVRhCa1j6GHyxLxSIRph21
         pPF8gFu8fDUG6v3g8A9aEY+38e0BRSxPyWPKAnDFascx1OZaVPDKeqIKK7sgzpnQTf
         JDwbNwMh6NqJuz+HrEnFpxLqZ9X8v2dVWQWOXo0E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BE4283520A8C; Tue,  6 Oct 2020 09:31:41 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:31:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Willy Tarreau' <w@1wt.eu>, 'Nick Clifton' <nickc@redhat.com>,
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
Message-ID: <20201006163141.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
 <20201006144302.GY2628@hirez.programming.kicks-ass.net>
 <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
 <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
 <20201006155052.GJ29330@paulmck-ThinkPad-P72>
 <20201006161039.GF5822@1wt.eu>
 <e31a06a9c1e04b6c8c054b1fed3f897b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31a06a9c1e04b6c8c054b1fed3f897b@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 04:22:10PM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 06 October 2020 17:11
> > 
> > On Tue, Oct 06, 2020 at 08:50:52AM -0700, Paul E. McKenney wrote:
> > > Comparing 25+ assembly languages to but two compilers most definitely
> > > motivates looking hard at doing something with the compilers.
> > 
> > +1, especially since the kernel is not special; anyone working with
> > threads faces the same issues in userland, which are often hidden
> > behind the implicit whole-memory clobbers of certain operations or
> > the call to mutex manipulation functions, but which become a reality
> > again as soon as you go slightly away from these and try to use
> > lockless mechanisms.
> 
> AFAICT most windows and android apps completely ignore the problem
> of thread locking - which is why the crash and lock up all the time :-)
> 
> I've spent most of the day looking at some library traces from a
> customer bug.
> I almost suspect a bug in the pthread mutex code on their system.
> They are using a nice, modern, 3.10.0-957.el7.x86_64 kernel.

It would be good if the compiler were more helpful!  Failing that, if
-something- could be more helpful!!!

							Thanx, Paul
