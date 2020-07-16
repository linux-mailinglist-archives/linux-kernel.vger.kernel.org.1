Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD71A222249
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGPMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:20:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46522 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgGPMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:20:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06GCJruJ055896;
        Thu, 16 Jul 2020 07:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594901993;
        bh=wOEZHIUvj01ZD2FMQ4zD9/pEgy9hFpYL3VYW3EcKwD0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ZLAVt/e6ycLEwuRHmkvqCc0XTPS1TtVKLJ33xJO08KGwy/G6TCZ+sYvrnhZsCc6cs
         z/L8xIN8UNTJTntbfzOo2L/kb0VL9SVKJ9I2cLApiuTthe9dTPkpx1gLZEe5yXjeKB
         /KO2WDdIan5/Ba2bfXRLLONyaSm+fIf+/t64o5VM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06GCJrHS068726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 07:19:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 16
 Jul 2020 07:19:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 16 Jul 2020 07:19:53 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06GCJnWW071711;
        Thu, 16 Jul 2020 07:19:50 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
 <20200619125801.9530-8-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com>
Date:   Thu, 16 Jul 2020 17:49:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619125801.9530-8-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/20 6:28 pm, Faiz Abbas wrote:
> Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 883e8bace3ed..40dd13e0adc5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SUNXI=y
>  CONFIG_MMC_BCM2835=y
>  CONFIG_MMC_SDHCI_XENON=y
> +CONFIG_MMC_SDHCI_AM654=y
>  CONFIG_MMC_OWL=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
> 

Gentle ping. Will, Catalin, can this patch be picked up?

Thanks,
Faiz
