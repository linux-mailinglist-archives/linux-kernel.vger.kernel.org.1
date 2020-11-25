Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3952C4817
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKYTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:15:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgKYTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606331698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaAgfQKT5g1bR2ENPqlxB2R/c5CFFmnrxcG/cpXyVp0=;
        b=gbrD2DS3199d6L8MvGAeV1fYaQpTqsD0D1+lZPtg06OkxQ0Tr5guwr52yOmcJ/DhqvUDQz
        7o5i1hSojOqrLuudD5jHypHMKw5piA2R5sWE4qjKyKMzQtAmeU9FaH1calJ9bOqAIrDa7V
        6pCNqRXPA0aI2I3Dc+JfxDkvc/llsk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-oDp0gM0yP0W4h5iMGBIhbQ-1; Wed, 25 Nov 2020 14:14:54 -0500
X-MC-Unique: oDp0gM0yP0W4h5iMGBIhbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C388100F345;
        Wed, 25 Nov 2020 19:14:52 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DAB560854;
        Wed, 25 Nov 2020 19:14:49 +0000 (UTC)
Date:   Wed, 25 Nov 2020 14:14:48 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X76tKLSpxKqwrmin@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
 <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
 <20201125141325.GK123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125141325.GK123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:13:25PM +0200, Mike Rapoport wrote:
> I suspect that memmap for the reserved pages is not properly initialized
> after recent changes in free_area_init(). They are cleared at
> init_unavailable_mem() to have zone=0 and node=0, but they seem to be

I'd really like if we would not leave those to 0,0 and if we set the
whole struct page at 0xff, if we miss the second stage that corrects
the uninitialized value. The hope is that it'll crash faster and more
reproducible that way.

> never re-initialized with proper zone and node links which was not the
> case before commit 73a6e474cb37 ("mm: memmap_init: iterate over memblock
> regions rather that check each PFN").

What's strange is that 73a6e474cb37 was suggested as fix for this
bug...

	https://lkml.kernel.org/r/20200505124314.GA5029@MiWiFi-R3L-srv

The addition of "pageblock_pfn_to_page" to validate min_pfn was added
in commit 73a6e474cb37, so I assumed that the first report below
didn't have commit 73a6e474cb37 already applied.

	https://lkml.kernel.org/r/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw

However if you're correct perhaps the patch was already applied in
5.7.0-rc2-next-20200423+, it landed upstream in v5.8 after all.

> Back then, memmap_init_zone() looped from zone_start_pfn till
> zone_end_pfn and struct page for reserved pages with pfns inside the
> zone would be initialized.
> 
> Now the loop is for interesection of [zone_start_pfn, zone_end_pfn] with
> memblock.memory and for x86 reserved ranges are not in memblock.memory,
> so the memmap for them remains semi-initialized.

That would matches the symptoms. I'll test it as first thing after
confirming older kernels had the right zoneid/nid on the reserved
pages.

Thanks,
Andrea

