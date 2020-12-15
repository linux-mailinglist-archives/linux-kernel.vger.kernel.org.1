Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB92DB506
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgLOUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgLOUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F4C0617A6;
        Tue, 15 Dec 2020 12:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=N/1okadLW/1bioiLHBq8zQD0b+zBkavJlAW3LSyJkNk=; b=nppOdxK8/vMIEzYqVMVjlrVXrl
        Lqp2DCPyIrJJnPtoZl1wCv0zPT/wQRlLYjrZaKhLvTvXGEmf0tqQAgMBiHQCKIspOx5UL99CVR1k2
        pa/Kh+BKFxCkHW1z0jC9brjgyBIgvgtD+zbPMv0P2jARbf2SQJJi1RNkBYkIp3L89MvuAOy27/s4v
        LWTT95yWaxd2NlVwoQ7mqeO3pketVmcT/N1FpYn0mBsBVszgUNTwQ3hE2ICHDn2dX70PeAn/L940S
        qB+m3uxTzEwC+/dWzVE4RiFNFgdoYUcpN5uTepv96km/phH/r5s2jQUT0u02I9MOG/3M2tGIx//Il
        wNli57sg==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpGi3-0002z8-Kg; Tue, 15 Dec 2020 20:14:12 +0000
Subject: Re: [PATCH v2 -next] platform: surface: fix non-PM_SLEEP build
 warnings
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20201214233336.19782-1-rdunlap@infradead.org>
 <5fd70f29-2795-5b46-4bc9-e60a26efee88@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <266d2103-ae66-e216-1940-a16c4199aefb@infradead.org>
Date:   Tue, 15 Dec 2020 12:14:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5fd70f29-2795-5b46-4bc9-e60a26efee88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 11:55 AM, Maximilian Luz wrote:
> On 12/15/20 12:33 AM, Randy Dunlap wrote:
>> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
>> functions are not used:
>>
>> ../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
>>   static int surface_gpe_resume(struct device *dev)
>>              ^~~~~~~~~~~~~~~~~~
>> ../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
>>   static int surface_gpe_suspend(struct device *dev)
>>              ^~~~~~~~~~~~~~~~~~~
>>
>> Fixes: 274335f1c557 ("platform/surface: Add Driver to set up lid GPEs on MS Surface device")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Maximilian Luz <luzmaximilian@gmail.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: platform-driver-x86@vger.kernel.org
>> ---
>> v2: dropped Maximilian's RVB tag since the patch changed
>>      use preferred __maybe_unused instead of ifdeffery:
>>        https://lore.kernel.org/patchwork/patch/732981/
>>
>>   drivers/platform/surface/surface_gpe.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20201214.orig/drivers/platform/surface/surface_gpe.c
>> +++ linux-next-20201214/drivers/platform/surface/surface_gpe.c
>> @@ -181,12 +181,12 @@ static int surface_lid_enable_wakeup(str
>>       return 0;
>>   }
>>   -static int surface_gpe_suspend(struct device *dev)
>> +static int __maybe_unused surface_gpe_suspend(struct device *dev)
>>   {
>>       return surface_lid_enable_wakeup(dev, true);
>>   }
>>   -static int surface_gpe_resume(struct device *dev)
>> +static int __maybe_unused surface_gpe_resume(struct device *dev)
>>   {
>>       return surface_lid_enable_wakeup(dev, false);
>>   }
>>
> 
> Code looks good to me.
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> As already mentioned before, I'd prefer the subject line to be
> "platform/surface: gpe: ...", or at least "platform/surface: ..." for
> consistency with other commits. May just be a personal preference
> though, so nothing that should prevent it from being applied.
> 

Ugh, sorry about that. I've changed that in the patch so if I ever
resend it, it will be fixed.


-- 
~Randy

