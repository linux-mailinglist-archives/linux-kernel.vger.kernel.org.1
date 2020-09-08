Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888CE26235B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHXF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 19:05:28 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36667 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIHXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:05:24 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so559620ils.3;
        Tue, 08 Sep 2020 16:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qeqE/5fPzRv3YsJ66Yy8YazV/xbUggNlRPkCJRA0bA=;
        b=MhrCfIi4c7NwDcTW8chKtWpsLVVW1UHnw7zL2MywIAM1XkCyWaaMUYNFindw4Zgy4O
         j9RIxvawBB5welx0TW3np/bbZGWaOOJ0x3K25fUrQWIynXa5o+lzeUor4MjAhxqffDDo
         dDK6awCoLx7HQ3CmzcjS//93Bvft34W5gKBGxwAEXYDVpd2PKJKrmuK2BDtiGWcv9x45
         y+gVSr7GIhIpsCZKM0sj07Irqjmfrg5dfMkxhJNizx+T2SbOSE7vjawxWTQ8Fow8OIeA
         i933SI/YLwYcVPnchVQ24ZFa+r24gdIIHgvAmCSCgvSefOecJfI3lv1MSgqMLnPbE3dP
         WUug==
X-Gm-Message-State: AOAM530jtjE3A/9U7XkGT1kz92R4U6VlCyMB6DP0qTxjKJkhhQH2V3jC
        CQIfih8rSunCFTXTXDPvig==
X-Google-Smtp-Source: ABdhPJypClO7IsDzE/xubvRHVl36SEZhjCvZo/KL6SE1PsR7GzOL7aa0mOKH4UtHDf4daBKwVdq/9Q==
X-Received: by 2002:a92:c009:: with SMTP id q9mr1098800ild.73.1599606323035;
        Tue, 08 Sep 2020 16:05:23 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k2sm372555ioj.2.2020.09.08.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:05:22 -0700 (PDT)
Received: (nullmailer pid 1108505 invoked by uid 1000);
        Tue, 08 Sep 2020 23:05:20 -0000
Date:   Tue, 8 Sep 2020 17:05:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        balbi@kernel.org, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for
 Versal DWC3 Controller
Message-ID: <20200908230520.GA1102401@bogus>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598467441-124203-2-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:14:00AM +0530, Manish Narani wrote:
> Add documentation for Versal DWC3 controller. Add required property
> 'reg' for the same. Also add optional properties for snps,dwc3.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.txt          | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> index 4aae5b2cef56..dd41ed831411 100644
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
> @@ -13,12 +14,19 @@ Required child node:
>  A child node must exist to represent the core DWC3 IP block. The name of
>  the node is not important. The content of the node is defined in dwc3.txt.
>  
> +Optional properties for snps,dwc3:
> +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
> +		flag configures Global SoC bus Configuration Register and
> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> +- interrupt-names: This property provides the names of the interrupt ids used

You have to define what the names are. 'dwc_usb3' seems pretty pointless 
if only 1 name.

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
> @@ -26,7 +34,9 @@ Example device node:
>  			dwc3@fe200000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0 0xfe200000 0x40000>;
> +				interrupt-name = "dwc_usb3";
>  				interrupts = <0x0 0x41 0x4>;
>  				dr_mode = "host";
> +				dma-coherent;
>  			};
>  		};
> -- 
> 2.17.1
> 
