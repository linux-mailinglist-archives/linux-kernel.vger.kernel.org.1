Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD8281098
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgJBK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:29:09 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:60341 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgJBK3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:29:09 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 06:29:08 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id B250BF80DF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:19:53 +0100 (IST)
Received: (qmail 4410 invoked from network); 2 Oct 2020 10:19:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2020 10:19:53 -0000
Date:   Fri, 2 Oct 2020 11:19:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002101952.GE3227@techsingularity.net>
References: <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090729.GU2628@hirez.programming.kicks-ass.net>
 <20201002094502.GD3227@techsingularity.net>
 <20201002095858.GN2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201002095858.GN2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 11:58:58AM +0200, Peter Zijlstra wrote:
> > It's enabled by default by enough distros that adding too many checks
> > is potentially painful. Granted it would be missed by most benchmarking
> > which tend to control allocations from userspace but a lot of performance
> > problems I see are the "death by a thousand cuts" variety.
> 
> Oh quite agreed, aka death by accounting. But if people are enabling
> DEBUG options in production kernels, there's something wrong, no?
> 

You'd think but historically I believe DEBUG_VM was enabled for some
distributions because it made certain classes of problems easier to debug
early. There is also a recent trend for enabling various DEBUG options for
"hardening" even when they protect very specific corner cases or are for
intended for kernel development. I've pushed back where I have an opinion
that matters but it's generally corrosive.

> Should we now go add CONFIG_REALLY_DEBUG_STAY_AWAY_ALREADY options?

It's heading in that direction :(

-- 
Mel Gorman
SUSE Labs
