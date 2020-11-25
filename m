Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5212C3DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgKYKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:30:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgKYKa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:30:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C54CAC6A;
        Wed, 25 Nov 2020 10:30:56 +0000 (UTC)
Date:   Wed, 25 Nov 2020 10:30:53 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201125103053.GL3306@suse.de>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
 <X71zdnZd61r429aO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <X71zdnZd61r429aO@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:56:22PM -0500, Andrea Arcangeli wrote:
> Hello,
> 
> On Tue, Nov 24, 2020 at 01:32:05PM +0000, Mel Gorman wrote:
> > I would hope that is not the case because they are not meant to overlap.
> > However, if the beginning of the pageblock was not the start of a zone
> > then the pages would be valid but the pfn would still be outside the
> > zone boundary. If it was reserved, the struct page is valid but not
> > suitable for set_pfnblock_flags_mask. However, it is a concern in
> > general because the potential is there that pages are isolated from the
> > wrong zone.
> 
> I guess we have more than one issue to correct in that function
> because the same BUG_ON reproduced again even with the tentative patch
> I posted earlier.
> 
> So my guess is that the problematic reserved page isn't pointed by the
> min_pfn, but it must have been pointed by the "highest" variable
> calculated below?
> 
> 			if (pfn >= highest)
> 				highest = pageblock_start_pfn(pfn);
> 
> When I looked at where "highest" comes from, it lacks
> pageblock_pfn_to_page check (which was added around v5.7 to min_pfn).
> 
> Is that the real bug, which may be fixed by something like this? (untested)
> 

It's plausible as it is a potential source of leaking but as you note
in another mail, it's surprising to me that valid struct pages, even if
within memory holes and reserved would have broken node/zone information
in the page flags.

-- 
Mel Gorman
SUSE Labs
