Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1728DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgJNJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbgJNJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:41 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A21C0610D3;
        Tue, 13 Oct 2020 15:41:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lw21so2038740ejb.6;
        Tue, 13 Oct 2020 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4nuFWG2TWEaroaWbXsdHg7/7bIoM3n77JVnNWHKmJm8=;
        b=DhVYzhksGh8Bz8e1nLtZ9oQlY1J3MXAdz5N5WXK0GiI55gwF+AgoZ5S8Y6VAgsrVWh
         t4+M6t/JwWVWRcmXMq8EHAhHAaK+9zk1zZyxtOex6aDGtCzFzBrjjc7AnBgSUyIS71KP
         JwCskVkOq/GIDqi5knSbpmPkbN+XItfZ/V7QVGE+YGqdksG/uVRnmLL11t6uv8JSrsCq
         umbuGpWAXm0OT6HE5hXh9L2KpC8x/fWF/OusWv0/prRJ0BptoKEHxdUfKqzfzxNq7zo7
         13XyQjyXidmruBCejwaluOE8k9IX4PZ5yKFzBkZ4ELFpfXqywbVV9zcGehH6viCQvPzL
         iodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4nuFWG2TWEaroaWbXsdHg7/7bIoM3n77JVnNWHKmJm8=;
        b=GnN3+XbbiT3JN5sQIpTeZ5QotZVqFdnx1mumFTaqC2oCYnM2G1ZYPmKptCgUvFE5Fs
         hdyfU5OGSjJtrevSf13CMdzCf7hEkyur5VJJ6OqJQcC7f63VXN4zZfO+RHJ96pymm2xV
         gSb7MPWCeLUWPnY0TokS4pRHQ+pR22LYJ17x6V3CzHVZNavm8IcmC3GdnKuPJUCRwaQt
         vMqmgpTpPpJ54xJ/1s5nvoVXueLFN3lcPcaI7y6dwAEId4hinZNzh/rbaZkY9JdPccC5
         ICqyIdP+IgTD5Row/sxQO9PdzsP2pPNmy/EtL98nQccf51Di1/02u0Fsa3wGuJ5wTGwV
         O3Ng==
X-Gm-Message-State: AOAM531aZq3niolqKXWgb3uFJnx0r3LtoFUczHDl4N460231pSMXSuKn
        FJBQzOkN6/MIGuze87pfFLd++F2jVlk=
X-Google-Smtp-Source: ABdhPJysL5LEiXR3WOKkdnzJL7DCX3tDzp7fXOOSphozKLTgrMgk3TiMGvRb+DX1+rXijH06SdmuYQ==
X-Received: by 2002:a17:906:8293:: with SMTP id h19mr2038790ejx.130.1602628882612;
        Tue, 13 Oct 2020 15:41:22 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g18sm618896eje.12.2020.10.13.15.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:41:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add basic support for
 Kobol's Helios64
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
 <20201013161340.720403-3-uwe@kleine-koenig.org>
 <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
 <66aa4ffd-15f8-7c45-282e-e3bddc1af421@kleine-koenig.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <99032f48-c807-def0-e672-7b2c408e1cc3@gmail.com>
Date:   Wed, 14 Oct 2020 00:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <66aa4ffd-15f8-7c45-282e-e3bddc1af421@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 10/13/20 10:22 PM, Uwe Kleine-König wrote:
> Hello Johan,
>
> On 10/13/20 7:34 PM, Johan Jonker wrote:
>> Part 1 of 2 missing here.
>
> Please complain to gmail then, given that patch 1 can be found on
>
https://lore.kernel.org/linux-arm-kernel/20201013161340.720403-2-uwe@kleine-koenig.org/.

Will check my spam.

>
>> Submit all patches to all maintainers and mail lists.
>> Don't forget robh+dt !
>
> I'm really surprised you insist here. In my experience Rob (with his
> dt-hat on) is not interested in specifics of the machine files and he
> already acked patch 1.

As rule of the dumb. Keep everybody in that list informed till the last
version. What they do with is not our problem or concern.

>
>> Add a little change log here.
>
> I assume you also didn't get the cover letter?
>
>>> +		fault-led {
>> fault_led: led-0 {}
>>
>> My fault.
>> Change ones more...
>>   # The first form is preferred, but fall back to just 'led' anywhere
in the
>>   # node name to at least catch some child nodes.
>>   "(^led-[0-9a-f]$|led)":
>
> ok, the label isn't necessary, is it?

Not really, for legacy and readability reasons keep it.
Without label both in nodename and as property one has to compare pin
numbers in pinctrl to see which node belong to each other.
Some users may want to add there own functions. With already available
label they can do so.

>
>>> +			label = "helios64:green:status";
>>> +			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>>
>>> +			linux,default-trigger = "none";
>>
>> Don't use 'none' for mainline.
>
> Oh, I missed that. Thanks for your persistence.

No thanks.

>
>>> +			default-state = "on";
>>> +		};
>>> +	};
>>> +
>>> +	vcc1v8_sys_s0: vcc1v8-sys-s0 {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc1v8_sys_s0";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +		vin-supply = <&vcc1v8_sys_s3>;
>>> +	};
>>> +
>>> +	vcc3v0_sd: vcc3v0-sd {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc3v0_sd";
>>
>> Doesn't a sd card need a on/off gpio?
>> Could you check the schematics?
>
> Hmm, there is a GPIO. I didn't consider a problem there given that the
> machine logs
>
> 	[   31.708706] vcc3v0_sd: disabling
>
> when there is no SD-card in the slot. Will investigate further.

Let us know...

>
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pmic_int_l>;
>>
>> sort
>
> I would expect this is an exception from the sorting rule.
>
> $ git grep pinctrl-names linus/master:arch/arm64/boot/dts/ | wc -l
> 1905
>
> $ git grep -A1 pinctrl-names linus/master:arch/arm64/boot/dts/ | \
>   grep pinctrl-0 | wc -l
> 1412
>
> When grepping over arch/arm64/boot/dts/rockchip the numbers are
> 453 and 445 respectively.
>
> Will use pinctrl-names above pinctrl-0 consistently.

That people in the past blindly followed the manufacturer dts doesn't
make it an exception to the sort rule. Whatever you do, do it consistent.

>
>>> +				regulator-max-microvolt = <1350000>;
>>> +				regulator-min-microvolt = <750000>;
>>
>>
>> The rest has min above max.
>> Exception to the sort rule, not sure what Heiko wants, but keep it every
>> where the same.
>
> OK, most rockchip dts have min before max, will fix up.
>
>>> +	i2c-scl-rising-time-ns = <160>;
>>> +	i2c-scl-falling-time-ns = <30>;
>>
>> sort
>
> I consider it logical to have rise before fall. In 43 of 59 cases in
> arch/arm64/boot/dts/rockchip/ it is done this way.

That people in the past blindly followed the manufacturer dts doesn't
make it an exception to the sort rule. Whatever you do, do it consistent.

>
>>> +	vqmmc-supply = <&vcc1v8_sys_s0>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&sdmmc {
>>> +	bus-width = <4>;
>>> +	cap-sd-highspeed;
>>
>>> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>>
>> see regulator?

Little longer version:
See my question at the sd regulator.
We have a pin to detect, but not to switch the regulator.
Haven't looked at the schematics. Just a reminder to check if it's
correct. Let us know..

>
> GPIO0_A7 is the card detect line. I don't understand your question. Is
> it the same as above, i.e. that it should be possible that the SD
> regulator can be disabled?
>
>>> +	disable-wp;
>>> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>>> +	pinctrl-names = "default";
>>> +	vmmc-supply = <&vcc3v0_sd>;
>>> +	vqmmc-supply = <&vcc_sdio_s0>;
>>> +	status = "okay";
>>> +};
>
> Best regards
> Uwe
>
