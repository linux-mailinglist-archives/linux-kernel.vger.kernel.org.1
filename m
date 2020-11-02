Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868DE2A271C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgKBJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:36:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7572 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgKBJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:36:34 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPnqH2VNvzLrVT;
        Mon,  2 Nov 2020 17:36:27 +0800 (CST)
Received: from [10.174.176.180] (10.174.176.180) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 17:36:25 +0800
Subject: Re: [PATCH] drm/bridge: tpd12s015: Fix irq registering in
 tpd12s015_probe
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20201031031648.42368-1-yuehaibing@huawei.com>
 <20201031071936.GA1044557@ravnborg.org>
 <57bfde5b-aee1-c15f-896a-63033e86d9a2@ti.com>
CC:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3d7fc2b4-8f8c-2ad3-34a5-7c48a6832df0@huawei.com>
Date:   Mon, 2 Nov 2020 17:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <57bfde5b-aee1-c15f-896a-63033e86d9a2@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/2 14:57, Tomi Valkeinen wrote:
> On 31/10/2020 09:19, Sam Ravnborg wrote:
>> Hi YueHaibing
>>
>> Thanks for the fix. Appreciated but please update as per comments below.
>>
>> On Sat, Oct 31, 2020 at 11:16:48AM +0800, YueHaibing wrote:
>>> gpiod_to_irq() return negative value in case of error,
>>> the existing code handle negative error codes wrongly.
>>>
>>> Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/gpu/drm/bridge/ti-tpd12s015.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>> index 514cbf0eac75..a18d5197c16c 100644
>>> --- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>> +++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>>> @@ -160,7 +160,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
>>>  
>>>  	/* Register the IRQ if the HPD GPIO is IRQ-capable. */
>>>  	tpd->hpd_irq = gpiod_to_irq(tpd->hpd_gpio);
>>> -	if (tpd->hpd_irq) {
>>> +	if (tpd->hpd_irq > 0) {
>>>  		ret = devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
>>>  						tpd12s015_hpd_isr,
>>>  						IRQF_TRIGGER_RISING |
>>
>> The current implmentation will skip devm_request_threaded_irq() in case
>> or error - but continue with the rest of the function. So the
>> driver fails to return an error code.
> 
> That is intended. If the HPD gpio supports IRQs (gpiod_to_irq returns a valid number), we use the
> IRQ. If it doesn't (gpiod_to_irq returns an error), it gets polled via detect(). Both are ok.
> 
> I don't know if the gpiod_to_irq never returning 0 is something we should rely on. The docs say
> gpiod_to_irq returns the irq number or an error, so I think checking for >= 0 matches the docs better.
> 

gpiod_to_irq() now never returns 0, see:
https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/gpio/gpiolib.c#L3183

Also commit 4c37ce8608a8 ("gpio: make gpiod_to_irq() return negative for NO_IRQ") says:

commit 4c37ce8608a8c6521726d4cd1d4f54424e8d095f
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon May 2 13:13:10 2016 +0200

    gpio: make gpiod_to_irq() return negative for NO_IRQ

    If a translation returns zero, that means NO_IRQ, so we
    should return an error since the function is documented to
    return a negative code on error.

So checking for >0 is enough, my patch is correct.

>  Tomi
> 
