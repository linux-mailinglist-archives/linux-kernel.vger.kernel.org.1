Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5F1E75FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2GhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 02:37:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgE2GhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:37:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E832D5B84A409C22E219;
        Fri, 29 May 2020 14:37:05 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 29 May
 2020 14:37:04 +0800
Subject: Re: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
 <20200527210233.GC206249@google.com>
 <23245f6e-528d-43ab-57b6-4ca16db43fe5@huawei.com>
 <20200528012615.GA232094@google.com>
 <8e30b18d-bf8e-dd2f-35fa-08bbfd1b507e@huawei.com>
 <20200528190010.GA162605@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9fa465a0-70b5-7d17-baf4-21224196e2bc@huawei.com>
Date:   Fri, 29 May 2020 14:37:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528190010.GA162605@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/29 3:00, Jaegeuk Kim wrote:
> On 05/28, Chao Yu wrote:
>> On 2020/5/28 9:26, Jaegeuk Kim wrote:
>>> On 05/28, Chao Yu wrote:
>>>> On 2020/5/28 5:02, Jaegeuk Kim wrote:
>>>>> On 05/27, Chao Yu wrote:
>>>>>> meta inode page should be flushed under cp_lock, fix it.
>>>>>
>>>>> It doesn't matter for this case, yes?
>>>>
>>>> It's not related to discard issue.
>>>
>>> I meant we really need this or not. :P
>>
>> Yes, let's keep that rule: flush meta pages under cp_lock, otherwise
>> checkpoint flush order may be broken due to race, right? as checkpoint
>> should write 2rd cp park page after flushing all meta pages.
> 
> Well, this is for shutdown test, and thus we don't need to sync up here.

I'm a little worried about race condition:

f2fs_write_checkpoint
 do_checkpoint
  ...
					shutdown
					f2fs_sync_meta_pages
					stop_checkpoint
  ...

Though, I haven't figure out potential damage of their racing.

> 
>>
>>>
>>>>
>>>> Now, I got some progress, I can reproduce that bug occasionally.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>> ---
>>>>>>  fs/f2fs/file.c | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index f7de2a1da528..0fcae4d90074 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>>>>  		break;
>>>>>>  	case F2FS_GOING_DOWN_METAFLUSH:
>>>>>> +		mutex_lock(&sbi->cp_mutex);
>>>>>>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
>>>>>> +		mutex_unlock(&sbi->cp_mutex);
>>>>>>  		f2fs_stop_checkpoint(sbi, false);
>>>>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>>>>  		break;
>>>>>> -- 
>>>>>> 2.18.0.rc1
>>>>> .
>>>>>
>>> .
>>>
> .
> 
