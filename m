Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE97280F50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgJBIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:54:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:54:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0928s11M027860;
        Fri, 2 Oct 2020 03:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601628841;
        bh=qK1L55KSfGNxl5yZH44hYOSd5RrT+2Tiy4CzcoiMp8w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CjGLMEl9/HIDjXDQ6B/4cmefDpNn7EfWKURg7lJUcLUPI7fx0dVQtOLli8sXM/Wyj
         YixbHu5tc4vdO7FQ3575B7C2xi8g6z+8prVSbQwkSb4qr/2o4V2McWXFMBboIWDhnE
         Z0XcvGYuFQxnSyhRd+vceQ1pkcvdRpWDMo2zo81k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0928s1Nt022521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 03:54:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 03:54:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 03:54:00 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0928rwou018386;
        Fri, 2 Oct 2020 03:53:58 -0500
Subject: Re: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
To:     Pawel Laszczak <pawell@cadence.com>, <balbi@kernel.org>
CC:     <peter.chen@nxp.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
References: <20200930065758.23740-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
Date:   Fri, 2 Oct 2020 11:53:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930065758.23740-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 30/09/2020 09:57, Pawel Laszczak wrote:
> To avoid duplicate error information patch replaces platform_get_irq_byname
> into platform_get_irq_byname_optional.

What is duplicate error information?

> 
> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>   drivers/usb/cdns3/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..a3f6dc44cf3a 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -465,7 +465,7 @@ static int cdns3_probe(struct platform_device *pdev)
>   
>   	cdns->xhci_res[1] = *res;
>   
> -	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
> +	cdns->dev_irq = platform_get_irq_byname_optional(pdev, "peripheral");

As per DT binding document, these are mandatory properties

  - interrupts: Interrupts used by cdns3 controller:
         "host" - interrupt used by XHCI driver.
         "peripheral" - interrupt used by device driver
         "otg" - interrupt used by DRD/OTG  part of driver

for dr_mode == "otg" -> all 3 are mandatory.
for dr_mode == "host" -> "otg" and "peripheral" IRQs are not required.
for dr_mode == "periphearal" -> "otg" and "host" IRQs are not required.

>   	if (cdns->dev_irq == -EPROBE_DEFER)
>   		return cdns->dev_irq;
>   
> @@ -477,7 +477,7 @@ static int cdns3_probe(struct platform_device *pdev)
>   		return PTR_ERR(regs);
>   	cdns->dev_regs	= regs;
>   
> -	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> +	cdns->otg_irq = platform_get_irq_byname_optional(pdev, "otg");
>   	if (cdns->otg_irq == -EPROBE_DEFER)
>   		return cdns->otg_irq;
>   
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
