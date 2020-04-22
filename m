Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBE1B4886
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDVPYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 11:24:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56520 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVPYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KkECSdeYB459bXX9pGUO7tmk+Q++s7iL1Wfe6Yw90kw=; b=3EG7drKNNTaBxZHOLlaWDrW8NI
        A2Vk2jp6H/qR02RnJLXHW0iIoLVYvQxNRHfrX+VcBvMajq7mWZZPVES29neuMekU9ZfoqVYtOGpb8
        NojtfGCGOJVvAGFJHKRe1XIRbVsEuEqy8LtfeNbizkmTH1iG/9yXhy9f0Y47u3qeCjVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jRHEt-004DqR-FC; Wed, 22 Apr 2020 17:24:39 +0200
Date:   Wed, 22 Apr 2020 17:24:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakov Petrina <jakov.petrina@sartura.hr>
Cc:     jason@lakedaemon.net, devicetree@vger.kernel.org,
        gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
        vladimir.vid@sartura.hr, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] arm: dts: uDPU: switch PHY operation mode to 2500base-x
Message-ID: <20200422152439.GG974925@lunn.ch>
References: <20200422150915.3355073-1-jakov.petrina@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422150915.3355073-1-jakov.petrina@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:09:15PM +0200, Jakov Petrina wrote:
> This resolves issues with certain SPF modules.

Hi Jakov

Please could you explain this some more. PHYLINK should be setting the
mode appropriately, based on the capabilities of the SFP module. Is
the real problem that the SFP module is indicating the wrong baud
rate?

	Andrew

> 
> Signed-off-by: Jakov Petrina <jakov.petrina@sartura.hr>
> Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> index 7eb6c1796cef..b6e2a9c68b2a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -144,7 +144,7 @@ lm75@49 {
>  };
>  
>  &eth0 {
> -	phy-mode = "sgmii";
> +	phy-mode = "2500base-x";
>  	status = "okay";
>  	managed = "in-band-status";
>  	phys = <&comphy1 0>;
> @@ -152,7 +152,7 @@ &eth0 {
>  };
>  
>  &eth1 {
> -	phy-mode = "sgmii";
> +	phy-mode = "2500base-x";
>  	status = "okay";
>  	managed = "in-band-status";
>  	phys = <&comphy0 1>;
> -- 
> 2.24.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
