Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3C1B9069
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDZNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 09:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDZNSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:18:05 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40ED206DD;
        Sun, 26 Apr 2020 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587907085;
        bh=dbrvMbw0yBV6vd0nF3Z2AMV57GmqXYSvMJdB4275+vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMR3MQIHF6dK4ei7QVQHSHZ2QphBskic6IltyczOPCPVO3XOf6zbqnUfkBseVwVDq
         n8cNhh/rAUuC0eNiJqCDCXSLHyCl5jovOAN/s1bI+lxKSZGAvi0nstgy7Z2o9khbeR
         b+xrg/ZcDzN/zirRnqiQ96HRxnHGzgilVzzQMPRA=
Date:   Sun, 26 Apr 2020 21:17:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Message-ID: <20200426131751.GC30501@dragon>
References: <20200407064251.39244-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407064251.39244-1-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 02:42:48PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch adds ftm_alarm0 DT node for Soc LX2160A
> FlexTimer1 module is used to wakeup the system in deep sleep
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index e5ee5591e52b..e0d8d68ce070 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -16,6 +16,10 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		rtc1 = &ftm_alarm0;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -768,6 +772,20 @@
>  			timeout-sec = <30>;
>  		};
>  
> +		rcpm: rcpm@1e34040 {

Keep the node sort in unit-address.  Also, try to use a generic node
name.

Shawn

> +			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1e34040 0x0 0x1c>;
> +			#fsl,rcpm-wakeup-cells = <7>;
> +			little-endian;
> +		};
> +
> +		ftm_alarm0: timer@2800000 {
> +			compatible = "fsl,lx2160a-ftm-alarm";
> +			reg = <0x0 0x2800000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
> +			interrupts = <0 44 4>;

IRQ_TYPE_LEVEL_HIGH

Shawn

> +		};
> +
>  		usb0: usb@3100000 {
>  			compatible = "snps,dwc3";
>  			reg = <0x0 0x3100000 0x0 0x10000>;
> -- 
> 2.17.1
> 
