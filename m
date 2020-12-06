Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD52D0083
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLFE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgLFE3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607228893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=th8Piry8zr8jwmBoGNyqaz39iFHmvQLMDYj54glntZ8=;
        b=QtT+lCFlmBA86kR6L5VWINxnBPmVLwlhTHPnzmG8hgD9KdLire/j3wJ/FvDX+lObMvwVoj
        wBDt4ZaFeBJlkdiXVlqQjZzcPL7NF9ObDFJ/f801XXMjD0l5Nowz+i+713vSZN1ydmPoRc
        5VBw+4AdwpwiXitJM/loRzYbS/ON3/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Vg5t3QcrM3e4NKAa7b-xbA-1; Sat, 05 Dec 2020 21:26:54 -0500
X-MC-Unique: Vg5t3QcrM3e4NKAa7b-xbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5839380363C;
        Sun,  6 Dec 2020 02:26:53 +0000 (UTC)
Received: from mail (ovpn-112-148.rdu2.redhat.com [10.10.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E565D9D5;
        Sun,  6 Dec 2020 02:26:48 +0000 (UTC)
Date:   Sat, 5 Dec 2020 21:26:47 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8xBZ03epeQD/hsn@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
 <X71zdnZd61r429aO@redhat.com>
 <20201125103053.GL3306@suse.de>
 <X76bnmBb2rkef/nS@redhat.com>
 <20201126104720.GO3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126104720.GO3306@suse.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, Nov 26, 2020 at 10:47:20AM +0000, Mel Gorman wrote:
> Agreed. This thread has a lot of different directions in it at this
> point so what I'd hope for is first, a patch that initialises holes with
> zone/node linkages within a 1<<(MAX_ORDER-1) alignment. If there is a
> hole, it would be expected the pages are PageReserved. Second, a fix to
> fast_isolate that forces PFNs returned to always be within the stated
> zone boundaries.

The last two patches should resolve the struct page
initialization
https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/ and the
VM_BUG_ON_PAGE never happened again as expected.

So I looked back to see how the "distance" logic is accurate. I added
those checks and I get negative hits:

diff --git a/mm/compaction.c b/mm/compaction.c
index cc1a7f600a86..844a90b0acdf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1331,6 +1331,12 @@ fast_isolate_freepages(struct compact_control *cc)
 	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
 	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
 
+	WARN_ON_ONCE((long) low_pfn < 0);
+	WARN_ON_ONCE((long) min_pfn < 0);
+	if ((long) low_pfn < 0)
+		return cc->free_pfn;
+	if ((long) min_pfn < 0)
+		return cc->free_pfn;
 	if (WARN_ON_ONCE(min_pfn > low_pfn))
 		low_pfn = min_pfn;

Both warn-on-once triggers, so it goes negative. While it appears not
kernel crashing since pfn_valid won't succeed on negative entries and
they'll always be higher than any pfn in the freelist, is this sign
that there's further room for improvement here?

Thanks,
Andrea

