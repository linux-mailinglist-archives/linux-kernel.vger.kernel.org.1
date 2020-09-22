Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F99274988
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:54:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34031 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:54:13 -0400
Received: by mail-io1-f66.google.com with SMTP id m17so21068251ioo.1;
        Tue, 22 Sep 2020 12:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qF2EAj+xZ27M9bstX87bUprxWqOcd9qGhCKaOFiGNc=;
        b=K1tsSEABTJtF80U2hngG6anJgaHEvEkXykeeK/sZEWuSP0W0nXzUiBmEtJOr8UgP/C
         j/O85hmFqosCgS1pmso/HWrTptRFx2Gaz/3OsEcxDxKQDOkS+F0mHCFXJpGHctNEYeQh
         aeESxILJPH9AaBsDzDJLwuQXoszTBYF4w3r38CuF29r7kaTmGXQpQbJLVpfyAa8TJ7oR
         GoUhM1/2QNRbobR1rubOZcHve+FBOnShiNX20QX54SSj2XMcv1k2J0C0OrNwmIHTXPXj
         J359t5JFq3VhzTe18+puqB08LXGNnSVvIZRbnosSRumh0a1x775y3V1YxC2f48KGZiEQ
         kHpg==
X-Gm-Message-State: AOAM532cla4nZ38KK449zXJD566XpRiCKRxoPzQ46NIs6EBvgsC9Dh1h
        wABzDseRGhKrvUMUPSG6aEgg+5NW/Hxc
X-Google-Smtp-Source: ABdhPJzijmPheoOp8k8M0D8ZYTknwbf0gqU6P2fI0sRjA5TFSpfxcEdmfuQ37IRLZxfB19R2VHB5Zg==
X-Received: by 2002:a05:6602:2e0e:: with SMTP id o14mr4889500iow.111.1600804452622;
        Tue, 22 Sep 2020 12:54:12 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e9sm9498571ilr.20.2020.09.22.12.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:54:11 -0700 (PDT)
Received: (nullmailer pid 3131804 invoked by uid 1000);
        Tue, 22 Sep 2020 19:54:10 -0000
Date:   Tue, 22 Sep 2020 13:54:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        balbi@kernel.org, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Message-ID: <20200922195410.GA3122345@bogus>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:33:04AM +0530, Manish Narani wrote:
> Add documentation for Versal DWC3 controller. Add required property
> 'reg' for the same. Also add optional properties for snps,dwc3.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> index 4aae5b2cef56..219b5780dbee 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> @@ -1,7 +1,8 @@
>  Xilinx SuperSpeed DWC3 USB SoC controller
>  
>  Required properties:
> -- compatible:	Should contain "xlnx,zynqmp-dwc3"
> +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
> +- reg:		Base address and length of the register control block
>  - clocks:	A list of phandles for the clocks listed in clock-names
>  - clock-names:	Should contain the following:
>    "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
> @@ -13,12 +14,24 @@ Required child node:
>  A child node must exist to represent the core DWC3 IP block. The name of
>  the node is not important. The content of the node is defined in dwc3.txt.
>  
> +Optional properties for snps,dwc3:
> +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
> +		flag configures Global SoC bus Configuration Register and
> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> +- snps,enable-hibernation: Add this flag to enable hibernation support for
> +		peripheral mode.

This belongs in the DWC3 binding. It also implies that hibernation is 
not supported by any other DWC3 based platform. Can't this be implied by 
the compatible string (in the parent)?

> +- interrupt-names: Should contain the following:
> +  "dwc_usb3"	USB gadget mode interrupts
> +  "otg"		USB OTG mode interrupts
> +  "hiber"	USB hibernation interrupts
> +
>  Example device node:
>  
>  		usb@0 {
>  			#address-cells = <0x2>;
>  			#size-cells = <0x1>;
>  			compatible = "xlnx,zynqmp-dwc3";
> +			reg = <0x0 0xff9d0000 0x0 0x100>;
>  			clock-names = "bus_clk" "ref_clk";
>  			clocks = <&clk125>, <&clk125>;
>  			ranges;
> @@ -26,7 +39,10 @@ Example device node:
>  			dwc3@fe200000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0 0xfe200000 0x40000>;
> -				interrupts = <0x0 0x41 0x4>;
> +				interrupt-names = "dwc_usb3", "otg", "hiber";
> +				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
>  				dr_mode = "host";
> +				dma-coherent;
> +				snps,enable-hibernation;
>  			};
>  		};
> -- 
> 2.17.1
> 
