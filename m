Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7D2A5FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgKDIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKDIxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:53:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604480024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tI7i3bJI9yEwkwLPy7YSUUeg1XKxRAeji3wTJwSxLc=;
        b=FB/xJAqlHsEtLX36bNKe+pCPMAijb1hAL+BI7JAZKeaMi24kuS43xaPLzyw+hSssPnIkSi
        zDXPTRydCx4J+419E1fDAz2M0e9qxtIXTDXwaMWldjwwgmLA3TgB5OUnqFPI/hY63SoCg0
        yyypzd08FMiJh68MVCvF1VS0zF4oWkY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9230AAECB;
        Wed,  4 Nov 2020 08:53:44 +0000 (UTC)
Date:   Wed, 4 Nov 2020 09:53:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201104085343.GA18718@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104084021.GB15700@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 16:40:21, Feng Tang wrote:
> On Wed, Nov 04, 2020 at 08:58:19AM +0100, Michal Hocko wrote:
> > On Wed 04-11-20 15:38:26, Feng Tang wrote:
> > [...]
> > > > Could you be more specific about the usecase here? Why do you need a
> > > > binding to a pure movable node? 
> > > 
> > > One common configuration for a platform is small size of DRAM plus huge
> > > size of PMEM (which is slower but cheaper), and my guess of their use
> > > is to try to lead the bulk of user space allocation (GFP_HIGHUSER_MOVABLE)
> > > to PMEM node, and only let DRAM be used as less as possible. 
> > 
> > While this is possible, it is a tricky configuration. It is essentially 
> > get us back to 32b and highmem...
> 
> :) Another possible case is similar binding on a memory hotplugable
> platform, which has one unplugable node and several other nodes configured
> as movable only to be hot removable when needed

Yes, another way to shoot your foot ;)

> > As I've said in reply to your second patch. I think we can make the oom
> > killer behavior more sensible in this misconfigured cases but I do not
> > think we want break the cpuset isolation for such a configuration.
> 
> Do you mean we skip the killing and just let the allocation fail? We've
> checked the oom killer code first, when the oom happens, both DRAM
> node and unmovable node have lots of free memory, and killing process
> won't improve the situation.

We already do skip oom killer and fail for lowmem allocation requests already.
This is similar in some sense. Another option would be to kill the
allocating context which will have less corner cases potentially because
some allocation failures might be unexpected.

> (Folloing is copied from your comments for 2/2) 
> > This allows to spill memory allocations over to any other node which
> > has Normal (or other lower) zones and as such it breaks cpuset isolation.
> > As I've pointed out in the reply to your cover letter it seems that
> > this is more of a misconfiguration than a bug.
> 
> For the usage case (docker container running), the spilling is already
> happening, I traced its memory allocation requests, many of them are
> movable, and got fallback to the normal node naturally with current

Could you be more specific? This sounds like a bug. Allocations
shouldn't spill over to a node which is not in the cpuset. There are few
exceptions like IRQ context but that shouldn't happen regurarly.

> code, only a few got blocked, as many of __alloc_pages_nodemask are
> called witih 'NULL' nodemask parameter.
> 
> And I made this RFC patch inspired by code in __alloc_pages_may_oom():
> 
> 	if (gfp_mask & __GFP_NOFAIL)
> 		page = __alloc_pages_cpuset_fallback(gfp_mask, order,
> 				ALLOC_NO_WATERMARKS, ac);

I am not really sure I follow here. __GFP_NOFAIL is a special beast
because such an allocation must not fail. Breaking node affinity is the
only option left. This shouldn't be something used for regular
allocation requests.
-- 
Michal Hocko
SUSE Labs
