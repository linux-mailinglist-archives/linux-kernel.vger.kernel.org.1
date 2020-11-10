Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341812ACF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgKJGEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:04:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7441 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:04:29 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CVckq1blLz74mH;
        Tue, 10 Nov 2020 14:04:19 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Nov
 2020 14:04:22 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid race condition for shinker count
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Light Hsieh <Light.Hsieh@mediatek.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <f195a4f0-34af-1594-f443-be8ba3058707@huawei.com>
 <20201110041958.GA1598246@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f8de28c2-da2f-f988-7fc9-6f38f19f3f41@huawei.com>
Date:   Tue, 10 Nov 2020 14:04:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201110041958.GA1598246@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/10 12:19, Jaegeuk Kim wrote:
> On 11/10, Chao Yu wrote:
>> On 2020/11/10 1:00, Jaegeuk Kim wrote:
>>> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
>>
>> I didn't get the problem clearly, did you mean __count_nat_entries() will
>> give the wrong shrink count due to race condition? should there be a lock
>> while reading these two variables?
>>
>>> wrong do_shinker work. Basically the two counts should not happen like that.
>>>
>>> So, I suspect this race condtion where:
>>> - f2fs_try_to_free_nats            __flush_nat_entry_set
>>>    nat_cnt=2, dirty_nat_cnt=2
>>>                                      __clear_nat_cache_dirty
>>>                                       spin_lock(nat_list_lock)
>>>                                       list_move()
>>>                                       spin_unlock(nat_list_lock)
>>>    spin_lock(nat_list_lock)
>>>    list_del()
>>>    spin_unlock(nat_list_lock)
>>>    nat_cnt=1, dirty_nat_cnt=2
>>>                                      nat_cnt=1, dirty_nat_cnt=1
>>
>> nm_i->nat_cnt and nm_i->dirty_nat_cnt were protected by
>> nm_i->nat_tree_lock, I didn't see why expanding nat_list_lock range
>> will help... since there are still places nat_list_lock() didn't
>> cover these two reference counts.
> 
> Yeah, I missed nat_tree_lock, and indeed it should cover this. So, the problem
> is Light reported subtle case of nat_cnt < dirty_nat_cnt in shrink_count.
> We may need to use nat_tree_lock in shrink_count?

change like this?

__count_nat_entries()

	down_read(&nm_i->nat_tree_lock);
	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
	up_read(&nm_i->nat_tree_lock);

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/node.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 42394de6c7eb..e8ec65e40f06 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -269,11 +269,10 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>>>    {
>>>    	spin_lock(&nm_i->nat_list_lock);
>>>    	list_move_tail(&ne->list, &nm_i->nat_entries);
>>> -	spin_unlock(&nm_i->nat_list_lock);
>>> -
>>>    	set_nat_flag(ne, IS_DIRTY, false);
>>>    	set->entry_cnt--;
>>>    	nm_i->dirty_nat_cnt--;
>>> +	spin_unlock(&nm_i->nat_list_lock);
>>>    }
>>>    static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
>>>
> .
> 
