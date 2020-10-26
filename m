Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110D2994B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788972AbgJZSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:00:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50814 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782693AbgJZSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:00:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09QI0At5036808;
        Mon, 26 Oct 2020 13:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603735210;
        bh=xuldlAeH4z54R0OXATYzlsnEaR2NLcVeIpP8W49t8p4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZkHdH9AVWgopMTWCAV4FpmdOR8MBm+qRIN+44BTlEHHR/PCHIFpJOcwR639DPMgws
         A0bucVRF/A1Yras9rHfUJE1MBEfEgJgAHinA1g1Ntt92BrLhaDzapayOp16435737x
         BqTCOD+rMfIMf5qr6sKr7vNaRV1OO3qFBT8oD640=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09QI0AmC098059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 13:00:10 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 26
 Oct 2020 13:00:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 26 Oct 2020 13:00:09 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09QI05L3075222;
        Mon, 26 Oct 2020 13:00:06 -0500
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20201026170624.24241-1-nm@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
Date:   Mon, 26 Oct 2020 23:30:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201026170624.24241-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/20 10:36 pm, Nishanth Menon wrote:
> With the integration of chip-id detection scheme in kernel[1], there
> is no specific need to maintain multitudes of SoC specific config
> options, discussed as per [2], we have deprecated the usage in other
> places for v5.10-rc1. Drop the configuration for the follow on kernel.
> 
> [1] drivers/soc/ti/k3-socinfo.c commit 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
> [2] https://lore.kernel.org/linux-arm-kernel/20200908112534.t5bgrjf7y3a6l2ss@akan/
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/soc/ti/Kconfig | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index f5b82ffa637b..7e2fb1c16af1 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -1,22 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# 64-bit ARM SoCs from TI
> -if ARM64
> -
> -if ARCH_K3
> -
> -config ARCH_K3_AM6_SOC
> -	bool "K3 AM6 SoC"
> -	help
> -	  Enable support for TI's AM6 SoC Family support
> -
> -config ARCH_K3_J721E_SOC
> -	bool "K3 J721E SoC"
> -	help
> -	  Enable support for TI's J721E SoC Family support
> -
> -endif
> -
> -endif

➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
COMPILE_TEST
drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC


I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.

[0]
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/

Thanks and regards,
Lokesh

