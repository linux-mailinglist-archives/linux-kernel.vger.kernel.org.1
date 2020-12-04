Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB02CEA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgLDIyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:54:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:53364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgLDIyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607072042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzUWTFBPDORH96iWBN+PzoJswcnczTaxytp5LowmCEU=;
        b=NDbrPj0qDNLfAfWJzbi4xsbf8SduwUiEgH/Z/xNOYSFwe9IcZH6fuxfDFBrqB//TEUxSep
        LRHo08oEO/YpShqf8CuOQdD8fieBnjisHCtLjK9x667fa28AWH9J6icxQBwKNNkvkphYpH
        Dn2FhDIJKze/52Kna9WFtZh04/W4t7A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 821FFACC4;
        Fri,  4 Dec 2020 08:54:02 +0000 (UTC)
Date:   Fri, 4 Dec 2020 09:54:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
Message-ID: <20201204085401.GB25569@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com>
 <20201203091703.GA17338@dhcp22.suse.cz>
 <CA+CK2bB-BC-5Szs1Piv3O=OGxQbJSGWzgMmDUtDewrCqEoNaXw@mail.gmail.com>
 <20201204084312.GA25569@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204084312.GA25569@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-12-20 09:43:13, Michal Hocko wrote:
> On Thu 03-12-20 10:15:41, Pavel Tatashin wrote:
[...]
> > Also, current_gfp_context() is used elsewhere, and in some
> > places removing __GFP_MOVABLE from gfp_mask means that we will need to
> > also change other things. For example [1], in try_to_free_pages() we
> > call current_gfp_context(gfp_mask) which can reduce the maximum zone
> > idx, yet we simply set it to: reclaim_idx = gfp_zone(gfp_mask), not to
> > the newly determined gfp_mask.
> 
> Yes and the direct reclaim should honor the movable zone restriction.
> Why should we reclaim ZONE_MOVABLE when the allocation cannot really
> allocate from it? Or have I misunderstood your concern?

Btw. if we have gfp mask properly filtered for the fast path then we can
remove the additional call to current_gfp_context from the direct
reclaim path. Something for a separate patch.
-- 
Michal Hocko
SUSE Labs
