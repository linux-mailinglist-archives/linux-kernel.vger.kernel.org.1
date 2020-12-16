Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5E2DC208
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLPOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:19:33 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2339 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLPOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:19:33 -0500
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CwxzR6sjgz13VMK;
        Wed, 16 Dec 2020 22:17:39 +0800 (CST)
Received: from [10.174.177.7] (10.174.177.7) by dggeme753-chm.china.huawei.com
 (10.3.19.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 16
 Dec 2020 22:18:43 +0800
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        <luolongjun@huawei.com>, <hejingxian@huawei.com>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
 <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com>
 <87v9d2rrdq.fsf@nanos.tec.linutronix.de>
From:   "shenkai (D)" <shenkai8@huawei.com>
Message-ID: <06977da1-d148-0079-0e85-32d657d1a1de@huawei.com>
Date:   Wed, 16 Dec 2020 22:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87v9d2rrdq.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.7]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme753-chm.china.huawei.com (10.3.19.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/12/16 18:12, Thomas Gleixner 写道:
> Kai,
>
> On Wed, Dec 16 2020 at 16:45, shenkai wrote:
>> 在 2020/12/16 5:20, Thomas Gleixner 写道:
>>>
>> Thanks for your and Andy's precious comments. I would like to take a try on
>>
>> reconstructing this patch to make it more decent and generic.
>>> It would be interesting to see the numbers just with play_dead() using
>>> hlt() or mwait(eax=0, 0) for the kexec case and no other change at all.
> Can you please as a first step look into this and check if the time
> changes?
>
> Thanks,
>
>          tglx
> .

After some tests, the conclusion that time cost is from deep C-state 
turns out to be wrong

Sorry for that.

Here is what I do:

In kexec case, first let APs spinwait like what I did  in that patch, 
but wake APs up by

sending apic INIT and SIPI  interrupts as normal procedure instead of 
writing to some

address and there is no acceleration (time cost is still 210ms).

So can we say that the main time cost is from apic INIT and SIPI 
interrupts and the handling

of them instead of deep C-state?


I didn't test with play_dead() because in kexec case, one new kernel 
will be started and APs can't be

waken up by normal interrupts like in hibernate case for the irq vectors 
are gone with the old kernel.

Or maybe I didn't get the point correctly?


Best regards

Kai



