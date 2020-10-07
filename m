Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6F2869FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgJGVUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgJGVUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:20:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFEB2083B;
        Wed,  7 Oct 2020 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602105606;
        bh=p6OqYGxH8MbED1I1XQzGjHQPgOc/O1yhtLBAX+e+mgk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XaTvU/tYs91/yYW+ongYAGC0Rq+0bb/F3efx+QQOXPfwZiOT0RIYY6Qhr/nffadsQ
         ecAr4i8rfiUG9mtnyvTnjI1dMgPojhuUsXqwfmtb6O/azIYH57QmY91k6a6OZm5vuw
         I2ozWFPout6Gzy2RNvMjtW53euA5LmDh/lRwm7ZE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8F3893522FA4; Wed,  7 Oct 2020 14:20:06 -0700 (PDT)
Date:   Wed, 7 Oct 2020 14:20:06 -0700
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
Message-ID: <20201007212006.GS29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
 <20201007093243.GB2628@hirez.programming.kicks-ass.net>
 <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
 <20201007115054.GD2628@hirez.programming.kicks-ass.net>
 <20201007171107.GO29330@paulmck-ThinkPad-P72>
 <20201007210717.GP2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007210717.GP2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:07:17PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 10:11:07AM -0700, Paul E. McKenney wrote:
> 
> > Challenges include:
> > 
> > o	Unmarked accesses.  Compilers are quite aggressive about
> > 	moving normal code.
> 
> Which is why this thread exists :-) We wants to dis-allow lifting the
> stores over our volatile-if.

Of course.  But you should expect this point to be a continual source
of shock and surprise to compiler folks.  ;-)

> > o	Separately compiled code.  For example, does the compiler have
> > 	unfortunatel optimization opportunities when "volatile if" 
> > 	appears in one translation unit and the dependent stores in
> > 	some other translation unit?
> 
> It can hardly lift anything outside a TU (barring the next point). So I
> don't see how it can go wrong here. This is in fact the case with the
> perf ringbuffer. The ctrl-dep lives in a different TU from the
> stores.

I don't see how it could either, but I have been surprised before.

> > o	LTO, as has already been mentioned in this thread.
> 
> So I would probably advocate the volatile-if to be a full sync point,
> and LTO would have to preserve that.

Completely agreed!  And probably not the only place that LTO needs
to be reined in a bit.

							Thanx, Paul
