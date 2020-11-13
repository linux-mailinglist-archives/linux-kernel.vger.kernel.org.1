Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C662B2172
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKMREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:04:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38206 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKMREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:04:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADH4g4A024110;
        Fri, 13 Nov 2020 11:04:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605287082;
        bh=mYouREokYwh6YjueN+p68m/8UBSmWBdu0U6nWQN79tU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=O0is2f0omaauobs+iHDsmyRtYOcG52t9XiNAb4vZk2va41b95bqv3I9BUIVzgIodm
         ILkHxzbZFaxdbcJFDDoEq4+twndvd9zeUfOI29IrRNAH0v3lsJ2igfEaO1PNYzxHUM
         VCO1JfyeekxFdpbe+YkynSPYecyFPBoz6XhfYQDk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADH4gAf019616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 11:04:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 11:04:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 11:04:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADH4fgm107295;
        Fri, 13 Nov 2020 11:04:42 -0600
Date:   Fri, 13 Nov 2020 11:04:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for
 TI's J721e platform
Message-ID: <20201113170441.2hvvqcnscpd7hos7@enigmatic>
References: <20201113154905.40095-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201113154905.40095-1-nsekhar@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:19-20201113, Sekhar Nori wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> Add configs to help enable regulators that supply power to the SD card
> on TI's J721e platform. These regulators are controlled by either
> SoC gpios or gpios over i2c expander.
> 
> vmlinux size before and after patch follow:
> 
Sekhar,

> Before:
>    text	   data	    bss	    dec	    hex	filename
> 19755448	10376346	 535572	30667366	1d3f266	vmlinux
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
> 19769232	10381390	 536212	30686834	1d43e72	vmlinux
> 
> difference is 19,468 (dec)
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> changes in v3:
> - add size delta as requested by Nishanth Menon

https://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git/commit/?h=ti-k3-config-next&id=6b133f475a97a0839f02e3c0b937886b9adc2933

https://lore.kernel.org/linux-arm-kernel/20201103190821.30937-1-faiz_abbas@ti.com/


Is this a duplicate patch?
> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c5f404ce2eec..e44d3f438530 100644
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
> @@ -498,6 +499,7 @@ CONFIG_PINCTRL_SDM845=y
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
