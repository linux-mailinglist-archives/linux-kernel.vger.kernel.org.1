Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91B2887EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgJILjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJILjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:39:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUWvupSS4x5Jc67h2CeSW+ULhwAq8rOUFqfMfL42U8Q=; b=bWHt8+GUjByoxNEQeA57hs9di7
        i7mGxYz3T/cym89tzhgnlcxiqTF2dGMHenx1Qmheg1uM4Sb5Pdg3cbsKad6YFKaBdXeXCRZenS1io
        Ec6LVYwWdaOnzTporuIxjsBJnED7gXmbse0kCYVTJiGJ0Nw91zd522X/GShkPeFGSO/ICAv+l4gsw
        9m21Q+jkq57NF/cNmI/m5IH7nHK3gAsChQJ9JE6SImzKa/w4Ke1CWOFzmfyi4ebHavd1fvklLkjad
        DGZBNGPL1ujc8ywEzBYsq9Yhh5Y9nLEO4Wtv5lJfmptQtYjTptJM0kWQvCgd11fHUVsSyAin6VuLh
        7ENGwByg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQqjy-0003hu-03; Fri, 09 Oct 2020 11:39:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68F6530008D;
        Fri,  9 Oct 2020 13:39:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E2A329AE66EF; Fri,  9 Oct 2020 13:39:09 +0200 (CEST)
Date:   Fri, 9 Oct 2020 13:39:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009113909.GL2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
 <20201009101405.GI4967@dhcp22.suse.cz>
 <20201009102009.GK2628@hirez.programming.kicks-ass.net>
 <20201009104808.GK4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009104808.GK4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:48:08PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 12:20:09, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:14:05PM +0200, Michal Hocko wrote:
> > > On Fri 09-10-20 11:47:41, Peter Zijlstra wrote:
> > 
> > > > That is, work backwards (from PREEMPT back to VOLUNTARY) instead of the
> > > > other way around.
> > > 
> > > My original idea was that the config would only define the default
> > > preemption mode. preempt_none parameter would then just act as an
> > > override. That would mean that CONFIG_PREEMPTION would be effectively
> > > gone from the kernel. The reason being that any code outside of the
> > > scheduler shouldn't really care about the preemption mode. I suspect
> > > this will prevent from dubious hacks and provide a more robust code in
> > > the end.
> > 
> > Sure; but the way of arriving at that destination might be easier if
> > you work backwards from PREEMPT=y, because while there _should_ not be
> > dependencies outside of the scheduler, we both know there are.
> 
> Wouldn't we need to examine each of the CONFIG_PREEMPTION code anyway?
> And wouldn't that be even more tricky? The boot time option would result
> in a more restrictive preemption mode while the code is actually
> assuming a less restrictive one.

Sure, in the end we'll have to look at all of that.

> > This also makes your patches independent of the series that makes
> > CONFIG_PREEMPTION unconditional.
> >
> > It also gives Kconfig space to limit the dynamic thing to archs that
> > have sufficient support (we'll be relying on static_call/static_branch,
> > and not everybody has that implemented in a way that makes it the
> > dynamic change worth-while).
> 
> Hmm, this is actually a good argument. I can imagine that kernels
> without CONFIG_JUMP_LABEL might increase a runtime overhead for
> something that users of that kernel might be not really interested in.
> This would make CONFIG_PREEMPT_DYNAMIC be selected by CONFIG_JUMP_LABEL.
> 
> I will add the CONFIG_PREEMPT_DYNAMIC in the next version. I just have
> to think whether flipping the direction is really safe and easier in the
> end. For our particular usecase we are more interested in
> NONE<->VOLUNTARY at this moment and having full preemption in the mix
> later is just fine. If you insist on the other direction then we can
> work on that.

Ah, I was purely thinking of the FULL preempt case. For the
NONE/VOLATILE case you can probably keep it simpler.
