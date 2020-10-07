Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD6285A29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgJGIL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:11:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42312 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgJGIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:11:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0978BK3Y105797;
        Wed, 7 Oct 2020 03:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602058280;
        bh=DNXyUfEbZqBsEY9RcIXJVmkjr4C20nFD/uMaR/UIEpM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=igh7soJ1YAFLEKo3+oiiuPpOdmSeasYF7Sjy1zBmkRWcq3JVd4+u/Y9t37wsHCp/E
         btCT7dNJJPdl2Vcj2S8L3E6MsxGw2EO3g2aVyMMMmHRZy2uoJIj76YpUa+LmWNuTFD
         chLAWHCc497Fx+xIazfAj3oiAGu1V+PMF0B9vJT4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0978BJ14023641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 03:11:20 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 03:11:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 03:11:19 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0978BH5Y112495;
        Wed, 7 Oct 2020 03:11:17 -0500
Subject: Re: [PATCH 1/2] usb: cdns3: Rids of duplicate error message
To:     Pawel Laszczak <pawell@cadence.com>, <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
References: <20201007033531.22526-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <94ff37e9-8a32-b61b-5ede-1b71b6a3d4ab@ti.com>
Date:   Wed, 7 Oct 2020 11:11:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007033531.22526-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 07/10/2020 06:35, Pawel Laszczak wrote:
> On failure, the platform_get_irq_byname prints an error message
> so, patch removes error message related to this function from
> core.c file.
> 
> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>   drivers/usb/cdns3/core.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..4fd3c742d9d5 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -469,9 +469,6 @@ static int cdns3_probe(struct platform_device *pdev)
>   	if (cdns->dev_irq == -EPROBE_DEFER)

if (cdns->dev_irq < 0 && cdns->dev_irq == -EPROBE_DEFER)

>   		return cdns->dev_irq;
>   
> -	if (cdns->dev_irq < 0)
> -		dev_err(dev, "couldn't get peripheral irq\n");
> -
>   	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
>   	if (IS_ERR(regs))
>   		return PTR_ERR(regs);
> @@ -481,10 +478,8 @@ static int cdns3_probe(struct platform_device *pdev)
>   	if (cdns->otg_irq == -EPROBE_DEFER)

if (cdns->otg_irq < 0 && cdns->otg_irq == -EPROBE_DEFER)

>   		return cdns->otg_irq;
>   
> -	if (cdns->otg_irq < 0) {
> -		dev_err(dev, "couldn't get otg irq\n");
> +	if (cdns->otg_irq < 0)

you can then get rid of this if {}.

>   		return cdns->otg_irq;
> -	}
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>   	if (!res) {
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
