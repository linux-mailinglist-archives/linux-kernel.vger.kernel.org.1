Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46E28869C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgJIKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJIKOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602238446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tqihfBLiXgPDJi1ekdIOztDjl+mzaS5KGF/0r87WZ0=;
        b=MItc3sFksd0/4NJ7hYjcj65feAlbGMeXZtuJYczhV06Uc2iBIESzaj5RwMzXoh/sG1nw2U
        JdmpwZ9DB8APvgjajEsA6vrlRUPOSzV/jZakF9dEsIVW1xwEfZxZ9ZI1/3/ezALVk3EDIH
        K94ySLid06ofGMXAESDYkhTZX/Xc3DQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0E1AADF5;
        Fri,  9 Oct 2020 10:14:06 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:14:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009101405.GI4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009094741.GH2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 11:47:41, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 02:35:53PM +0200, Michal Hocko wrote:
> > On Wed 07-10-20 14:21:44, Peter Zijlstra wrote:
> > > On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> > > > I wanted to make sure that the idea is sound for maintainers first. The
> > > > next step would be extending the command line to support full preemption
> > > > as well but there is much more work in that area. Frederic has promissed
> > > > to look into that.
> > > 
> > > The sanest way there is to static_call() __preempt_schedule() I think.
> > 
> > Yes, I have checked the code and identified few other places like
> > irqentry_exit_cond_resched. We also need unconditional
> > CONFIG_PREEMPT_COUNT IIUC and there are quite some places guarded by
> > CONFIG_PREEMPTION that would need to be examined. Some of them are
> > likely pretending to be more clever than they really are/should be -
> > e.g. mm/slub.c. So there is likely a lot of leg work.
> 
> The easiest way might be to introduce PREEMPT_DYNAMIC that
> depends/selects PREEMPT. That way you're basically running a PREEMPT=y
> kernel.
> 
> Then have PREEMPT_DYNAMIC allow disabling the __preempt_schedule /
> preempt_schedule_irq() callsites using static_call/static_branch
> respectively.
> 
> That is, work backwards (from PREEMPT back to VOLUNTARY) instead of the
> other way around.

My original idea was that the config would only define the default
preemption mode. preempt_none parameter would then just act as an
override. That would mean that CONFIG_PREEMPTION would be effectively
gone from the kernel. The reason being that any code outside of the
scheduler shouldn't really care about the preemption mode. I suspect
this will prevent from dubious hacks and provide a more robust code in
the end.

Does that sound reasonable?

-- 
Michal Hocko
SUSE Labs
