Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E16288750
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgJIKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731698AbgJIKsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:48:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602240489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2VTQ0Fc4oyaW8Y8KoJqjB5dWzVIQScUlJ5OcZmPOrMU=;
        b=kd//CB2sOmyHPGY9iY+9WnFXKpAVAhn3+bOWwZ1g/57xs6gBhYsS2sDVUcUcPvsoUGA/5t
        CsgNDh22R0oxsjjKh/SolRGiYBC0eWmEwg1zLFp7HoGbDGacBuUhN6KS4QhDJPIa1aFyC3
        0lh/deIhQ+bfeeey4J3IBOHlzvGTIKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A5A6AB95;
        Fri,  9 Oct 2020 10:48:09 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:48:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009104808.GK4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
 <20201009101405.GI4967@dhcp22.suse.cz>
 <20201009102009.GK2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009102009.GK2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 12:20:09, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:14:05PM +0200, Michal Hocko wrote:
> > On Fri 09-10-20 11:47:41, Peter Zijlstra wrote:
> 
> > > That is, work backwards (from PREEMPT back to VOLUNTARY) instead of the
> > > other way around.
> > 
> > My original idea was that the config would only define the default
> > preemption mode. preempt_none parameter would then just act as an
> > override. That would mean that CONFIG_PREEMPTION would be effectively
> > gone from the kernel. The reason being that any code outside of the
> > scheduler shouldn't really care about the preemption mode. I suspect
> > this will prevent from dubious hacks and provide a more robust code in
> > the end.
> 
> Sure; but the way of arriving at that destination might be easier if
> you work backwards from PREEMPT=y, because while there _should_ not be
> dependencies outside of the scheduler, we both know there are.

Wouldn't we need to examine each of the CONFIG_PREEMPTION code anyway?
And wouldn't that be even more tricky? The boot time option would result
in a more restrictive preemption mode while the code is actually
assuming a less restrictive one.
 
> This also makes your patches independent of the series that makes
> CONFIG_PREEMPTION unconditional.
>
> It also gives Kconfig space to limit the dynamic thing to archs that
> have sufficient support (we'll be relying on static_call/static_branch,
> and not everybody has that implemented in a way that makes it the
> dynamic change worth-while).

Hmm, this is actually a good argument. I can imagine that kernels
without CONFIG_JUMP_LABEL might increase a runtime overhead for
something that users of that kernel might be not really interested in.
This would make CONFIG_PREEMPT_DYNAMIC be selected by CONFIG_JUMP_LABEL.

I will add the CONFIG_PREEMPT_DYNAMIC in the next version. I just have
to think whether flipping the direction is really safe and easier in the
end. For our particular usecase we are more interested in
NONE<->VOLUNTARY at this moment and having full preemption in the mix
later is just fine. If you insist on the other direction then we can
work on that.

Thanks!
-- 
Michal Hocko
SUSE Labs
