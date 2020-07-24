Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8192522BB53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 03:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgGXBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 21:22:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbgGXBWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:22:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C112B95D81FDF460943;
        Fri, 24 Jul 2020 09:22:16 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 24 Jul
 2020 09:22:11 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix use-after-free issue
To:     Song Feng <songfengcn@163.com>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200723102806.9662-1-yuchao0@huawei.com>
 <666af139.9663.1737c480519.Coremail.songfengcn@163.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <85b9af8d-0062-9c6b-0ad7-c48870a5cf2b@huawei.com>
Date:   Fri, 24 Jul 2020 09:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <666af139.9663.1737c480519.Coremail.songfengcn@163.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng,

Thanks for the reminder. :)

Jaegeuk, could you please fix this while merging.

Thanks,

On 2020/7/23 23:26, Song Feng wrote:
> At 2020-07-23 17:28:06, "Chao Yu" <yuchao0@huawei.com> wrote:
> 
>> From: Li Guifu <bluce.liguifu@huawei.com>
>>
>> During umount, f2fs_put_super() unregisters procfs entries after
>> f2fs_destroy_segment_manager(), it may cause use-after-free
>> issue when umount races with procfs accessing, fix it by relcating
> typo issue: relcating -> relocating?
>> f2fs_unregister_sysfs().
>>
>> [Chao Yu: change commit title/message a bit]
>>
>> Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> fs/f2fs/super.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 80cb7cd358f8..bf8bd64c8380 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1175,6 +1175,9 @@ static void f2fs_put_super(struct super_block *sb)
>> 	int i;
>> 	bool dropped;
>>
>> +	/* unregister procfs/sysfs entries to avoid race case */
>> +	f2fs_unregister_sysfs(sbi);
>> +
>> 	f2fs_quota_off_umount(sb);
>>
>> 	/* prevent remaining shrinker jobs */
>> @@ -1240,8 +1243,6 @@ static void f2fs_put_super(struct super_block *sb)
>>
>> 	kvfree(sbi->ckpt);
>>
>> -	f2fs_unregister_sysfs(sbi);
>> -
>> 	sb->s_fs_info = NULL;
>> 	if (sbi->s_chksum_driver)
>> 		crypto_free_shash(sbi->s_chksum_driver);
>> -- 
>> 2.26.2
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> please check typo issue for comment: relcating->relocating?
> 
