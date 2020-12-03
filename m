Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311582CCFE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgLCG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:56:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:56:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmmnF0crGz15LKB;
        Thu,  3 Dec 2020 14:55:29 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 3 Dec 2020
 14:55:50 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Light Hsieh <Light.Hsieh@mediatek.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com> <20201112054051.GA4092972@google.com>
 <X8iAh7quYw77O6XC@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <df364dab-6640-654b-c36e-3f84f4bcbc2b@huawei.com>
Date:   Thu, 3 Dec 2020 14:55:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X8iAh7quYw77O6XC@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/3 14:07, Jaegeuk Kim wrote:
> On 11/11, Jaegeuk Kim wrote:
>> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
>> wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.
>>
>> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>> v3:
>>   - fix to use NM_I(sbi)
>>
>>   fs/f2fs/shrinker.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
>> index d66de5999a26..555712ba06d8 100644
>> --- a/fs/f2fs/shrinker.c
>> +++ b/fs/f2fs/shrinker.c
>> @@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
>>   
>>   static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
>>   {
>> -	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
>> +	long count;
>> +
>> +	down_read(&NM_I(sbi)->nat_tree_lock);
>> +	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
>> +	up_read(&NM_I(sbi)->nat_tree_lock);
> 
> I just fosund this can give kernel hang due to the following backtrace.
> f2fs_shrink_count
> shrink_slab
> shrink_node
> do_try_to_free_pages
> try_to_free_pages
> __alloc_pages_nodemask
> alloc_pages_current
> allocate_slab
> __slab_alloc
> __slab_alloc
> kmem_cache_alloc
> add_free_nid
> f2fs_flush_nat_entries
> f2fs_write_checkpoint

Oh, I missed that case.

> 
> Let me just check like this.
> 
>>From 971163330224449d90aac90957ea38f77d494f0f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 6 Nov 2020 13:22:05 -0800
> Subject: [PATCH] f2fs: avoid race condition for shrinker count
> 
> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> wrong do_shinker work. Let's avoid to return insane overflowed value.
> 
> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/shrinker.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index d66de5999a26..75b5b4aaed99 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -18,9 +18,9 @@ static unsigned int shrinker_run_no;
>   
>   static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
>   {
> -	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> -
> -	return count > 0 ? count : 0;
> +	if (NM_I(sbi)->nat_cnt > NM_I(sbi)->dirty_nat_cnt)
> +		return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;

Hmm.. in the case that we are not in checkpoint progress, nat_cnt and dirty_nat_cnt
is mutable, how can we make sure the calculation is non-negative after the check
condition? :(

Thanks

> +	return 0;
>   }
>   
>   static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
> 
