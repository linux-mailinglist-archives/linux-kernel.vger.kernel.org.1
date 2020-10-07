Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B76285F48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJGMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:35:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJGMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:35:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602074154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKVoRPDcYIvc3oXdpWLKcaOI1PJO0HyqrM9NWpXvJM0=;
        b=YN/6vhtsbJjQzFcsu+BnmsyGKsVgX51vsszKSEjY6X07PODAfCG1AFGr6hdVkEDqlWa7Qm
        oOxbk4OQovo+OIpBEU8NfNy1cYFHePXzzXy1MZqzfRmQ/hmp+OCkpCSjMUmqEYDUDpBqji
        3VMgEXKIpyx2wEj4x3lOl45BRv8n2xA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14BFDAB5C;
        Wed,  7 Oct 2020 12:35:54 +0000 (UTC)
Date:   Wed, 7 Oct 2020 14:35:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201007123553.GK29020@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007122144.GF2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-10-20 14:21:44, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> > I wanted to make sure that the idea is sound for maintainers first. The
> > next step would be extending the command line to support full preemption
> > as well but there is much more work in that area. Frederic has promissed
> > to look into that.
> 
> The sanest way there is to static_call() __preempt_schedule() I think.

Yes, I have checked the code and identified few other places like
irqentry_exit_cond_resched. We also need unconditional
CONFIG_PREEMPT_COUNT IIUC and there are quite some places guarded by
CONFIG_PREEMPTION that would need to be examined. Some of them are
likely pretending to be more clever than they really are/should be -
e.g. mm/slub.c. So there is likely a lot of leg work.
-- 
Michal Hocko
SUSE Labs
