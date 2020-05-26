Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24951CC251
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgEIPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 11:07:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728053AbgEIPHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 11:07:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 966B02D283076DB303F6;
        Sat,  9 May 2020 23:07:38 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 23:07:35 +0800
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Add module license
To:     Randy Dunlap <rdunlap@infradead.org>, <thierry.reding@gmail.com>,
        <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <harigovi@codeaurora.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20200509063017.2000-1-yanaijie@huawei.com>
 <5d692435-1d55-ade9-fe22-00ffc1cdca64@infradead.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <e910e123-f725-a3a4-56fc-7f1f39020953@huawei.com>
Date:   Sat, 9 May 2020 23:07:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5d692435-1d55-ade9-fe22-00ffc1cdca64@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/5/9 14:36, Randy Dunlap 写道:
> On 5/8/20 11:30 PM, Jason Yan wrote:
>> Fix the following build warning:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-visionox-rm69299.o
>> see include/linux/module.h for more information
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
>> index 25fe8b0bb040..ec279ffdbd94 100644
>> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
>> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
>> @@ -300,3 +300,4 @@ static struct mipi_dsi_driver visionox_rm69299_driver = {
>>   module_mipi_dsi_driver(visionox_rm69299_driver);
>>   
>>   MODULE_DESCRIPTION("Visionox RM69299 DSI Panel Driver");
>> +MODULE_LICENSE("GPL");
>>
> 
> I sent a patch for this yesterday.
> 

I'm sorry. Please ignore this one.

Thanks,

> 

