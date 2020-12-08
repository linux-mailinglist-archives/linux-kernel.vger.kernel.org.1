Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2E2D2022
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLHBcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:32:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9030 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLHBcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:32:02 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqjLK70S3zhnp6;
        Tue,  8 Dec 2020 09:30:49 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 09:31:15 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: support chksum
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Eric Biggers <ebiggers@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126103209.67985-1-yuchao0@huawei.com>
 <X86Sb2pvD53MzO5+@gmail.com>
 <e6bc842d-90a2-d4ce-56be-594bcebaea37@huawei.com>
 <X87WK9SOoJ8cn14T@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <05d5639a-bd60-f379-9905-380c69cddee7@huawei.com>
Date:   Tue, 8 Dec 2020 09:31:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X87WK9SOoJ8cn14T@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/8 9:26, Jaegeuk Kim wrote:
> On 12/08, Chao Yu wrote:
>> On 2020/12/8 4:37, Eric Biggers wrote:
>>> On Thu, Nov 26, 2020 at 06:32:09PM +0800, Chao Yu wrote:
>>>> +	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {
>>>
>>> This really could use some parentheses.  People shouldn't have to look up a
>>> C operator precedence table to understand the code.
>>
>> Will add parentheses to avoid misread.
>>
>>>
>>>> +		u32 provided = le32_to_cpu(dic->cbuf->chksum);
>>>> +		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
>>>> +
>>>> +		if (provided != calculated) {
>>>> +			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
>>>> +				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
>>>> +				printk_ratelimited(
>>>> +					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
>>>> +					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
>>>> +					provided, calculated);
>>>> +			}
>>>> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> +			WARN_ON_ONCE(1);
>>>
>>> WARN, WARN_ON_ONCE, BUG, BUG_ON, etc. are only for kernel bugs, not for invalid
>>> inputs from disk or userspace.
>>>
>>> There is already a log message printed just above, so it seems this WARN_ON_ONCE
>>> should just be removed.
>>
>> Jaegeuk wants to give WARN_ON and marking a FSCK flag without returning EFSCORRUPTED,
> 
> I think above printk_ratelimited should be enough.

Okay, so let me update the patch.

Thanks,

> 
>>
>> Jaegeuk, thoughts?
>>
>> Thanks,
>>
>>>
>>> - Eric
>>> .
>>>
> .
> 
