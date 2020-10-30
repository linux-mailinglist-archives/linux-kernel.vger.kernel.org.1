Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2C29F97F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJ3AKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3AKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:10:43 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30CA020756;
        Fri, 30 Oct 2020 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604016642;
        bh=HhMiwNSPHbCREvHc/7+74xJI9P/gWgD7l/IMkhp5LOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH8x1Sty0lFIjbiS8zSeHz9ZuwKUOeC//frspGgbUlyev2c0df6HBaB7yBu3Pggba
         AnTqORnLvlK+1qPglgef914U0kuWLx+DsmTXi3gMvxUQ6lWiv1+rD8ljAOMF+BGK1I
         VSfTIuRkwsoyESO8HqB4UYjF9xm5whsOiJlamm8c=
Date:   Fri, 30 Oct 2020 08:10:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] arm64: dts: ls2088ardb: add PHY nodes for the CS4340
 PHYs
Message-ID: <20201030001038.GU28755@dragon>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-6-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925132503.30206-6-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:24:59PM +0300, Ioana Ciornei wrote:
> Annotate the EMDIO1 node and describe the 4 10GBASER PHYs found on the
> LS2088ARDB board. Also, add phy-handles for DPMACs 1-4 to their
> associated PHY.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> index f6b4d75a258b..0d1935fcd201 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> @@ -22,3 +22,44 @@ chosen {
>  		stdout-path = "serial1:115200n8";
>  	};
>  };
> +
> +&dpmac1 {
> +	phy-handle = <&mdio1_phy1>;
> +};
> +
> +&dpmac2 {
> +	phy-handle = <&mdio1_phy2>;
> +};
> +
> +&dpmac3 {
> +	phy-handle = <&mdio1_phy3>;
> +};
> +
> +&dpmac4 {
> +	phy-handle = <&mdio1_phy4>;
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	mdio1_phy1: emdio1_phy@1 {
> +		compatible = "ethernet-phy-id13e5.1002";
> +		reg = <0x10>;
> +		phy-connection-type = "10gbase-r";
> +	};

Please have a newline between nodes.

Shawn

> +	mdio1_phy2: emdio1_phy@2 {
> +		compatible = "ethernet-phy-id13e5.1002";
> +		reg = <0x11>;
> +		phy-connection-type = "10gbase-r";
> +	};
> +	mdio1_phy3: emdio1_phy@3 {
> +		compatible = "ethernet-phy-id13e5.1002";
> +		reg = <0x12>;
> +		phy-connection-type = "10gbase-r";
> +	};
> +	mdio1_phy4: emdio1_phy@4 {
> +		compatible = "ethernet-phy-id13e5.1002";
> +		reg = <0x13>;
> +		phy-connection-type = "10gbase-r";
> +	};
> +};
> -- 
> 2.25.1
> 
