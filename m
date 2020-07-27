Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7B22EC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgG0MYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 08:24:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28166 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728292AbgG0MYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595852644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ld82Mx2jdY88y70RF5lgMLftQqJLR4BjtuJgddo1PVw=;
        b=KvMa4fYLP04J+QDFsB/FofB1dfLkXYR9WxxTaoRIllsniT2HNPkxV5l/j4CHsgY8gbBtKm
        3YDrPEa9rqalH06WcGvEWnR6busje2M7eYKtpYNMreg1qDsUrE1/L5iPeqtsimxSfOrojL
        Qc6TIEn0ZJT1WG8hQ9ZbMdwpmJj88Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-hY0ts04GOnyiXrCDnJU5Pg-1; Mon, 27 Jul 2020 08:24:00 -0400
X-MC-Unique: hY0ts04GOnyiXrCDnJU5Pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F7684CD40;
        Mon, 27 Jul 2020 12:23:59 +0000 (UTC)
Received: from [10.36.114.48] (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F051379D02;
        Mon, 27 Jul 2020 12:23:52 +0000 (UTC)
Subject: Re: [PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization
 in has_unmovable_pages() to memory offlining
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-6-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <8f0dfc91-bf91-4d9c-a4f5-ebaeb568b39b@redhat.com>
Date:   Mon, 27 Jul 2020 14:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630142639.22770-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.20 16:26, David Hildenbrand wrote:
> We can already have pages that can be offlined but not allocated in
> ZONE_MOVABLE - PageHWPoison pages. While these pages can be skipped when
> offlining ("moving them to /dev/null"), we cannot move them when
> allocating.
> 
> virtio-mem managed memory is similar. The logical memory holes
> corresponding to unplug memory ranges can be skipped when offlining,
> however, the pages cannot be moved. Currently, virtio-mem special-cases
> ZONE_MOVABLE, such that:
> - partially plugged memory blocks it added to Linux cannot be onlined to
>   ZONE_MOVABLE
> - when unplugging memory, it will never consider memory blocks that were
>   onlined to ZONE_MOVABLE
> 
> We also want to support ZONE_MOVABLE in virtio-mem for both cases. Note
> that virtio-mem does not blindly try to unplug random pages within its
> managed memory region. It always plugs memory left-to-right and tries to
> unplug memory right-to-left - in roughly MAX_ORDER - 1 granularity. In
> theory, the movable ZONE part would only shrink when unplugging memory
> from ZONE_MOVABLE.
> 
> Let's perform the ZONE_MOVABLE optimization only for memory offlining,
> such that we reduce the number of false positives from
> has_unmovable_pages() in case of alloc_contig_range() on ZONE_MOVABLE.
> 
> Note: We currently don't seem to have any user of alloc_contig_range()
> that actually uses ZONE_MOVABLE. This change is mostly valuable for the
> documentation.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bd3ebf08f09b9..45077d74d975d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8237,9 +8237,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		/*
>  		 * If the zone is movable and we have ruled out all reserved
>  		 * pages then it should be reasonably safe to assume the rest
> -		 * is movable.
> +		 * is movable. As we can have some pages in the movable zone
> +		 * that are only considered movable for memory offlining (esp.,
> +		 * PageHWPoison and PageOffline that will be skipped), we
> +		 * perform this optimization only for memory offlining.
>  		 */
> -		if (zone_idx(zone) == ZONE_MOVABLE)
> +		if ((flags & MEMORY_OFFLINE) && zone_idx(zone) == ZONE_MOVABLE)
>  			continue;
>  
>  		/*
> 

So, as we don't have any alloc_contig_range() users that use
ZONE_MOVABLE for now, and virtio-mem will be the only one for now (which
accounts for 50% of the special cases - PG_offline), I think we might
drop this patch.

Worst think is that if we ever have other alloc_contig_range() users,
that we return "false" from has_unmovable_pages() and fail later when
trying to migrate/isolate all pages. This should, however, only happen
in rare cases (and there are already other cases where we have basically
unmovable data - long-term pinnings).

On the plus side, keeping the ZONE_MOVABLE optimizations here also
allows virtio-mem to better tolerate unstable page flags when trying to
alloc_contig_range().

Thoughts?

-- 
Thanks,

David / dhildenb

