Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC22C5BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391709AbgKZSPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391523AbgKZSPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606414520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr8wXcIpPppGS97jdPzVZuGasHPDWlCeBn83szgFA6k=;
        b=FvSmYs7M3QW4bW1EEj3QTCOrcgaRd4pDkN5V6jwvAvZB9DWQNshzoJd7VdtJY7P6QHWNyQ
        okwnNU11bvACNnf0ZPIcc5+1PFqWwGUp+5PL1aaiRVpg0KffO9My6pNSQbbE1dClBNAmpq
        +qv73sKZzlB/4/bSoeAmINNGf8yUvMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-bS2Ru4VcNzO3HKNt1GylXQ-1; Thu, 26 Nov 2020 13:15:18 -0500
X-MC-Unique: bS2Ru4VcNzO3HKNt1GylXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9941805BFC;
        Thu, 26 Nov 2020 18:15:16 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02DEB60855;
        Thu, 26 Nov 2020 18:15:13 +0000 (UTC)
Date:   Thu, 26 Nov 2020 13:15:12 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X7/wsNx9fInRZtQx@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:05:14AM +0100, David Hildenbrand wrote:
> I agree that this is sub-optimal, as such pages are impossible to detect
> (PageReserved is just not clear as discussed with Andrea). The basic
> question is how we want to proceed:
> 
> a) Make sure any online struct page has a valid nid/zid, and is spanned
> by the nid/zid.
> b) Use a fake nid that will bail out when used for page_zone() and
> page_pgdat(), and make pfn walkers detect that.
> 
> AFAIU, Andrea seems to prefer a). I thing b) might be easier in corner
> cases. Thoughts?

Yes that's a good summary.

My reason I slightly prefer a) is that it will perform faster at
runtime.

I seen also the proposed patch that adds the pfn_to_page embedded in
pfn_valid to show those pfn as invalid, that is especially slow and I
don't like it for that reason. Additional bugchecks for NO_NODEID will
slowdown things too, so they should be justified by some benefit. It
concerns me if pfn_valid becomes slower.

b) will also make compaction bail out on that pageblock which it
doesn't need to so it'll provide a worse runtime to compaction as
well.

a) is what the code already does if only the e820 map range was
reserved with memblock_reserved, after applying Mike's patch to
initialize reserved memblock regions too.

It turns out the VM_BUG_ON_PAGE, as far as compaction is concerned, is
just a false positive, it detected a broken VM invariant, but it was
fine to proceed in the DEBUG_VM=n case that wouldn't crash.

Before da50c57bdbb8e37ec6f8c934a2f8acbf4e4fdfb9 the struct page
corresponding to the e820 unknown type range page wouldn't be marked
PageReserved, that also looked wrong but it was also basically harmless.

Neither of the two defects is too bad: it could be ignored if we just
remove the bugcheck, but it's just nice if the bugcheck turn out to be
correct in the pageblock.

If we initialize all RAM and non-RAM ranges in the same way, then
there's no discrepancy. Mike's patch seem to do just that by walking
the memblock.reserved memblocks in the same way as the
memblock.memory.

NOTE: I would also much prefer b) if only it would guarantee zero
runtime slowdown. (Which is I especially dislike pfn_valid internally
calling pfn_to_page)

Thanks,
Andrea

