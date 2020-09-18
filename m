Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0626F269
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgIRC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:58:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbgIRC6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:58:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 92998A3469232E76FC6F;
        Fri, 18 Sep 2020 10:58:39 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 18 Sep
 2020 10:58:36 +0800
Subject: Re: [PATCH 6/9] f2fs: zstd: Switch to the zstd-1.4.6 API
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Nick Terrell <terrelln@fb.com>, Johannes Weiner <jweiner@fb.com>,
        "Nick Terrell" <nickrterrell@gmail.com>, Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, "Chris Mason" <clm@fb.com>,
        Kernel Team <Kernel-team@fb.com>, Niket Agarwal <niketa@fb.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-9-nickrterrell@gmail.com>
 <28bf92f1-1246-a840-6195-0e230e517e6d@huawei.com>
 <C8517011-9B6F-499F-BEC6-25BF1F0794AC@fb.com>
 <f7b19bc6-e57f-b4d8-b1f7-89c428b79cdf@huawei.com>
 <C327820B-5BD8-4739-AE4E-04EF27BE8150@fb.com>
 <9589E483-A94B-4AF6-8C03-B0763715B40A@fb.com>
 <a8b6e21d-fb51-1a50-8f2a-045f3a496c12@huawei.com>
 <20200918025627.GA3518637@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6eb268c8-7276-5859-e5b0-ce0a541e27e7@huawei.com>
Date:   Fri, 18 Sep 2020 10:58:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200918025627.GA3518637@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/18 10:56, Eric Biggers wrote:
> On Fri, Sep 18, 2020 at 09:47:32AM +0800, Chao Yu wrote:
>> Ah, I got it.
>>
>> Step of enabling compressed inode is not correct, we should touch an empty
>> file, and then use 'chattr +c' on that file to enable compression, otherwise
>> the race condition could be complicated to handle. So we need below diff to
>> disallow setting compression flag on an non-empty file:
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 8a422400e824..b462db7898fd 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1836,6 +1836,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   		if (iflags & F2FS_COMPR_FL) {
>>   			if (!f2fs_may_compress(inode))
>>   				return -EINVAL;
>> +			if (get_dirty_pages(inode) || fi->i_compr_blocks)
>> +				return  -EINVAL;
>>
>>   			set_compress_context(inode);
>>   		}
> 
> Why not:
> 
> 	if (inode->i_size)
> 		return -EINVAL;

Yeah, I noticed that after replying this email, I've prepared the new patch
which including the i_size check.

Thanks for noticing this.

Thanks,

> .
> 
