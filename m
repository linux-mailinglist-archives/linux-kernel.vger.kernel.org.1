Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7624FD72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 14:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHXMHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 08:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgHXMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:07:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC1D3AC19;
        Mon, 24 Aug 2020 12:07:45 +0000 (UTC)
Date:   Mon, 24 Aug 2020 14:07:13 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v2 10/10] mm/memory_hotplug: mark pageblocks
 MIGRATE_ISOLATE while onlining memory
Message-ID: <20200824120713.GB7491@linux>
References: <20200819175957.28465-1-david@redhat.com>
 <20200819175957.28465-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819175957.28465-11-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:59:57PM +0200, David Hildenbrand wrote:
> Currently, it can happen that pages are allocated (and freed) via the buddy
> before we finished basic memory onlining.
> 
> For example, pages are exposed to the buddy and can be allocated before
> we actually mark the sections online. Allocated pages could suddenly
> fail pfn_to_online_page() checks. We had similar issues with pcp
> handling, when pages are allocated+freed before we reach
> zone_pcp_update() in online_pages() [1].
> 
> Instead, mark all pageblocks MIGRATE_ISOLATE, such that allocations are
> impossible. Once done with the heavy lifting, use
> undo_isolate_page_range() to move the pages to the MIGRATE_MOVABLE
> freelist, marking them ready for allocation. Similar to offline_pages(),
> we have to manually adjust zone->nr_isolate_pageblock.
> 
> [1] https://lkml.kernel.org/r/1597150703-19003-1-git-send-email-charante@codeaurora.org
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Charan Teja Reddy <charante@codeaurora.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
