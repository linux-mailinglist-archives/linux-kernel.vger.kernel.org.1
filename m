Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61F2CEAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgLDJUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:20:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgLDJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:20:10 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnRwN0GQKz15XR8;
        Fri,  4 Dec 2020 17:19:00 +0800 (CST)
Received: from [10.174.179.81] (10.174.179.81) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 17:19:25 +0800
Subject: Re: [PATCH] staging: greybus: audio: Add missing unlock in
 gbaudio_dapm_free_controls()
To:     Johan Hovold <johan@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
CC:     <elder@kernel.org>, <gregkh@linuxfoundation.org>,
        <dan.carpenter@oracle.com>, <aibhav.sr@gmail.com>,
        <greybus-dev@lists.linaro.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20201204021350.28182-1-wanghai38@huawei.com>
 <X8n2CL58pQ/077rQ@localhost>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <d95dac95-09d0-66bb-4f3b-5ffa154be174@huawei.com>
Date:   Fri, 4 Dec 2020 17:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <X8n2CL58pQ/077rQ@localhost>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/12/4 16:40, Johan Hovold Ð´µÀ:
> On Fri, Dec 04, 2020 at 10:13:50AM +0800, Wang Hai wrote:
>> Add the missing unlock before return from function
>> gbaudio_dapm_free_controls() in the error handling case.
>>
>> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   drivers/staging/greybus/audio_helper.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
>> index 237531ba60f3..293675dbea10 100644
>> --- a/drivers/staging/greybus/audio_helper.c
>> +++ b/drivers/staging/greybus/audio_helper.c
>> @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>>   		if (!w) {
>>   			dev_err(dapm->dev, "%s: widget not found\n",
>>   				widget->name);
>> +			mutex_unlock(&dapm->card->dapm_mutex);
>>   			return -EINVAL;
>>   		}
>>   		widget++;
> This superficially looks correct, but there seems to be another bug in
> this function. It can be used free an array of widgets, but if one of
> them isn't found we just leak the rest. Perhaps that return should
> rather be "widget++; continue;".
>
I think this is a good idea, should I send a v2 patch?
>
