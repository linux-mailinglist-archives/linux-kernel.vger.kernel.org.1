Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716282D506C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 02:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLJBlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 20:41:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9417 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgLJBlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:41:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrxRt3dNBz7C6b;
        Thu, 10 Dec 2020 09:39:54 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 09:40:25 +0800
Subject: Re: [PATCH RESEND v2 5/5] f2fs: introduce sb_status sysfs node
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20201209084328.30416-1-yuchao0@huawei.com>
 <20201209084328.30416-5-yuchao0@huawei.com> <X9D1dXVwKFvfHpP9@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6f8bf3c3-f210-ec06-372f-c27c85d0449b@huawei.com>
Date:   Thu, 10 Dec 2020 09:40:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X9D1dXVwKFvfHpP9@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/10 0:04, Jaegeuk Kim wrote:
> On 12/09, Chao Yu wrote:
>> Introduce /sys/fs/f2fs/<devname>/stat/sb_status to show superblock
>> status in real time as below:
>>
>> IS_DIRTY:		no
>> IS_CLOSE:		no
>> IS_SHUTDOWN:		no
>> IS_RECOVERED:		no
>> IS_RESIZEFS:		no
>> NEED_FSCK:		no
>> POR_DOING:		no
>> NEED_SB_WRITE:		no
>> NEED_CP:		no
>> CP_DISABLED:		no
>> CP_DISABLED_QUICK:	no
>> QUOTA_NEED_FLUSH:	no
>> QUOTA_SKIP_FLUSH:	no
>> QUOTA_NEED_REPAIR:	no
> 
> Wait, this is breaking a sysfs rule where one entry should show one value.

Hmm.. let me change to show the sb status value directly, but then we needs extra
tool or a mapping table to parse the real status every bit means.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs |  5 ++++
>>   fs/f2fs/sysfs.c                         | 36 +++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 3dfee94e0618..57ab839dc3a2 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -377,3 +377,8 @@ Description:	This gives a control to limit the bio size in f2fs.
>>   		Default is zero, which will follow underlying block layer limit,
>>   		whereas, if it has a certain bytes value, f2fs won't submit a
>>   		bio larger than that size.
>> +
>> +What:		/sys/fs/f2fs/<disk>/stat/sb_status
>> +Date:		December 2020
>> +Contact:	"Chao Yu" <yuchao0@huawei.com>
>> +Description:	Show status of f2fs superblock in real time.
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index ebca0b4961e8..1b85e6d16a94 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -101,6 +101,40 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>>   				sbi->sectors_written_start) >> 1)));
>>   }
>>   
>> +#define	SB_STATUS(s)	(s ? "yes" : "no")
>> +static ssize_t sb_status_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "IS_DIRTY:		%s\n"
>> +				"IS_CLOSE:		%s\n"
>> +				"IS_SHUTDOWN:		%s\n"
>> +				"IS_RECOVERED:		%s\n"
>> +				"IS_RESIZEFS:		%s\n"
>> +				"NEED_FSCK:		%s\n"
>> +				"POR_DOING:		%s\n"
>> +				"NEED_SB_WRITE:		%s\n"
>> +				"NEED_CP:		%s\n"
>> +				"CP_DISABLED:		%s\n"
>> +				"CP_DISABLED_QUICK:	%s\n"
>> +				"QUOTA_NEED_FLUSH:	%s\n"
>> +				"QUOTA_SKIP_FLUSH:	%s\n"
>> +				"QUOTA_NEED_REPAIR:	%s\n",
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_IS_DIRTY)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_IS_CLOSE)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_IS_RECOVERED)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_IS_RESIZEFS)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_NEED_FSCK)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_POR_DOING)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_NEED_CP)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_CP_DISABLED)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)),
>> +			SB_STATUS(is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR)));
>> +}
>> +
>>   static ssize_t features_show(struct f2fs_attr *a,
>>   		struct f2fs_sb_info *sbi, char *buf)
>>   {
>> @@ -711,7 +745,9 @@ static struct attribute *f2fs_feat_attrs[] = {
>>   };
>>   ATTRIBUTE_GROUPS(f2fs_feat);
>>   
>> +F2FS_GENERAL_RO_ATTR(sb_status);
>>   static struct attribute *f2fs_stat_attrs[] = {
>> +	ATTR_LIST(sb_status),
>>   	NULL,
>>   };
>>   ATTRIBUTE_GROUPS(f2fs_stat);
>> -- 
>> 2.29.2
> .
> 
