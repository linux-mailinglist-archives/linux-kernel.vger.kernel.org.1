Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE912A3434
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKBTei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:34:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33314 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKBTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:34:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JYMU5091528;
        Mon, 2 Nov 2020 13:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604345662;
        bh=eZyetkFj1QHofroFApzpQ89xviZ2HnFz5qa4zQeQBJs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KcmZzkzlLOkWub7LSjcIcLsl3YuBa0RzJwB8IZovN39N5mAtlT13i9latzA3HODcn
         O0A6k2Ys5LskBtDj5piwFS2EiRHP7jAyQcRe67aXrun4b69sMKaHsaYfsEReu9li51
         t4STdkA2/VoiQ8Fx1YUQ3Lh7Y9Fi64tQ+yLp39qY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2JYMFe125135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 13:34:22 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 13:34:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 13:34:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JYL9q127402;
        Mon, 2 Nov 2020 13:34:21 -0600
Date:   Mon, 2 Nov 2020 13:34:20 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <t-kristo@ti.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable GPIO and I2C configs for
 TI's J721e platform
Message-ID: <20201102193420.4hm37mkkq2dhn3uq@coherent>
References: <20201102183005.14174-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102183005.14174-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:00-20201103, Faiz Abbas wrote:
> Add configs to help enable regulators that supply power to the SD card
> on TI's J721e platform. These regulators are controlled by either
> SoC gpios or gpios over i2c expander.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> 
> Changes in v2: Squashed changes into a single patch
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20201002164535.9920-1-faiz_abbas@ti.com/


Faiz, See:
https://lore.kernel.org/linux-arm-kernel/CAK8P3a2dxGV4ussfC16XN98xeSwsKum=Hu8_GJ+E3ZS=wu8oYw@mail.gmail.com/

Do you mind indicating size delta introduced by this change since this
is going to impact a lot of folks?

> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5cfe3cf6f2ac..bbf42faaddfe 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -438,6 +438,7 @@ CONFIG_I2C_IMX=y
>  CONFIG_I2C_IMX_LPI2C=y
>  CONFIG_I2C_MESON=y
>  CONFIG_I2C_MV64XXX=y
> +CONFIG_I2C_OMAP=y
>  CONFIG_I2C_OWL=y
>  CONFIG_I2C_PXA=y
>  CONFIG_I2C_QCOM_CCI=m
> @@ -497,6 +498,7 @@ CONFIG_PINCTRL_SDM845=y
>  CONFIG_PINCTRL_SM8150=y
>  CONFIG_PINCTRL_SM8250=y
>  CONFIG_GPIO_ALTERA=m
> +CONFIG_GPIO_DAVINCI=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_MB86S7X=y
>  CONFIG_GPIO_MPC8XXX=y
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
