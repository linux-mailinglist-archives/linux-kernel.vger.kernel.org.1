Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D592A273A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgKBJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:43:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59630 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKBJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:43:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A29gZr4122182;
        Mon, 2 Nov 2020 03:42:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604310155;
        bh=wID7KWQuyPbpff634ZRa+jxmimF60o/eMaA/d4X62fI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O822Oi/pWSvGnc2GHJD8REMc5uzV0qeFsVUUDruLIVWqF/OvjvCXUg55irFrEElq8
         x6Q+u/qOnsfPpbR4QzVefFzDp9c2YW9ZoupEoGdCCkNmZcJ9jHPxROHW4KDzwV1aTP
         0nLjY4jU3j5ChQtNkehBbLfo0+dg+yXQ8WnMqaLw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A29gZcv028949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 03:42:35 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 03:42:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 03:42:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A29gAwr074602;
        Mon, 2 Nov 2020 03:42:11 -0600
Subject: Re: [PATCH] drm/bridge: tpd12s015: Fix irq registering in
 tpd12s015_probe
To:     Yuehaibing <yuehaibing@huawei.com>, Sam Ravnborg <sam@ravnborg.org>
CC:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20201031031648.42368-1-yuehaibing@huawei.com>
 <20201031071936.GA1044557@ravnborg.org>
 <57bfde5b-aee1-c15f-896a-63033e86d9a2@ti.com>
 <3d7fc2b4-8f8c-2ad3-34a5-7c48a6832df0@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <bbf82393-0cbd-bb2c-6002-368486a1b900@ti.com>
Date:   Mon, 2 Nov 2020 11:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d7fc2b4-8f8c-2ad3-34a5-7c48a6832df0@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2020 11:36, Yuehaibing wrote:
> On 2020/11/2 14:57, Tomi Valkeinen wrote:
>> On 31/10/2020 09:19, Sam Ravnborg wrote:
>>> Hi YueHaibing
>>>
>>> Thanks for the fix. Appreciated but please update as per comments below.
>>>
>>> On Sat, Oct 31, 2020 at 11:16:48AM +0800, YueHaibing wrote:
>>>> gpiod_to_irq() return negative value in case of error,
>>>> the existing code handle negative error codes wrongly.
>>>>
>>>> Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/gpu/drm/bridge/ti-tpd12s015.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>>> index 514cbf0eac75..a18d5197c16c 100644
>>>> --- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>>> +++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>>> @@ -160,7 +160,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
>>>>  
>>>>  	/* Register the IRQ if the HPD GPIO is IRQ-capable. */
>>>>  	tpd->hpd_irq = gpiod_to_irq(tpd->hpd_gpio);
>>>> -	if (tpd->hpd_irq) {
>>>> +	if (tpd->hpd_irq > 0) {
>>>>  		ret = devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
>>>>  						tpd12s015_hpd_isr,
>>>>  						IRQF_TRIGGER_RISING |
>>>
>>> The current implmentation will skip devm_request_threaded_irq() in case
>>> or error - but continue with the rest of the function. So the
>>> driver fails to return an error code.
>>
>> That is intended. If the HPD gpio supports IRQs (gpiod_to_irq returns a valid number), we use the
>> IRQ. If it doesn't (gpiod_to_irq returns an error), it gets polled via detect(). Both are ok.
>>
>> I don't know if the gpiod_to_irq never returning 0 is something we should rely on. The docs say
>> gpiod_to_irq returns the irq number or an error, so I think checking for >= 0 matches the docs better.
>>
> 
> gpiod_to_irq() now never returns 0, see:
> https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/gpio/gpiolib.c#L3183
> 
> Also commit 4c37ce8608a8 ("gpio: make gpiod_to_irq() return negative for NO_IRQ") says:
> 
> commit 4c37ce8608a8c6521726d4cd1d4f54424e8d095f
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Mon May 2 13:13:10 2016 +0200
> 
>     gpio: make gpiod_to_irq() return negative for NO_IRQ
> 
>     If a translation returns zero, that means NO_IRQ, so we
>     should return an error since the function is documented to
>     return a negative code on error.
> 
> So checking for >0 is enough, my patch is correct.

Yes, but that is a gpiod_to_irq internal implementation detail. The documentation says it returns an
error code (negative) or a valid irq number. The documentation does not say gpiod_to_irq never
returns 0.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
