Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391382849B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJFJwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:52:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A521C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 02:52:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so12704617ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpndHynjiFOuceItUVm+AOdG3zbe75h4joXfwYhnJAg=;
        b=FCLx73moQAXqeIjasaAw7nsZvnH+svOrYn1ReUOpR2YYnEdn1Rw93VfaRHuhiv3Pbs
         Y4re8crhbHyo6oGRSxVJeua10lYk+UaKKgBJ6bnVji7ZmoniVQkNdUMJcXhvXJXaVEew
         VM5tYxc5Vljyfa6N/QiUCH/671ZaxGlC5EP1Ig8aifLkuR1c4etMCzVL3nhjHt/e7zlM
         aBn86JYpPvC9kFy5JgSi4hL9yYuFNcGUBLcKB/fHU5R3FpKCOCB0pSx6h018XFZj2YbO
         nZV16RDQ6Lih66mujQgRUlu/fNYqzmSN+ByvQuzsejexVkQSW4G4dcT50VaFx59ZikyJ
         R5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpndHynjiFOuceItUVm+AOdG3zbe75h4joXfwYhnJAg=;
        b=pwOhu8ZVTDdXYs/SoZdHEk7ueirxWmR3QeEUrmCH0ecTLcYVD44eYCkqN4NqgoUcqm
         dQP+Xof2vak/hTG7R2QX5/fpWSRMOIR+V8Ket3HoLeS9l3DvDxBVk+1fqHA30auxsOhq
         OvPKMNSGXMINcUZFCgG4YeM7JSWAsNtwi/useKTqqLkdBUwOW2Xs0w4yNfT3oW3hLGz3
         9EVxiyzGiWLg6er5A3ByFGMMpDEcmlahWk4bu2af0aCa8dG1oRZnFkVx/RHp1N6eL21q
         BME3Wyy9SOcRY3CDxj1iuEi6m6onZ8hVjsLQNL/VavTLgMgCbSpuIMgWu9u4WzoCaE1J
         TVhg==
X-Gm-Message-State: AOAM532B0xQApXNqQgRU0q6X4Cb/fGz8hvja9TaoBtaLcD+cLIyXXlGJ
        co5WsJBVT1fAZAc2WImIjgc8qStYEWg=
X-Google-Smtp-Source: ABdhPJytDn5qeBQbaa/PyR2BMzIVAbfo2+hXQgKZxA3UE8zolJnnIZqwo0zBndyLTd1iD/j/syzE/w==
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr4379100ejb.411.1601977920680;
        Tue, 06 Oct 2020 02:52:00 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e9sm1969902edu.49.2020.10.06.02.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 02:52:00 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: dts: rockchip: add SPDIF node for
 rk3399-rockpro64
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201005140311.2507530-1-katsuhiro@katsuster.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com>
Date:   Tue, 6 Oct 2020 11:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005140311.2507530-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katsuhiro, Heiko,

Question for the maintainer:
Should we add a SPDIF node if the connector is not physical on a board,
only a header?

Thanks Katsuhiro for the "aplay -l" screen print.

**** List of PLAYBACK Hardware Devices ****
card 0: hdmisound [hdmi-sound], device 0: ff8a0000.i2s-i2s-hifi
i2s-hifi-0 [ff8a0000.i2s-i2s-hifi i2s-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: rockchiprk3399 [rockchip,rk3399], device 0: ff890000.i2s-ES8316
HiFi ES8316 HiFi-0 [ff890000.i2s-ES8316 HiFi ES8316 HiFi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: rockchiprk339_1 [rockchip,rk3399], device 0:
ff870000.spdif-dit-hifi dit-hifi-0 [ff870000.spdif-dit-hifi dit-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


On 10/5/20 4:03 PM, Katsuhiro Suzuki wrote:
> This patch adds 'disabled' SPDIF sound node and related settings
> of SPDIF for rk3399-rockpro64.
> 
> RockPro64 has output pins for SPDIF Tx. But RK3399 does not have
> enough DMA channel for enabling SPDIF tx. Current settings are:
> 
>   - I2S0     (Req num 0, 1): Enabled : Output to 40pins header CON40
>   - I2S1     (Req num 2, 3): Enabled : Output to ES8316 on board
>   - I2S2     (Req num 4, 5): Enabled : Output to internal HDMI core
>   - SPDIF Tx (Req num 7)   : Disabled: Output to connector J10
> 
> If users want to enable ALL sound I/Os, we need 7 DMA channels for
> it. But unfortunately, RK3399 has only 6 DMA channels. So users have
> to choose from the following:
> 
>   - Disable one of I2S (Ex. I2S0) and enable SPDIF tx
>   - Keep enable I2S0/1/2 and disable SPDIF tx
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> ---
> 
> Changes in v3:
>   - Refine commit description why adding disabled node
> 
> Changes in v2:
>   - Remove redundant status property
> ---
>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6e553ff47534..58097245994a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -76,6 +76,23 @@ sound {
>  		dais = <&i2s1_p0>;
>  	};
>  


	hdmi_sound: hdmi-sound {
		compatible = "simple-audio-card";
		simple-audio-card,name = "hdmi-sound";

Maybe rename to "HDMI"?

[..]
	};

	sound {
		compatible = "audio-graph-card";
		label = "rockchip,rk3399";

Maybe change this to "ES8316" to prevent confusion?

		dais = <&i2s1_p0>;
	};


> +	sound-dit {
> +		compatible = "audio-graph-card"
> +		label = "rockchip,rk3399";

This would be the second sound card with the same label.
It seems that aplay/linux? adds "-1" to it and removes the comma, so we get:

hdmisound
rockchiprk3399
rockchiprk339_1

Shouldn't we label it with something that reflect the function/output.
Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
Make a shorter label without spaces or special chars, so that chars
don't get removed?

Proposal:

HDMI
ES8316
SPDIF

> +		dais = <&spdif_p0>;

Maybe disable too?

The "sound-dit" node is standard enabled and will start some process
with a dia in a node that is disabled.


> +	};
> +
> +	spdif-dit {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;

Maybe disable too?

> +
> +		port {
> +			dit_p0_0: endpoint {

> +				remote-endpoint = <&spdif_p0_0>;

This also points to something that's disabled.

> +			};
> +		};
> +	};
> +
>  	vcc12v_dcin: vcc12v-dcin {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -698,6 +715,16 @@ &sdhci {
>  	status = "okay";
>  };
>  
> +&spdif {
> +	pinctrl-0 = <&spdif_bus_1>;

This node is disabled.

> +
> +	spdif_p0: port {
> +		spdif_p0_0: endpoint {
> +			remote-endpoint = <&dit_p0_0>;
> +		};
> +	};
> +};
> +
>  &spi1 {
>  	status = "okay";
>  
> 

