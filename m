Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20F4247C70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 05:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRDGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 23:06:02 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52130 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgHRDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:06:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U66CMbv_1597719958;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U66CMbv_1597719958)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 11:05:58 +0800
Date:   Tue, 18 Aug 2020 11:05:58 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_reporting: the "page" must not be the list head
Message-ID: <20200818030558.GC29756@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
 <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
 <aaa56d83-2444-d74e-025a-508a2be6b772@linux.intel.com>
 <c362eb24-d4bc-82e8-e813-0951ce50b440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c362eb24-d4bc-82e8-e813-0951ce50b440@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:07:04PM +0200, David Hildenbrand wrote:
>On 17.08.20 18:05, Alexander Duyck wrote:
>> 
>> 
>> On 8/17/2020 2:35 AM, David Hildenbrand wrote:
>>> On 17.08.20 10:48, Wei Yang wrote:
>>>> If "page" is the list head, list_for_each_entry_safe() would stop
>>>> iteration.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>> ---
>>>>   mm/page_reporting.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>>>> index 3bbd471cfc81..aaaa3605123d 100644
>>>> --- a/mm/page_reporting.c
>>>> +++ b/mm/page_reporting.c
>>>> @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>>>>   		 * the new head of the free list before we release the
>>>>   		 * zone lock.
>>>>   		 */
>>>> -		if (&page->lru != list && !list_is_first(&page->lru, list))
>>>> +		if (!list_is_first(&page->lru, list))
>>>>   			list_rotate_to_front(&page->lru, list);
>>>>   
>>>>   		/* release lock before waiting on report processing */
>>>>
>>>
>>> Is this a fix or a cleanup? If it's a fix, can this be reproduced easily
>>> and what ere the effects?
>>>
>> 
>> This should be a clean-up. Since the &page->lru != list will always be true.
>> 
>
>Makes sense, maybe we can make that a little bit clearer in the patch
>description.
>

Ok, do you have some suggestion on the description?

   A clean-up for commit xxx?

I would appreciate your suggestion :-)

>> If I recall at some point the that was a check for &next->lru != list 
>> but I think I pulled out an additional conditional check somewhere so 
>> that we just go through the start of the loop again and iterate over 
>> reported pages until we are guaranteed to have a non-reported page to 
>> rotate to the top of the list with the general idea being that we wanted 
>> the allocator to pull non-reported pages before reported pages.
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
