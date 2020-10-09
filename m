Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34862886BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgJIKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:20:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6773FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eTSyiUWZ5oQl1uBbbkMfxU9sRHDp/kmy09nBobKLqcY=; b=RHb4Se19Z5mOyl7JH5QcXPosVV
        KzRAsOGK1VdWHXSe8q5SSf6VzO+bOSf07HQsVXFQWSRZXyYOhFDbHy27aIGIiaZTCSb6k4VZVxZ/3
        9zOywjuxd7o7kdh2ieGONwQk1Mrp64UybafsuFnULBvXtETlraSuSAFfFRMGfRo0ebgFsl24mhFGH
        uenYiZAEn3hQ5Q5o+5MsglX8/wahyafibXzRrXxegtrGl4vj6AcxXEC4FNTfwr4ftQw6WXM/0Zl2L
        qtctdUPYUt+CAY9tXP9TTnbnexMPfwxjOCqMDQGCLolF7/HKM2z0+fOI0Qpye9fPD9kCmNESZKUO3
        gJqUXsUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQpVS-00015M-RB; Fri, 09 Oct 2020 10:20:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E575300B22;
        Fri,  9 Oct 2020 12:20:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CB9229AE66E9; Fri,  9 Oct 2020 12:20:09 +0200 (CEST)
Date:   Fri, 9 Oct 2020 12:20:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009102009.GK2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
 <20201009101405.GI4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009101405.GI4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:14:05PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 11:47:41, Peter Zijlstra wrote:

> > That is, work backwards (from PREEMPT back to VOLUNTARY) instead of the
> > other way around.
> 
> My original idea was that the config would only define the default
> preemption mode. preempt_none parameter would then just act as an
> override. That would mean that CONFIG_PREEMPTION would be effectively
> gone from the kernel. The reason being that any code outside of the
> scheduler shouldn't really care about the preemption mode. I suspect
> this will prevent from dubious hacks and provide a more robust code in
> the end.

Sure; but the way of arriving at that destination might be easier if
you work backwards from PREEMPT=y, because while there _should_ not be
dependencies outside of the scheduler, we both know there are.

This also makes your patches independent of the series that makes
CONFIG_PREEMPTION unconditional.

It also gives Kconfig space to limit the dynamic thing to archs that
have sufficient support (we'll be relying on static_call/static_branch,
and not everybody has that implemented in a way that makes it the
dynamic change worth-while).
