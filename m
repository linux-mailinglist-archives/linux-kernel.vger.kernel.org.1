Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBD2B0686
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKLNe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:34:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53772 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:34:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACDYMsr053425;
        Thu, 12 Nov 2020 07:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605188062;
        bh=3WJbU5Nkjzk0TgsARggB4KDwhbQol8EeB5NepzS1qm4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u90yOef5dcxrnQLEBBmP3J2bZPEhFKTKT6HjJrINz8Ipk68GwJjEhto4GhFVu7xt2
         9RzpRuufiFodPBqqR3ct2QdvPLgr1tZHOXyjKqpfbIlNmdubxvpirQNZRBgpx9iVJM
         VQv72bTivCdjrKV6BkVlNjGJgHYZT+G5M6tlVg/4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACDYML0122796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 07:34:22 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 07:34:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 07:34:22 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACDYIjY117262;
        Thu, 12 Nov 2020 07:34:19 -0600
Subject: Re: [PATCH V2 3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary
 status set to "okay" for crypto
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-4-nm@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <774fa259-af70-d08e-605a-c419239e9a1a@ti.com>
Date:   Thu, 12 Nov 2020 15:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112014929.25227-4-nm@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 03:49, Nishanth Menon wrote:
> The default state of a device tree node is "okay". There is no specific
> use of explicitly adding status = "okay" in the SoC dtsi.
> 
> Fixes: 8ebcaaae8017 ("arm64: dts: ti: k3-j721e-main: Add crypto accelerator node")
> Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
> Changes since V1:
> - No change.
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 21e50021dd83..2bd66a9e4b1d 100644
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
> index b54332d6fdc5..9747c387385b 100644
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

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
