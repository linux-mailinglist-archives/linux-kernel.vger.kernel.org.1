Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DF2D1FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLHA7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:59:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgLHA7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:59:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cqhd54FxVzM1N0;
        Tue,  8 Dec 2020 08:58:33 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 08:59:12 +0800
Subject: Re: [f2fs-dev] [PATCH v5 RESEND] f2fs: compress: add compress_inode
 to cache compressed blocks
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201207095220.73093-1-yuchao0@huawei.com>
 <X85wshahXe4nR+N6@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8cccbe7f-94c0-ddd0-4da5-234d02839ae0@huawei.com>
Date:   Tue, 8 Dec 2020 08:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X85wshahXe4nR+N6@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/8 2:13, Eric Biggers wrote:
> On Mon, Dec 07, 2020 at 05:52:20PM +0800, Chao Yu wrote:
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index dae15c96e659..fd413d319e93 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -268,6 +268,9 @@ compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
>>   			 choosing the target file and the timing. The user can do manual
>>   			 compression/decompression on the compression enabled files using
>>   			 ioctls.
>> +compress_cache		 Support to use address space of inner inode to cache
>> +			 compressed block, in order to improve cache hit ratio of
>> +			 random read.
> 
> What is an "inner inode"?  Mount options should be understandable without
> understanding filesystem implementation details.

I'd like to use "a filesystem managed inode" instead, if there is no further
comment.

> 
>> +const struct address_space_operations f2fs_compress_aops = {
>> +	.releasepage = f2fs_release_page,
>> +	.invalidatepage = f2fs_invalidate_page,
>> +};
>> +
>> +struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
>> +{
>> +	return sbi->compress_inode->i_mapping;
>> +}
>> +
>> +void invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
>> +{
>> +	if (!sbi->compress_inode)
>> +		return;
>> +	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
>> +}
> 
> Global functions should have the "f2fs_" prefix.

Yup,

Thanks,

> 
> - Eric
> .
> 
