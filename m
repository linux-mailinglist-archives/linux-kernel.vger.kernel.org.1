Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766312C4727
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgKYSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730420AbgKYSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606327209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2TfpgLBbqTLgJ/HITwubrW+9Ir09rOmpEtYtMzPxVI=;
        b=fO67HqHCbQs28MFcfeaNq44Hi9X9aH8vZxiDCRTFY8yQTqBjN/N4OGoCIdRHBunis2ZyF3
        n5hpvxQ2xMSprnbimzRzzWH3uQTf754FYq3clCURf8mE1sWrZ1bKdynhONLY7hU8kQ7wwr
        9iWYQhtCCkH8MfvW3CH+MCQvaVsXBSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-LYalrKdJM3iCrbc3A1jHRg-1; Wed, 25 Nov 2020 13:00:04 -0500
X-MC-Unique: LYalrKdJM3iCrbc3A1jHRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3245C1074640;
        Wed, 25 Nov 2020 18:00:03 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 836E260855;
        Wed, 25 Nov 2020 17:59:59 +0000 (UTC)
Date:   Wed, 25 Nov 2020 12:59:58 -0500
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
Message-ID: <X76bnmBb2rkef/nS@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
 <X71zdnZd61r429aO@redhat.com>
 <20201125103053.GL3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125103053.GL3306@suse.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:30:53AM +0000, Mel Gorman wrote:
> On Tue, Nov 24, 2020 at 03:56:22PM -0500, Andrea Arcangeli wrote:
> > Hello,
> > 
> > On Tue, Nov 24, 2020 at 01:32:05PM +0000, Mel Gorman wrote:
> > > I would hope that is not the case because they are not meant to overlap.
> > > However, if the beginning of the pageblock was not the start of a zone
> > > then the pages would be valid but the pfn would still be outside the
> > > zone boundary. If it was reserved, the struct page is valid but not
> > > suitable for set_pfnblock_flags_mask. However, it is a concern in
> > > general because the potential is there that pages are isolated from the
> > > wrong zone.
> > 
> > I guess we have more than one issue to correct in that function
> > because the same BUG_ON reproduced again even with the tentative patch
> > I posted earlier.
> > 
> > So my guess is that the problematic reserved page isn't pointed by the
> > min_pfn, but it must have been pointed by the "highest" variable
> > calculated below?
> > 
> > 			if (pfn >= highest)
> > 				highest = pageblock_start_pfn(pfn);
> > 
> > When I looked at where "highest" comes from, it lacks
> > pageblock_pfn_to_page check (which was added around v5.7 to min_pfn).
> > 
> > Is that the real bug, which may be fixed by something like this? (untested)
> > 
> 
> It's plausible as it is a potential source of leaking but as you note
> in another mail, it's surprising to me that valid struct pages, even if
> within memory holes and reserved would have broken node/zone information
> in the page flags.

I think the patch to add pageblock_pfn_to_page is still needed to cope
with !pfn_valid or a pageblock in between zones, but pfn_valid or
pageblock in between zones is not what happens here.

So the patch adding pageblock_pfn_to_page would have had the undesired
side effect of hiding the bug so it's best to deal with the other bug
first.

