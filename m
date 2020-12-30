Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777712E79F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgL3OUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:20:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:64455 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgL3OUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:20:07 -0500
IronPort-SDR: A2bRSNflKh5UXxgCiLXDrERS41dEjd75zbjOc9hdkpTieimqORLjWwmCe8WncHM6jSSKuE1Rdr
 ne241raGa3ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="261359892"
X-IronPort-AV: E=Sophos;i="5.78,461,1599548400"; 
   d="scan'208";a="261359892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 06:19:26 -0800
IronPort-SDR: tmOl3Z62Uo84jH8hAJiYOeYTECaUdq/2xEvydyjaDffdtZnffmZMTE+4w4FYMqdEf41sOtYtCh
 fHlYantPHPCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,461,1599548400"; 
   d="scan'208";a="395850007"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga002.fm.intel.com with ESMTP; 30 Dec 2020 06:19:23 -0800
Date:   Wed, 30 Dec 2020 22:19:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com
Subject: Re: [PATCH 1/2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <20201230141923.GA43248@shbuild999.sh.intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <20201229165642.GA371241@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229165642.GA371241@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 08:56:42AM -0800, Roman Gushchin wrote:
> On Tue, Dec 29, 2020 at 10:35:13PM +0800, Feng Tang wrote:
> > When checking a memory cgroup related performance regression [1],
> > from the perf c2c profiling data, we found high false sharing for
> > accessing 'usage' and 'parent'.
> > 
> > On 64 bit system, the 'usage' and 'parent' are close to each other,
> > and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
> > is usally written, while 'parent' is usually read as the cgroup's
> > hierarchical counting nature.
> > 
> > So move the 'parent' to the end of the structure to make sure they
> > are in different cache lines.
> > 
> > Following are some performance data with the patch, against
> > v5.11-rc1, on several generations of Xeon platforms. Most of the
> > results are improvements, with only one malloc case on one platform
> > shows a -4.0% regression. Each category below has several subcases
> > run on different platform, and only the worst and best scores are
> > listed:
> > 
> > fio:				 +1.8% ~  +8.3%
> > will-it-scale/malloc1:		 -4.0% ~  +8.9%
> > will-it-scale/page_fault1:	 no change
> > will-it-scale/page_fault2:	 +2.4% ~  +20.2%
> > 
> > [1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  include/linux/page_counter.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > index 85bd413..6795913 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -12,7 +12,6 @@ struct page_counter {
> >  	unsigned long low;
> >  	unsigned long high;
> >  	unsigned long max;
> > -	struct page_counter *parent;
> >  
> >  	/* effective memory.min and memory.min usage tracking */
> >  	unsigned long emin;
> > @@ -27,6 +26,14 @@ struct page_counter {
> >  	/* legacy */
> >  	unsigned long watermark;
> >  	unsigned long failcnt;
> > +
> > +	/*
> > +	 * 'parent' is placed here to be far from 'usage' to reduce
> > +	 * cache false sharing, as 'usage' is written mostly while
> > +	 * parent is frequently read for cgroup's hierarchical
> > +	 * counting nature.
> > +	 */
> > +	struct page_counter *parent;
> >  };
> 
> LGTM!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks for the review!

> I wonder if we have the same problem with min/low/high/max?
> Maybe try to group all mostly-read-only fields (min, low, high,
> max and parent) and separate them with some padding?

Yep, we thought about it too. From current perf c2c profiling
data, I haven't noticed obvious hot spots of false sharing for
min/low/high/max (which are read mostly).

For padding, we had some proposal before, current page_counter
for 64 bits platform is 112 bytes, padding to 2 cacheline
will only cost 16 bytes more. If this is fine, I can send another
patch or folder it to this one.

Thanks,
Feng

> Thank you!
