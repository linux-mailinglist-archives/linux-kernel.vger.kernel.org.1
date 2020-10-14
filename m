Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9272928E063
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgJNMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:17:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgJNMRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:17:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9021A31B;
        Wed, 14 Oct 2020 05:17:24 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E69F3F719;
        Wed, 14 Oct 2020 05:17:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add basic support for
 Kobol's Helios64
To:     Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
 <20201013161340.720403-3-uwe@kleine-koenig.org>
 <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
 <66aa4ffd-15f8-7c45-282e-e3bddc1af421@kleine-koenig.org>
 <99032f48-c807-def0-e672-7b2c408e1cc3@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b5edc522-e673-6013-cb9a-fe5ae180cfa7@arm.com>
Date:   Wed, 14 Oct 2020 13:17:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <99032f48-c807-def0-e672-7b2c408e1cc3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-13 23:41, Johan Jonker wrote:
> Hi Uwe,
> 
> On 10/13/20 10:22 PM, Uwe Kleine-König wrote:
>> Hello Johan,
>>
>> On 10/13/20 7:34 PM, Johan Jonker wrote:
>>> Part 1 of 2 missing here.
>>
>> Please complain to gmail then, given that patch 1 can be found on
>>
> https://lore.kernel.org/linux-arm-kernel/20201013161340.720403-2-uwe@kleine-koenig.org/.
> 
> Will check my spam.
> 
>>
>>> Submit all patches to all maintainers and mail lists.
>>> Don't forget robh+dt !
>>
>> I'm really surprised you insist here. In my experience Rob (with his
>> dt-hat on) is not interested in specifics of the machine files and he
>> already acked patch 1.
> 
> As rule of the dumb. Keep everybody in that list informed till the last
> version. What they do with is not our problem or concern.

Note that get_maintainer.pl is hardly perfect, and using a bit of 
judgement is a far better idea than zealously trusting it to be the one 
true CC list and spamming people with things they really aren't going to 
care about. I mean, I *still* occasionally get CCed on random PowerPC 
patches because I once touched a couple of couple of unrelated lines in 
one of their arch headers...

Even if you're perfectly happy to spend time scanning and deleting 
hundreds of irrelevant emails from your inbox every day, don't assume 
that everyone else feels the same way ;)

FWIW as far as lists go, if I have a good idea of who the target 
audience for a patch is then I'll only CC LKML for the sake of archiving 
if there aren't at least two other relevant lists on CC.

>>
>>> Add a little change log here.
>>
>> I assume you also didn't get the cover letter?
>>
>>>> +		fault-led {
>>> fault_led: led-0 {}
>>>
>>> My fault.
>>> Change ones more...
>>>    # The first form is preferred, but fall back to just 'led' anywhere
> in the
>>>    # node name to at least catch some child nodes.
>>>    "(^led-[0-9a-f]$|led)":
>>
>> ok, the label isn't necessary, is it?
> 
> Not really, for legacy and readability reasons keep it.
> Without label both in nodename and as property one has to compare pin
> numbers in pinctrl to see which node belong to each other.
> Some users may want to add there own functions. With already available
> label they can do so.

The LED's "label" property already canonically describes what it is. An 
unused DTS label just adds noise in the source and bloats DTBs built 
with symbols. If there really are users out there who want to use 
overlays to set a custom trigger or state for the fraction of boot time 
between the LED driver probing and when a udev rule could do it, I can't 
imagine they'd mind adding the couple of extra lines to specify the full 
node path in their overlay.

>>
>>>> +			label = "helios64:green:status";
>>>> +			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>>>
>>>> +			linux,default-trigger = "none";
>>>
>>> Don't use 'none' for mainline.
>>
>> Oh, I missed that. Thanks for your persistence.
> 
> No thanks.
> 
>>
>>>> +			default-state = "on";
>>>> +		};
>>>> +	};
>>>> +
>>>> +	vcc1v8_sys_s0: vcc1v8-sys-s0 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc1v8_sys_s0";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <1800000>;
>>>> +		regulator-max-microvolt = <1800000>;
>>>> +		vin-supply = <&vcc1v8_sys_s3>;
>>>> +	};
>>>> +
>>>> +	vcc3v0_sd: vcc3v0-sd {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc3v0_sd";
>>>
>>> Doesn't a sd card need a on/off gpio?
>>> Could you check the schematics?
>>
>> Hmm, there is a GPIO. I didn't consider a problem there given that the
>> machine logs
>>
>> 	[   31.708706] vcc3v0_sd: disabling
>>
>> when there is no SD-card in the slot. Will investigate further.

Looking at how the regulator core handles enable pins, I'd assume that a 
regulator can always be *logically* enabled and disabled regardless of 
whether doing so will actually physically switch it. (And I guess I've 
finally disproved my own thought about whether "regulator-always-on" is 
redundant for non-switchable regulators...)

It's not absolutely *mandatory* for VMMC to be switchable - some low-end 
boards simply take it off any old 3V3 rail, however that does prevent 
power-cycling the card to reset it if it gets into a bad state, so I'd 
tend to expect a well-designed board would carry the extra few cents of 
BOM cost for a switchable regulator.

> Let us know...
> 
>>
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&pmic_int_l>;
>>>
>>> sort
>>
>> I would expect this is an exception from the sorting rule.
>>
>> $ git grep pinctrl-names linus/master:arch/arm64/boot/dts/ | wc -l
>> 1905
>>
>> $ git grep -A1 pinctrl-names linus/master:arch/arm64/boot/dts/ | \
>>    grep pinctrl-0 | wc -l
>> 1412
>>
>> When grepping over arch/arm64/boot/dts/rockchip the numbers are
>> 453 and 445 respectively.
>>
>> Will use pinctrl-names above pinctrl-0 consistently.
> 
> That people in the past blindly followed the manufacturer dts doesn't
> make it an exception to the sort rule. Whatever you do, do it consistent.
> 
>>
>>>> +				regulator-max-microvolt = <1350000>;
>>>> +				regulator-min-microvolt = <750000>;
>>>
>>>
>>> The rest has min above max.
>>> Exception to the sort rule, not sure what Heiko wants, but keep it every
>>> where the same.
>>
>> OK, most rockchip dts have min before max, will fix up.
>>
>>>> +	i2c-scl-rising-time-ns = <160>;
>>>> +	i2c-scl-falling-time-ns = <30>;
>>>
>>> sort
>>
>> I consider it logical to have rise before fall. In 43 of 59 cases in
>> arch/arm64/boot/dts/rockchip/ it is done this way.
> 
> That people in the past blindly followed the manufacturer dts doesn't
> make it an exception to the sort rule. Whatever you do, do it consistent.
> 
>>
>>>> +	vqmmc-supply = <&vcc1v8_sys_s0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&sdmmc {
>>>> +	bus-width = <4>;
>>>> +	cap-sd-highspeed;
>>>
>>>> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>>>
>>> see regulator?
> 
> Little longer version:
> See my question at the sd regulator.
> We have a pin to detect, but not to switch the regulator.
> Haven't looked at the schematics. Just a reminder to check if it's
> correct. Let us know..

I share Uwe's befuddlement here - VMMC and CD are pretty much entirely 
unrelated. If the dedicated CD function is used its internal pullup 
depends on VQMMC, but that means you can't power down the I/O when no 
card is present, because it then can't generate an interrupt when one 
*is* inserted (or like RK3288 the CD line just floats and fires 
interrupts randomly). At least on RK3399 they moved the CD pin to a 
different I/O bank where the GPIO function is always-on regardless of 
VQMMC, so using the pin as a GPIO here allows the whole SDMMC block to 
be fully powered down when idle. None of which has anything to do with 
VMMC, which is the main power supply to the card itself and doesn't go 
anywhere near the SoC...

Robin.

>>
>> GPIO0_A7 is the card detect line. I don't understand your question. Is
>> it the same as above, i.e. that it should be possible that the SD
>> regulator can be disabled?
>>
>>>> +	disable-wp;
>>>> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>>>> +	pinctrl-names = "default";
>>>> +	vmmc-supply = <&vcc3v0_sd>;
>>>> +	vqmmc-supply = <&vcc_sdio_s0>;
>>>> +	status = "okay";
>>>> +};
>>
>> Best regards
>> Uwe
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
