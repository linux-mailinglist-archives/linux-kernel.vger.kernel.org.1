Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F61FFA51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgFRRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732192AbgFRRcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:32:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AFA208B8;
        Thu, 18 Jun 2020 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592501526;
        bh=yTsrBl2tE3fnFEIPv5CpTnTJlef/tgV4kZQ5U8GHJPk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UlADRr7WPtcKFU60fOr0nPBXKkKCmTiJXKtK1awwyyMozYrumEaYzjk4gKRCbAKZx
         dKEY7iMvjfLaSg1faXq+gXFitw+PT6LJj/ZiTrrN32GzQMD1MzSiunYq7D2hxeMWp7
         ssY1umEG+TBGUQMrb02kMW5n51sLBp+H9edLded8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEC9E35229B4; Thu, 18 Jun 2020 10:32:06 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:32:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618173206.GS2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618172504.GA14613@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:25:04PM +0200, Uladzislau Rezki wrote:
> > > +	// Handle two first channels.
> > > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > > +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> > > +			bnext = bkvhead[i]->next;
> > > +			debug_rcu_bhead_unqueue(bkvhead[i]);
> > > +
> > > +			rcu_lock_acquire(&rcu_callback_map);
> > > +			if (i == 0) { // kmalloc() / kfree().
> > > +				trace_rcu_invoke_kfree_bulk_callback(
> > > +					rcu_state.name, bkvhead[i]->nr_records,
> > > +					bkvhead[i]->records);
> > > +
> > > +				kfree_bulk(bkvhead[i]->nr_records,
> > > +					bkvhead[i]->records);
> > > +			} else { // vmalloc() / vfree().
> > > +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > > +					trace_rcu_invoke_kfree_callback(
> > > +						rcu_state.name,
> > > +						bkvhead[i]->records[j], 0);
> > > +
> > > +					vfree(bkvhead[i]->records[j]);
> > > +				}
> > > +			}
> > > +			rcu_lock_release(&rcu_callback_map);
> > 
> > Not an emergency, but did you look into replacing this "if" statement
> > with an array of pointers to functions implementing the legs of the
> > "if" statement?  If nothing else, this would greatly reduced indentation.
> > 
> >
> > I am taking this as is, but if you have not already done so, could you
> > please look into this for a follow-up patch?
> > 
> I do not think it makes sense, because it would require to check each
> pointer in the array, what can lead to many branching, i.e. "if-else"
> instructions.

Mightn't the compiler simply unroll the outer loop?  Then the first
unrolled iteration of that loop would contain the then-clause and
the second unrolled iteration would contain the else-clause.  At that
point, there would be no checking, just direct calls.

Or am I missing something?

> Paul, thank you to take it in!

Thank you for persisting!

							Thanx, Paul
