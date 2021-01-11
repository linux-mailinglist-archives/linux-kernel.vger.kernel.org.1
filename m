Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CAE2F20F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbhAKUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:39:35 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39796 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbhAKUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:39:34 -0500
Received: by mail-ot1-f48.google.com with SMTP id d8so155094otq.6;
        Mon, 11 Jan 2021 12:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuduTLZlbG35ugDeNBQcYjINyRmKUeAkNe31I9bczWo=;
        b=asMuTe0uocr9SEqNnzcnSO2QKwsmrL4IJj10rkBoiNIHr5Y5Lq5wKYYZjmWh+6SzsU
         RW+eetiAZPnZdubeOne0UN2889CvVfm2by4Ec8tNHTO3ZBeVQO1lyDIMa1CfKZsqhG/4
         K+bYMHwSebgUz+mMT6TJOhwT11TsfxB5YUpFtgC05++rfW8s6ZEV1CB2Ilw7SS30SrjJ
         gf8MbAvSykbmcyZFq6Z2xzvpDrDuu8JZWzbX7C9ZQUMJdvqrBCZ3llTfzdtuwAASNZEc
         WRiS2MoF88NXDTRSsk1x2Ze7d04azI3ZIn30eILkh1Q2UrBt9jKI1N2npp/k0BVnBing
         nVNQ==
X-Gm-Message-State: AOAM533noXsDlkmrYi40EHEKuJr4eljp53J79rqS0TCIxF3waK8mYahg
        H+FfglqjVVmBo+TEDtxrBw==
X-Google-Smtp-Source: ABdhPJxTRSLja0Ho46/iFyMEhN0kc2ToJeDnvK9Ayi6Oy07tXCHtANqvw5CXVDBAtyMzqOaEojN1Mg==
X-Received: by 2002:a9d:2a86:: with SMTP id e6mr611496otb.313.1610397532905;
        Mon, 11 Jan 2021 12:38:52 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p132sm182478oia.41.2021.01.11.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:38:52 -0800 (PST)
Received: (nullmailer pid 3026340 invoked by uid 1000);
        Mon, 11 Jan 2021 20:38:50 -0000
Date:   Mon, 11 Jan 2021 14:38:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        linus.walleij@linaro.org, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, BMC-SW@aspeedtech.com,
        haiyue.wang@linux.intel.com, cyrilbur@gmail.com,
        rlippert@google.com
Subject: Re: [PATCH v4 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
Message-ID: <20210111203850.GA3022469@robh.at.kernel.org>
References: <20201229063157.3587-1-chiawei_wang@aspeedtech.com>
 <20201229063157.3587-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229063157.3587-2-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 02:31:53PM +0800, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 99 ++++---------------
>  1 file changed, 21 insertions(+), 78 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index d0a38ba8b9ce..90eb0ecc95d1 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -9,13 +9,7 @@ primary use case of the Aspeed LPC controller is as a slave on the bus
>  conditions it can also take the role of bus master.
>  
>  The LPC controller is represented as a multi-function device to account for the
> -mix of functionality it provides. The principle split is between the register
> -layout at the start of the I/O space which is, to quote the Aspeed datasheet,
> -"basically compatible with the [LPC registers from the] popular BMC controller
> -H8S/2168[1]", and everything else, where everything else is an eclectic
> -collection of functions with a esoteric register layout. "Everything else",
> -here labeled the "host" portion of the controller, includes, but is not limited
> -to:
> +mix of functionality, which includes, but is not limited to:
>  
>  * An IPMI Block Transfer[2] Controller
>  
> @@ -44,80 +38,29 @@ Required properties
>  ===================
>  
>  - compatible:	One of:
> -		"aspeed,ast2400-lpc", "simple-mfd"
> -		"aspeed,ast2500-lpc", "simple-mfd"
> -		"aspeed,ast2600-lpc", "simple-mfd"
> +		"aspeed,ast2400-lpc-v2", "simple-mfd", "syscon"
> +		"aspeed,ast2500-lpc-v2", "simple-mfd", "syscon"
> +		"aspeed,ast2600-lpc-v2", "simple-mfd", "syscon"
>  
>  - reg:		contains the physical address and length values of the Aspeed
>                  LPC memory region.
>  
>  - #address-cells: <1>
>  - #size-cells:	<1>
> -- ranges: 	Maps 0 to the physical address and length of the LPC memory
> -                region
> -
> -Required LPC Child nodes
> -========================
> -
> -BMC Node
> ---------
> -
> -- compatible:	One of:
> -		"aspeed,ast2400-lpc-bmc"
> -		"aspeed,ast2500-lpc-bmc"
> -		"aspeed,ast2600-lpc-bmc"
> -
> -- reg:		contains the physical address and length values of the
> -                H8S/2168-compatible LPC controller memory region
> -
> -Host Node
> ----------
> -
> -- compatible:   One of:
> -		"aspeed,ast2400-lpc-host", "simple-mfd", "syscon"
> -		"aspeed,ast2500-lpc-host", "simple-mfd", "syscon"
> -		"aspeed,ast2600-lpc-host", "simple-mfd", "syscon"
> -
> -- reg:		contains the address and length values of the host-related
> -                register space for the Aspeed LPC controller
> -
> -- #address-cells: <1>
> -- #size-cells:	<1>
> -- ranges: 	Maps 0 to the address and length of the host-related LPC memory
> +- ranges:	Maps 0 to the physical address and length of the LPC memory
>                  region
>  
>  Example:
>  
>  lpc: lpc@1e789000 {
> -	compatible = "aspeed,ast2500-lpc", "simple-mfd";
> +	compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
>  	reg = <0x1e789000 0x1000>;
>  
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  	ranges = <0x0 0x1e789000 0x1000>;

No child nodes? Then you don't need 'ranges', '#size-cells', nor 
'#address-cells'.

> -
> -	lpc_bmc: lpc-bmc@0 {
> -		compatible = "aspeed,ast2500-lpc-bmc";
> -		reg = <0x0 0x80>;
> -	};
> -
> -	lpc_host: lpc-host@80 {
> -		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
> -		reg = <0x80 0x1e0>;
> -		reg-io-width = <4>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x0 0x80 0x1e0>;
> -	};
>  };
>  
> -BMC Node Children
> -==================
> -
> -
> -Host Node Children
> -==================
>  
>  LPC Host Interface Controller
>  -------------------
> @@ -149,14 +92,12 @@ Optional properties:
>  
>  Example:
>  
> -lpc-host@80 {
> -	lpc_ctrl: lpc-ctrl@0 {
> -		compatible = "aspeed,ast2500-lpc-ctrl";
> -		reg = <0x0 0x80>;
> -		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> -		memory-region = <&flash_memory>;
> -		flash = <&spi>;
> -	};
> +lpc_ctrl: lpc-ctrl@80 {
> +	compatible = "aspeed,ast2500-lpc-ctrl";
> +	reg = <0x80 0x80>;
> +	clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> +	memory-region = <&flash_memory>;
> +	flash = <&spi>;
>  };
>  
>  LPC Host Controller
> @@ -179,9 +120,9 @@ Required properties:
>  
>  Example:
>  
> -lhc: lhc@20 {
> +lhc: lhc@a0 {
>  	compatible = "aspeed,ast2500-lhc";
> -	reg = <0x20 0x24 0x48 0x8>;
> +	reg = <0xa0 0x24 0xc8 0x8>;
>  };
>  
>  LPC reset control
> @@ -192,16 +133,18 @@ state of the LPC bus. Some systems may chose to modify this configuration.
>  
>  Required properties:
>  
> - - compatible:		"aspeed,ast2600-lpc-reset" or
> -			"aspeed,ast2500-lpc-reset"
> -			"aspeed,ast2400-lpc-reset"
> + - compatible:		One of:
> +			"aspeed,ast2600-lpc-reset";
> +			"aspeed,ast2500-lpc-reset";
> +			"aspeed,ast2400-lpc-reset";
> +
>   - reg:			offset and length of the IP in the LHC memory region
>   - #reset-controller	indicates the number of reset cells expected
>  
>  Example:
>  
> -lpc_reset: reset-controller@18 {
> +lpc_reset: reset-controller@98 {
>          compatible = "aspeed,ast2500-lpc-reset";
> -        reg = <0x18 0x4>;
> +        reg = <0x98 0x4>;
>          #reset-cells = <1>;
>  };
> -- 
> 2.17.1
> 
