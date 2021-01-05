Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C382EB20F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbhAESGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730743AbhAESGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609869920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UESOViXeUqqgxTdJOAvu5P6aSrx26z1BgEX3o3McZLI=;
        b=gK+EbbmoXYwl0CHUhBOylcDh+3rzbaCuvnZRg0d1qhkEeG+VgWaVxpYSt3A1NQjgv96nLt
        am5CoOraNs2OZ+QKvXOHDT/dr92FMnsECaHlH9deUO2EElrxu+st7mknHZ9xkEwnAkFGZO
        x0pBhPgPyNusRsOKyF/tusGvNACb1YY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-wVG8_QOEOE2lzpYxfpzJkw-1; Tue, 05 Jan 2021 13:05:18 -0500
X-MC-Unique: wVG8_QOEOE2lzpYxfpzJkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4A984A5E0;
        Tue,  5 Jan 2021 18:05:16 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1A5D1F46F;
        Tue,  5 Jan 2021 18:05:13 +0000 (UTC)
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Yang Shi <shy828301@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hillf.zj@alibaba-inc.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <d81664e1-bde0-4dcb-f602-6eb201ceada0@redhat.com>
 <CAHbLzko4BH6GOJsz33NEbwLTxJQJxVHH3qLzHzoM1LycT=ccbg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e6eb5ffa-403a-7012-db7e-f2e5a015f6de@redhat.com>
Date:   Tue, 5 Jan 2021 19:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzko4BH6GOJsz33NEbwLTxJQJxVHH3qLzHzoM1LycT=ccbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 19:04, Yang Shi wrote:
> On Tue, Jan 5, 2021 at 8:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.01.21 07:58, Muchun Song wrote:
>>> If the refcount is one when it is migrated, it means that the page
>>> was freed from under us. So we are done and do not need to migrate.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  mm/migrate.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 4385f2fb5d18..a6631c4eb6a6 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>>               return -ENOSYS;
>>>       }
>>>
>>> +     if (page_count(hpage) == 1) {
>>> +             /* page was freed from under us. So we are done. */
>>> +             putback_active_hugepage(hpage);
>>> +             return MIGRATEPAGE_SUCCESS;
>>> +     }
>>> +
>>>       new_hpage = get_new_page(hpage, private);
>>>       if (!new_hpage)
>>>               return -ENOMEM;
>>>
>>
>> This series seems to fix quite some important cases (thanks). Do we want
>> to cc stable some/all?
> 
> For this particular one, I don't think so IMHO. It is an optimization
> rather than a bug fix.

I'm rather referring to the actual fixes (I received no cover letter so
I picked the first patch in the series)


-- 
Thanks,

David / dhildenb

