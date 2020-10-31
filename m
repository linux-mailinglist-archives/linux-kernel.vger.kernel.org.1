Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1962A175E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgJaMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:32:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgJaMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:32:30 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNdqF3r0mzhd6G;
        Sat, 31 Oct 2020 20:32:25 +0800 (CST)
Received: from [10.174.176.180] (10.174.176.180) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 20:32:23 +0800
Subject: Re: [PATCH] drm/bridge: tpd12s015: Fix irq registering in
 tpd12s015_probe
To:     Sam Ravnborg <sam@ravnborg.org>
References: <20201031031648.42368-1-yuehaibing@huawei.com>
 <20201031071936.GA1044557@ravnborg.org>
CC:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tomi.valkeinen@ti.com>, <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <24de298a-1b0b-8b2b-41c6-f68b1f5e1637@huawei.com>
Date:   Sat, 31 Oct 2020 20:32:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20201031071936.GA1044557@ravnborg.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/31 15:19, Sam Ravnborg wrote:
> Hi YueHaibing
> 
> Thanks for the fix. Appreciated but please update as per comments below.
> 
> On Sat, Oct 31, 2020 at 11:16:48AM +0800, YueHaibing wrote:
>> gpiod_to_irq() return negative value in case of error,
>> the existing code handle negative error codes wrongly.
>>
>> Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-tpd12s015.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>> index 514cbf0eac75..a18d5197c16c 100644
>> --- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
>> +++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
>> @@ -160,7 +160,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
>>  
>>  	/* Register the IRQ if the HPD GPIO is IRQ-capable. */
>>  	tpd->hpd_irq = gpiod_to_irq(tpd->hpd_gpio);
>> -	if (tpd->hpd_irq) {
>> +	if (tpd->hpd_irq > 0) {
>>  		ret = devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
>>  						tpd12s015_hpd_isr,
>>  						IRQF_TRIGGER_RISING |
> 
> The current implmentation will skip devm_request_threaded_irq() in case
> or error - but continue with the rest of the function. So the
> driver fails to return an error code.
> 
> In case of error (negative value) then return early with that error

Agree, will resubmit.

> value. If gpiod_to_irq() returns 0 assume this is a valid irq and let
> the code continue.

gpiod_to_irq() never returns 0, so no need check this.

> 
> Please fix and re-submit - or tell me if I am mistaken.
> 
> 	Sam
> .
> 
