Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F52D1FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLHBKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:10:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9391 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:10:21 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CqhsC00Hfz7B2B;
        Tue,  8 Dec 2020 09:09:02 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 09:09:32 +0800
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: compress: deny setting
 unsupported compress algorithm
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201207095609.73825-1-yuchao0@huawei.com>
 <X85xlc2Q0gnBywBE@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d7d906c1-a503-b5f0-4eca-d468213242ab@huawei.com>
Date:   Tue, 8 Dec 2020 09:09:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X85xlc2Q0gnBywBE@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/8 2:16, Eric Biggers wrote:
> On Mon, Dec 07, 2020 at 05:56:09PM +0800, Chao Yu wrote:
>> If kernel doesn't support certain kinds of compress algorithm, deny to set
>> them as compress algorithm of f2fs via 'compress_algorithm=%s' mount option.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> no changes, just rebase on dev branch.
> 
> This doesn't apply to the dev branch anymore.

Maybe you apply patches with wrong order?

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev

> 
>>   fs/f2fs/super.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index e0fe72f1d2c8..662e59f32645 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -936,9 +936,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   			if (!name)
>>   				return -ENOMEM;
>>   			if (!strcmp(name, "lzo")) {
>> +#ifdef CONFIG_F2FS_FS_LZO
>>   				F2FS_OPTION(sbi).compress_algorithm =
>>   								COMPRESS_LZO;
>> +#else
>> +				f2fs_info(sbi, "Image doesn't support lzo compression");
>> +#endif
> 
> These info messages don't make sense.  It's not the filesystem image that
> doesn't support the algorithm, but rather the kernel that doesn't.
> 
> Also, shouldn't these be warnings instead of "info"?

Correct.

> 
> - Eric
> .
> 
