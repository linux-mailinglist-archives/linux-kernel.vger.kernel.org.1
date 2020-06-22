Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69202035AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFVLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgFVLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:25:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1409C061794;
        Mon, 22 Jun 2020 04:25:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so7215549wrm.2;
        Mon, 22 Jun 2020 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XZse9AJ4R7SRzA+VZNtgiFX85zhjfIUflbQuQALrRq4=;
        b=gehmnNCvu7d2SsXrB69+aq7VFVXyJPLF62JCpZhOzT08Of79s+F4ZjninEQvwiSmRW
         ywRuLmOOwp5kTQXdF55u9bUT+hOqPrvtGcNh2xdnGYurCh8V4eU6jewRm9yHeD1YgoN0
         m7oIP2wpHFFfFBS2IS5NGRaiT8fjFTmgn9Oskv2f59MEbxGT5/EvOIXc5tGomSiYyZH2
         IF2/YqfjUTLAmHuWQddhFFuRSKgFCCy4feSinjQmbcFanZtY3dvPMaOV5/vY/JjmA0B8
         ZJ806sIF1koMwpxGoKIc7b6MAFsL47OEt7uwgacfzJRjCGeqxVqtyA03V3ZmaJFHEiuv
         8beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XZse9AJ4R7SRzA+VZNtgiFX85zhjfIUflbQuQALrRq4=;
        b=gH4VnxAohNu/h/xiP9UodfgZcJ8ftvxHfZH0KYPjq6xbCHBkccsOKf+Ani3VyYJz/m
         D3JYWErUlVoxJ8UVtDbE63jAGj7JjvXg4eCvOp7m3fStcC+3DSMoHYeYAWLyjl2p3YpA
         a8EFj8q8YVmPfySxZP6qJwztMxGVA8nrbX9Af+9dZQjtCZdHBSckJaLHNfTnBI3G2ssL
         i2phqKhygLaWcQDD4CL4mbrcm7xYCixzFMcCVfWErPoa2hgvW+eR7npIIw0n7Y0mNMcH
         9nXhzpoo3JHPO4A27AiJzD8cyawKPxTMDm49+C/GFda1ohPkvR2TKgcZG5ODv4VEK7+2
         Hm9A==
X-Gm-Message-State: AOAM532vMDfIPKLgZDhoRBXbS+8z0crd5WY5/vSsyHvj/bJIERcP72M0
        wQpH+c5ugj+6gYJhZgi/vPtSDHVU
X-Google-Smtp-Source: ABdhPJyOT+CmAbCdd5kyEI81Rkw75wKAWOm9Kze8iUh5MMlPIRvOV0QG2COPr0mO8zcQDWgLYqXPwQ==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr9047840wro.318.1592825133276;
        Mon, 22 Jun 2020 04:25:33 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
        by smtp.gmail.com with ESMTPSA id d63sm17401323wmc.22.2020.06.22.04.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 04:25:32 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] arm64: dts: add dts nodes for MT6779
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, devicetree@vger.kernel.org
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
 <1585128694-13881-7-git-send-email-hanks.chen@mediatek.com>
 <3751b55b-07a7-7985-a8d9-5414a4ca0d24@gmail.com>
 <1592314461.6256.18.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <247c07c2-4488-a112-5874-4bd7c9d98292@gmail.com>
Date:   Mon, 22 Jun 2020 13:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592314461.6256.18.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2020 15:34, Hanks Chen wrote:
> On Wed, 2020-03-25 at 17:39 +0100, Matthias Brugger wrote:
>>
>> On 25/03/2020 10:31, Hanks Chen wrote:
>>> this adds initial MT6779 dts settings fo board support,
>>
>> "for board support"
>>
>>> including cpu, gic, timer, ccf, pinctrl, uart...etc.
>>
>> The etc is PMU and PSCI and sysirq, correct? Let's list at least sysirq as this
>> is something MediaTek specific.
>>
>>>
>>> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>>  arch/arm64/boot/dts/mediatek/mt6779-evb.dts |   31 ++++
>>>  arch/arm64/boot/dts/mediatek/mt6779.dtsi    |  265 +++++++++++++++++++++++++++
>>>  3 files changed, 297 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6779-evb.dts
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6779.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 458bbc4..53f1c61 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -1,6 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
>>> new file mode 100644
>>> index 0000000..164f5cb
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
>>> @@ -0,0 +1,31 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2019 MediaTek Inc.
>>> + * Author: Mars.C <mars.cheng@mediatek.com>
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt6779.dtsi"
>>> +
>>> +/ {
>>> +	model = "MediaTek MT6779 EVB";
>>> +	compatible = "mediatek,mt6779-evb", "mediatek,mt6779";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart0;
>>> +	};
>>> +
>>> +	memory@40000000 {
>>> +		device_type = "memory";
>>> +		reg = <0 0x40000000 0 0x1e800000>;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:921600n8";
>>> +	};
>>> +};
>>> +
>>> +&uart0 {
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
>>> new file mode 100644
>>> index 0000000..422ff5f
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
>>> @@ -0,0 +1,265 @@
>> [...]
>>> +
>>> +	uart_clk: dummy26m {
>>> +		compatible = "fixed-clock";
>>> +		clock-frequency = <26000000>;
>>> +		#clock-cells = <0>;
>>> +	};
>>
>> No real clocks for uart? What about CLK_INFRA_UARTx?
> 
> sorry, I miss the clocks for uart
> I'll add "baud" and "bus" in next version.
> 
> clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_UART0>;
> clock-names = "baud", "bus";
> 
> 
>>
>>> +
>>> +	timer {
>>> +		compatible = "arm,armv8-timer";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
>>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
>>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
>>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
>>> +	};
>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>> [...]
>>> +
>>> +		uart0: serial@11002000 {
>>> +			compatible = "mediatek,mt6779-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11002000 0 0x400>;
>>> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
>>> +			clocks = <&uart_clk>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		uart1: serial@11003000 {
>>> +			compatible = "mediatek,mt6779-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11003000 0 0x400>;
>>> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_LOW>;
>>> +			clocks = <&uart_clk>;
>>> +			status = "disabled";
>>> +		};
>>
>> SoC has only two UARTs but clock driver has three, how comes?
>>
> 
> In mt6779 SoC, we have four UARTs.
> but we only use UART0 and UART1 as standard serial ports for APMCU.The
> others for modem side.
> so we add two UARTs in dts.
> 

Sorry for the late reply.

DTS describes the HW, so we should add all four to the mt6779.dtsi but only
enable the one that can be used.
BTW I thought modem works through user space application, so why don't you want
to expose them?

Regards,
Matthias

>>> +
>>> +		audio: clock-controller@11210000 {
>>> +			compatible = "mediatek,mt6779-audio", "syscon";
>>> +			reg = <0 0x11210000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		mfgcfg: clock-controller@13fbf000 {
>>> +			compatible = "mediatek,mt6779-mfgcfg", "syscon";
>>> +			reg = <0 0x13fbf000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		mmsys: clock-controller@14000000 {
>>> +			compatible = "mediatek,mt6779-mmsys", "syscon";
>>> +			reg = <0 0x14000000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>
>> Please beware that we are refactoring the mmsys right now. Please use this new
>> approach as this will go upstream soon.
>>
>> https://patchwork.kernel.org/project/linux-mediatek/list/?series=254897
>>
> Got it, I'll update new approach in next version.
> Thanks!
> 
>> Regards,
>> Matthias
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
