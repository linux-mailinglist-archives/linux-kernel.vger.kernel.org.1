Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFA28F314
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgJONTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:19:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728418AbgJONTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:19:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E6C65124808B93566D67;
        Thu, 15 Oct 2020 21:19:13 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 21:19:06 +0800
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
To:     <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>,
        <linfeilong@huawei.com>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <a220bf939f0c9aece318197881d6f092@suse.de>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <5cfdd51c-c539-5d30-6388-168dfd83f6b5@huawei.com>
Date:   Thu, 15 Oct 2020 21:19:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a220bf939f0c9aece318197881d6f092@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/15 20:58, osalvador@suse.de wrote:
> On 2020-10-15 14:15, Shijie Luo wrote:
>> When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code breaks
>>  and passing origin pte - 1 to pte_unmap_unlock seems like not a good 
>> idea.
>>
>> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
>> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
>> ---
>>  mm/mempolicy.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 3fde772ef5ef..01f088630d1d 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -571,7 +571,11 @@ static int queue_pages_pte_range(pmd_t *pmd,
>> unsigned long addr,
>>          } else
>>              break;
>>      }
>> -    pte_unmap_unlock(pte - 1, ptl);
>> +
>> +    if (addr >= end)
>> +        pte = pte - 1;
>> +
>> +    pte_unmap_unlock(pte, ptl);
>
> But this is still wrong, isn't it?
> Unless I am missing something, this is "only" important under 
> CONFIG_HIGHPTE.
>
> We have:
>
> pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>
> which under CONFIG_HIGHPTE does a kmap_atomoc.
>
> Now, we either break the loop in the first pass because of 
> !(MPOL_MF_MOVE | MPOL_MF_MOVE_ALL),
> or we keep incrementing pte by every pass.
> Either way is wrong, because the pointer kunmap_atomic gets will not 
> be the same (since we incremented pte).
>
> Or is the loop meant to be running only once, so pte - 1 will bring us 
> back to the original pte?
>
> .

Thanks for your reply, if we break the loop in the first pass, the pte 
pointer will not be incremented,

pte - 1 equals original pte - 1,  because we only increase pte pointer 
when not break the loop.

