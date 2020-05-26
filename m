Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A071BDA59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgD2LIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 07:08:06 -0400
Received: from foss.arm.com ([217.140.110.172]:37328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgD2LIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:08:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBABE1042;
        Wed, 29 Apr 2020 04:08:01 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E52D3F73D;
        Wed, 29 Apr 2020 04:07:59 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: Audio sound card name [was [PATCH 4/7] arm64:
 dts: allwinner: a64: Add HDMI audio]
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200429081729.qa3gqtl5sof2jhem@gilmour.lan>
 <f9b701d9-0c4e-6e41-1ce8-52adf0f59a2a@arm.com>
 <2545943.S5iK65abk1@jernej-laptop>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8a6b9707-d6c0-04ea-97a6-27cbbe468631@arm.com>
Date:   Wed, 29 Apr 2020 12:07:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2545943.S5iK65abk1@jernej-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-29 11:53 am, Jernej Škrabec wrote:
> Dne sreda, 29. april 2020 ob 12:43:06 CEST je Robin Murphy napisal(a):
>> On 2020-04-29 9:17 am, Maxime Ripard wrote:
>>> On Wed, Apr 29, 2020 at 02:24:00PM +0800, Chen-Yu Tsai wrote:
>>>> On Wed, Apr 29, 2020 at 1:11 AM Robin Murphy <robin.murphy@arm.com>
> wrote:
>>>>> On 2020-04-28 5:49 pm, Clément Péron wrote:
>>>>>> Hi Mark, Rob,
>>>>>>
>>>>>> On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wrote:
>>>>>>> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Clément Péron wrote:
>>>>>>>> Hi Maxime,
>>>>>>>>
>>>>>>>> On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech>
> wrote:
>>>>>>>>> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Clément Péron wrote:
>>>>>>>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>>>>>>>
>>>>>>>>>> Add a simple-soundcard to link audio between HDMI and I2S.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>>>>>>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>>>>>>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>     arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21
>>>>>>>>>>     +++++++++++++++++++
>>>>>>>>>>     1 file changed, 21 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>>>>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
>>>>>>>>>> e56e1e3d4b73..08ab6b5e72a5 100644
>>>>>>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>>>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>>>>>>> @@ -102,6 +102,25 @@
>>>>>>>>>>
>>>>>>>>>>                  status = "disabled";
>>>>>>>>>>          
>>>>>>>>>>          };
>>>>>>>>>>
>>>>>>>>>> +     hdmi_sound: hdmi-sound {
>>>>>>>>>> +             compatible = "simple-audio-card";
>>>>>>>>>> +             simple-audio-card,format = "i2s";
>>>>>>>>>> +             simple-audio-card,name = "allwinner,hdmi";
>>>>>>>>>
>>>>>>>>> I'm not sure what the usual card name should be like though. I would
>>>>>>>>> assume that this should be something specific enough so that you're
>>>>>>>>> able to differentiate between boards / SoC so that the userspace
>>>>>>>>> can choose a different configuration based on it?
>>>>>>>>
>>>>>>>> I really don't know what we should use here,
>>>>>>>> I just have a look at other SoC:
>>>>>>>> rk3328: "HDMI"
>>>>>>>> rk3399: "hdmi-sound"
>>>>>>>> r8a774c0-cat874: "CAT874 HDMI sound"
>>>>>>>>
>>>>>>>> But maybe it's time to introduce proper name:
>>>>>>>> What about :
>>>>>>>> pat
>>>>>>>> sun50i-h6-hdmi
>>>>>>>
>>>>>>> It's pretty much what we've been using for the other sound cards we
>>>>>>> have, so it makes sense to me.
>>>>>>
>>>>>> I have a question regarding the simple-audio-card,name.
>>>>>> In this patch, I would like to introduce a simple-audio-card for the
>>>>>> Allwinner A64 HDMI.
>>>>>>
>>>>>> What should be the preferred name for this sound card?
>>>>>> "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?
>>>>>
>>>>> I can at least speak for RK3328, and the reasoning there was that as the
>>>>> user looking at what `aplay -l` says, I don't give a hoot about what the
>>>>> SoC may be called, I see two cards and I want to know, with the least
>>>>> amount of uncertainty, which one will make the sound come out of the
>>>>> port that's labelled "HDMI" on the box ;)
>>>>
>>>> I agree. The user really doesn't care what SoC the system uses. The only
>>>> real requirement is to be able to tell which output the card is related
>>>> to, i.e. is it onboard or an external DAC, is it analog or HDMI, etc..
>>>
>>> Yeah, but it's exactly the point.
>>>
>>> If we also end up with "HDMI" as our card name, then the userspace has no
>>> way to tell anymore if it's running from an rk3328 or an allwinner SoC,
>>> or something else entirely. And therefore it cannot really configure
>>> anything to work out of the box anymore.
>>
>> OK, you're a userspace audio application - enlighten me as to what exact
>> chip you're running on here, and why you need to know:
>>
>> card 0: HDMI [HDA ATI HDMI]
>>
>> or how about here?
>>
>> card 0: Intel [HDA Intel]
>>
>>
>> Furthermore, your argument works both ways - if the equivalent (or in
>> common cases like DesignWare IP blocks, exact same) thing across 3
>> different SoCs has 3 different names, then it's that much harder for
>> userspace that wants to present a consistent behaviour. I don't know
>> exactly why LibreELEC have downstream patches that standardise all the
>> Rockchip ones to "HDMI", but I can't help noting that they do.
>>
>> With simple-audio-card we're talking about trivial interfaces that often
>> don't expose any controls at all, so there's unlikely to be much
>> 'configuration' for userspace to do beyond choosing which card to output to.
> 
> This combination (DesignWare HDMI controller + I2S) is same as on Rockchip.
> Only difference is slightly different version of HDMI controller and different
> I2S core. Not sure what kind of configuration do you have in mind, but all
> these controllers support 2-8 channels, different sample sizes, even
> passthrough mode can be set (but it's not implemented yet). I would say that
> this audio output supports quiet a few possible configurations.

Right, what I'm getting at is that the stuff that matters is all regular 
audio capabilities exposed via the appropriate APIs, and any choices are 
going to be mostly based on the audio being played and what the receiver 
on the other end of the link supports. I'm genuinely curious as to what 
actual configuration decision could be made purely based on the SoC 
name, regardless of the board, receiver, or the capabilities advertised 
by the interface itself.

Thanks,
Robin.
