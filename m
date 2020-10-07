Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279D5285F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgJGM3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:29:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJGM3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:29:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602073764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5IGfljwHBccTu4EnUAuGHAEO7WK+XuDIhx9cYCdy2Q=;
        b=eY65VnS9rBQbaDJPW7r95aCTaRmGsQzEJKdrVNI3mA8t2dTGk7SKze/lsyN8dISFDP8oYm
        rCaZLEdP9Tb/pOhsyHxKKikCjlZRtD4QupiJpHcH2Zs26zSX6OP9WUUY+BxFJ+2MgDg8NN
        t2Dzv+bbjjunlPYfMuFhG2h7UlXzR7E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FAE9ADEC;
        Wed,  7 Oct 2020 12:29:24 +0000 (UTC)
Date:   Wed, 7 Oct 2020 14:29:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201007122923.GJ29020@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007121939.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007121939.GE2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-10-20 14:19:39, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Many people are still relying on pre built distribution kernels and so
> > distributions have to provide mutliple kernel flavors to offer different
> > preemption models. Most of them are providing PREEMPT_NONE for typical
> > server deployments and PREEMPT_VOLUNTARY for desktop users.
> 
> Is there actually a benefit to NONE? We were recently talking about
> removing it.

I believe Mel can provide much better insight. We have been historically using
PREEMPT_NONE for our enterprise customers mostly for nice throughput
numbers. Many users are really targeting throughput much more than
latencies. My understanding is that even though VOLUNTARY preemption model
doesn't add too many preemption points on top of NONE it is still
something that is observable (IIRC 2-3% on hackbench).
 
> The much more interesting (runtime) switch (IMO) would be between
> VOLUNTARY and PREEMPT.

Absolutely and as said we are looking into that. This is meant to be a
first baby step in that direction. Still very useful in our current
situation when we want to provide both NONE and VOLUNTARY.

-- 
Michal Hocko
SUSE Labs
