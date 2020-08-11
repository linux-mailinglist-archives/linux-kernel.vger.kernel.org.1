Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5733124219B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 17:05:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgHKVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597179945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w/CFevgv2LKIcwPhT6heCKR78UGNjJRfEsDBre7Lx3E=;
        b=bMFXFwR1ylx2WUw5xLpFJPY1AhdrHUL+9pHSxKAs5GySeHXiS5Foe6todYKpG8zzW44PeU
        9iU3xxOgR9WRpL6oMbwl+jOg0e/fXjzBD8xP2WbQom7q43rsqq0F8igjkdwGC9IVn+ZNb6
        AK4VO8XEd4IOQExsNrh6yPvUwKCdSrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-2m7ImA_RPiqWc0AB5v2X2Q-1; Tue, 11 Aug 2020 17:05:42 -0400
X-MC-Unique: 2m7ImA_RPiqWc0AB5v2X2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7665C8015FC;
        Tue, 11 Aug 2020 21:05:40 +0000 (UTC)
Received: from [10.36.112.12] (ovpn-112-12.ams2.redhat.com [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 930DA5D9D7;
        Tue, 11 Aug 2020 21:05:38 +0000 (UTC)
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        rientjes@google.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com>
Date:   Tue, 11 Aug 2020 23:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.20 14:58, Charan Teja Reddy wrote:
> The following race is observed with the repeated online, offline and a
> delay between two successive online of memory blocks of movable zone.
> 
> P1						P2
> 
> Online the first memory block in
> the movable zone. The pcp struct
> values are initialized to default
> values,i.e., pcp->high = 0 &
> pcp->batch = 1.
> 
> 					Allocate the pages from the
> 					movable zone.
> 
> Try to Online the second memory
> block in the movable zone thus it
> entered the online_pages() but yet
> to call zone_pcp_update().
> 					This process is entered into
> 					the exit path thus it tries
> 					to release the order-0 pages
> 					to pcp lists through
> 					free_unref_page_commit().
> 					As pcp->high = 0, pcp->count = 1
> 					proceed to call the function
> 					free_pcppages_bulk().
> Update the pcp values thus the
> new pcp values are like, say,
> pcp->high = 378, pcp->batch = 63.
> 					Read the pcp's batch value using
> 					READ_ONCE() and pass the same to
> 					free_pcppages_bulk(), pcp values
> 					passed here are, batch = 63,
> 					count = 1.
> 
> 					Since num of pages in the pcp
> 					lists are less than ->batch,
> 					then it will stuck in
> 					while(list_empty(list)) loop
> 					with interrupts disabled thus
> 					a core hung.
> 
> Avoid this by ensuring free_pcppages_bulk() is called with proper count
> of pcp list pages.
> 
> The mentioned race is some what easily reproducible without [1] because
> pcp's are not updated for the first memory block online and thus there
> is a enough race window for P2 between alloc+free and pcp struct values
> update through onlining of second memory block.
> 
> With [1], the race is still exists but it is very much narrow as we
> update the pcp struct values for the first memory block online itself.
> 
> [1]: https://patchwork.kernel.org/patch/11696389/
> 

IIUC, this is not limited to the movable zone, it could also happen in
corner cases with the normal zone (e.g., hotplug to a node that only has
DMA memory, or no other memory yet).

> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
> 
> v1: https://patchwork.kernel.org/patch/11707637/
> 
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e4896e6..839039f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	struct page *page, *tmp;
>  	LIST_HEAD(head);
>  
> +	/*
> +	 * Ensure proper count is passed which otherwise would stuck in the
> +	 * below while (list_empty(list)) loop.
> +	 */
> +	count = min(pcp->count, count);
>  	while (count) {
>  		struct list_head *list;
>  
> 

Fixes: and Cc: stable... tags?

-- 
Thanks,

David / dhildenb

