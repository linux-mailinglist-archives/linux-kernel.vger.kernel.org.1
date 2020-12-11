Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFE2D6FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395454AbgLKGJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:09:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9592 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390573AbgLKGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:09:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsgLl6zK3zM2wt;
        Fri, 11 Dec 2020 14:07:59 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 11 Dec
 2020 14:08:37 +0800
Subject: Re: [PATCH RFC] f2fs: compress: add compress_flag in struct
 f2fs_comp_option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20201210092020.66245-1-yuchao0@huawei.com>
 <X9JZn2ELSZISEQpU@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bfe87060-7e47-a9c8-897f-17352d0fc623@huawei.com>
Date:   Fri, 11 Dec 2020 14:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X9JZn2ELSZISEQpU@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/11 1:23, Jaegeuk Kim wrote:
> On 12/10, Chao Yu wrote:
>> Add a extra field compress_flag to get/set more compress option from/to
>> compressed inode.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>
>> Daeho, Jaegeuk,
>>
>> Could you please check whether we could add this new field to struct
>> f2fs_comp_option? so we can expand to allow user to query/config more
>> options of compressed inode via new ioctl.
>>
>> It needs to consider before original patches goes to merge window, let
>> me know you have other concerns.
> 
> Chao, I think it'd hard to add this at time point, unless there's critical
> info that we need to set very urgently.

Oops, so it needs extra ioctl interface to get/set newly added chksum and
compress_level configs...

Thanks,

> 
>>
>>   fs/f2fs/file.c            | 1 +
>>   include/uapi/linux/f2fs.h | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 16ea10f2bcf5..fbf06311c88d 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3965,6 +3965,7 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
>>   
>>   	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
>>   	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
>> +	option.compress_flag = F2FS_I(inode)->i_compress_flag;
>>   
>>   	inode_unlock_shared(inode);
>>   
>> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
>> index 352a822d4370..2b9c4c99ceee 100644
>> --- a/include/uapi/linux/f2fs.h
>> +++ b/include/uapi/linux/f2fs.h
>> @@ -93,6 +93,7 @@ struct f2fs_sectrim_range {
>>   struct f2fs_comp_option {
>>   	__u8 algorithm;
>>   	__u8 log_cluster_size;
>> +	__u16 compress_flag;
>>   };
>>   
>>   #endif /* _UAPI_LINUX_F2FS_H */
>> -- 
>> 2.29.2
> .
> 
