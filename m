Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B789028450C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJFEqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:46:06 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59011 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgJFEqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:46:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 74A62AD2;
        Tue,  6 Oct 2020 00:46:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Oct 2020 00:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=S
        rJsp35sTBZn6IZIizSoq2S7ftGFC9KRoVan5bpPXow=; b=il0ZPV6NtjBaeNqnf
        juZSSYucT6wqUikdPdUCecioVZp8PLNJ50yWnuC1vBt5wQXK7dPhX1t1ox0CkEpN
        8i4QXIkSgQblNhPtdRcMuehcbdp77v0znya4XziTVkZ8zkrE6/yc9jKqeHTxGHNR
        P69Ol1ichb4Ox3fp09bSvU0LvFYsjIcAeO+9eFMqjL3T7xaX9dwf2Ihz7imF+A/F
        ISmXBi3wEBJfam/vfSlVtrYTbu4pFbo8tZBTGuDOPCqQjgG0wcMg25Hu/YsqlWqm
        pxCPAzAJKtmc7hUMCc9Yf4C7f1psF8Or18WdKaa2Etf3w7WTnXE0aCg5UGOn7K5w
        PYbSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=SrJsp35sTBZn6IZIizSoq2S7ftGFC9KRoVan5bpPX
        ow=; b=MxBkJSDkfQGdPNfU2dtR4bueUez4+pyDGJ7ma0wxL3tGurQEF6YbkuATk
        XNM6mq23v0v/CH0k7qa5B/8I2c9klljMfFKTv9hebAG21Tcldy2uTNRFKdU+ndFz
        DIBqSY9FrepmC3nIylECmgUJm6s2CSW24/t3nE0EMaI0FwB5hfBCFSaC0ZI643kO
        YO+n1wqfErQyiJmMuInofqq/ItTz/WMneL1d/7Obj5TR8LmT/wtTjFD/nEvLBf9g
        3uiTwr+plypdEr8MdzxXswjd1ItH621yDFOYacZJ7BnkVgtfyUqC9xQL9UDJq/Gs
        eOTDypG8TKPnRs9EQLJUvyV4TaaVw==
X-ME-Sender: <xms:i_Z7X--9NdC8HkABhKHFJw9DmcHWHQs-riw-x5eL4Kr6iHfJC6joOw>
    <xme:i_Z7X-u00JFjD68EGG32JpOeRFWgXIsc8h6CB2-rWzbqvbcOsY_8EcaEA6vSYuQBP
    pEOoK3Ku5GJrn5Bkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:i_Z7X0CCbCLA8APn3dCddruq6uIHV-0tEKuks_AT7CybC9mpdZqqDQ>
    <xmx:i_Z7X2dhHP0GhGfn72Gofo3__28nDjm9bfVNWf3-vP2YlN4qVslglw>
    <xmx:i_Z7XzPHz52c82pwnDqzdsJRAyYBERq1CXOxTlktXZgPq66fvp84oQ>
    <xmx:jPZ7X-dPTbT8OVlIitknmn3Qtnlf0uH_oQ20ZanMLtEa5NSyjG0N3g>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66C24306467E;
        Tue,  6 Oct 2020 00:46:03 -0400 (EDT)
Subject: Re: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while
 streams are open
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-21-samuel@sholland.org>
 <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
 <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <58687207-c5e7-2b4e-1ac6-221a85ceb224@sholland.org>
Date:   Mon, 5 Oct 2020 23:46:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 8:15 AM, Chen-Yu Tsai wrote:
> On Mon, Oct 5, 2020 at 8:01 PM Maxime Ripard <maxime@cerno.tech> wrote:
>>
>> On Wed, Sep 30, 2020 at 09:11:43PM -0500, Samuel Holland wrote:
>>> The codec's clock input is shared among all AIFs, and shared with other
>>> audio-related hardware in the SoC, including I2S and SPDIF controllers.
>>> To ensure sample rates selected by userspace or by codec2codec DAI links
>>> are maintained, the clock rate must be protected while it is in use.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>  sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
>>> index 501af64d43a0..86065bee7cd3 100644
>>> --- a/sound/soc/sunxi/sun8i-codec.c
>>> +++ b/sound/soc/sunxi/sun8i-codec.c
...
>>> @@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>>>                          (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
>>>
>>>       /* BCLK divider (SYSCLK/BCLK ratio) */
>>>       bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
>>>       regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>>>                          SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
>>>                          bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
>>>
>>> -     if (!aif->open_streams) {
>>> +     /* SYSCLK rate */
>>> +     if (aif->open_streams) {
>>> +             ret = clk_set_rate(scodec->clk_module, sysclk_rate);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +     } else {
>>> +             ret = clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
>>
>> It's not really clear to me why we wouldn't want to always protect the
>> clock rate here?
> 
> I believe the intention is to allow a window, i.e. when no audio
> blocks are running,
> when it is possible to switch between sample rate families?

Yes, this is an advantage now. It would not be the case if sun4i-i2s did
something similar. It has the same problem that multiple separate sound
cards compete for one PLL.

> ChenYu

Cheers,
Samuel
