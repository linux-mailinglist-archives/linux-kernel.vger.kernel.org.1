Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC29A1E191B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 03:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbgEZBeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 21:34:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4895 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387794AbgEZBeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:34:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4F4B5C67983534339F8;
        Tue, 26 May 2020 09:34:09 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 May
 2020 09:34:04 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com> <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
 <20200525150608.GA55033@google.com>
 <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
Message-ID: <a44f9c2e-3859-6c5d-6f06-7c4c6b4c01c5@huawei.com>
Date:   Tue, 26 May 2020 09:34:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/26 9:11, Chao Yu wrote:
> On 2020/5/25 23:06, Jaegeuk Kim wrote:
>> On 05/25, Chao Yu wrote:
>>> On 2020/5/25 11:56, Jaegeuk Kim wrote:
>>>> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
>>>
>>> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
>>> pages like we change for node pages to avoid potential dead loop...
>>
>> I believe we're doing for them. :P
> 
> Actually, I mean do we need to drop dirty meta/data pages explicitly as below:
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 3dc3ac6fe143..4c08fd0a680a 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -299,8 +299,15 @@ static int __f2fs_write_meta_page(struct page *page,
> 
>  	trace_f2fs_writepage(page, META);
> 
> -	if (unlikely(f2fs_cp_error(sbi)))
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			ClearPageUptodate(page);
> +			dec_page_count(sbi, F2FS_DIRTY_META);
> +			unlock_page(page);
> +			return 0;
> +		}
>  		goto redirty_out;
> +	}
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
>  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 48a622b95b76..94b342802513 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2682,6 +2682,12 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> 
>  	/* we should bypass data pages to proceed the kworkder jobs */
>  	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			ClearPageUptodate(page);
> +			inode_dec_dirty_pages(inode);
> +			unlock_page(page);
> +			return 0;
> +		}

Oh, I notice previously, we will drop non-directory inode's dirty pages directly,
however, during umount, we'd better drop directory inode's dirty pages as well, right?

>  		mapping_set_error(page->mapping, -EIO);
>  		/*
>  		 * don't drop any dirty dentry pages for keeping lastest
> 
>>
>>>
>>> Thanks,
>>>
>>>> in an inifinite loop. Let's drop dirty pages at umount in that case.
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>> v3:
>>>>  - fix wrong unlock
>>>>
>>>> v2:
>>>>  - fix typos
>>>>
>>>>  fs/f2fs/node.c | 9 ++++++++-
>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index e632de10aedab..e0bb0f7e0506e 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>  
>>>>  	trace_f2fs_writepage(page, NODE);
>>>>  
>>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>>> +	if (unlikely(f2fs_cp_error(sbi))) {
>>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
>>>> +			ClearPageUptodate(page);
>>>> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
>>>> +			unlock_page(page);
>>>> +			return 0;
>>>> +		}
>>>>  		goto redirty_out;
>>>> +	}
>>>>  
>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>>  		goto redirty_out;
>>>>
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
