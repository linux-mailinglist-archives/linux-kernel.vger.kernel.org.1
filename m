Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9DE2C4803
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKYTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgKYTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606330927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uFZEde0fjOKdsoDsRuCfq7lnGFjepdQaAwnfRHGJI0=;
        b=NSt6QhKhrqp1rw37UUY6NrT0A2tiHeoQI8bPfoqwrROwmOzgBQIoQanLtM9uUN/TxI4wM8
        F+vsGISJaOsc0dRgXg0HoQVEt6Fl9f9FCQfRpLCfw37h4SHzZHAGakiKfl2MunL1kioUaE
        sXfb10q7pGsUgpJr4a854KYYlvyEl2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-osmPAM7sNPiVfU8_dn8syg-1; Wed, 25 Nov 2020 14:02:03 -0500
X-MC-Unique: osmPAM7sNPiVfU8_dn8syg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BA61E7C7;
        Wed, 25 Nov 2020 19:02:01 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 924B65D9CA;
        Wed, 25 Nov 2020 19:01:57 +0000 (UTC)
Date:   Wed, 25 Nov 2020 14:01:56 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X76qJCg0Pa8diO59@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:08:54PM +0100, Vlastimil Babka wrote:
> Yeah I guess it would be simpler if zoneid/nid was correct for 
> pfn_valid() pfns within a zone's range, even if they are reserved due 
> not not being really usable memory.
> 
> I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
> chosen solution is to make this to a real hole, the hole should be 
> extended to MAX_ORDER_NR_PAGES aligned boundaries.

The way pfn_valid works it's not possible to render all non-RAM pfn as
!pfn_valid, CONFIG_HOLES_IN_ZONE would not achieve it 100% either. So
I don't think we can rely on that to eliminate all non-RAM reserved
pages from the mem_map and avoid having to initialize them in the
first place. Some could remain as in this case since in the same
pageblock there's non-RAM followed by RAM and all pfn are valid.

> In any case, compaction code can't fix this with better range checks.

David's correct that it can, by adding enough PageReserved (I'm
running all systems reproducing this with plenty of PageReserved
checks in all places to work around it until we do a proper fix).

My problem with that is that 1) it's simply non enforceable at runtime
that there is not missing PageReserved check and 2) what benefit it
would provide to leave a wrong zoneid in reserved pages and having to
add extra PageReserved checks?

A struct page has a deterministic zoneid/nid, if it's pointed by a
valid pfn (as in pfn_valid()) the simplest is that the zoneid/nid in
the page remain correct no matter if it's reserved at boot, it was
marked reserved by a driver that swap the page somewhere else with the
GART or EFI or something else. All reserved pages should work the
same, RAM and non-RAM, since the non-RAM status can basically change
at runtime if a driver assigns the page to hw somehow.

NOTE: on the compaction side, we still need to add
thepageblock_pfn_to_page to validate the "highest" pfn because the
pfn_valid() check is missing on the first pfn on the pageblock as it's
also missing the check of a pageblock that spans over two different
zones.

Thanks,
Andrea

