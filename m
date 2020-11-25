Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E972C3DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgKYKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:39:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgKYKjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:39:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB4E8AC60;
        Wed, 25 Nov 2020 10:39:35 +0000 (UTC)
Date:   Wed, 25 Nov 2020 10:39:33 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201125103933.GM3306@suse.de>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
> > Something must have changed more recently than v5.1 that caused the
> > zoneid of reserved pages to be wrong, a possible candidate for the
> > real would be this change below:
> > 
> > +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> > 
> 
> Before that change, the memmap of memory holes were only zeroed out. So the zones/nid was 0, however, pages were not reserved and had a refcount of zero - resulting in other issues.
> 
> Most pfn walkers shouldn???t mess with reserved pages and simply skip them. That would be the right fix here.
> 

Ordinarily yes, pfn walkers should not care about reserved pages but it's
still surprising that the node/zone linkages would be wrong for memory
holes. If they are in the middle of a zone, it means that a hole with
valid struct pages could be mistaken for overlapping nodes (if the hole
was in node 1 for example) or overlapping zones which is just broken.

> > 
> > Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> > all times, otherwise if the second stage fails we end up in a bug with
> > weird side effects.
> 
> Memory holes with a valid memmap might not have a zone/nid. For now, skipping reserved pages should be good enough, no?
> 

It would partially paper over the issue that setting the pageblock type
based on a reserved page. I agree that compaction should not be returning
pfns that are outside of the zone range because that is buggy in itself
but valid struct pages should have valid information. I don't think we
want to paper over that with unnecessary PageReserved checks.

-- 
Mel Gorman
SUSE Labs
