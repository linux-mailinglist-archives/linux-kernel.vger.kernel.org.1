Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106E2CFB0C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgLEKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:49:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgLEKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:45:44 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cp5lW4gbWzhkcy;
        Sat,  5 Dec 2020 18:43:35 +0800 (CST)
Received: from [10.174.179.81] (10.174.179.81) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Dec 2020 18:44:01 +0800
Subject: Re: [PATCH] staging: greybus: audio: Add missing unlock in
 gbaudio_dapm_free_controls()
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Johan Hovold <johan@kernel.org>
CC:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <aibhav.sr@gmail.com>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201204021350.28182-1-wanghai38@huawei.com>
 <X8n2CL58pQ/077rQ@localhost>
 <CAAs3649kGerXZqgffwethn-JNOiiFSif1COM3no4Az4Ah220VA@mail.gmail.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <5614008b-69b8-c37f-ddb9-7497862eb8bc@huawei.com>
Date:   Sat, 5 Dec 2020 18:44:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAs3649kGerXZqgffwethn-JNOiiFSif1COM3no4Az4Ah220VA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/12/5 2:02, Vaibhav Agarwal 写道:
> On Fri, Dec 4, 2020 at 2:10 PM Johan Hovold <johan@kernel.org> wrote:
>> On Fri, Dec 04, 2020 at 10:13:50AM +0800, Wang Hai wrote:
>>> Add the missing unlock before return from function
>>> gbaudio_dapm_free_controls() in the error handling case.
>>>
>>> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>>> ---
>>>   drivers/staging/greybus/audio_helper.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
>>> index 237531ba60f3..293675dbea10 100644
>>> --- a/drivers/staging/greybus/audio_helper.c
>>> +++ b/drivers/staging/greybus/audio_helper.c
>>> @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>>>                if (!w) {
>>>                        dev_err(dapm->dev, "%s: widget not found\n",
>>>                                widget->name);
>>> +                     mutex_unlock(&dapm->card->dapm_mutex);
>>>                        return -EINVAL;
>>>                }
>>>                widget++;
>> This superficially looks correct, but there seems to be another bug in
>> this function. It can be used free an array of widgets, but if one of
>> them isn't found we just leak the rest. Perhaps that return should
>> rather be "widget++; continue;".
>>
>> Vaibhav?
> Thanks Wang for sharing the patch. As already pointed by Johan, this
> function indeed has another bug as well.
> Pls feel free to share the patch as suggested above.
I just sent another patch

"[PATCH] staging: greybus: audio: Fix possible leak free widgets in 
gbaudio_dapm_free_controls"

> Johan
> .
>
