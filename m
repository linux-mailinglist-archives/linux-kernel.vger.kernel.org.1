Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF382B6368
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgKQNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:37:57 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2374 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbgKQNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:37:53 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Cb6SW5DK4z54ZY;
        Tue, 17 Nov 2020 21:37:31 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 21:37:49 +0800
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
From:   "xuqiang (M)" <xuqiang36@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
 <b278ce4baea0cf79403f793721d16a8b@kernel.org>
 <32592d73-9800-f420-eb00-474d9ded6155@huawei.com>
 <338d65dfeac0cc026c74d9e78ec6f0c1@kernel.org>
 <96243568-01ad-31c2-e927-6b85738c9bc3@huawei.com>
Message-ID: <4750e471-78dd-4a35-21a7-39172adc2295@huawei.com>
Date:   Tue, 17 Nov 2020 21:37:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <96243568-01ad-31c2-e927-6b85738c9bc3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/11/10 17:09, xuqiang (M) 写道:
>
> 在 2020/11/9 18:43, Marc Zyngier 写道:
>> On 2020-11-09 03:05, xuqiang (M) wrote:
>>> 在 2020/11/8 0:54, Marc Zyngier 写道:
>>>> [dropping Jason, whose email address has been bouncing for weeks now]
>>>>
>>>> On 2020-11-07 10:42, Xu Qiang wrote:
>>>>> On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do 
>>>>> nothing
>>>>
>>>> Which platform?
>>> Hisi Ascend platform
>>>>
>>>>> in its suspend and resuse function.On the other hand,firmware stores
>>>>> GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
>>>>> and restores these registers in the resume. As a result, the ITS 
>>>>> executes
>>>>> the residual commands in the queue.
>>>>
>>>> Which firmware are you using? I just had a look at the trusted 
>>>> firmware source
>>>> code, and while it definitely does something that *looks* like what 
>>>> you are
>>>> describing, it doesn't re-enable the ITS on resume.
>>>>
>>>> So what are you running?
>>>
>>> I am using ATF. Since ITS_FLAGS_SAVE_SUSPEND_STATE is not set,ITS
>>> driver of OS will
>>>
>>> not re-enable ITS in th resume. To make ITS work properly, we changed
>>> the ATF code
>>>
>>> to re-enable ITS on resume.
>>
>> I don't think the words "work properly" apply here.
>>
>> The kernel didn't do what you wanted, so instead of fixing the 
>> kernel, you
>> introduced a bug that results in memory corruption from the firmware.
>>
>> What are you plans to fix your firmware? Because from an upstream ATF
>> compatibility PoV, all there is to do is to fixup the command queue and
>> enable the ITS.
>>
>>         M.
>
>
> I'm sorry I didn't make it clear how to do this. I'm going to reset 
> commit
>
> which re-enable ITS  on the ATF, and drop the checks for 
> ITS_FLAGS_SAVE_SUSPEND_STATE
>
> in the OS.
>
> In other words, the ATF does not re-enable ITS, and OS itself 
> re-enables ITS when it resumes.
>
> To do this, I have to remove the check of ITS_FLAGS_SAVE_SUSPEND_STATE 
> because it is not set.
>
>
> Thanks
>
>         Xu.
>
Hi Marc

     I have been waiting for your reply. Are there any questions about 
this modification plan?

Thanks

         Xu.

