Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F231FE923
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgFRC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 22:57:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbgFRC5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:57:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 016FE8AB76B30C6AFD00;
        Thu, 18 Jun 2020 10:57:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 18 Jun
 2020 10:57:49 +0800
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:_[PATCH]_f2fs:_fix_a_race_conditio?=
 =?UTF-8?Q?n_between_f2fs=5fwrite=5fend=5fio_and_f2fs=5fdel=5ffsync=5fnode?=
 =?UTF-8?Q?=5fentry?=
To:     Zac <zhaowuyun@wingtech.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592384659-20203-1-git-send-email-zhaowuyun@wingtech.com>
 <86069ba3-cba3-7bc9-c90b-e931abd0dde5@huawei.com>
 <000001d64519$b05a1180$110e3480$@wingtech.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <86c34c66-b370-6c6d-91fe-b9235f9c5785@huawei.com>
Date:   Thu, 18 Jun 2020 10:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000001d64519$b05a1180$110e3480$@wingtech.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/18 10:39, Zac wrote:
> 
>> On 2020/6/17 17:04, zhaowuyun@wingtech.com wrote:
>>> From: Wuyun Zhao <zhaowuyun@wingtech.com>
>>>
>>> Under some condition, the __write_node_page will submit a page which is
>> not
>>> f2fs_in_warm_node_list and will not call f2fs_add_fsync_node_entry.
>>> f2fs_gc continue to run to invoke f2fs_iget -> do_read_inode to read the
>> same node page
>>> and set code node, which make f2fs_in_warm_node_list become true,
>>> that will cause f2fs_bug_on in f2fs_del_fsync_node_entry when
>> f2fs_write_end_io called.
>> Could you please add below race condition description into commit
>> message?
>>
>> - f2fs_write_end_io
>> 					- f2fs_iget
>> 					 - do_read_inode
>> 					  - set_cold_node
>> 					  recover cold node flag
>>  - f2fs_in_warm_node_list
>>   - is_cold_node
>>   if node is cold, assume we have added
>>   node to fsync_node_list during writepages()
>>  - f2fs_del_fsync_node_entry
>>   - f2fs_bug_on() due to node page
>>   is not in fsync_node_list
> 
> Ok, will add the commit message.
> 
>> BTW, I'm curious about why we can lose cold flag for non-dir inode?
>> any clue to reproduce this bug (I mean losing cold flag)?
> 
> it's a f2fs image with 25600MB
> flash this image to device
> the device will resize it according to the userdata partition size which is
> about 94GB
> the device mount the f2fs partition
> then hit this f2fs_bug_on
> 
> seems that the cold flag is not been set when mkfs

Ah, I guess both mkfs/sload ignores setting cold node flag for non-dir inode,
could you please send another patch to fix this issue?

> 
> I think the issue is that
> 
> 1. the node page in the storage is without cold bit
> 2. f2fs_disable_checkpoint -> f2fs_gc -> f2fs_get_node_page, this page won't
> be set cold flag
> 3. f2fs_move_node_page -> __write_node_page to write this page
> 4. f2fs_gc -> f2fs_iget -> do_read_inode to read this page and set cold flag

Clear enough, thanks for your explanation. :)

Thanks,

> 
>>>
>>> [   34.966133] Call trace:
>>> [   34.969902]  f2fs_del_fsync_node_entry+0x100/0x108
>>> [   34.976071]  f2fs_write_end_io+0x1e0/0x288
>>> [   34.981539]  bio_endio+0x248/0x270
>>> [   34.986289]  blk_update_request+0x2b0/0x4d8
>>> [   34.991841]  scsi_end_request+0x40/0x440
>>> [   34.997126]  scsi_io_completion+0xa4/0x748
>>> [   35.002593]  scsi_finish_command+0xdc/0x110
>>> [   35.008143]  scsi_softirq_done+0x118/0x150
>>> [   35.013610]  blk_done_softirq+0x8c/0xe8
>>> [   35.018811]  __do_softirq+0x2e8/0x578
>>> [   35.023828]  irq_exit+0xfc/0x120
>>> [   35.028398]  handle_IPI+0x1d8/0x330
>>> [   35.033233]  gic_handle_irq+0x110/0x1d4
>>> [   35.038433]  el1_irq+0xb4/0x130
>>> [   35.042917]  kmem_cache_alloc+0x3f0/0x418
>>> [   35.048288]  radix_tree_node_alloc+0x50/0xf8
>>> [   35.053933]  __radix_tree_create+0xf8/0x188
>>> [   35.059484]  __radix_tree_insert+0x3c/0x128
>>> [   35.065035]  add_gc_inode+0x90/0x118
>>> [   35.069967]  f2fs_gc+0x1b80/0x2d70
>>> [   35.074718]  f2fs_disable_checkpoint+0x94/0x1d0
>>> [   35.080621]  f2fs_fill_super+0x10c4/0x1b88
>>> [   35.086088]  mount_bdev+0x194/0x1e0
>>> [   35.090923]  f2fs_mount+0x40/0x50
>>> [   35.095589]  mount_fs+0xb4/0x190
>>> [   35.100159]  vfs_kern_mount+0x80/0x1d8
>>> [   35.105260]  do_mount+0x478/0xf18
>>> [   35.109926]  ksys_mount+0x90/0xd0
>>> [   35.114592]  __arm64_sys_mount+0x24/0x38
>>>
>>> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>> ---
>>>  fs/f2fs/inode.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index be6ac33..0df5c8c 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -402,6 +402,7 @@ static int do_read_inode(struct inode *inode)
>>>
>>>  	/* try to recover cold bit for non-dir inode */
>>>  	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page)) {
>>> +		f2fs_wait_on_page_writeback(node_page, NODE, true, true);
>>>  		set_cold_node(node_page, false);
>>>  		set_page_dirty(node_page);
>>>  	}
>>>
> 
> .
> 
