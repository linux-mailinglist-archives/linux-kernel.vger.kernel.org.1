Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993422FC788
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 03:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbhATCMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 21:12:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11407 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbhATCKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:10:54 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DL88c3QNYz7XfZ;
        Wed, 20 Jan 2021 10:09:04 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 10:10:09 +0800
Subject: Re: [PATCH] hugetlbfs: remove meaningless variable avoid_reserve
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210116092644.42697-1-linmiaohe@huawei.com>
 <2900fea0-e77c-8c6a-1529-c95ded5319e6@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <52159266-f3bf-1043-9f63-f6147355f043@huawei.com>
Date:   Wed, 20 Jan 2021 10:10:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2900fea0-e77c-8c6a-1529-c95ded5319e6@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/20 2:41, Mike Kravetz wrote:
> Please CC Andrew on hugetlb patches as they need to go through his tree.
> 
> On 1/16/21 1:26 AM, Miaohe Lin wrote:
>> The variable avoid_reserve is meaningless because we never changed its
>> value and just passed it to alloc_huge_page(). So remove it to make code
>> more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
>> hugepage yet.
> 
> One might argue that using a named variable makes the call to alloc_huge_page
> more clear.  I do not disagree with the change,  However, there are some
> subtle reasons why alloc_huge_page is called with 'avoid_reserve = 0' from
> fallocate.  Therefore, I would prefer that a comment be added above the call
> in addition to this change.  See below.
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 88751e35e69d..23ad6ed8b75f 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -680,7 +680,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>  		 */
>>  		struct page *page;
>>  		unsigned long addr;
>> -		int avoid_reserve = 0;
>>  
>>  		cond_resched();
>>  
>> @@ -717,7 +716,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>  		}
>>  
>>  		/* Allocate page and add to page cache */
> 
> Perhaps, change comment to read:
> 
> 		/*
> 		 * Allocate page without setting the avoid_reserve argument.
> 		 * There certainly are no reserves associated with the
> 		 * pseudo_vma.  However, there could be shared mappings with
> 		 * reserves for the file at the inode level.  If we fallocate
> 		 * pages in these areas, we need to consume the reserves
> 		 * to keep reservation accounting consistent.
> 		 */
> 

Many thanks for detailed and excellent comment. Will do it in v2.
Thanks again.
