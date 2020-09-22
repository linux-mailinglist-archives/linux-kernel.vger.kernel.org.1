Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378127386D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgIVCSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbgIVCSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:18:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC5B23A5B;
        Tue, 22 Sep 2020 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600741089;
        bh=lsiuqSEugT6scCuXgCbzc0A+fQVhGa7ZCy6u7OWr+A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUZ9HB6P3smqW2jZhNdt1iJtP0oVHkqV7bUnFTRSS8Civ/YzjkUL+45k2+jzeYaXp
         Rq67SQDmO1SNBo3vsATXaD9hEqkfVIZvJZ3oKvcHsx+zrw8RBnYp5w6PzCcI4N6ygY
         Ft/rSVqxosgwXmzscdpkHNyIeg8Np4xe9u02sYsY=
Date:   Tue, 22 Sep 2020 10:18:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: layerscape: correct watchdog clocks for
 LS1088A
Message-ID: <20200922021801.GU25109@dragon>
References: <20200914075202.43341-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914075202.43341-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:52:02PM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> On LS1088A, watchdog clk are divided by 16, correct it in dts.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

It doesn't apply to my imx/dt64 branch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index b0bbe57..2bd0a71 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -712,56 +712,56 @@
>  		cluster1_core0_watchdog: wdt@c000000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc000000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster1_core1_watchdog: wdt@c010000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc010000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster1_core2_watchdog: wdt@c020000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc020000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster1_core3_watchdog: wdt@c030000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc030000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster2_core0_watchdog: wdt@c100000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc100000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster2_core1_watchdog: wdt@c110000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc110000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster2_core2_watchdog: wdt@c120000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc120000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		cluster2_core3_watchdog: wdt@c130000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc130000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
>  			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
> -- 
> 2.7.4
> 
