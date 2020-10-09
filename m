Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67AE288331
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgJIHFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:05:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgJIHFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:05:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6CBE07F916D97EDA2CB9;
        Fri,  9 Oct 2020 15:05:29 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 9 Oct 2020
 15:05:25 +0800
Subject: Re: [f2fs-dev] [f2fs bug] infinite loop in
 f2fs_get_meta_page_nofail()
To:     <jaegeuk@kernel.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        <syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <000000000000432c5405b1113296@google.com>
 <20201007213253.GD1530638@gmail.com> <20201007215305.GA714500@google.com>
 <c7baef0d-d459-114f-7146-627f0c4159ad@huawei.com>
 <20201009015015.GA1931838@google.com>
 <8fa4f9fe-5ca5-f3a3-c8f4-e800373c1e46@huawei.com>
 <20201009043237.GB1973455@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a842eec8-2dbb-aa01-cc64-c513d59cad24@huawei.com>
Date:   Fri, 9 Oct 2020 15:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201009043237.GB1973455@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/9 12:32, jaegeuk@kernel.org wrote:
> On 10/09, Chao Yu wrote:
>> On 2020/10/9 9:50, jaegeuk@kernel.org wrote:
>>> On 10/09, Chao Yu wrote:
>>>> On 2020/10/8 5:53, jaegeuk@kernel.org wrote:
>>>>> On 10/07, Eric Biggers wrote:
>>>>>> [moved linux-fsdevel to Bcc]
>>>>>>
>>>>>> On Wed, Oct 07, 2020 at 02:18:19AM -0700, syzbot wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following issue on:
>>>>>>>
>>>>>>> HEAD commit:    a804ab08 Add linux-next specific files for 20201006
>>>>>>> git tree:       linux-next
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=17fe30bf900000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ee250ac8137be41d7b13
>>>>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336413b900000
>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f7392b900000
>>>>>>>
>>>>>>> The issue was bisected to:
>>>>>>>
>>>>>>> commit eede846af512572b1f30b34f9889d7df64c017d4
>>>>>>> Author: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>> Date:   Fri Oct 2 21:17:35 2020 +0000
>>>>>>>
>>>>>>>        f2fs: f2fs_get_meta_page_nofail should not be failed
>>>>>>>
>>>>>>
>>>>>> Jaegeuk, it looks like the loop you added in the above commit doesn't terminate
>>>>>> if the requested page is beyond the end of the device.
>>>>>
>>>>> Yes, that will go infinite loop. Otherwise, it will trigger a panic during
>>>>> the device reboot. Let me think how to avoid that before trying to get the
>>>>> wrong lba access.
>>>>
>>>> Delivering f2fs_get_sum_page()'s return value needs a lot of codes change, I think
>>>> we can just zeroing sum_page in error case, as we have already shutdown f2fs via
>>>> calling f2fs_stop_checkpoint(), then f2fs_cp_error() will stop all updates to
>>>> filesystem data including summary pages.
>>>
>>> That sounds like one solution tho, I'm afraid of getting another panic by
>>> wrong zero'ed summary page.
>>
>> What case do you mean? maybe I missed some corner cases?
> 
> I sent v2 to fix syzbot issue, which fixes wrong use of
> f2fs_get_meta_page_nofail.

I agreed to fix that case, however we may encounter deadloop in other
places where we call f2fs_get_meta_page_nofail()? like the case that
filesystem will always see EIO after we shutdown device via dmflakey?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thoughts?
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> - Eric
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>> .
>>>>>
>>> .
>>>
> .
> 
