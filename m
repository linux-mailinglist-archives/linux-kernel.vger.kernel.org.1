Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1454E2A384C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgKCBS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:18:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6692 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:18:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQBk66jMZz15NlQ;
        Tue,  3 Nov 2020 09:18:22 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 09:18:15 +0800
Subject: Re: [PATCH] coresight: funnel: Remove unnecessary .owner of static
 funnel driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1604139150-18659-1-git-send-email-liuqi115@huawei.com>
 <20201102172330.GB2749502@xps15>
CC:     <suzuki.poulose@arm.com>, <Al.Grant@arm.com>,
        <mike.leach@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <813ceaa8-9bad-6e10-45f8-a56656519f63@huawei.com>
Date:   Tue, 3 Nov 2020 09:18:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201102172330.GB2749502@xps15>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,


On 2020/11/3 1:23, Mathieu Poirier wrote:
> Hi Liu,
>
> On Sat, Oct 31, 2020 at 06:12:30PM +0800, Qi Liu wrote:
>> As driver.owner has been set in platform_driver_register(), it is
>> unnecessary to set it in static funnel driver, so remove it from
>> struct static_funnel_driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-funnel.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
>> index af40814..07bc203 100644
>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>> @@ -356,7 +356,6 @@ static struct platform_driver static_funnel_driver = {
>>  	.remove          = static_funnel_remove,
>>  	.driver         = {
>>  		.name   = "coresight-static-funnel",
>> -		.owner	= THIS_MODULE,
> I received two identical patches (with a different title) from you.  Since there
> was no explanation I will discard the first one and work with this one.
>
> You are correct, platform_driver_register() does take care of THIS_MODULE.
> Please send another revision where you will do three things:
>
> 1) CC the coresight mailing list, as instructed by get_maintainer.pl
> 1) Also fix the replicator driver.
> 2) Add a comment that clearly mentions THIS_MODULE doesn't need to be set:
>
>                 .name   = "coresight-static-funnel",
>                 /* THIS_MODULE is taken care of by platform_driver_register() */
>                 .of_match_table = static_funnel_match,
>                 .acpi_match_table = ACPI_PTR(static_funnel_ids),
>                 .pm	= &funnel_dev_pm_ops,
>
> Thanks,
> Mathieu
Thanks for your review , I'll send a new patch latter.

Liu
>> --
>> 2.8.1
>>
> .
>


