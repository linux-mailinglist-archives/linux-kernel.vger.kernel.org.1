Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584D41F31B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgFIBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 21:16:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbgFIBQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:16:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DEB57A161CBD11C1D533;
        Tue,  9 Jun 2020 09:16:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 9 Jun 2020
 09:16:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_TRIM_FILE ioctl
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200605042746.201180-1-daeho43@gmail.com>
 <fd9bd76c-1864-2cfc-bf86-ef705c8a407d@huawei.com>
 <CACOAw_yw+zczoWpNvYz_UHRYjr8BS+xKK=7_BKi0_0wEhp8Lvg@mail.gmail.com>
 <36d3c98e-24bb-988c-57a3-82730cc75cbc@huawei.com>
 <CACOAw_wVEw3+Kyz2HvvanhhP2_-xQy9wjfpDt5G0ahXM8o-V-Q@mail.gmail.com>
 <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com>
 <20200608130734.GB200855@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <69510409-791a-f955-a6c6-0b81607cf197@huawei.com>
Date:   Tue, 9 Jun 2020 09:16:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200608130734.GB200855@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/8 21:07, Jaegeuk Kim wrote:
> On 06/08, Chao Yu wrote:
>> On 2020/6/8 15:19, Daeho Jeong wrote:
>>> Yes, I agree with you about each vendor has different implementation on discard.
>>> So, we might be gonna use the combination of zeroing and send discards
>>> for a more
>>> secure solution. :)
>>
>> IIRC, current solution is:
>>
>> - pin file
>> - get all block addresses of file
>> - write zero to block addresses
>> - issue discard
>>
>> Is that correct?
>>
>> Could we handle those logic (zero out & discard) in new interface
>> (may be named as {F2FS,EXT4}_IOC_SEC_TRIM_FILE)? then userspace logic
>> could be quite simple later, and also memcpy could be avoid to make
>> destruction process more efficient.
> 
> What about adding a flag to determine calling unmap and/or zero out?

Better. :)

Thanks,

> 
>>
>> Just raw proposal. :)
>>
>> Thanks,
>>
>>> I think we still need a discard interface to unmap from the mapping
>>> table of the storage device side.
>>>
>>> Thanks,
>>>
>>> 2020년 6월 8일 (월) 오후 3:57, Chao Yu <yuchao0@huawei.com>님이 작성:
>>>>
>>>> On 2020/6/8 11:36, Daeho Jeong wrote:
>>>>> Yes, this is for security key destruction.
>>>>>
>>>>> AFAIK, discard will unmap the data block and, after done it,
>>>>> we can read either zero data or garbage data from that block depending
>>>>> on eMMC/UFS.
>>>>
>>>> Since spec didn't restrict how vendor implement the erase interface, so
>>>> in order to enhance performance of discard interface, vendor could implement
>>>> it as an async one, which may not zero mapping entry(L1 table), instead, it
>>>> could set related bitmap to invalid that mapping entry, than later if device
>>>> allow user to access that invalid mapping entry, key info may be explosed,
>>>>
>>>> It's completely up to how vendor implement the interface, so I think there is
>>>> still risk to use discard.
>>>>
>>>> Thanks,
>>>>
>>>>> In a view point of read data, it might be the same with zeroing the data block.
>>>>> However, since we can even unmap that block, I believe discard is
>>>>> safer than zeroing out.
>>>>>
>>>>> 2020년 6월 8일 (월) 오전 11:46, Chao Yu <yuchao0@huawei.com>님이 작성:
>>>>>>
>>>>>> On 2020/6/5 12:27, Daeho Jeong wrote:
>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>
>>>>>>> Added a new ioctl to send discard commands to whole data area of
>>>>>>> a regular file for security reason.
>>>>>>
>>>>>> I guess this interface is introduced for security key destruction, if I'm
>>>>>> right, however, IIRC, discard(erase) semantics in eMMC/UFS spec won't
>>>>>> guarantee that data which was discard could be zeroed out, so after discard,
>>>>>> the key still have risk of exposure. So instead, should we use sb_issue_zeroout()?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>>> ---
>>>>>>>  fs/f2fs/f2fs.h |   1 +
>>>>>>>  fs/f2fs/file.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>  2 files changed, 130 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>> index c812fb8e2d9c..9ae81d0fefa0 100644
>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>> @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>>>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 18, __u64)
>>>>>>>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS                             \
>>>>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 19, __u64)
>>>>>>> +#define F2FS_IOC_TRIM_FILE           _IO(F2FS_IOCTL_MAGIC, 20)
>>>>>>>
>>>>>>>  #define F2FS_IOC_GET_VOLUME_NAME     FS_IOC_GETFSLABEL
>>>>>>>  #define F2FS_IOC_SET_VOLUME_NAME     FS_IOC_SETFSLABEL
>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>> index dfa1ac2d751a..58507bb5649c 100644
>>>>>>> --- a/fs/f2fs/file.c
>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>> @@ -3749,6 +3749,132 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>>>>>>>       return ret;
>>>>>>>  }
>>>>>>>
>>>>>>> +static int f2fs_trim_file(struct file *filp)
>>>>>>> +{
>>>>>>> +     struct inode *inode = file_inode(filp);
>>>>>>> +     struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>>> +     struct address_space *mapping = inode->i_mapping;
>>>>>>> +     struct bio *bio = NULL;
>>>>>>> +     struct block_device *prev_bdev = NULL;
>>>>>>> +     loff_t file_size;
>>>>>>> +     pgoff_t index, pg_start = 0, pg_end;
>>>>>>> +     block_t prev_block = 0, len = 0;
>>>>>>> +     int ret = 0;
>>>>>>> +
>>>>>>> +     if (!f2fs_hw_support_discard(sbi))
>>>>>>> +             return -EOPNOTSUPP;
>>>>>>> +
>>>>>>> +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
>>>>>>> +                     f2fs_compressed_file(inode))
>>>>>>> +             return -EINVAL;
>>>>>>> +
>>>>>>> +     if (f2fs_readonly(sbi->sb))
>>>>>>> +             return -EROFS;
>>>>>>> +
>>>>>>> +     ret = mnt_want_write_file(filp);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     inode_lock(inode);
>>>>>>> +
>>>>>>> +     file_size = i_size_read(inode);
>>>>>>> +     if (!file_size)
>>>>>>> +             goto err;
>>>>>>> +     pg_end = (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
>>>>>>> +
>>>>>>> +     ret = f2fs_convert_inline_inode(inode);
>>>>>>> +     if (ret)
>>>>>>> +             goto err;
>>>>>>> +
>>>>>>> +     down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>>>> +     down_write(&F2FS_I(inode)->i_mmap_sem);
>>>>>>> +
>>>>>>> +     ret = filemap_write_and_wait(mapping);
>>>>>>> +     if (ret)
>>>>>>> +             goto out;
>>>>>>> +
>>>>>>> +     truncate_inode_pages(mapping, 0);
>>>>>>> +
>>>>>>> +     for (index = pg_start; index < pg_end;) {
>>>>>>> +             struct dnode_of_data dn;
>>>>>>> +             unsigned int end_offset;
>>>>>>> +
>>>>>>> +             set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>>>>> +             ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
>>>>>>> +             if (ret)
>>>>>>> +                     goto out;
>>>>>>> +
>>>>>>> +             end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
>>>>>>> +             if (pg_end < end_offset + index)
>>>>>>> +                     end_offset = pg_end - index;
>>>>>>> +
>>>>>>> +             for (; dn.ofs_in_node < end_offset;
>>>>>>> +                             dn.ofs_in_node++, index++) {
>>>>>>> +                     struct block_device *cur_bdev;
>>>>>>> +                     block_t blkaddr = f2fs_data_blkaddr(&dn);
>>>>>>> +
>>>>>>> +                     if (__is_valid_data_blkaddr(blkaddr)) {
>>>>>>> +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
>>>>>>> +                                     blkaddr, DATA_GENERIC_ENHANCE)) {
>>>>>>> +                                     ret = -EFSCORRUPTED;
>>>>>>> +                                     goto out;
>>>>>>> +                             }
>>>>>>> +                     } else
>>>>>>> +                             continue;
>>>>>>> +
>>>>>>> +                     cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
>>>>>>> +                     if (f2fs_is_multi_device(sbi)) {
>>>>>>> +                             int i = f2fs_target_device_index(sbi, blkaddr);
>>>>>>> +
>>>>>>> +                             blkaddr -= FDEV(i).start_blk;
>>>>>>> +                     }
>>>>>>> +
>>>>>>> +                     if (len) {
>>>>>>> +                             if (prev_bdev == cur_bdev &&
>>>>>>> +                                     blkaddr == prev_block + len) {
>>>>>>> +                                     len++;
>>>>>>> +                             } else {
>>>>>>> +                                     ret = __blkdev_issue_discard(prev_bdev,
>>>>>>> +                                             SECTOR_FROM_BLOCK(prev_block),
>>>>>>> +                                             SECTOR_FROM_BLOCK(len),
>>>>>>> +                                             GFP_NOFS, 0, &bio);
>>>>>>> +                                     if (ret)
>>>>>>> +                                             goto out;
>>>>>>> +> +                                  len = 0;
>>>>>>> +                             }
>>>>>>> +                     }
>>>>>>> +
>>>>>>> +                     if (!len) {
>>>>>>> +                             prev_bdev = cur_bdev;
>>>>>>> +                             prev_block = blkaddr;
>>>>>>> +                             len = 1;
>>>>>>> +                     }
>>>>>>> +             }
>>>>>>> +
>>>>>>> +             f2fs_put_dnode(&dn);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (len)
>>>>>>> +             ret = __blkdev_issue_discard(prev_bdev,
>>>>>>> +                                     SECTOR_FROM_BLOCK(prev_block),
>>>>>>> +                                     SECTOR_FROM_BLOCK(len),
>>>>>>> +                                     GFP_NOFS, 0, &bio);
>>>>>>> +out:
>>>>>>> +     if (bio) {
>>>>>>> +             ret = submit_bio_wait(bio);
>>>>>>> +             bio_put(bio);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     up_write(&F2FS_I(inode)->i_mmap_sem);
>>>>>>> +     up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>>>> +err:
>>>>>>> +     inode_unlock(inode);
>>>>>>> +     mnt_drop_write_file(filp);
>>>>>>> +
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>>>>>  {
>>>>>>>       if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
>>>>>>> @@ -3835,6 +3961,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>>>>>               return f2fs_release_compress_blocks(filp, arg);
>>>>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>>>>>>>               return f2fs_reserve_compress_blocks(filp, arg);
>>>>>>> +     case F2FS_IOC_TRIM_FILE:
>>>>>>> +             return f2fs_trim_file(filp);
>>>>>>>       default:
>>>>>>>               return -ENOTTY;
>>>>>>>       }
>>>>>>> @@ -4004,6 +4132,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>>>>>       case F2FS_IOC_GET_COMPRESS_BLOCKS:
>>>>>>>       case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
>>>>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>>>>>>> +     case F2FS_IOC_TRIM_FILE:
>>>>>>>               break;
>>>>>>>       default:
>>>>>>>               return -ENOIOCTLCMD;
>>>>>>>
>>>>> .
>>>>>
>>> .
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
