Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF132F323A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbhALNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbhALNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610459500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqV6xUNCn3zaauF+LhOcuwhDVizk+gj2YN6AZWHRrPo=;
        b=dBA8uVFMKzgT2VpuOKTnV4EBG/owxfqJMe5FVBlqb94vDzeJ02yol5PaoDCyRoT5cgx4hy
        JVTbOyP2z9ARHFdqi/YB9ioEdUvbydDJEaI0HvjU/1n3JzDPK9dsz8gLuIalrP5jZQbT+Y
        n8poSRL2Ytnib0CARlvJc5dJrJg/XrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-C3XE_pOpPASBYhPOkH5WOQ-1; Tue, 12 Jan 2021 08:51:36 -0500
X-MC-Unique: C3XE_pOpPASBYhPOkH5WOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A508144E7;
        Tue, 12 Jan 2021 13:51:34 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEF455C239;
        Tue, 12 Jan 2021 13:51:31 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <CAMZfGtWnATsqgdqVONgAFWAAJU=KGxVJQEt38b8JTV+UtRzkYw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <423ee403-bba7-acf6-8934-9db36d3a719a@redhat.com>
Date:   Tue, 12 Jan 2021 14:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWnATsqgdqVONgAFWAAJU=KGxVJQEt38b8JTV+UtRzkYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 14:40, Muchun Song wrote:
> On Tue, Jan 12, 2021 at 7:11 PM David Hildenbrand <david@redhat.com> wrote:
>>
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
>>>>              return -ENOSYS;
>>>>      }
>>>>
>>>> +    if (page_count(hpage) == 1) {
>>>> +            /* page was freed from under us. So we are done. */
>>>> +            putback_active_hugepage(hpage);
>>>> +            return MIGRATEPAGE_SUCCESS;
>>>> +    }
>>>> +
>>>>      new_hpage = get_new_page(hpage, private);
>>>>      if (!new_hpage)
>>>>              return -ENOMEM;
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
> 
> Without this patch, if you want to migrate a HUgeTLB page,
> the page is freed to the hugepage pool. With this patch,
> the page is also freed to the hugepage pool.
> I didn't see any different. I am missing something?

I am definitely not an expert on hugetlb pools, that's why I am asking.

Isn't it, that with your code, no new page is allocated - so
dissolve_free_huge_pages() might just refuse to dissolve due to
reservations, bailing out, no?

(as discussed, looks like alloc_contig_range() needs to be fixed to
handle this correctly)

-- 
Thanks,

David / dhildenb

