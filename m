Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3F2F2E11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbhALLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729394AbhALLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610451250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFXsqS//Qa1h2ehQGzspg6CEoG46NmAqT6A5EbYgQ7k=;
        b=fCEh+ya5kU0QgoN1gG0rZPnM6Qyo1ROJT5KoiUoPrw9R94DFn/58oAuRpFinSYlcYAQ7L7
        3QgUfnLO7jxymJkrayYSJNu8i9q4A5jms232I4+CEj2pySGZLRfSv//xGPOd1mVdowxfa8
        +DynJoRz4T+pLzjKr662Q6VqXXqN0j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-GkizPVrCNcWYPTmkRdWF4w-1; Tue, 12 Jan 2021 06:34:08 -0500
X-MC-Unique: GkizPVrCNcWYPTmkRdWF4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43DF28145F0;
        Tue, 12 Jan 2021 11:34:06 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3C6C60CBB;
        Tue, 12 Jan 2021 11:34:02 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
Date:   Tue, 12 Jan 2021 12:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112112709.GO22493@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 12:27, Michal Hocko wrote:
> On Tue 12-01-21 12:11:21, David Hildenbrand wrote:
>> On 12.01.21 12:00, David Hildenbrand wrote:
>>> On 10.01.21 13:40, Muchun Song wrote:
>>>> If the refcount is one when it is migrated, it means that the page
>>>> was freed from under us. So we are done and do not need to migrate.
>>>>
>>>> This optimization is consistent with the regular pages, just like
>>>> unmap_and_move() does.
>>>>
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Acked-by: Yang Shi <shy828301@gmail.com>
>>>> ---
>>>>  mm/migrate.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 4385f2fb5d18..a6631c4eb6a6 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>>>  		return -ENOSYS;
>>>>  	}
>>>>  
>>>> +	if (page_count(hpage) == 1) {
>>>> +		/* page was freed from under us. So we are done. */
>>>> +		putback_active_hugepage(hpage);
>>>> +		return MIGRATEPAGE_SUCCESS;
>>>> +	}
>>>> +
>>>>  	new_hpage = get_new_page(hpage, private);
>>>>  	if (!new_hpage)
>>>>  		return -ENOMEM;
>>>>
>>>
>>> Question: What if called via alloc_contig_range() where we even want to
>>> "migrate" free pages, meaning, relocate it?
>>>
>>
>> To be more precise:
>>
>> a) We don't have dissolve_free_huge_pages() calls on the
>> alloc_contig_range() path. So we *need* migration IIUC.
>>
>> b) dissolve_free_huge_pages() will fail if going below the reservation.
>> In that case we really want to migrate free pages. This even applies to
>> memory offlining.
>>
>> Either I am missing something important or this patch is more dangerous
>> than it looks like.
> 
> This is an interesting point. But do we try to migrate hugetlb pages in
> alloc_contig_range? isolate_migratepages_block !PageLRU need to be

I didn't test it so far (especially in the context of virtio-mem or
CMA), but have a TODO item on my long list of things to look at in the
future.

> marked as PageMovable AFAICS. This would be quite easy to implement but
> a more fundamental question is whether we really want to mess with
> existing pools for alloc_contig_range.

Can these pages fall onto ZONE_MOVABLE or even MIGRATE_CMA? If yes, we
really want to. And I think both is the case for "ordinary" huge pages
allocated via the buddy.

> 
> Anyway you are quite right that this change has more side effects than
> it is easy to see while it doesn't really bring any major advantage
> other than the consistency.

Free hugetlbfs pages are special. E.g., they cannot simply be skipped
when offlining. So I don't think consistency actually really applies.


-- 
Thanks,

David / dhildenb

