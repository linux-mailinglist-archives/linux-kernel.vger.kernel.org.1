Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBC2C63C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgK0LUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgK0LUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:20:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30573C0613D1;
        Fri, 27 Nov 2020 03:20:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so5219110wrt.2;
        Fri, 27 Nov 2020 03:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxB5L4+nF4sAICEXNlH6T+45cqgn3iHBYM/XseYVDT0=;
        b=oMcX1SSPuZ7WZNlcfoLpo5kUKsjOQsj7bbxQ+lSji6KOD5rEscQ/FDo0JAKzLmYlfS
         NZuaij9DXI5uOth4VRJ7/pkSVEQ0Ay5D3gIEI9AXJzfAnnNM9hFz4l/IaxhUJuzzNws8
         tIfhOuGPV7vS1wfaOYCMw23AKZ1Yjp0DK0Z7p7g6AQzZz86cJT42EmpKwoYRChRV0mG7
         JmJ5U7H84XyU+eDGQxjYdOy1CMxgjuIABGf7lYGTiR+T0P+Nv0lhUsr5CiKbkxE7Vm7v
         VypW2u4Qziv8rhqzkGAwhh3Mt+Fu8JcAN2RY7bRIRPMKf/tsK1+rWf72nX9vLpdKdw2w
         /SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxB5L4+nF4sAICEXNlH6T+45cqgn3iHBYM/XseYVDT0=;
        b=oynuygQ4hzJD8stIvRv+Kr5DVoZhdbbMcukGeBRZdUOmuOG4aXyVGhLSad4KNg8+DF
         LxnRODVMM+uHC1zV5AwaXcQA2W2e1HO2kKZa+Us2wK0MVHOBLnc94z2InAdoHZEf+TE6
         sjbz+Ux60kN9EvIAH/0oMRf4vrslHXpzRyL0cgDY6G6wmA41owX+knoVRjkrDmUU0WTr
         VaVGSFzHrWzTL/H9P6V5QppbTayVnf4V3Y1LdxSfy9GadMtoyY65VHjPDTOneLGg+sAv
         UoBaTGl45uRFlm+DTW+N8WsGX04cKlR6yqlnq8qCgDpZmZABVQyZQnr3ecnJXa0yLGoy
         i7zw==
X-Gm-Message-State: AOAM532FBIojpHIBZBxY9mehLxcSj42K9b9NTn8hs1APNVA9TtDvmCRE
        280CaFtfTGO/lLKzoTfVARQ=
X-Google-Smtp-Source: ABdhPJwrYIqMkKez+ccJKOv7rpRAHruS5C1aifhxSJlqY+fgx0LKeQ89hHcgT/0TXhf2e0s2uxvG8w==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr9631926wre.383.1606476037970;
        Fri, 27 Nov 2020 03:20:37 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 189sm13678368wmb.18.2020.11.27.03.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 03:20:37 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mt8183: Add pwm and backlight node
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201124041253.4181273-1-hsinyi@chromium.org>
 <8484ec3b-14aa-f0de-28d6-f360c491515b@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <acb813d6-8643-5b9a-2ae1-bc03f2a37ffa@gmail.com>
Date:   Fri, 27 Nov 2020 12:20:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <8484ec3b-14aa-f0de-28d6-f360c491515b@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/11/2020 11:24, Enric Balletbo i Serra wrote:
> Hi Hsin-Yi,
> 
> Thank you for your patch.
> 
> On 24/11/20 5:12, Hsin-Yi Wang wrote:
>> Add pwm to mt8183 and backlight to mt8183-kukui.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
> 
> Picked the patch and checked that pwm for the backlight is working as expected
> on my Lenovo Ideapad Duet.
> 
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 

Applied to v5.10-next/dts64

Thanks!

>>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 28 +++++++++++++++++++
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 10 +++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> index 85f7c33ba4461..bf2ad1294dd30 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> @@ -19,6 +19,17 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	backlight_lcd0: backlight_lcd0 {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pwm0 0 500000>;
>> +		power-supply = <&bl_pp5000>;
>> +		enable-gpios = <&pio 176 0>;
>> +		brightness-levels = <0 1023>;
>> +		num-interpolated-steps = <1023>;
>> +		default-brightness-level = <576>;
>> +		status = "okay";
>> +	};
>> +
>>   	memory@40000000 {
>>   		device_type = "memory";
>>   		reg = <0 0x40000000 0 0x80000000>;
>> @@ -536,6 +547,17 @@ pins_clk {
>>   		};
>>   	};
>>   
>> +	pwm0_pin_default: pwm0_pin_default {
>> +		pins1 {
>> +			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
>> +			output-high;
>> +			bias-pull-up;
>> +		};
>> +		pins2 {
>> +			pinmux = <PINMUX_GPIO43__FUNC_DISP_PWM>;
>> +		};
>> +	};
>> +
>>   	scp_pins: scp {
>>   		pins_scp_uart {
>>   			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
>> @@ -670,6 +692,12 @@ pins_wifi_wakeup {
>>   	};
>>   };
>>   
>> +&pwm0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pwm0_pin_default>;
>> +};
>> +
>>   &scp {
>>   	status = "okay";
>>   	pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 08a914d3a6435..a974bad899365 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -479,6 +479,16 @@ spi0: spi@1100a000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		pwm0: pwm@1100e000 {
>> +			compatible = "mediatek,mt8183-disp-pwm";
>> +			reg = <0 0x1100e000 0 0x1000>;
>> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
>> +			#pwm-cells = <2>;
>> +			clocks = <&topckgen CLK_TOP_MUX_DISP_PWM>,
>> +					<&infracfg CLK_INFRA_DISP_PWM>;
>> +			clock-names = "main", "mm";
>> +		};
>> +
>>   		i2c3: i2c@1100f000 {
>>   			compatible = "mediatek,mt8183-i2c";
>>   			reg = <0 0x1100f000 0 0x1000>,
>>
