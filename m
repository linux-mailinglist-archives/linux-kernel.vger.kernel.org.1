Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3902C859B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgK3NhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:37:03 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44296 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgK3NhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:37:02 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjjLi-0002T6-9n; Mon, 30 Nov 2020 14:36:14 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Mon, 30 Nov 2020 14:36:12 +0100
Message-ID: <2753094.YVpnkQH3Kb@diego>
In-Reply-To: <e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com>
References: <20201005140311.2507530-1-katsuhiro@katsuster.net> <e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 6. Oktober 2020, 11:51:58 CET schrieb Johan Jonker:
> Hi Katsuhiro, Heiko,
> 
> Question for the maintainer:
> Should we add a SPDIF node if the connector is not physical on a board,
> only a header?

I think so ... the connector always is just like n-pins on a board,
only "sometimes" someone solders a fancy jack to it ;-)


Heiko

> 
> Thanks Katsuhiro for the "aplay -l" screen print.
> 
> **** List of PLAYBACK Hardware Devices ****
> card 0: hdmisound [hdmi-sound], device 0: ff8a0000.i2s-i2s-hifi
> i2s-hifi-0 [ff8a0000.i2s-i2s-hifi i2s-hifi-0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: rockchiprk3399 [rockchip,rk3399], device 0: ff890000.i2s-ES8316
> HiFi ES8316 HiFi-0 [ff890000.i2s-ES8316 HiFi ES8316 HiFi-0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 2: rockchiprk339_1 [rockchip,rk3399], device 0:
> ff870000.spdif-dit-hifi dit-hifi-0 [ff870000.spdif-dit-hifi dit-hifi-0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> 
> On 10/5/20 4:03 PM, Katsuhiro Suzuki wrote:
> > This patch adds 'disabled' SPDIF sound node and related settings
> > of SPDIF for rk3399-rockpro64.
> > 
> > RockPro64 has output pins for SPDIF Tx. But RK3399 does not have
> > enough DMA channel for enabling SPDIF tx. Current settings are:
> > 
> >   - I2S0     (Req num 0, 1): Enabled : Output to 40pins header CON40
> >   - I2S1     (Req num 2, 3): Enabled : Output to ES8316 on board
> >   - I2S2     (Req num 4, 5): Enabled : Output to internal HDMI core
> >   - SPDIF Tx (Req num 7)   : Disabled: Output to connector J10
> > 
> > If users want to enable ALL sound I/Os, we need 7 DMA channels for
> > it. But unfortunately, RK3399 has only 6 DMA channels. So users have
> > to choose from the following:
> > 
> >   - Disable one of I2S (Ex. I2S0) and enable SPDIF tx
> >   - Keep enable I2S0/1/2 and disable SPDIF tx
> > 
> > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > 
> > ---
> > 
> > Changes in v3:
> >   - Refine commit description why adding disabled node
> > 
> > Changes in v2:
> >   - Remove redundant status property
> > ---
> >  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > index 6e553ff47534..58097245994a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > @@ -76,6 +76,23 @@ sound {
> >  		dais = <&i2s1_p0>;
> >  	};
> >  
> 
> 
> 	hdmi_sound: hdmi-sound {
> 		compatible = "simple-audio-card";
> 		simple-audio-card,name = "hdmi-sound";
> 
> Maybe rename to "HDMI"?
> 
> [..]
> 	};
> 
> 	sound {
> 		compatible = "audio-graph-card";
> 		label = "rockchip,rk3399";
> 
> Maybe change this to "ES8316" to prevent confusion?
> 
> 		dais = <&i2s1_p0>;
> 	};
> 
> 
> > +	sound-dit {
> > +		compatible = "audio-graph-card"
> > +		label = "rockchip,rk3399";
> 
> This would be the second sound card with the same label.
> It seems that aplay/linux? adds "-1" to it and removes the comma, so we get:
> 
> hdmisound
> rockchiprk3399
> rockchiprk339_1
> 
> Shouldn't we label it with something that reflect the function/output.
> Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
> Make a shorter label without spaces or special chars, so that chars
> don't get removed?
> 
> Proposal:
> 
> HDMI
> ES8316
> SPDIF
> 
> > +		dais = <&spdif_p0>;
> 
> Maybe disable too?
> 
> The "sound-dit" node is standard enabled and will start some process
> with a dia in a node that is disabled.
> 
> 
> > +	};
> > +
> > +	spdif-dit {
> > +		compatible = "linux,spdif-dit";
> > +		#sound-dai-cells = <0>;
> 
> Maybe disable too?
> 
> > +
> > +		port {
> > +			dit_p0_0: endpoint {
> 
> > +				remote-endpoint = <&spdif_p0_0>;
> 
> This also points to something that's disabled.
> 
> > +			};
> > +		};
> > +	};
> > +
> >  	vcc12v_dcin: vcc12v-dcin {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "vcc12v_dcin";
> > @@ -698,6 +715,16 @@ &sdhci {
> >  	status = "okay";
> >  };
> >  
> > +&spdif {
> > +	pinctrl-0 = <&spdif_bus_1>;
> 
> This node is disabled.
> 
> > +
> > +	spdif_p0: port {
> > +		spdif_p0_0: endpoint {
> > +			remote-endpoint = <&dit_p0_0>;
> > +		};
> > +	};
> > +};
> > +
> >  &spi1 {
> >  	status = "okay";
> >  
> > 
> 
> 




