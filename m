Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B05277D45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIYA5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:57:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgIYA5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:57:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA3FBF253B9569A7D13D;
        Fri, 25 Sep 2020 08:57:18 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 25 Sep
 2020 08:57:16 +0800
Subject: Re: [PATCH] f2fs: compress: fix to disallow enabling compress on
 non-empty file
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200918030349.19667-1-yuchao0@huawei.com>
 <20200924200305.GA2568648@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dbf3a532-cd38-2b31-e4ab-e83505c6c9c4@huawei.com>
Date:   Fri, 25 Sep 2020 08:57:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200924200305.GA2568648@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/25 4:03, Jaegeuk Kim wrote:
> On 09/18, Chao Yu wrote:
>> Compressed inode and normal inode has different layout, so we should
>> disallow enabling compress on non-empty file to avoid race condition
>> during inode .i_addr array parsing and updating.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/file.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 58e464cc15f0..139fdfc1dc55 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1821,6 +1821,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   		if (iflags & F2FS_COMPR_FL) {
>>   			if (!f2fs_may_compress(inode))
>>   				return -EINVAL;
>> +			if (inode->i_size)
> 
> Changed like this.
> 
> +                       if (S_ISREG(inode->i_mode) && inode->i_size)

My bad, thanks for fixing this. :)

Thanks,

> 
> 
>> +				return -EINVAL;
>>   
>>   			set_compress_context(inode);
>>   		}
>> -- 
>> 2.26.2
> .
> 
