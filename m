Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C2ECA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAGGld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 01:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAGGld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:41:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DC222E00;
        Thu,  7 Jan 2021 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610001652;
        bh=EXQtTGtOrAJ6507/SRQiTHdd0MLo4maxbEmNq6/kO2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0Eegwt1Xsz5OpjUZBOUJAUD+ftFK3B6IigZ64H1HJAEhLXdVADQFPNQImjXsV1kB
         tlNgwMlQ/VRutKJF5YGnObtI0FgtMfCPsXHr3mxZXGzX8sb3aKCn70s68js680atrI
         impL9SefkOBqEmr1Sus+YTOydo0K9OJJC0Y+a46rlJGKNXCxKmEMX34pr8fhSmaTEQ
         /OJBXSW4coXq5IOpN5gG+06XiU1yzn6yCpaYxvKuk5wFhXMYIVS9mPaQ+l+u1zpOsZ
         re7VrjXMMK9DBEs7Ab2xHi6WdHI2iBQOgjpMcd6VntNtrdLCozOcn7aLiFUHt9hdOh
         eOt0v6XsUU9rw==
Date:   Thu, 7 Jan 2021 14:40:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rai Harninder <harninder.rai@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix the offset of the reset register
Message-ID: <20210107064046.GF28365@dragon>
References: <20201215212622.717-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215212622.717-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:26:22PM +0100, Michael Walle wrote:
> The offset of the reset request register is 0, the absolute address is
> 0x1e60000. Boards without PSCI support will fail to perform a reset:
> 
> [   26.734700] reboot: Restarting system
> [   27.743259] Unable to restart system
> [   27.746845] Reboot failed -- System halted
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Michael Walle <michael@walle.cc>

Out of curiosity, how did you get it fixed with your commit 3f0fb37b22b4
("arm64: dts: ls1028a: fix reboot node") in the first place?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 045739dbcb17..0a5923e96d7f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -102,7 +102,7 @@
>  	reboot {
>  		compatible ="syscon-reboot";
>  		regmap = <&rst>;
> -		offset = <0xb0>;
> +		offset = <0>;
>  		mask = <0x02>;
>  	};
>  
> -- 
> 2.20.1
> 
