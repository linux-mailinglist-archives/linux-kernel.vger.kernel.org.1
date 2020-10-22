Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB73F295EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898989AbgJVMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504148AbgJVMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:52:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4F2CAECD;
        Thu, 22 Oct 2020 12:52:08 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:52:00 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 7/7] mm, page_alloc: disable pcplists during memory
 offline
Message-ID: <20201022125159.GE26121@linux>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-8-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-8-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:42:01PM +0200, Vlastimil Babka wrote:
> Memory offline relies on page isolation can race with process freeing pages to
> pcplists in a way that a page from isolated pageblock can end up on pcplist.
> This can be worked around by repeated draining of pcplists, as done by commit
> 968318261221 ("mm/memory_hotplug: drain per-cpu pages again during memory
> offline").
> 
> David and Michal would prefer that this race was closed in a way that callers
> of page isolation who need stronger guarantees don't need to repeatedly drain.
> David suggested disabling pcplists usage completely during page isolation,
> instead of repeatedly draining them.
> 
> To achieve this without adding special cases in alloc/free fastpath, we can use
> the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
> will be immediately flushed.
> 
> The race can thus be closed by setting pcp->high to 0 and draining pcplists
> once, before calling start_isolate_page_range(). The draining will serialize
> after processes that already disabled interrupts and read the old value of
> pcp->high in free_unref_page_commit(), and processes that have not yet disabled
> interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
> pcplists. This guarantees no stray pages on pcplists in zones where isolation
> happens.
> 
> This patch thus adds zone_pcp_disable() and zone_pcp_enable() functions that
> page isolation users can call before start_isolate_page_range() and after
> unisolating (or offlining) the isolated pages.
> 
> Also, drain_all_pages() is optimized to only execute on cpus where pcplists are
> not empty. The check can however race with a free to pcplist that has not yet
> increased the pcp->count from 0 to 1. Thus make the drain optionally skip the
> racy check and drain on all cpus, and use this option in zone_pcp_disable().
> 
> As we have to avoid external updates to high and batch while pcplists are
> disabled, we take pcp_batch_high_lock in zone_pcp_disable() and release it in
> zone_pcp_enable(). This also synchronizes multiple users of
> zone_pcp_disable()/enable().
> 
> Currently the only user of this functionality is offline_pages().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I definitely like this one, and the implemantion looks smoth.
As Michal said in another thread, Hwposion code will also benefit from this,
since now we have a drain_all_pages dance that might be suboptimal and not
accurate.
I will get back to that once this gets merged.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Oscar Salvador
SUSE L3
