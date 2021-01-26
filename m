Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751BB3040B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405937AbhAZOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:42:58 -0500
Received: from m12-12.163.com ([220.181.12.12]:54730 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391478AbhAZOmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=XqxZk
        6Q21yuXDtAlxWPHamBd0euAii3WqYerQCRCsFI=; b=jCbQsSkBEzOetCO5nF1ht
        KNBb+bZmFJW5oVapHE3S9iX7DOZpO/OvxWSzgpPMuKkLfe+obq+98O2hoP2LMNdk
        u+KY9mZERjvSispv24Lkxzm+55oqVIyKY6H0G8QaBhzcabpIJ8IrmHbI1zSOu7Dg
        1QmY5HbveoF1nyvoqfb7F4=
Received: from [192.168.31.187] (unknown [36.170.37.79])
        by smtp8 (Coremail) with SMTP id DMCowADX34doKRBgBbuGNw--.3258S2;
        Tue, 26 Jan 2021 22:38:33 +0800 (CST)
Subject: Re: [RESEND PATCH v2] arm/mm/ptdump:Add address markers for KASAN
 regions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210120125010.10896-1-carver4lio@163.com>
 <CACRpkda5VXyg5F7r4RaHrSh303KZ3FjxnLEsQ1tFNXjMhxDqLw@mail.gmail.com>
From:   carver4lio@163.com
Message-ID: <bf5040d0-a131-02a5-8eed-005e2604b355@163.com>
Date:   Tue, 26 Jan 2021 22:38:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda5VXyg5F7r4RaHrSh303KZ3FjxnLEsQ1tFNXjMhxDqLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowADX34doKRBgBbuGNw--.3258S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW8Cr4UWryUGF1fAFW8WFg_yoWkZFc_Xr
        40yFn7ur45Ar1fCFn7GFn5Xrn0gr9Fg3yDJF93KF93Xry0vrWDCF4DCFZa9w4rAry7Gr4S
        yr42vw1kt3429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUetUUUUUUUU==
X-Originating-IP: [36.170.37.79]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/1tbiWAkmnVuHvVmxywAAso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 4:36 PM, Linus Walleij wrote:
> On Wed, Jan 20, 2021 at 1:54 PM Hailong liu <carver4lio@163.com> wrote:
> 
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> ARM has recently supported KASAN, so I think that it's time to add KASAN
>> regions for PTDUMP on ARM.
>>
>> I have tested this patch with QEMU + vexpress-a15. Both CONFIG_ARM_LPAE
>> and no CONFIG_ARM_LPAE.
>>
>> The result after patching looks like this:
>>  ---[ Kasan shadow start ]---
>>  0x6ee00000-0x7af00000         193M     RW NX SHD MEM/CACHED/WBWA
>>  0x7b000000-0x7f000000          64M     ro NX SHD MEM/CACHED/WBWA
>>  ---[ Kasan shadow end ]---
>>  ---[ Modules ]---
>>  ---[ Kernel Mapping ]---
>>         ......
>>  ---[ vmalloc() Area ]---
>>         ......
>>  ---[ vmalloc() End ]---
>>  ---[ Fixmap Area ]---
>>  ---[ Vectors ]---
>>         ......
>>  ---[ Vectors End ]---
>>
>> v2:
>> - fix the puzzling subject and the description due to my
>> carelessness.
>>
>> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Looks correct!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please put this into Russell's patch tracker.

I have put this patch into Russell's patch tracker, and its status now is
incoming.


