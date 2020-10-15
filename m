Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6828F13E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgJOL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:29:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51556 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgJOL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:29:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09FBTTlf073783;
        Thu, 15 Oct 2020 06:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602761369;
        bh=t1SeR8tYhrhyovLm6t3PgzEHxjV8nllU9xUheyJtGJo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YvhL3F3J5a+0lG9R/1gMS/QF/7JGMynnhcjWVgEOtWY7LGsIroaKU7a7XUSwajzf+
         P8AZgWJC10QNBmHrKqbY4xDQkOHWQ3tBqYem3uE35Iz7/+EMWFtxXIg1F9q8tx1j3t
         4m/YdDoPPmGycMjBOv8AnQJNQ+Qm8U4iJyNNmr8c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09FBTT2C098486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 06:29:29 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 15
 Oct 2020 06:29:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 15 Oct 2020 06:29:28 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09FBTQTf116716;
        Thu, 15 Oct 2020 06:29:27 -0500
Subject: Re: [PATCH v4] usb: cdns3: Rids of duplicate error message
To:     Pawel Laszczak <pawell@cadence.com>, <peter.chen@nxp.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
References: <20201015045447.1440-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5dc23ed8-8c7f-ff04-1d86-4910f1a49428@ti.com>
Date:   Thu, 15 Oct 2020 14:29:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015045447.1440-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2020 07:54, Pawel Laszczak wrote:
> On failure, the platform_get_irq_byname prints an error message,
> so patch removes error message related to this function from
> core.c file.
> 
> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Acked-by: Peter Chen <peter.chen@nxp.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
> Changelog:
> v4
> - fixed typo.
> - "Acked-by" tag has been added.
> v3
> - changed error condition checking for dev_irq.
> v2
> - simplified code as sugested by Roger Quadros.
> 
>   drivers/usb/cdns3/core.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..f2dedce3a40e 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -466,11 +466,8 @@ static int cdns3_probe(struct platform_device *pdev)
>   	cdns->xhci_res[1] = *res;
>   
>   	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
> -	if (cdns->dev_irq == -EPROBE_DEFER)
> -		return cdns->dev_irq;
> -
>   	if (cdns->dev_irq < 0)
> -		dev_err(dev, "couldn't get peripheral irq\n");
> +		return cdns->dev_irq;
>   
>   	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
>   	if (IS_ERR(regs))
> @@ -478,14 +475,9 @@ static int cdns3_probe(struct platform_device *pdev)
>   	cdns->dev_regs	= regs;
>   
>   	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> -	if (cdns->otg_irq == -EPROBE_DEFER)
> +	if (cdns->otg_irq < 0)
>   		return cdns->otg_irq;
>   
> -	if (cdns->otg_irq < 0) {
> -		dev_err(dev, "couldn't get otg irq\n");
> -		return cdns->otg_irq;
> -	}
> -
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>   	if (!res) {
>   		dev_err(dev, "couldn't get otg resource\n");
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
