Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96E62FF81A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhAUWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:39:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35622 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAUWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:39:23 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD2AD8AE;
        Thu, 21 Jan 2021 23:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611268722;
        bh=mTQDzFLz8lnA56YiNe1nBrmoqyjpQjUrMbQWPECDNsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vgFywrRqn3LvYAWiHZ+FgcnFwlJ8v3xIvAK+SmRtck8UQi0FNMXfyidz8WZbzJTOM
         3CnFPa9OmqYp8JjucgrpxK8VsDXGHTLJ6d8zjOedRL29ujb65oCXP/kwz+1MFjZwNC
         DdT+Qc3+cgD2YN/yhYfw0PUSbtMmjz8BUPPeuqg8=
Date:   Fri, 22 Jan 2021 00:38:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/12] arm64: dts: zynqmp: Enable reset controller
 driver
Message-ID: <YAoCX6/zidjXZ0Mf@pendragon.ideasonboard.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
 <4fb62952f61e5046d750fff0e3e469c7abd1d0d0.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fb62952f61e5046d750fff0e3e469c7abd1d0d0.1611224800.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Thu, Jan 21, 2021 at 11:26:52AM +0100, Michal Simek wrote:
> Enable reset controller to be prepared for use.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2:
> - Remove reset description for IPs from this patch. IPs will be enabled
>   separately with DT binding update.
> - Change patch subject
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index cdc1a0ddfa01..94a2e1f2b713 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
>  			xlnx_aes: zynqmp-aes {
>  				compatible = "xlnx,zynqmp-aes";
>  			};
> +
> +			zynqmp_reset: reset-controller {
> +				compatible = "xlnx,zynqmp-reset";
> +				#reset-cells = <1>;
> +			};
>  		};
>  	};
>  

-- 
Regards,

Laurent Pinchart
