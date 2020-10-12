Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7128228AFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgJLIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:16:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgJLIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:16:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09C8GAZ6018397;
        Mon, 12 Oct 2020 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602490570;
        bh=EeOk5U7dM/ZinVPm0g5IDyfXmSWU4mN+EyyeLXE4LW8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kVxYbLtvw+ZF2fY4XFWqHjZEV/S9XBM3rBLDcTiwGvqut/VZvrGUNv030v+iLOHUu
         jcAlOpSYIlEI0DEfwMeN5PkpMuA8HKrL8XroxK0v9HVLV4ob3RBLUrouYlohZ+IwLA
         Pr1D9HYVtibuibATSZDibtKP5H+Wm3EY1Gmv0kvA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09C8G9kS082697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 03:16:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 03:16:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 03:16:09 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09C8G7ex087114;
        Mon, 12 Oct 2020 03:16:08 -0500
Subject: Re: [PATCH v2] usb: cdns3: Rids of duplicate error message
To:     Pawel Laszczak <pawell@cadence.com>, <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
References: <20201012064256.8344-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
Date:   Mon, 12 Oct 2020 11:16:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012064256.8344-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 12/10/2020 09:42, Pawel Laszczak wrote:
> On failure, the platform_get_irq_byname prints an error message
> so, patch removes error message related to this function from
> core.c file.
> 
> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
> Changelog:
> v2
> - simplified code as sugested by Roger Quadros.
> 
>   drivers/usb/cdns3/core.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..85ef3025b293 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -469,22 +469,14 @@ static int cdns3_probe(struct platform_device *pdev)
>   	if (cdns->dev_irq == -EPROBE_DEFER)

Shouldn't this be
	if (cdns->dev_irq < 0)
?

>   		return cdns->dev_irq;
>   
> -	if (cdns->dev_irq < 0)
> -		dev_err(dev, "couldn't get peripheral irq\n");
> -
>   	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
>   	if (IS_ERR(regs))
>   		return PTR_ERR(regs);
>   	cdns->dev_regs	= regs;
>   
>   	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> -	if (cdns->otg_irq == -EPROBE_DEFER)
> -		return cdns->otg_irq;
> -
> -	if (cdns->otg_irq < 0) {
> -		dev_err(dev, "couldn't get otg irq\n");
> +	if (cdns->otg_irq < 0)
>   		return cdns->otg_irq;
> -	}
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>   	if (!res) {
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
