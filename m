Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBA2A77E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgKEHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:20:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgKEHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:20:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A57K1qS069060;
        Thu, 5 Nov 2020 01:20:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604560801;
        bh=aNnXmi+/BsbX9YuV+Vb2u6E5JEoEpPn5Q9SWNj/7eck=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q9AMAhhwXgg6+Eyfc9S3V8N/IBko+GprebnDGlxvC3vD2ce1sHxBITbG3V/9vpJWm
         R85wRfxKe0bxydDL3MtA37dZGGgXF7LNWjfpiaq1XVsP2PrAb3fZ+f4O/qQs6ViQMC
         +SNoLo4wTq49WyY1o7vTZ25RyGkMuyEHKcOUv2a8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A57K1fb059899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 01:20:01 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 01:20:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 01:20:00 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A57JwIG037919;
        Thu, 5 Nov 2020 01:19:59 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65*/j721e*: Fix unit address format
 error for dss node
To:     Nishanth Menon <nm@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201104222519.12308-1-nm@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9e1b0cf4-3048-ea54-1477-408b3bc0539b@ti.com>
Date:   Thu, 5 Nov 2020 09:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104222519.12308-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2020 00:25, Nishanth Menon wrote:
> Fix the node address to follow the device tree convention.
> 
> This fixes the dtc warning:
> <stdout>: Warning (simple_bus_reg): /bus@100000/dss@04a00000: simple-bus
> unit address format error, expected "4a00000"
> 
> Fixes: 76921f15acc0 ("arm64: dts: ti: k3-j721e-main: Add DSS node")
> Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 533525229a8d..27f6fd9eaa0a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -834,7 +834,7 @@ csi2_0: port@0 {
>  		};
>  	};
>  
> -	dss: dss@04a00000 {
> +	dss: dss@4a00000 {
>  		compatible = "ti,am65x-dss";
>  		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
>  			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index e2a96b2c423c..c66ded9079be 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1278,7 +1278,7 @@ ufs@4e84000 {
>  		};
>  	};
>  
> -	dss: dss@04a00000 {
> +	dss: dss@4a00000 {
>  		compatible = "ti,j721e-dss";
>  		reg =
>  			<0x00 0x04a00000 0x00 0x10000>, /* common_m */
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
