Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371A12A953A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKFL1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:27:33 -0500
Received: from foss.arm.com ([217.140.110.172]:35822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFL1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:27:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCDD2147A;
        Fri,  6 Nov 2020 03:27:32 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5B13F719;
        Fri,  6 Nov 2020 03:27:31 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: Reorder LED triggers from mmc
 devices on rk3399-roc-pc.
To:     Johan Jonker <jbx6244@gmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dianders@chromium.org, wens@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201104192933.1001-1-m.reichl@fivetechno.de>
 <db3986ed-e572-bdd1-6f04-3bb2d04d49fa@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bb433605-09fd-388b-dfb0-0a3c52b3fc9f@arm.com>
Date:   Fri, 6 Nov 2020 11:27:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <db3986ed-e572-bdd1-6f04-3bb2d04d49fa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 10:29, Johan Jonker wrote:
> Hi Markus,
> 
> On 11/4/20 8:29 PM, Markus Reichl wrote:
>> After patch [1] SD-card becomes mmc1 and eMMC becomes mmc2.
>> Correct trigger of LEDs accordingly.
>>
>> [1]
>> https://patchwork.kernel.org/patch/11881427
>>
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index e7a459fa4322..20309076dbac 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -74,14 +74,14 @@ diy_led: led-1 {
>>   			label = "red:diy";
>>   			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>>   			default-state = "off";
>> -			linux,default-trigger = "mmc1";
> 
>> +			linux,default-trigger = "mmc2";
> 
> remove
>>   		};
>>   
>>   		yellow_led: led-2 {
>>   			label = "yellow:yellow-led";
>>   			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>>   			default-state = "off";
>> -			linux,default-trigger = "mmc0";
> 
>> +			linux,default-trigger = "mmc1";
> 
> remove
> 
>>   		};
>>   	};
>>   
>>
> 
> The "mmc1" and "mmc2" options are custom values and invalid to the
> automated dt check in the mainline kernel.

It's already been established that the binding is at fault here. Effort 
should be spent on fixing *that*, not sacrificing useful and intended DT 
functionality in blind deference to the schema gods.

Robin.

> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml
> 
> 
>    linux,default-trigger:
>      description:
>        This parameter, if present, is a string defining the trigger
> assigned to
>        the LED.
>      $ref: /schemas/types.yaml#definitions/string
> 
>      enum:
>          # LED will act as a back-light, controlled by the framebuffer system
>        - backlight
>          # LED will turn on (but for leds-gpio see "default-state"
> property in
>          # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
>        - default-on
>          # LED "double" flashes at a load average based rate
>        - heartbeat
>          # LED indicates disk activity
>        - disk-activity
>          # LED indicates IDE disk activity (deprecated), in new
> implementations
>          # use "disk-activity"
>        - ide-disk
>          # LED flashes at a fixed, configurable rate
>        - timer
>          # LED alters the brightness for the specified duration with one
> software
>          # timer (requires "led-pattern" property)
>        - pattern
> 
