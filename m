Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14642C4874
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgKYTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728639AbgKYTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606332788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCzZEjGV2+6wxo4yercQuWLJShcOU76TLNb98oZ3taM=;
        b=Yp4EfdcdW22hAqjJuUyqf2sP0FWIwngWC4inBmeTTHMCoJUS46B2agk4baj4clcbEpTjz+
        fjEGDFdCs8gIvXodxAGjqNlBUmJ+S1pCcwMJSnEVODyCKhjxKeSK2lcy4f56Heac/weVmq
        S5x9W1pTVxSx1YDVXnsUw7aPnRXpXMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-m972k9RhMCax67Q8beC-Ww-1; Wed, 25 Nov 2020 14:33:06 -0500
X-MC-Unique: m972k9RhMCax67Q8beC-Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13EDA1084C80;
        Wed, 25 Nov 2020 19:33:05 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 239A75D9C6;
        Wed, 25 Nov 2020 19:33:02 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz> <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz> <X76qJCg0Pa8diO59@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <424bba1c-d9af-e2a9-0b5a-3a71d525bf30@redhat.com>
Date:   Wed, 25 Nov 2020 20:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X76qJCg0Pa8diO59@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 20:01, Andrea Arcangeli wrote:
> On Wed, Nov 25, 2020 at 01:08:54PM +0100, Vlastimil Babka wrote:
>> Yeah I guess it would be simpler if zoneid/nid was correct for 
>> pfn_valid() pfns within a zone's range, even if they are reserved due 
>> not not being really usable memory.
>>
>> I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
>> chosen solution is to make this to a real hole, the hole should be 
>> extended to MAX_ORDER_NR_PAGES aligned boundaries.
> 
> The way pfn_valid works it's not possible to render all non-RAM pfn as
> !pfn_valid, CONFIG_HOLES_IN_ZONE would not achieve it 100% either. So

Well, we could do it the arm64 way and provide a custom pfn_valid() and
check memblock for RAM - please don't! :D

> I don't think we can rely on that to eliminate all non-RAM reserved
> pages from the mem_map and avoid having to initialize them in the
> first place. Some could remain as in this case since in the same
> pageblock there's non-RAM followed by RAM and all pfn are valid.
> 
>> In any case, compaction code can't fix this with better range checks.
> 
> David's correct that it can, by adding enough PageReserved (I'm
> running all systems reproducing this with plenty of PageReserved
> checks in all places to work around it until we do a proper fix).
> 
> My problem with that is that 1) it's simply non enforceable at runtime
> that there is not missing PageReserved check and 2) what benefit it
> would provide to leave a wrong zoneid in reserved pages and having to
> add extra PageReserved checks?

See my other mail. If we have a clean way to set *any* memmap (non-RAM,
memory holes at any place) to a proper nid/zid, then we won't need
reserved checks. I raised some cases that need more thought than a
simple "hole in zone".


-- 
Thanks,

David / dhildenb

