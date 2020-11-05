Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A682A8062
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgKEOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:06:38 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2363 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgKEOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:06:37 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CRlgT294qz519v;
        Thu,  5 Nov 2020 22:06:29 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 22:06:34 +0800
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
References: <20201103081123.119969-1-xuqiang36@huawei.com>
 <87imamtiav.wl-maz@kernel.org>
 <8395dfbb-a90e-6903-abe9-cd6f7c48f441@huawei.com>
 <11f4143b4ef55739ff1441e848c1f66f@kernel.org>
From:   "xuqiang (M)" <xuqiang36@huawei.com>
Message-ID: <5310d2fb-3f01-1283-ea4d-c5992f0c16a5@huawei.com>
Date:   Thu, 5 Nov 2020 22:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <11f4143b4ef55739ff1441e848c1f66f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/11/5 21:12, Marc Zyngier 写道:
> Please don't top-post.
>
> On 2020-11-05 11:54, xuqiang (M) wrote:
>> The kernel sends three commands in the following sequence:
>>
>> 1.mapd(deviceA, ITT_addr1, valid:1)
>>
>> 2.mapti(deviceA):ITS write ITT_addr1 memory;
>>
>> 3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);
>>
>> 4.mapd(deviceA, ITT_addr2, valid:1);
>>
>> 5.mapti(deviceA):ITS write ITT_addr2 memory;
>>
>> In this case, the processor enters the sleep mode. After the kernel
>> performs the suspend operation, the firmware performs the store
>> operation and saves GITS_CBASER and GITS_CWRITER registers.
>>
>> Then, the processor is woken up, and the firmware restores GITS_CBASER
>> and GITS_CWRITER registers. Because GITS_CWRITER register is not 0,
>> ITS will read the above command sequence execution from the command
>> queue, causing ITT_addr1 memory to be trampled.
>
> This cannot work. By doing a memset on the command queue, you are
> only feeding crap to the ITS (command 0 simply does not exist).
> Consider yourself lucky that it doesn't just lock-up.
>
> What needs to happen is the restore sequence that is already in the
> driver, so that the command queue is in a sane state before re-enabling
> the ITS.
>
>         M.


On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set, thus

the first if condition in its_save_disable under list_for_each_entry goes

to the continue, however, I want to set the GITS_CWRITER to 0 at the

end of list_for_each_entry.

Do you have any suggestions about how to do this?

