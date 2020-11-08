Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09492AAC0C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKHQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:00:41 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:48640 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:00:41 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0A8G0JJE062174;
        Mon, 9 Nov 2020 01:00:19 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Mon, 09 Nov 2020 01:00:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (80.57.232.153.ap.dti.ne.jp [153.232.57.80])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0A8G0Ju1062166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Nov 2020 01:00:19 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3] arm64: dts: rockchip: add SPDIF node for
 rk3399-rockpro64
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201005140311.2507530-1-katsuhiro@katsuster.net>
 <e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c7ecafe4-b344-9e3f-b7d2-b17adf6545c5@katsuster.net>
Date:   Mon, 9 Nov 2020 01:00:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko, Johan,

This is ping... How about Johan's question?

> Question for the maintainer:
> Should we add a SPDIF node if the connector is not physical on a board,
> only a header?

If we don't need to add nodes for sound I/F that has only header not
physical on a board, we should drop this patch and also remove I2S0
because I2S0 has no physical connector on a board.

Additionally, I2S1 share the I2S_CLK pin with I2S0. So ROCKPro64 users
perhaps cannot use I2S0 and I2S1 (for ES8316) at same time. If users
try to use I2S1 after I2S0, I2S1 overwrites clock setting and I2S0
will face strange behavior.

I don't know why ROCKPro64 has such strange pin implementation...


For Johan:

Sorry for late reply. Thank you for your review.
And I agree with you renaming sound nodes.

- HDMI
- ES8316 (or "Analog" is more useful for media player SW??)
- SPDIF (if we need)


Best Regards,
Katsuhiro Suzuki


On 2020/10/06 18:51, Johan Jonker wrote:
> Hi Katsuhiro, Heiko,
> 
> Question for the maintainer:
> Should we add a SPDIF node if the connector is not physical on a board,
> only a header?
> 
> Thanks Katsuhiro for the "aplay -l" screen print.
> 
> **** List of PLAYBACK Hardware Devices ****
> card 0: hdmisound [hdmi-sound], device 0: ff8a0000.i2s-i2s-hifi
> i2s-hifi-0 [ff8a0000.i2s-i2s-hifi i2s-hifi-0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 1: rockchiprk3399 [rockchip,rk3399], device 0: ff890000.i2s-ES8316
> HiFi ES8316 HiFi-0 [ff890000.i2s-ES8316 HiFi ES8316 HiFi-0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 2: rockchiprk339_1 [rockchip,rk3399], device 0:
> ff870000.spdif-dit-hifi dit-hifi-0 [ff870000.spdif-dit-hifi dit-hifi-0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> 
> 
> On 10/5/20 4:03 PM, Katsuhiro Suzuki wrote:
>> This patch adds 'disabled' SPDIF sound node and related settings
>> of SPDIF for rk3399-rockpro64.
>>
>> RockPro64 has output pins for SPDIF Tx. But RK3399 does not have
>> enough DMA channel for enabling SPDIF tx. Current settings are:
>>
>>    - I2S0     (Req num 0, 1): Enabled : Output to 40pins header CON40
>>    - I2S1     (Req num 2, 3): Enabled : Output to ES8316 on board
>>    - I2S2     (Req num 4, 5): Enabled : Output to internal HDMI core
>>    - SPDIF Tx (Req num 7)   : Disabled: Output to connector J10
>>
>> If users want to enable ALL sound I/Os, we need 7 DMA channels for
>> it. But unfortunately, RK3399 has only 6 DMA channels. So users have
>> to choose from the following:
>>
>>    - Disable one of I2S (Ex. I2S0) and enable SPDIF tx
>>    - Keep enable I2S0/1/2 and disable SPDIF tx
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>> ---
>>
>> Changes in v3:
>>    - Refine commit description why adding disabled node
>>
>> Changes in v2:
>>    - Remove redundant status property
>> ---
>>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> index 6e553ff47534..58097245994a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> @@ -76,6 +76,23 @@ sound {
>>   		dais = <&i2s1_p0>;
>>   	};
>>   
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
>> +	sound-dit {
>> +		compatible = "audio-graph-card"
>> +		label = "rockchip,rk3399";
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
>> +		dais = <&spdif_p0>;
> 
> Maybe disable too?
> 
> The "sound-dit" node is standard enabled and will start some process
> with a dia in a node that is disabled.
> 
> 
>> +	};
>> +
>> +	spdif-dit {
>> +		compatible = "linux,spdif-dit";
>> +		#sound-dai-cells = <0>;
> 
> Maybe disable too?
> 
>> +
>> +		port {
>> +			dit_p0_0: endpoint {
> 
>> +				remote-endpoint = <&spdif_p0_0>;
> 
> This also points to something that's disabled.
> 
>> +			};
>> +		};
>> +	};
>> +
>>   	vcc12v_dcin: vcc12v-dcin {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vcc12v_dcin";
>> @@ -698,6 +715,16 @@ &sdhci {
>>   	status = "okay";
>>   };
>>   
>> +&spdif {
>> +	pinctrl-0 = <&spdif_bus_1>;
> 
> This node is disabled.
> 
>> +
>> +	spdif_p0: port {
>> +		spdif_p0_0: endpoint {
>> +			remote-endpoint = <&dit_p0_0>;
>> +		};
>> +	};
>> +};
>> +
>>   &spi1 {
>>   	status = "okay";
>>   
>>
> 

