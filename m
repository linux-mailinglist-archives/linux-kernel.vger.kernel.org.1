Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F01A3117
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDIImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 04:42:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgDIImS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:42:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB59DAC02DEF2497F8AE;
        Thu,  9 Apr 2020 16:42:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:41:58 +0800
Subject: Re: [PATCH] signal: check sig before setting info in
 kill_pid_usb_asyncio
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     <ebiederm@xmission.com>, <oleg@redhat.com>, <tj@kernel.org>,
        <guro@fb.com>, <joel@joelfernandes.org>, <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
 <20200330084415.p4v5g6s24innsjrc@wittgenstein>
 <2d00096f-94f7-753e-c05f-14860fed2abe@huawei.com>
 <EFD902AA-B999-4E13-AC1E-1A28E93435BB@ubuntu.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <d4d090da-02dc-c2ca-32ab-90057d5aa893@huawei.com>
Date:   Thu, 9 Apr 2020 16:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <EFD902AA-B999-4E13-AC1E-1A28E93435BB@ubuntu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/9 14:53, Christian Brauner wrote:
> On April 9, 2020 5:26:08 AM GMT+02:00, Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>> Friendly ping...
>>
>> On 2020/3/30 16:44, Christian Brauner wrote:
>>> On Mon, Mar 30, 2020 at 10:18:33AM +0800, Zhiqiang Liu wrote:
>>>>
>>>> In kill_pid_usb_asyncio, if signal is not valid, we do not need to
>>>> set info struct.
>>>>
>>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>>
>>> I'd have done:
>>>
>>> if (!valid_signal(sig))
>>> 	return -EINVAL;
>>>
>>> instead of setting ret to EINVAL above but that's mostly a matter of
>> style.
>>>
>>> Picking this up unless someone sees a problem with it.
>>>
>>> Thank you!
>>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>
>>> .
>>>
> 
> The patches are queued for after rc1. So around next week.
> They came too late to make it into the merge window.
> 
> Christian
> 
That is ok, thanks.

Regards.
Zhiqiang Liu.

> .
> 

