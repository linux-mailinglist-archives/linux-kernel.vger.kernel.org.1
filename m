Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418AE1B19F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgDTXMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 19:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDTXMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:12:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB1C20B1F;
        Mon, 20 Apr 2020 23:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587424364;
        bh=prcsJ07hDip1xTde/WHBahDCQn8U4Cvvsfn0XdiVO80=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SE9RHwqQbGZk0A3Q+St4Mh2IYkKdWVFA4lBrTtID2ZrL+OEQpTvr0iXK6TLIn5sqA
         ElVGxlpUSdVRsIMk4EbltbLkdxVUFkM7AKgsuCucxokKuu/iVX7lJSHLv4SBOPhEOM
         RLBuX+s10xt1rzylHHwWsi52cD2GyCcMBEKTpxNE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3C2353523411; Mon, 20 Apr 2020 16:12:44 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:12:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Petko Manolov' <petko.manolov@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200420231244.GK17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72>
 <20200420225715.GA176156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420225715.GA176156@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:57:15AM +0200, Marco Elver wrote:
> On Mon, 20 Apr 2020, Paul E. McKenney wrote:
> 
> > On Sun, Apr 19, 2020 at 09:37:10PM +0000, David Laight wrote:
> > > From: Petko Manolov
> > > > Sent: 19 April 2020 19:30
> > > > 
> > > > On 20-04-19 18:02:50, David Laight wrote:
> > > > > From: Petko Manolov
> > > > > > Sent: 19 April 2020 10:45
> > > > > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > > > > >
> > > > > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > > > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> > > > >
> > > > > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > > > > field 'volatile'?
> > > > 
> > > > This is a bit heavy.  I guess you've read this one:
> > > > 
> > > > 	https://lwn.net/Articles/233479/
> > > 
> > > I remember reading something similar before.
> > > I also remember a very old gcc (2.95?) that did a readback
> > > after every volatile write on sparc (to flush the store buffer).
> > > That broke everything.
> > > 
> > > I suspect there is a lot more code that is attempting to be lockless
> > > these days.
> > > Ring buffers (one writer and one reader) are a typical example where
> > > you don't need locks but do need to use a consistent value.
> > > 
> > > Now you may also need ordering between accesses - which I think needs
> > > more than volatile.
> > 
> > In Petko's patch, all needed ordering is supplied by the fact that it
> > is the same variable being read and written.  But yes, in many other
> > cases, more ordering is required.
> > 
> > > > And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> > > > example, all others are from withing spin_lock/unlock pairs then we _may_ not
> > > > need READ/WRITE_ONCE().
> > > 
> > > The cost of volatile accesses is probably minimal unless the
> > > code is written assuming the compiler will only access things once.
> > 
> > And there are variables marked as volatile, for example, jiffies.
> > 
> > But one downside of declaring variables volatile is that it can prevent
> > KCSAN from spotting violations of the concurrency design for those
> > variables.
> 
> Note that, KCSAN currently treats volatiles not as special, except a
> list of some known global volatiles (like jiffies). This means, that
> KCSAN will tell us about data races involving unmarked volatiles (unless
> they're in the list).
> 
> As far as I can tell, this is what we want. At least according to LKMM.
> 
> If, for whatever reason, volatiles should be treated differently, we'll
> have to modify the compilers to emit different instrumentation for the
> kernel.

I stand corrected, then, thank you!

In the current arrangement, declaring a variable volatile will cause
KCSAN to generate lots of false positives.

I don't currently have a strong feeling on changing the current situation
with respect to volatile variables.  Is there a strong reason to change?
The general view of the community, as you say, has been that you don't use
the volatile keyword outside of exceptions such as jiffies, atomic_read(),
atomic_set(), READ_ONCE(), WRITE_ONCE() and perhaps a few others.

Thoughts?

							Thanx, Paul
