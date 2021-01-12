Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480682F2594
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbhALBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:34:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10649 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbhALBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:34:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFCk86KzFz15nt2;
        Tue, 12 Jan 2021 09:32:32 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 12 Jan
 2021 09:33:29 +0800
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210107093126.116958-1-yuchao0@huawei.com>
 <X/we0NoUqAwuW82+@google.com>
 <6b0060b9-460a-617a-3778-e67f35d551f0@huawei.com>
 <cdd681ad-462d-cb37-2b4b-8f9d547bc718@huawei.com>
Message-ID: <b44c2af4-d142-baff-387c-6b967f76065c@huawei.com>
Date:   Tue, 12 Jan 2021 09:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cdd681ad-462d-cb37-2b4b-8f9d547bc718@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/11 19:45, Chao Yu wrote:
> On 2021/1/11 18:31, Chao Yu wrote:
>> On 2021/1/11 17:48, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> After quick test of fsstress w/ fault injection, it gave wrong block address
>>> errors. Could you please run the test a bit?
>>
>> Jaegeuk,
>>
>> Oh, I've covered with fstest cases and there is no such error message, let me
>> try fault injection + SPO case soon.
> 
> Till now, I haven't see any problem... will let the test run for longer time in
> this night.
> 
> Could you share me detailed error message you encounter?

Still, I don't see wrong block address error...

Did the error occur from below path:

- f2fs_end_read_compressed_page
  - f2fs_cache_compressed_page
   - f2fs_is_valid_blkaddr

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
