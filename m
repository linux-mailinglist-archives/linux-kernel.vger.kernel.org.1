Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4819D2CDA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgLCPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:46:14 -0500
Received: from foss.arm.com ([217.140.110.172]:43654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgLCPqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:46:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7951063;
        Thu,  3 Dec 2020 07:45:27 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CA73F718;
        Thu,  3 Dec 2020 07:45:25 -0800 (PST)
Subject: Re: [linux-sunxi] Re: [PATCH 7/8] arm64: dts: allwinner: Add
 Allwinner H616 .dtsi file
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com>
 <3b4f4bf6-2fba-5d35-bdf5-74b8ced10357@sholland.org>
 <34e5618e-4a3d-9a46-5077-179c82592fce@arm.com>
 <CAGb2v67+Bfhnw9hFv8vOLTOqmb-hoYxRnk4Q7CQZjzJbzkQxqg@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <3dc67c21-f649-cca5-ec54-c639c54ee56a@arm.com>
Date:   Thu, 3 Dec 2020 15:44:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67+Bfhnw9hFv8vOLTOqmb-hoYxRnk4Q7CQZjzJbzkQxqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2020 15:02, Chen-Yu Tsai wrote:
> On Thu, Dec 3, 2020 at 6:54 PM André Przywara <andre.przywara@arm.com> wrote:
>>
>> On 03/12/2020 03:16, Samuel Holland wrote:
>>
>> Hi,
>>
>>> On 12/2/20 7:54 AM, Andre Przywara wrote:
>>> ...
>>>> +    soc {
>>>> +            compatible = "simple-bus";
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <1>;
>>>> +            ranges = <0x0 0x0 0x0 0x40000000>;
>>>> +
>>>> +            syscon: syscon@3000000 {
>>>> +                    compatible = "allwinner,sun50i-h616-system-control",
>>>> +                                 "allwinner,sun50i-a64-system-control";
>>>> +                    reg = <0x03000000 0x1000>;
>>>> +                    #address-cells = <1>;
>>>> +                    #size-cells = <1>;
>>>> +                    ranges;
>>>> +
>>>> +                    sram_c: sram@28000 {
>>>> +                            compatible = "mmio-sram";
>>>> +                            reg = <0x00028000 0x30000>;
>>>> +                            #address-cells = <1>;
>>>> +                            #size-cells = <1>;
>>>> +                            ranges = <0 0x00028000 0x30000>;
>>>> +                    };
>>>> +
>>>> +                    sram_c1: sram@1a00000 {
>>>> +                            compatible = "mmio-sram";
>>>> +                            reg = <0x01a00000 0x200000>;
>>>> +                            #address-cells = <1>;
>>>> +                            #size-cells = <1>;
>>>> +                            ranges = <0 0x01a00000 0x200000>;
>>>> +
>>>> +                            ve_sram: sram-section@0 {
>>>> +                                    compatible = "allwinner,sun50i-h616-sram-c1",
>>>> +                                                 "allwinner,sun4i-a10-sram-c1";
>>>> +                                    reg = <0x000000 0x200000>;
>>>> +                            };
>>>> +                    };
>>>> +            };
>>>
>>> You mentioned that you could not find a SRAM A2. How were these SRAM ranges
>>> verified? If you can load eGON.BT0 larger than 32 KiB, then presumably NBROM
>>> uses SRAM C, and it is in the manual, but I see no mention of SRAM C1.
>>
>> The manual says that SRAM C *can* be used by "the system", at boot time,
>> as long as it's configured correctly. I couldn't find any details on how
>> to switch clock sources for SRAM C, and the manual stanza on this is
>> quite gibberish. I presume it's configured either by BROM or by reset
>> default this way. I think the idea is that the later users (VE, DE) take
>> ownership at some point (which means we can't run any firmware in there).
>> The BSP boot0 is 48KB already, so reaching into SRAM C, and the code
>> itself heavily uses SRAM C (found by hacking boot0 to drop to FEL and
>> inspecting the memory afterwards).
>>
>> For C1: I copied this name from the H6 .dtsi, the manual calls this
>> "VE-SRAM", in both manuals, and the description looks identical there
>> for both SoCs. I think this will be later used by the video engine, so I
>> kept it in. The large size made me suspicious, and from former
>> experiments it looks like being aliased to (parts of) SRAM C.
> 
> I would just call it sram_ve or ve_sram. SRAM C1 would make more sense if
> it were part of SRAM C, not the other way around.

But isn't that what we do? "sram_c1" is just the node name alias used
for the parent node. That is actually never referenced anywhere (in any
of the the H6 .dts), so we can actually remove it, I guess.
The actual SRAM section is called ve_sram already.
And I can't change the compatible name, for the fallback, at least.

I can make the new compatible string read
"allwinner,sun50i-h616-ve-sram", if that helps, but that would mean
deviating from the H6 and other SoCs.

Cheers,
Andre


> 
> Also the sram-section node would make more sense if it were in sram_c, as
> that is the part that gets switched around, not the full region @ 1a00000.
> 
> ChenYu
> 
>> Maybe some guys with more VE knowledge can shine some light on this?
>>
>> Cheers,
>> Andre
>>

