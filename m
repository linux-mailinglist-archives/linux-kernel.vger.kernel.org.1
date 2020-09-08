Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496E42620C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgIHUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:15:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40718 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgIHPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088CUDRA099188;
        Tue, 8 Sep 2020 07:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599568213;
        bh=ZlGhz4fcfvz0XlQMcLisz9jUHjYObz1xSQH6+ZJjyB8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uvYf7GokGdF/5EiCT9TmmHekygILpdPsfAEukLopyFVfzj3GlUVa5GuJRLxrANApU
         pa5AXG1WF9ad18bZNBKNFl87MmFycHS737n8zwGFwAn7LS3dHpCzf56dtPiOhZi2bb
         RURZzPSJR8MGbDfmRAGb1/jPaFHHRZyarmjGrwsg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088CUDf5024531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 07:30:13 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 07:30:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 07:30:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088CUD5e031056;
        Tue, 8 Sep 2020 07:30:13 -0500
Date:   Tue, 8 Sep 2020 07:30:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v2 2/6] arm64: dts: ti: k3-j7200-main: Add SERDES lane
 control mux
Message-ID: <20200908123013.jvim7rlokzvxdpse@akan>
References: <20200907145213.30788-1-rogerq@ti.com>
 <20200907145213.30788-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907145213.30788-3-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:52-20200907, Roger Quadros wrote:
> The SERDES lane control mux registers are present in the
> CTRLMMR space.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 1702ac0bbf40..e72c7a0ccad5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -18,6 +18,21 @@
>  		};
>  	};
>  
> +	scm_conf: scm-conf@100000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +		reg = <0 0x00100000 0 0x1c000>;

Just to stay consistent with j7200 stuff we are trying to keep clean:

reg = <0x00 0x00100000 0x00 0x1c000>;

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x00100000 0x1c000>;

ranges = <0x00 0x00 0x00100000 0x1c000>;

> +
> +		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> +					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
> +		};
> +	};
> +
>  	gic500: interrupt-controller@1800000 {
>  		compatible = "arm,gic-v3";
>  		#address-cells = <2>;
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
