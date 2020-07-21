Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E714622829B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGUOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 10:47:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60848 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGUOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:47:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LEkkHL029060;
        Tue, 21 Jul 2020 09:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595342806;
        bh=zXcjraNdieCat5ZM86lkn+6Gv+qgiFtvCPdxqpheW60=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=vWqVu2XR7OHXKWU2VjCmuyD6LeJezdVgH93He3QzJaYmwqaOTV6rHkemi8luf4oTQ
         LXJ4fPMSi3+9E1x0RE6WyJ1R0RJgOeTqeFLkyhBa7vr1f2m6IocNNvu3+sg1cfSLgA
         bfdGRZJca5VUUHzp0sP238KQyrm3foeSEnIqHgoA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LEkjRx113908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 09:46:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 09:46:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 09:46:45 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LEkg6d006260;
        Tue, 21 Jul 2020 09:46:43 -0500
Subject: Re: [PATCH for v5.9] ARM: mach-davinci: Replace HTTP links with HTTPS
 ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <bgolaszewski@baylibre.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200719102020.57779-1-grandmaster@al2klimov.de>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <10638fa7-6150-0960-9153-fd3a51debac3@ti.com>
Date:   Tue, 21 Jul 2020 20:16:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200719102020.57779-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 3:50 PM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index f2e7609e5346..87c517d65f62 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -2,7 +2,7 @@
>  /*
>   * Device Tree for DA850 EVM board
>   *
> - * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  /dts-v1/;
>  #include "da850.dtsi"
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index d028d38a44bf..5b0125f1265c 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -201,7 +201,7 @@ config MACH_MITYOMAPL138
>  	help
>  	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
>  	  System on Module.  Information on this SoM may be found at
> -	  http://www.mitydsp.com
> +	  https://www.mitydsp.com
>  
>  config MACH_OMAPL138_HAWKBOARD
>  	bool "TI AM1808 / OMAPL-138 Hawkboard platform"
> @@ -209,7 +209,7 @@ config MACH_OMAPL138_HAWKBOARD
>  	help
>  	  Say Y here to select the TI AM1808 / OMAPL-138 Hawkboard platform .
>  	  Information of this board may be found at
> -	  http://www.hawkboard.org/
> +	  https://www.hawkboard.org/

This now redirects to something irrelevant. So, dropped the URL
altogether. Also, we use prefix "ARM: davinci: " in subject line.

I made those changes locally and committed the patch. Will try to send
for v5.9, but its getting quite late.

Thanks,
Sekhar
