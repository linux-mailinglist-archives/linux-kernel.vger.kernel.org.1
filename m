Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543C9210178
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 03:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgGABbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 21:31:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgGABbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:31:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54271B50266FCE1EE869;
        Wed,  1 Jul 2020 09:31:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 09:31:14 +0800
Subject: Re: [PATCH 1/2] f2fs: split f2fs_allocate_new_segments()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200622093849.35684-1-yuchao0@huawei.com>
 <20200629201943.GB1117827@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0e3c7fe2-9cb8-c457-e251-eb0fb7c0760e@huawei.com>
Date:   Wed, 1 Jul 2020 09:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200629201943.GB1117827@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk, could you please help to change __allocate_new_segment() to static
in your tree?

On 2020/6/30 4:19, Jaegeuk Kim wrote:
> On 06/22, Chao Yu wrote:
>> to two independent functions:
>> - f2fs_allocate_new_segment() for specified type segment allocation
>> - f2fs_allocate_new_segments() for all data type segments allocation
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h     |  3 ++-
>>  fs/f2fs/file.c     |  2 +-
>>  fs/f2fs/recovery.c |  2 +-
>>  fs/f2fs/segment.c  | 39 +++++++++++++++++++++++----------------
>>  4 files changed, 27 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 70565d81320b..07290943e91d 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3327,7 +3327,8 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>>  void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>  					unsigned int start, unsigned int end);
>> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type);
>> +void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type);
>> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
>>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>>  bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
>>  					struct cp_control *cpc);
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index f196187159e9..67c65e40b22b 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1659,7 +1659,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>>  		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
>>  
>>  		f2fs_lock_op(sbi);
>> -		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
>> +		f2fs_allocate_new_segment(sbi, CURSEG_COLD_DATA_PINNED);
> 
> This should be CURSEG_COLD_DATA. Otherwise it causes the below kernel panic.
> I fixed this in the -dev, so let me know, if you have other concern.
> 
>   259 Unable to handle kernel NULL pointer dereference at virtual address 00000008
>   259 task: 0000000082b4de99 task.stack: 00000000c6b39dbf
>   259 pc : f2fs_do_write_data_page+0x2b4/0x794
>   259 lr : f2fs_do_write_data_page+0x290/0x794
>   259 sp : ffffff800c83b5a0 pstate : 60c00145
>   259 Call trace:
>   259  f2fs_do_write_data_page+0x2b4/0x794
>   259  f2fs_write_single_data_page+0x4a4/0x764
>   259  f2fs_write_data_pages+0x4dc/0x968
>   259  do_writepages+0x60/0x124
>   259  __writeback_single_inode+0xd8/0x490
>   259  writeback_sb_inodes+0x3a8/0x6e4
>   259  __writeback_inodes_wb+0xa4/0x14c
>   259  wb_writeback+0x218/0x434
>   259  wb_workfn+0x2bc/0x57c
>   259  process_one_work+0x25c/0x440
>   259  worker_thread+0x24c/0x480
>   259  kthread+0x11c/0x12c
>   259  ret_from_fork+0x10/0x18
> 
>>  		f2fs_unlock_op(sbi);
>>  
>>  		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>> index ae5310f02e7f..af974ba273b3 100644
>> --- a/fs/f2fs/recovery.c
>> +++ b/fs/f2fs/recovery.c
>> @@ -742,7 +742,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
>>  		f2fs_put_page(page, 1);
>>  	}
>>  	if (!err)
>> -		f2fs_allocate_new_segments(sbi, NO_CHECK_TYPE);
>> +		f2fs_allocate_new_segments(sbi);
>>  	return err;
>>  }
>>  
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 113114f98087..f15711e8ee5b 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2707,28 +2707,35 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>  	up_read(&SM_I(sbi)->curseg_lock);
>>  }
>>  
>> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type)
>> +void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
>>  {
>> -	struct curseg_info *curseg;
>> +	struct curseg_info *curseg = CURSEG_I(sbi, type);
>>  	unsigned int old_segno;
>> -	int i;
>>  
>> -	down_write(&SIT_I(sbi)->sentry_lock);
>> +	if (!curseg->next_blkoff &&
>> +		!get_valid_blocks(sbi, curseg->segno, false) &&
>> +		!get_ckpt_valid_blocks(sbi, curseg->segno))
>> +		return;
>>  
>> -	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
>> -		if (type != NO_CHECK_TYPE && i != type)
>> -			continue;
>> +	old_segno = curseg->segno;
>> +	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
>> +	locate_dirty_segment(sbi, old_segno);
>> +}
>>  
>> -		curseg = CURSEG_I(sbi, i);
>> -		if (type == NO_CHECK_TYPE || curseg->next_blkoff ||
>> -				get_valid_blocks(sbi, curseg->segno, false) ||
>> -				get_ckpt_valid_blocks(sbi, curseg->segno)) {
>> -			old_segno = curseg->segno;
>> -			SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
>> -			locate_dirty_segment(sbi, old_segno);
>> -		}
>> -	}
>> +void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type)
>> +{
>> +	down_write(&SIT_I(sbi)->sentry_lock);
>> +	__allocate_new_segment(sbi, type);
>> +	up_write(&SIT_I(sbi)->sentry_lock);
>> +}
>>  
>> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
>> +{
>> +	int i;
>> +
>> +	down_write(&SIT_I(sbi)->sentry_lock);
>> +	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
>> +		__allocate_new_segment(sbi, i);
>>  	up_write(&SIT_I(sbi)->sentry_lock);
>>  }
>>  
>> -- 
>> 2.26.2
> .
> 
