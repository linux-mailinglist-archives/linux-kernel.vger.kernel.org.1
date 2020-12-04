Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF12CE4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgLDBTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:19:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8630 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgLDBTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:19:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnFFW06kwz15Q6h;
        Fri,  4 Dec 2020 09:18:07 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 09:18:31 +0800
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8d735b5a-7940-6409-bcfe-d5a855a74d74@huawei.com>
Date:   Fri, 4 Dec 2020 09:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X8k9UoUKcyThlJNU@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 3:32, Eric Biggers wrote:
> On Thu, Dec 03, 2020 at 02:17:15PM +0800, Chao Yu wrote:
>> +config F2FS_FS_LZ4HC
>> +	bool "LZ4HC compression support"
>> +	depends on F2FS_FS_COMPRESSION
>> +	depends on F2FS_FS_LZ4
>> +	select LZ4HC_COMPRESS
>> +	default y
>> +	help
>> +	  Support LZ4HC compress algorithm, if unsure, say Y.
>> +
> 
> It would be helpful to mention that LZ4HC is on-disk compatible with LZ4.

Sure, let me update description.

> 
>>   static int lz4_compress_pages(struct compress_ctx *cc)
>>   {
>>   	int len;
>>   
>> +#ifdef CONFIG_F2FS_FS_LZ4HC
>> +	return lz4hc_compress_pages(cc);
>> +#endif
> 
> This looks wrong; it always calls lz4hc compression even for regular lz4.

It's fine. lz4hc_compress_pages() will call LZ4_compress_HC() only when
compress level is set.

> 
>>   static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   {
>>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> @@ -886,10 +939,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   			if (!strcmp(name, "lzo")) {
>>   				F2FS_OPTION(sbi).compress_algorithm =
>>   								COMPRESS_LZO;
>> -			} else if (!strcmp(name, "lz4")) {
>> +			} else if (!strncmp(name, "lz4", 3)) {
> 
> strcmp() is fine, no need for strncmp().

Actually, I reuse "lz4" mount option parameter, to enable lz4hc algorithm, user
only need to specify compress level after "lz4" string, e.g.
compress_algorithm=lz4, f2fs use lz4 algorithm
compress_algorithm=lz4:xx, f2fs use lz4hc algorithm with compress level xx.

So, I use !strncmp(name, "lz4", 3) here.

> 
>> @@ -1547,6 +1612,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>>   	}
>>   	seq_printf(seq, ",compress_algorithm=%s", algtype);
>>   
>> +	if (!F2FS_OPTION(sbi).compress_level)
>> +		seq_printf(seq, ":%d", F2FS_OPTION(sbi).compress_level);
>> +
> 
> This looks wrong; it only prints compress_level if it is 0.

Yes, will fix.

> 
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 55be7afeee90..2dcc63fe8494 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -275,6 +275,9 @@ struct f2fs_inode {
>>   			__u8 i_compress_algorithm;	/* compress algorithm */
>>   			__u8 i_log_cluster_size;	/* log of cluster size */
>>   			__le16 i_compress_flag;		/* compress flag */
>> +						/* 0 bit: chksum flag
>> +						 * [10,15] bits: compress level
>> +						 */
> 
> What is the use case for storing the compression level on-disk?

One case I can image is if user wants to specify different compress level for
different algorithm in separated files.

e.g.
mount -o comrpess_algorithm=zstd:10 /dev/sdc /f2fs
touch fileA;
write fileA;
mount -o remount,comrpess_algorithm=lz4:8 /f2fs
write fileA;
touch fileB;
write fileB;

Thanks,

> 
> Keep in mind that compression levels are an implementation detail; the exact
> compressed data that is produced by a particular algorithm at a particular
> compression level is *not* a stable interface.  It can change when the
> compressor is updated, as long as the output continues to be compatible with the
> decompressor.
> 
> So does compression level really belong in the on-disk format?
> 
> - Eric
> .
> 
