Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F691CE0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgEKQwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 12:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgEKQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:52:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D75206D7;
        Mon, 11 May 2020 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589215941;
        bh=b/yxjgJC2CuxHj+5rql56i3dEt86BgH3xwqCAuAIF9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE6o75wLdo/KppzMxATQ0XogQnqrpmH3VGgJVIfprF/zLj1RhAdH1vRUEjim/Bt5S
         nsRFEPcxFaft8RBBLV0BJEreD5eUD/NQwLrgbamFBkiNOMJihz1Db4A0D+nnvmRhhl
         zCxe1EKi9NG3bkd+wN24IlGduwRBUkwqnECqdm64=
Date:   Mon, 11 May 2020 17:52:17 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511165216.GA23081@willie-the-truck>
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
 <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
 <20200509213654.GO2869@paulmck-ThinkPad-P72>
 <20200511155812.GB22270@willie-the-truck>
 <20200511164319.GV2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511164319.GV2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:43:19AM -0700, Paul E. McKenney wrote:
> On Mon, May 11, 2020 at 04:58:13PM +0100, Will Deacon wrote:
> > On Sat, May 09, 2020 at 02:36:54PM -0700, Paul E. McKenney wrote:
> > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > index 1f77349..1de006e 100644
> > > --- a/kernel/locking/osq_lock.c
> > > +++ b/kernel/locking/osq_lock.c
> > > @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> > >  	 */
> > >  
> > >  	for (;;) {
> > > -		if (prev->next == node &&
> > > +		/*
> > > +		 * cpu_relax() below implies a compiler barrier which would
> > > +		 * prevent this comparison being optimized away.
> > > +		 */
> > > +		if (data_race(prev->next) == node &&
> > >  		    cmpxchg(&prev->next, node, NULL) == node)
> > >  			break;
> > 
> > I'm fine with the data_race() placement, but I don't find the comment
> > very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> > loop, so I don't think that the cpu_relax() is really relevant.
> 
> Suppose that the compiler loaded a value that was not equal to "node".
> In that case, the cmpxchg() won't happen, so something else must force
> the compiler to do the reload in order to avoid an infinite loop, right?
> Or am I missing something here?

Then we just go round the loop and reload prev:

	prev = READ_ONCE(node->prev);

which should be enough to stop the compiler, no?

Will
