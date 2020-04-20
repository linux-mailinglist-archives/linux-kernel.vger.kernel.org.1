Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470A1B0742
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:20:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F58C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f0cvpJYoLzD97qtyZ06Wi/pSIo+Zf1D3ZnjsqWEec+4=; b=NQpj3uRgKrebKItqEk5MSgmovV
        ZGyV/nJ32iVTWVz4HSCbk/lB/ENDVMLV7AylNHRPegzphNzNxZquGuW3BbJO8FwpSgDFj5FvR/a5i
        lZh9AOHIDVN8BR1Y5kpTuhY2rzFoxYBhuJBdwy2S0MHLsdwZTem75KHH554S2Yn+R/yoNuS2CIWTU
        aQwVO6UH0HwwKqkNjBHqw2soj35C7UM6HIw7aNx1zkGH+RmO6MzqjMQnIfZ8L4m6VcEuwASBqAT5H
        Up3sZvtk6xvWyvnwte4HXE4T29WmV/AxL2lDWgLY0jTfWfqJrY6cPJJjiuOr45FWMmhrB4TmDrOo6
        2mCJjB7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQUTC-0005QJ-Ff; Mon, 20 Apr 2020 11:20:10 +0000
Date:   Mon, 20 Apr 2020 04:20:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
Message-ID: <20200420112010.GA5820@bombadil.infradead.org>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 04:59:33PM +0900, js1304@gmail.com wrote:
> ZONE_MOVABLE is special. It is considered as normal type zone on
> !CONFIG_HIGHMEM, but, it is considered as highmem type zone
> on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
> on the ZONE_MOVABLE has no direct mapping until now.
> 
> However, following patchset
> "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
> , which is once merged and reverted, will be tried again and will break
> this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
> Hence, the ZONE_MOVABLE which is considered as highmem type zone could
> have the both types of pages, direct mapped and not. Since
> the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
> required to allocate the memory from it. And, we conservatively need to
> consider the ZONE_MOVABLE as highmem type zone.

I don't understand why CMA allocating pages from ZONE_MOVABLE somehow
gives these pages a direct mapping.  Maybe you have a freaky layout in
the architecture that makes no sense and that's what needs to be fixed?

My understanding of the zones is based on x86, and it looks like this
on a 32-bit system with 8GB of memory:

ZONE_DMA	0-16MB
ZONE_NORMAL	16-896MB
ZONE_HIGHMEM	896-xMB
ZONE_MOVABLE	x-8192MB

where x is a boot option used to partition the highmem between movable
and unmovable.

Now, why would allocating the CMA from ZONE_NORMAL suddenly make these
pages part of the direct mapping?
