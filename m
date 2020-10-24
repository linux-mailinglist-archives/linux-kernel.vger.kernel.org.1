Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4F6297DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762505AbgJXRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:12:32 -0400
Received: from exa.lopez.ar ([51.89.75.32]:45774 "EHLO exa.lopez.ar"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762487AbgJXRMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:12:30 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Oct 2020 13:12:27 EDT
Authentication-Results: exa.lopez.ar; auth=pass (plain)
Subject: Re: [linux-sunxi] [PATCH 03/10] ARM: dts: sun7i: cubietruck: Enable
 RGMII RX/TX delay on Ethernet PHY
To:     wens@kernel.org, Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201024162515.30032-1-wens@kernel.org>
 <20201024162515.30032-3-wens@kernel.org>
From:   =?UTF-8?Q?Emilio_L=c3=b3pez?= <emilio@elopez.com.ar>
Message-ID: <47f00919-39fe-bbf3-32c7-e1375f34a7be@elopez.com.ar>
Date:   Sat, 24 Oct 2020 14:04:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024162515.30032-3-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
        by exa.lopez.ar (Haraka) with ESMTPSA id B3E375ED-B79F-46BB-BD98-D96F37E02556.1
        envelope-from <emilio@elopez.com.ar> (authenticated bits=0)
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
        Sat, 24 Oct 2020 17:04:52 +0000
DKIM-Signature: v=1;a=rsa-sha256;bh=2EyzHnJp15sr8tT4gTFe+OUB6xzYrozSwpx/bWJER5w=;c=relaxed/simple;d=elopez.com.ar;h=from:subject:date:message-id:to:cc:mime-version;s=s20200214815;b=o95xcThYIBGLVZGG4AU8efDz+q0bhaSeA181ZgEltYBYm6N6k1D4opc1jA8VwRk3WhjMp+yC5Y0ux1dx9DJNGxNI86BYwfPLNCCcVKc/WSSKKuvbKrJitQxkeG0ICCWKVBYqpjeXedwVHegfPmI00i3Nh+fG/nkHs34jjb5lgChyxz2KWw4SFMkTqjRLeDZnp6D50nQwyVSpFIex4t/LxcUXepptIIA7o1GBoPXCqnl+NC0KZk7+Lum2Djlfzj9Xq+cyhnr/Da5gnw+i+pYGT8wT0T2Bg93i7EMM7SoJkaB2vHrNA2SOs4PBuA5t1zq3AgC72oa/XcF8sIa/MT4NvA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El 24/10/20 a las 13:25, Chen-Yu Tsai escribió:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the Cubietruck has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: 67073d97672d ("ARM: dts: sun7i: cubietruck: Enable the GMAC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 8c8dee6ea461..9109ca0919ad 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -151,7 +151,7 @@ &gmac {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&gmac_rgmii_pins>;
>   	phy-handle = <&phy1>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>   	status = "okay";
>   };
>   
> 

I upgraded kernels yesterday and saw that networking had stopped 
working. I can confirm that this patch fixes the problem and restores 
connectivity on my Cubietruck. I also verified the information with the 
schematics, and it looks alright to me :)

Reviewed-by: Emilio López <emilio@elopez.com.ar>
Tested-by: Emilio López <emilio@elopez.com.ar>

Thanks!
Emilio
