Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25FF2E961F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhADNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:35:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:26556 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbhADNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:35:37 -0500
IronPort-SDR: UmpDFPRV9gY0Ms4kQusiDChF5dX9MIP10XhXvYMC1zZ01lQOyuYvlLPUqv7QpmhrT8Z0YFdHwd
 n0TlVMR4ECWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="176172253"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="176172253"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 05:34:48 -0800
IronPort-SDR: ZC72G4Xg7XmdPpH9pGGCkSQvY+CVk1z4afxu9vUOCrMjsQyvdfXczPpgZKpjXl9QTd98/PDGZ5
 2IxKMdHKswyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="349942515"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 05:34:45 -0800
Date:   Mon, 4 Jan 2021 21:34:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 1/2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <20210104133445.GA101866@shbuild999.sh.intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <20210104130357.GF13207@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104130357.GF13207@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Jan 04, 2021 at 02:03:57PM +0100, Michal Hocko wrote:
> On Tue 29-12-20 22:35:13, Feng Tang wrote:
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
> 
> Yes, parent is write-once field so having it away from other heavy RW
> fields makes sense to me.
>  
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
> 
> What is the second number? Std?

For each case like 'page_fault2', I run several subcases on different
generations of Xeon, and only listed the lowest (first number) and
highest (second number) scores.

There are 5 runs and the result are: +3.6%, +2.4%, +10.4%, +20.2%,
+4.7%, and +2.4% and +20.2% are listed.

Thanks,
Feng
