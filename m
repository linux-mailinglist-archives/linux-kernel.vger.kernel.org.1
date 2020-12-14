Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB972D9181
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 01:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbgLNA4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 19:56:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44901 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgLNA4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 19:56:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AFB645C0118;
        Sun, 13 Dec 2020 19:55:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Dec 2020 19:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=d
        SHu5a+c9pw7qJLwh+DHvg2AtCB3w70XWRDwq3zSeQw=; b=FSN4Xv/tfI1VPU303
        QNJtaY/mAslVHaIghsnxDifqeYW0eArNBdXj2oN9M30bzOjxL1PI9vYV3T7FjqI7
        5fHhLNjhVfyzouCoIWqlSDUOzt2glzxahd5+FGtvJtyaiMXOUsTKUN7zhGj3ZsR6
        j59ERQ+xv23Q6CZaWYhD2FmYobHXcfF7gTNk5hRoxZQ7RjRI+R5X/HcbSvojRwo7
        Doy4nkX75isk4hb+UZurllnxuNbZL4Tw0tqD5PrL2e2lrHjzjkjMZfYuy0shx/l9
        lupzFBrEieMd/QJMffJZ5UJiORzCS9CSJq43bkSeSgIBhdqoXkzI7GojU5z9dR/6
        RPuSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=dSHu5a+c9pw7qJLwh+DHvg2AtCB3w70XWRDwq3zSe
        Qw=; b=LbdLgmYYzRMSm+TiNVkHkhe5EP3ii1y9g5S7t1lZLGgvDG4KRW+FG+qh/
        hIGtAcNrhWU96QFTmA2HQdJQYtJT/SfyaGebt8WC+bZjIABrdtScpQgZg4hVNMOF
        YbCWCz/A0TDO4CntgOIsphZAICNpts750GQUOex+ZS7OXOZDpnwmPFdBPx20mEY5
        4LfyHwIJMBKGILMNSuer5z48DN/ejhbtF9ndoltNtrQdDv8X8BuQanCEPgltA924
        39El0oCJus8fxL+rQG0tgQbB0cZ7rWcI6nVb3zTtE/TmThBeXYGLFuENQ82lkJoC
        Su/aaPbMTbPJ8KCdXuedCD3XNOi9Q==
X-ME-Sender: <xms:AbjWX2p7bQnLmcrLFb-tjn6M5vOI28C-LOqqMigSBCVAwlCumz5iGw>
    <xme:AbjWX0rkLFr4s1oZpGc683xNahOnIzjNcYkHvo5HLekrH6pe-LS2CuhPpb9W2F-gt
    kMmN4H9bN-WlaHa0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekjedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffeigfelvdfgtdetleduveevgfdutdeiuddtveetvdfhffejlefh
    heetjeetvdelnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepje
    dtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:AbjWX7MH0FErHXpDxjWkSSkHOO9SXN5KAi8yDmyQZIUb0PRzOtcZPg>
    <xmx:AbjWX16FZVQcZz9z4LhNEd5w0jj1k3sBJo--769-52a6cLRY9DTCeA>
    <xmx:AbjWX14B-NdqA0T9qk5XuRpUkO5QSQ0pKNFNKOyYiDj3VqqElRvinA>
    <xmx:ArjWXyuPOJeSyl-jis9bfPeLooxu7jXySBT-ycpbh_i4MLcl2dZXJQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B58B24005B;
        Sun, 13 Dec 2020 19:55:29 -0500 (EST)
Subject: Re: [PATCH v3 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
 documentation
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
 <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
 <20201207161259.z6no7m2xqwb2jrju@gilmour>
 <4ceaf71c-dbac-4dc3-7921-d59a40fbece7@sholland.org>
 <20201208061128.3e20f00b@monster.powergraphx.local>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fbc84df2-d6d7-bfc3-0a8b-f1b24b7fd0a9@sholland.org>
Date:   Sun, 13 Dec 2020 18:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208061128.3e20f00b@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 11:11 PM, Wilken Gottwalt wrote:
> On Mon, 7 Dec 2020 21:22:23 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
>> On 12/7/20 10:12 AM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Mon, Dec 07, 2020 at 05:05:03PM +0100, Wilken Gottwalt wrote:
>>>> Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
>>>> compatible SoCs.
>>>>
>>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>>> ---
>>>>  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 63 +++++++++++++++++++
>>>>  1 file changed, 63 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>>>> b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml new file mode 100644
>>>> index 000000000000..2954ee0b36a7
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>>>> @@ -0,0 +1,63 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
>>>> +
>>>> +maintainers:
>>>> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - allwinner,sun8i-hwspinlock
>>>
>>> This can be a const instead of an enum, and since it was introduced with
>>> the A33 it should be sun8i-a33-hwspinlock. There's a lot of SoCs in that
>>> family, some without that IP, and we could even see new SoCs in that
>>> family with a different IP at some point.
>>
>> I just looked at the A31 ARISC blob, and it uses the hwspinlock hardware
>> as well, with the same MMIO address and gate/reset bits as A33-H3. So
>> the first compatible would actually be sun6i-a31-hwspinlock.
> 
> Hmm, so it would make sense to also change the drivers symbols from sun8i to
> sun6i, right?

Correct.

> Before I do that, is there maybe a sun4i which also includes
> the hwspinlock unit? Just in case :D

There is a sun4i, but there is no evidence it contains the hwspinlock unit.

Cheers,
Samuel

> 
> greetings,
> Wilken
> 
>> Cheers,
>> Samuel
>>
>>>> +
>>>> +    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x1000
>>>> +      maxItems: 1
>>>
>>> There's no need for those comments
>>>
>>>> +
>>>> +    clocks:       # phandle to the reference clock
>>>
>>> This should be the description, and it's fairly obvious so you don't
>>> really need that comment.
>>>
>>>> +      maxItems: 1
>>>> +
>>>> +    clock-names:  # name of the bus ("ahb")
>>>> +      maxItems: 1
>>>
>>> You don't need clock-names if there's a single clock
>>>
>>>> +
>>>> +    resets:       # phandle to the reset control
>>>> +      maxItems: 1
>>>
>>> Same thing than for the clocks
>>>
>>>> +
>>>> +    reset-names:  # name of the bus ("ahb")
>>>> +      maxItems: 1
>>>> +
>>>
>>> Ditto
>>>
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - resets
>>>> +  - reset-names
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +
>>>> +  - |
>>>> +    /* H2+ based OrangePi Zero */
>>>> +    hwspinlock: hwspinlock@1C18000 {
>>>
>>> Unit-address's are lowercase
>>>
>>>> +      compatible = "allwinner,sun8i-hwspinlock";
>>>> +      reg = <0x01c18000 0x1000>;
>>>> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
>>>> +      clock-names = "ahb";
>>>> +      resets = <&ccu RST_BUS_SPINLOCK>;
>>>> +      reset-names = "ahb";
>>>> +    };
>>>> +
>>>> +    /* H6 based OrangePi 3 */
>>>> +    hwspinlock: hwspinlock@3004000 {
>>>> +      compatible = "allwinner,sun8i-hwspinlock";
>>>> +      reg = <0x03004000 0x1000>;
>>>> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
>>>> +      clock-names = "ahb";
>>>> +      resets = <&ccu RST_BUS_SPINLOCK>;
>>>> +      reset-names = "ahb";
>>>> +    };
>>>
>>> Different examples should be different items on that list, but both are
>>> essentially the same binding so you can drop one.
>>>
>>> Maxime
>>>
>>
> 

