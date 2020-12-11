Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1A2D801B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbgLKUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgLKUly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:41:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3904C0613D3;
        Fri, 11 Dec 2020 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6knrEQCXntsvK6+oBQBU88owhBmoCN500ay3MRFs9Ko=; b=y1oaq5OFwNRVrMS/k4g5kzuHXy
        XpXuBMOlEXrB0j4TWDl24eUR8m4kug6Kiy580Qu8rbWpQwIk5iQQIll4YBdDLhqML7hcuyEB+7Njs
        RTwbANKlIwijDuQsV8xGsMaWzyDfSvkDag8oSG7cwrv+mD6ONsJ5NIrItOSlen6bxc31jYj8lPok7
        JGJHSadg1rVZjm1bZ0ZSZpTS+VZuLOwZxuAlhjcCJ5iQkI67NLior/6QUz7pL/4SkmEUPZtCxRUpJ
        WfwPoO177OuqB+DpYFbNnNrLgg+I+I2cfDIi55Y8GImfnaKVjvhtvHUHJOqDu0/vdaOwSacYmFTJc
        b68get1g==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knpDz-0002w9-G5; Fri, 11 Dec 2020 20:41:11 +0000
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20201211190335.16501-1-rdunlap@infradead.org>
 <3705938f-6f82-88ef-455b-e0f7459989e3@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c9e708d4-f4c5-01e2-d003-7f5d92a533e9@infradead.org>
Date:   Fri, 11 Dec 2020 12:41:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3705938f-6f82-88ef-455b-e0f7459989e3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 12:23 PM, Maximilian Luz wrote:
> On 12/11/20 8:03 PM, Randy Dunlap wrote:
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
>>   drivers/platform/surface/surface_gpe.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> --- linux-next-20201210.orig/drivers/platform/surface/surface_gpe.c
>> +++ linux-next-20201210/drivers/platform/surface/surface_gpe.c
>> @@ -181,6 +181,7 @@ static int surface_lid_enable_wakeup(str
>>       return 0;
>>   }
>>   +#ifdef CONFIG_PM_SLEEP
>>   static int surface_gpe_suspend(struct device *dev)
>>   {
>>       return surface_lid_enable_wakeup(dev, true);
>> @@ -190,6 +191,7 @@ static int surface_gpe_resume(struct dev
>>   {
>>       return surface_lid_enable_wakeup(dev, false);
>>   }
>> +#endif
>>     static SIMPLE_DEV_PM_OPS(surface_gpe_pm, surface_gpe_suspend, surface_gpe_resume);
>>  
> 
> Right, thanks.
> 
> I assume this covers all instances of this warning in platform/surface?
> Otherwise, a "platform: surface: gpe: ..." subject would make more sense.

It should cover all of surface/. It was an allmodconfig and then I disabled
CONFIG_PM and CONFIG_PM_SLEEP etc.

As for prefixes, how many levels do we want to use?
(that's mostly rhetorical, although I would read answers :)

> As for the rest:
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

thanks.
-- 
~Randy

