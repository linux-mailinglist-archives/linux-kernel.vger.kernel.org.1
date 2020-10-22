Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9254295EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504545AbgJVMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:40:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442034AbgJVMkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:40:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1548FB934;
        Thu, 22 Oct 2020 12:40:03 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:39:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 4/7] mm, page_alloc: simplify pageset_update()
Message-ID: <20201022123958.GB26121@linux>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-5-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:41:58PM +0200, Vlastimil Babka wrote:
> pageset_update() attempts to update pcplist's high and batch values in a way
> that readers don't observe batch > high. It uses smp_wmb() to order the updates
> in a way to achieve this. However, without proper pairing read barriers in
> readers this guarantee doesn't hold, and there are no such barriers in
> e.g. free_unref_page_commit().
> 
> Commit 88e8ac11d2ea ("mm, page_alloc: fix core hung in free_pcppages_bulk()")
> already showed this is problematic, and solved this by ultimately only trusing
> pcp->count of the current cpu with interrupts disabled.
> 
> The update dance with unpaired write barriers thus makes no sense. Replace
> them with plain WRITE_ONCE to prevent store tearing, and document that the
> values can change asynchronously and should not be trusted for correctness.
> 
> All current readers appear to be OK after 88e8ac11d2ea. Convert them to
> READ_ONCE to prevent unnecessary read tearing, but mainly to alert anybody
> making future changes to the code that special care is needed.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Yeah, I never got my head around those smp_wmb()

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
