Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45892FFA13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAVBm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:42:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11424 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAVBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:42:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMMRb540xzj9jy;
        Fri, 22 Jan 2021 09:41:15 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 09:42:09 +0800
Subject: Re: [PATCH] hugetlbfs: make hugepage size conversion more readable
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210120092348.13811-1-linmiaohe@huawei.com>
 <668845df-e654-ecdc-c32a-b50a22098333@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <65c34b40-7c0f-6102-da3b-586551b50453@huawei.com>
Date:   Fri, 22 Jan 2021 09:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <668845df-e654-ecdc-c32a-b50a22098333@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/22 3:00, Mike Kravetz wrote:
> On 1/20/21 1:23 AM, Miaohe Lin wrote:
>> The calculation 1U << (h->order + PAGE_SHIFT - 10) is actually equal to
>> (PAGE_SHIFT << (h->order)) >> 10. So we can make it more readable by
>> replace it with huge_page_size(h) / SZ_1K.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 25c1857ff45d..f94b8f6553fa 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
>>  		put_fs_context(fc);
>>  	}
>>  	if (IS_ERR(mnt))
>> -		pr_err("Cannot mount internal hugetlbfs for page size %uK",
>> -		       1U << (h->order + PAGE_SHIFT - 10));
>> +		pr_err("Cannot mount internal hugetlbfs for page size %luK",
>> +		       huge_page_size(h) / SZ_1K);
> 
> I appreciate the effort to make the code more readable.  The existing
> calculation does take a minute to understand.  However, it is correct and
> anyone modifying the code should be able to understand.
> 
> With my compiler, your proposed change adds an additional instruction to
> the routine mount_one_hugetlbfs.  I know this is not significant, but still

I thought compiler would generate the same code...

> it does increase the kernel size for a change that is of questionable value.
> 
> In the kernel, size in KB is often calculated as (size << (PAGE_SHIFT - 10)).
> If you change the calculation in the hugetlb code to be:
> > 			huge_page_size(h) << (PAGE_SHIFT - 10)

I'am sorry but this looks not really correct. I think the calculation shoud be
huge_page_size(h) >> 10. What do you think?

> 
> my compiler will actually reduce the size of the routine by one instruction.
> 
Many thanks.
