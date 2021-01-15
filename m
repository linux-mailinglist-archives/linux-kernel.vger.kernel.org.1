Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFE2F7058
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbhAOCFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:05:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11534 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbhAOCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:05:06 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH4G04rtLzMKKS;
        Fri, 15 Jan 2021 10:03:04 +0800 (CST)
Received: from [10.174.176.197] (10.174.176.197) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 10:04:19 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210114113140.23069-1-linmiaohe@huawei.com>
 <853d6aa4-b84c-7ac2-00d4-402893fcf6b3@redhat.com>
 <b7587d72-fb5b-4e0f-4fa0-d63e035e521c@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9841241e-eb8f-9b49-8d2d-d84effda8ba4@huawei.com>
Date:   Fri, 15 Jan 2021 10:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b7587d72-fb5b-4e0f-4fa0-d63e035e521c@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 2021/1/15 3:16, Mike Kravetz wrote:
> On 1/14/21 4:32 AM, David Hildenbrand wrote:
>> On 14.01.21 12:31, Miaohe Lin wrote:
>>> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
>>> and releasing hugetlb_lock.
>>
>> So, what's the deal then? Adding more code?
>>
>> If this is a performance improvement, we should spell it out. Otherwise
>> I don't see a real benefit of this patch.
>>
> 
> Thanks for finding/noticing this.
> 
> As David points out, the commit message should state that this is a
> performance improvement.  Mention that such a change avoids an unnecessary
> hugetlb_lock lock/unlock cycle.  You can also mention that this unnecessary
> lock cycle is happening on 'most' hugetlb munmap operations.
> 

My bad. I should spell this out explicitly. Many thanks for both of you.

>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/hugetlb.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 737b2dce19e6..fe2da9ad6233 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -5241,7 +5241,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>>>  	 * reservations to be released may be adjusted.
>>>  	 */
>>>  	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
>>> -	hugetlb_acct_memory(h, -gbl_reserve);
>>> +	if (gbl_reserve)
>>> +		hugetlb_acct_memory(h, -gbl_reserve);
> 
> It is true that gbl_reserve is likely to be 0 in this code path.  However,
> there are other code paths where hugetlb_acct_memory is called with a delta
> value of 0 as well.  I would rather see a simple check at the beginning of
> hugetlb_acct_memory like.
> 
> 	if (!delta)
> 		return 0;
> 

Sounds good. Will do it in v2. Many thanks again.
