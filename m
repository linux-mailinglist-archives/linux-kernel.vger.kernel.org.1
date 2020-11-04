Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8D2A5FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKDIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:40:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:52516 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDIkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:40:24 -0500
IronPort-SDR: 4Hz9iT3/DgHjUU5mRfwF2wk2WvZvRmNMoESdfcLOS3v+ipRBW/WYSC8vWToVZQOH+P3s2EIfa0
 8Ww4imFKg5XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166595546"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="166595546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 00:40:24 -0800
IronPort-SDR: 1yqp2FoU4soRwC8zdeWoBQmLGPxpmPWAvYZG7Bs0yMWSWtekt/wPQ7d8ZxoU/TeW5HfQ3654bN
 uOiBlrM9daeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="528851047"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2020 00:40:22 -0800
Date:   Wed, 4 Nov 2020 16:40:21 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201104084021.GB15700@shbuild999.sh.intel.com>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104075819.GA10052@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:58:19AM +0100, Michal Hocko wrote:
> On Wed 04-11-20 15:38:26, Feng Tang wrote:
> [...]
> > > Could you be more specific about the usecase here? Why do you need a
> > > binding to a pure movable node? 
> > 
> > One common configuration for a platform is small size of DRAM plus huge
> > size of PMEM (which is slower but cheaper), and my guess of their use
> > is to try to lead the bulk of user space allocation (GFP_HIGHUSER_MOVABLE)
> > to PMEM node, and only let DRAM be used as less as possible. 
> 
> While this is possible, it is a tricky configuration. It is essentially 
> get us back to 32b and highmem...

:) Another possible case is similar binding on a memory hotplugable
platform, which has one unplugable node and several other nodes configured
as movable only to be hot removable when needed

> As I've said in reply to your second patch. I think we can make the oom
> killer behavior more sensible in this misconfigured cases but I do not
> think we want break the cpuset isolation for such a configuration.

Do you mean we skip the killing and just let the allocation fail? We've
checked the oom killer code first, when the oom happens, both DRAM
node and unmovable node have lots of free memory, and killing process
won't improve the situation.

(Folloing is copied from your comments for 2/2) 
> This allows to spill memory allocations over to any other node which
> has Normal (or other lower) zones and as such it breaks cpuset isolation.
> As I've pointed out in the reply to your cover letter it seems that
> this is more of a misconfiguration than a bug.

For the usage case (docker container running), the spilling is already
happening, I traced its memory allocation requests, many of them are
movable, and got fallback to the normal node naturally with current
code, only a few got blocked, as many of __alloc_pages_nodemask are
called witih 'NULL' nodemask parameter.

And I made this RFC patch inspired by code in __alloc_pages_may_oom():

	if (gfp_mask & __GFP_NOFAIL)
		page = __alloc_pages_cpuset_fallback(gfp_mask, order,
				ALLOC_NO_WATERMARKS, ac);

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
