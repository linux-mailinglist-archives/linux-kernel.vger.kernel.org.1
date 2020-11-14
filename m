Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BF2B2A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 02:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKNBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 20:41:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35788 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKNBlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 20:41:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AE1f17l041447;
        Fri, 13 Nov 2020 19:41:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605318061;
        bh=dH2ZAWLBi5UA8BZBmTUUTm3BSdMU3RvMx3RqhQqF6l4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ot1ZT/PFQaHsbKwNopoDsAqeZCr7ZSXvd4Jf69twtEa+BGRQSwFKTWkv5DwzU0iaL
         jDZonZ6dlekk64RVI765Jjt7X0csv70liw+Cs56bRB28/96CIitzga/NJuZA0lYu1C
         n3lxHDXGq+L0Pq/r/Hms0iv2v1lnUxLJ/ajQTjPw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AE1f1rf059925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 19:41:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 19:41:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 19:41:00 -0600
Received: from [10.250.232.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AE1eu1E002065;
        Fri, 13 Nov 2020 19:40:57 -0600
Subject: Re: [PATCH V4 3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary
 status set to "okay" for crypto
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201113211826.13087-1-nm@ti.com>
 <20201113211826.13087-4-nm@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <07cf9429-46c4-f0ff-2b2c-0de6c26cf864@ti.com>
Date:   Sat, 14 Nov 2020 07:10:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201113211826.13087-4-nm@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2020 2:48 AM, Nishanth Menon wrote:
> The default state of a device tree node is "okay". There is no specific
> use of explicitly adding status = "okay" in the SoC dtsi.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Tero Kristo <t-kristo@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> ---
> Change in v4: Dropped Fixes
> 
> V3: https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-4-nm@ti.com/
> V2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-4-nm@ti.com/
> V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index c842b9803f2d..116818912ba2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -119,7 +119,6 @@ crypto: crypto@4e00000 {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
> -		status = "okay";
>   
>   		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
>   				<&main_udmap 0x4001>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 137966c6be1f..19e602afdb05 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -345,8 +345,6 @@ main_crypto: crypto@4e00000 {
>   		#size-cells = <2>;
>   		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
>   
> -		status = "okay";
> -
>   		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
>   				<&main_udmap 0x4001>;
>   		dma-names = "tx", "rx1", "rx2";
> 
