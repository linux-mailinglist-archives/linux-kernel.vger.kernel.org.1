Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE22A9099
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKFHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:43:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:43:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604648627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnX7uXKPZQUeEZFP59LpWieA3/qlzCyihBRFjshRskk=;
        b=DYN2oGJSQ4lo3t6xYc0d27aUhryoKMDWOsLjMx1oUaMaeuo1lo3Ipl5ZoGJx9wfsZ0ZdDE
        mtXNOUw6aECFJ37Vg7Vsqa57R8mybtY6e38FjVHOu5AyM6TmQHc26/7HA3UV4SzBh37TEd
        ZRKuSv1PBcxgro6sSDIqOhGh2YXEEXQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8493BAB8F;
        Fri,  6 Nov 2020 07:43:47 +0000 (UTC)
Date:   Fri, 6 Nov 2020 08:43:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201106074346.GA7247@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <87zh3vp0k3.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh3vp0k3.fsf@yhuang-dev.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-11-20 12:32:44, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 05-11-20 09:40:28, Feng Tang wrote:
> >> On Wed, Nov 04, 2020 at 09:53:43AM +0100, Michal Hocko wrote:
> >>  
> >> > > > As I've said in reply to your second patch. I think we can make the oom
> >> > > > killer behavior more sensible in this misconfigured cases but I do not
> >> > > > think we want break the cpuset isolation for such a configuration.
> >> > > 
> >> > > Do you mean we skip the killing and just let the allocation fail? We've
> >> > > checked the oom killer code first, when the oom happens, both DRAM
> >> > > node and unmovable node have lots of free memory, and killing process
> >> > > won't improve the situation.
> >> > 
> >> > We already do skip oom killer and fail for lowmem allocation requests already.
> >> > This is similar in some sense. Another option would be to kill the
> >> > allocating context which will have less corner cases potentially because
> >> > some allocation failures might be unexpected.
> >> 
> >> Yes, this can avoid the helpless oom killing to kill a good process(no
> >> memory pressure at all)
> >> 
> >> And I think the important thing is to judge whether this usage (binding
> >> docker like workload to unmovable node) is a valid case :) 
> >
> > I am confused. Why wouldbe an unmovable node a problem. Movable
> > allocations can be satisfied from the Zone Normal just fine. It is other
> > way around that is a problem.
> >
> >> Initially, I thought it invalid too, but later think it still makes some
> >> sense for the 2 cases:
> >>     * user want to bind his workload to one node(most of user space
> >>       memory) to avoid cross-node traffic, and that node happens to
> >>       be configured as unmovable
> >
> > See above
> >
> >>     * one small DRAM node + big PMEM node, and memory latency insensitive
> >>       workload could be bound to the cheaper unmovable PMEM node
> >
> > Please elaborate some more. As long as you have movable and normal nodes
> > then this should be possible with a deal of care - most notably the
> > movable:kernel ratio memory shouldn't be too big.
> >
> > Besides that why does PMEM node have to be MOVABLE only in the first
> > place?
> 
> The performance of PMEM is much worse than that of DRAM.  If we found
> that some pages on PMEM are accessed frequently (hot), we may want to
> move them to DRAM to optimize the system performance.  If the unmovable
> pages are allocated on PMEM and hot, it's possible that we cannot move
> the pages to DRAM unless rebooting the system.  So we think we should
> make the PMEM nodes to be MOVABLE only.

That is fair but then you really need a fallback node too. So this is
mere optimization rather than a fundamental restriction.
-- 
Michal Hocko
SUSE Labs
