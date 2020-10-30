Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41ED29FA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJ3BbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:31:19 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:37861 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgJ3BbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:31:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 348C3BF9;
        Thu, 29 Oct 2020 21:20:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Oct 2020 21:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=V
        q44LRhd0cH+xqCv2R7hForse8RAqAQaEsvsIsJ8iBk=; b=StWnN6ZwMJzP37hNr
        oOTSqDI6L0nwxqtm9SpqaEbutuGs7ITQSwe+STVKnfmm3wqD8nYfsyOh4jub/p8B
        GERMppMgK4PvEAZBfB975NAZkfQlFnh0bqDXh82WWK1csOKAgFPpR0NneaTLWpjF
        pz7I8UySbiXzBStHicns9/Bzuxm16+5g1rw2nO5V2RQpCX0GaHNLj17P8dx6JuIb
        VU95zCt6Ogh9TJJB33/a8IOz8hB/177GgssdgsVI6NxjzpapCynhC8FuYmPHInQe
        dMFBVnHhVBYdI5P/C3CDVeJljBn8gBmoJeN0xqHCu34ZsBSTFmPQjqzT8jl+RmU3
        lz4Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Vq44LRhd0cH+xqCv2R7hForse8RAqAQaEsvsIsJ8i
        Bk=; b=SbcACNp6tR/fIW7yWUNtd8hNq2Ye2p4sh4kmb33o46umgIBusm45igcwR
        wGQn2KQ7i8BOhDL2/xjUsmENiL/1Gm7fI4Fp5w0+lv4d4q4r4rNMgVL6+T5tc9V9
        7AT6KEzaL/J+evvzu6RAguHw9CbLQpdYXU6kA4DZWmR+ibUd5eXwIaExvbRn0IHs
        Ynu9b6xZOvXXqmypDRiOaPJmUI+86Ma6q0PrkZmUegqmDLKokrroMato/M6cPeNu
        1e3m+Xxs0xRuT08EOCHn1GxKB64UA6rpzrp9CRqO112mPKx0RgmYuCSDAjtkEwJe
        cU7/G0YJ55EwaVg+/mNJjnxZc2JJg==
X-ME-Sender: <xms:dGqbX3Wm1te6ADrqNfeEAQ5-DvdXA7Gl_kGtNLTigNSgOqQTCkKcJg>
    <xme:dGqbX_kZxPGKFe3Phf_pfsA8Ha99z3A4KbrRhG1bsNE0qqiMq1kZdAgQG4_y-7KPc
    5vxuZ8XAExtx7zymw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgleekudevjedtjefhieelvdfhgeegieeikeelhfeffeffffffgedu
    teetleeijeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:dGqbXzYdwfapoLTPt5qppt4Em1a4jsjcZrh5tBKh4-ooZ3jaUVWP2Q>
    <xmx:dGqbXyVgI5d_WzPM4E2ObKm_a6WDJJwMH6KbZBdYeX8SEZnu1a36qQ>
    <xmx:dGqbXxny0BYt8BrPOWT0fCX4jkQ9lMc0K9CBMjkUVWgWzCjoBIfqww>
    <xmx:dmqbX08harbibNIcPg2hrJLwCB_9ufFJYdISO1CMlu5chk_mrujwxDkfLiw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C80B328005D;
        Thu, 29 Oct 2020 21:20:52 -0400 (EDT)
Subject: Re: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20201027183149.145165-1-peron.clem@gmail.com>
 <20201027183149.145165-2-peron.clem@gmail.com>
 <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com>
 <CAJiuCcdX7jc-VMWYfPPL3qu9RcUU7VMdjshyPH_xLA0yVXftUw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3f0c46e2-24a4-b6ee-1ea2-9de5344cfb9d@sholland.org>
Date:   Thu, 29 Oct 2020 20:20:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcdX7jc-VMWYfPPL3qu9RcUU7VMdjshyPH_xLA0yVXftUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 4:43 PM, Clément Péron wrote:
> Hi Pierre-Louis,
> 
> On Tue, 27 Oct 2020 at 19:59, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>> @@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>>>       case SND_SOC_DAIFMT_DSP_B:
>>>       case SND_SOC_DAIFMT_LEFT_J:
>>>       case SND_SOC_DAIFMT_RIGHT_J:
>>> -             lrck_period = params_physical_width(params) * slots;
>>> +             lrck_period = slot_width * slots;
>>>               break;
>>>
>>>       case SND_SOC_DAIFMT_I2S:
>>> -             lrck_period = params_physical_width(params);
>>> +             lrck_period = slot_width;
>>>               break;
>>
>> Aren't I2S, LEFT_J and RIGHT_J pretty much the same in terms of lrclk
>> rate/period? the only thing that can change is the polarity, no?
>>
>> Not sure why it's handled differently here?
> 
> I just had a look at the User Manual for H3 and H6 and I didn't find
> any reason why LEFT_J and RIGHT_J should be computed in a different
> way as I2S.

Yes, and the manual explicitly groups LEFT_J and RIGHT_J with I2S when
describing this field:

   PCM Mode: Number of BCLKs within (Left + Right) channel width.
   I2S/Left-Justified/Right-Justified Mode: Number of BCLKs within each
individual channel width(Left or Right)

So I agree that the code is wrong here.

Regards,
Samuel

> Also the commit introducing this doesn't mention it.
> 7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")
> 
> I can't test it with my board but if nobody complains about it, I will
> introduce a fix for this in the next version and change this also for
> H6.
> 
> Thanks for your review,
> Clement
> 

