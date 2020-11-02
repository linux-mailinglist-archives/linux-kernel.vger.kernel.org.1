Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC912A24EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgKBG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:57:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48104 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBG5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:57:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A26vCQF053237;
        Mon, 2 Nov 2020 00:57:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604300232;
        bh=JTo7kayqjYwO3duP000M0zTm0U8KiaUdPxQC6iPTFn0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W6bNXynCngzCaYOzXnPt064BEkoP2UUCFr61trX9YBs+EWa0x7B8w8ftw/jVcdA9s
         +eEXRAH70lwlREVbBbGtiO528L8m9i6rVg04xJCzYO1cZ8P5RVgLB3X8KGaISaWjSB
         ZPSalIL2hd1I8OIJUpmW95TnauFqzhApn+uiLxwY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A26vCS6000379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 00:57:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 00:57:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 00:57:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A26v9js028321;
        Mon, 2 Nov 2020 00:57:09 -0600
Subject: Re: [PATCH] drm/bridge: tpd12s015: Fix irq registering in
 tpd12s015_probe
To:     Sam Ravnborg <sam@ravnborg.org>, YueHaibing <yuehaibing@huawei.com>
CC:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20201031031648.42368-1-yuehaibing@huawei.com>
 <20201031071936.GA1044557@ravnborg.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <57bfde5b-aee1-c15f-896a-63033e86d9a2@ti.com>
Date:   Mon, 2 Nov 2020 08:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031071936.GA1044557@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2020 09:19, Sam Ravnborg wrote:
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

That is intended. If the HPD gpio supports IRQs (gpiod_to_irq returns a valid number), we use the
IRQ. If it doesn't (gpiod_to_irq returns an error), it gets polled via detect(). Both are ok.

I don't know if the gpiod_to_irq never returning 0 is something we should rely on. The docs say
gpiod_to_irq returns the irq number or an error, so I think checking for >= 0 matches the docs better.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
