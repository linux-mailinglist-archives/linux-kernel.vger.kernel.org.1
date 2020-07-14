Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAE2200FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGNXUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 19:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGNXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:20:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:20:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so506312wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/KMagfkLbbir5XD2E7V8iMKOu/nE7qe0ZSxVTJVsu5Y=;
        b=I78DT92rk2oGUJNey+cMiJ+dT1q2neBqqRdkKk5hQk+kaMkXt5Z1hTIWtXtbl4f7TQ
         +64sPRnnKCWYuoKMDmbwoLXqYPWi7TGwNfnvKe3IHbtwhAKKJh+iwZT2L810KyMya/0z
         Yx6hgnbaUUDMqeBJM3KSFjEcHLQvA2q8adZbLlPJO7Cxljyddd53TCFO2C7eDHSEyd/K
         ++teAkTGOI2b1PKFHB22OwLkFNjzWerwFPA1tZZa+4xErRTS0g5912aXv0xpH2bdtVcr
         nicBCEGRDD7LNFyYq4YuSv4JMYTiDvG+4ll3/KQkUG02RSHHDW1eqhmanwJXqLyAz1QS
         ZKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KMagfkLbbir5XD2E7V8iMKOu/nE7qe0ZSxVTJVsu5Y=;
        b=T5FnXC59OdubmEHhdQJYJkqTG17My2+4lMBal29dil7IxRksLO8JE9j9RuVCvL/0As
         +U7pLXTBuR7ZxIYlDStNC55J6OMswRe4nv3I1Fs2iZFopaggLJvzTNNfz3pYXGKi8Pc0
         n6pM9HRPG7GfboojDMcQFEaHeZOshxwoL5TG5KFe8iVPOZwXuP7/ovxMXmkMZFnyELCe
         6oK5VKngoEt2deB9tEg1AlOEwCKsgOhiLr00iRKjRN4tHe3EhRCopXfX29MRhhwzkOl5
         FETd7DSwDuGk+FVhwpv5uACmRNC5JU2ZKQduRF9/3/46fDtG/IvcwE+fRzkA855BWb7G
         /BVw==
X-Gm-Message-State: AOAM530UIthcHJF6F82mQcTqIwzvnSPjnSHCIpDXG9ZSeujvx5hoatns
        dtZku5E5Cl8Vu3IvDQJbN7QGeg==
X-Google-Smtp-Source: ABdhPJxg5ZRUMNL70rPOM9WunXXtcwFJTQMTcUcvKt8QOZqVA17b3C0Soo2dTi99b+nuQY2xrpeCTQ==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr8189076wrp.227.1594768829794;
        Tue, 14 Jul 2020 16:20:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9? ([2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9])
        by smtp.googlemail.com with ESMTPSA id w128sm587809wmb.19.2020.07.14.16.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 16:20:29 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
 <20200706105538.2159-4-daniel.lezcano@linaro.org>
 <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
 <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
 <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
 <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
 <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
 <75683b75-6e1b-6e4e-2354-477c487a5f5f@linaro.org>
Message-ID: <4cfb15f6-2801-3386-c7cf-6296a54571a1@linaro.org>
Date:   Wed, 15 Jul 2020 01:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <75683b75-6e1b-6e4e-2354-477c487a5f5f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 22:32, Daniel Lezcano wrote:
> On 13/07/2020 11:31, Marek Szyprowski wrote:
>> Hi
>>
>> On 07.07.2020 11:15, Marek Szyprowski wrote:
>>> On 06.07.2020 15:46, Daniel Lezcano wrote:
>>>> On 06/07/2020 15:17, Marek Szyprowski wrote:
>>>>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>>>>> The generic netlink protocol is implemented but the different
>>>>>> notification functions are not yet connected to the core code.
>>>>>>
>>>>>> These changes add the notification calls in the different
>>>>>> corresponding places.
>>>>>>
>>>>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>>>>> ("thermal: core: Add notifications call in the framework"). Sadly it
>>>>> breaks booting various Samsung Exynos based boards. Here is an example
>>>>> log from Odroid U3 board:
>>>>>
>>>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>>>> 00000010
>>>>> pgd = (ptrval)
>>>>> [00000010] *pgd=00000000
>>>>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>>>> Modules linked in:
>>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560
>>>>> #1146
>>>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>>>> PC is at kmem_cache_alloc+0x13c/0x418
>>>>> LR is at kmem_cache_alloc+0x48/0x418
>>>>> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
>>>>> ...
>>>>> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>>>>> Control: 10c5387d  Table: 4000404a  DAC: 00000051
>>>>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>>>>> Stack: (0xee8f1cf8 to 0xee8f2000)
>>>>> ...
>>>>> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] 
>>>>> (__alloc_skb+0x5c/0x170)
>>>>> [<c08cd170>] (__alloc_skb) from [<c07ec19c>]
>>>>> (thermal_genl_send_event+0x24/0x174)
>>>>> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>]
>>>>> (thermal_notify_tz_create+0x58/0x74)
>>>>> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>]
>>>>> (thermal_zone_device_register+0x358/0x650)
>>>>> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>]
>>>>> (of_parse_thermal_zones+0x304/0x7a4)
>>>>> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>]
>>>>> (thermal_init+0xdc/0x154)
>>>>> [<c1028964>] (thermal_init) from [<c0102378>] 
>>>>> (do_one_initcall+0x8c/0x424)
>>>>> [<c0102378>] (do_one_initcall) from [<c1001158>]
>>>>> (kernel_init_freeable+0x190/0x204)
>>>>> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>]
>>>>> (kernel_init+0x8/0x118)
>>>>> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>>>>
>>>>> Reverting it on top of linux-next fixes the boot issue. I will
>>>>> investigate it further soon.
>>>> Thanks for reporting this.
>>>>
>>>> Can you send the addr2line result and code it points to ?
>>>
>>> addr2line of c02b5cac (kmem_cache_alloc+0x13c/0x418) points to 
>>> mm/slub.c +2839, but I'm not sure if we can trust it. imho it looks 
>>> like some trashed memory somewhere, but I don't have time right now to 
>>> analyze it further now...
>>
>> Just one more thing I've noticed. The crash happens only if the kernel 
>> is compiled with old GCC (tested with arm-linux-gnueabi-gcc (Linaro GCC 
>> 4.9-2017.01) 4.9.4). If I compile kernel with newed GCC (like 
>> arm-linux-gnueabi-gcc (Linaro GCC 6.4-2017.11) 6.4.1 20171012), it works 
>> fine...
>>
>> This happens also with Linux next-20200710, which again got this commit.
> 
> So I finally succeed to reproduce on an ARM64 with a recent compiler,
> earlycon, and the option CONFIG_INIT_ON_ALLOC_DEFAULT_ON.


Finally, narrowed down the issue.

 - genetlink initialization is done at subsys initcall.
 - thermal netlink init is done at core initcall
 - netlink is done at core initcall

By changing the order:

 - netlink and genetlink at core initcall
 - thermal init at postcore initcall

That fixes the problem. The genetlink initcall order is from 2005 and
IMO it makes sense to come right after the netlink initialization.

It is acceptable to have the thermal init at the postcore initcall. It
is very recently we moved from fs_initcall to core_initcall.

Thanks to Arnd who give me a direction to look at.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
