Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8926D178
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQDLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQDLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:11:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51208C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GKghxhRLzhiu2qEyWdAXVHkgMgfdRZjJpRZm/WkUb6E=; b=ltKks9VB83KII8YUlizV4bPpRD
        iA1zhTL5/Kpf9GimjDqJWqFZ8LfscnshHqQzYV+axi3vd0GXpv5Ae2PC1K5iDHKorJtNBL0JQKRw9
        wDn6JAY2u0o2cItqK9zfRP75bm3pkSpOT5N+OLewy3URZIT01WlEE3qx/r/8YiKh9DFARuep8UltU
        I+VyTDhFH2qghSIoU1ioHSP/9bXDL/oIZEyCxXs59Y9v7S4+u8KiT/IMxXbEW0aRUk0JLLiLFeRIw
        0zIdIOhCeVfIUJvjslBjRPsNfLanYrAIlFXG3u6kzMiK/2UfMTq7f/6byYSElsF/dr81JQvp7B+H6
        9wefTPNw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIkKW-0006l2-Na; Thu, 17 Sep 2020 03:11:28 +0000
Date:   Thu, 17 Sep 2020 04:11:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@redhat.com>, Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
Message-ID: <20200917031128.GQ5449@casper.infradead.org>
References: <20200916005936.232788-1-ying.huang@intel.com>
 <2fe2a22235a0474b4a3de939cc22c19affc945fd.camel@redhat.com>
 <91cfda06-0286-cb36-01fb-23cf28facee4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cfda06-0286-cb36-01fb-23cf28facee4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:29:41PM +0200, David Hildenbrand wrote:
> On 16.09.20 15:39, Qian Cai wrote:
> > On Wed, 2020-09-16 at 08:59 +0800, Huang Ying wrote:
> >>  static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> >> @@ -2474,11 +2481,13 @@ int mpol_misplaced(struct page *page, struct
> >> vm_area_struct *vma, unsigned long
> >>  	int thisnid = cpu_to_node(thiscpu);
> >>  	int polnid = NUMA_NO_NODE;
> >>  	int ret = -1;
> >> +	bool moron;
> > 
> > Are you really going to use that name those days?
> > 
> > 
> 
> include/uapi/linux/mempolicy.h:#define MPOL_F_MORON     (1 << 4) /*
> Migrate On protnone Reference On Node */
> 
> Not commenting the decision for that name. It's uapi ... and naming the
> variable like the uapi flag seems to be a sane thing to do ... hmmm ...

Perhaps we could migrate to mopron / MPOL_F_MOPRON?
