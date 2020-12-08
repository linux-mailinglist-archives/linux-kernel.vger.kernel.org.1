Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64CD2D2166
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLHDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:23:34 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43315 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727752AbgLHDXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:23:33 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DD9C0B55;
        Mon,  7 Dec 2020 22:22:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Dec 2020 22:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=A
        WJEf3NATbEAZn6vc+u0d+euLXDOTbcdSQLfQpbv+D8=; b=AJIBxBFn1zwh5OklU
        2yAb06Ubfc380YjoHEyi7xfYk02jq4tAxzJhi+s8xE0PWR0RczC1MGm1quNnaY+y
        GSLYJ0fo7r44rNlPxmfPUMvYCKNY/82e/XEm3y+t+GGzrZsWHrrAJ2SG4IUso5zg
        lkbreOESegZ3dzmkFr+P/bpwy+x+90njDd8/uXB/KOLvS3+VCyB/ba3jUNzYi4yh
        diDd+e/K14o9xR6vtl7TLfrOQUZDa8ZmMv3UXXPPHy7+ka7aWR5pZXoHO8tkRcI0
        PJ/PNjkpkaB2GWL/SUdxrcg1ra8dDsOUXbSbY6HeRNrnT/Ydwbkx47bNNZmFZqvm
        5nhXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=AWJEf3NATbEAZn6vc+u0d+euLXDOTbcdSQLfQpbv+
        D8=; b=JByOyJ43iz1aGOeu4+C1hjBdgBJZHmxev0Iisg/yO+FVUHRS/rJCcvKUX
        3/Cc5f4FRVKQNUkQrLXUdanjpC7aDVuzZeL7tBjrwc9tYdBH3qJ6adiSoEbXSugw
        moU75IJE1xurv7zNvO4W9k8Ll1OCmCphpwzjQDHB2ZHoHi/e8xI3YzLUXx2F1TAS
        1FGod+UIj7rLfTwviowyddOmT22IlgDtu51N4Gws0ypXXuxXvUHKB6XkD6rBRieo
        yrxOdXyU0GngTChLBEZBmDEAVYJJP3PRXiSqr2uGtEEh798dhyyvK8hTMG7VqjcX
        2Ej3/JPIszOo6OrlizEk/KTGkNMLg==
X-ME-Sender: <xms:cPHOX_WHHSaH-ldAJ_bPwDjYNUBNWCf_QhDQHjzc_NnuGIukSVy46Q>
    <xme:cPHOX3kdi9Y1Y-EZ-X5wrDxtqh_Ac4B3P3M7FV58uJ63a4187Or-SFxjT4_HxYY9b
    nukfgTJmsfBju2f7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefheenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfekheeileeiudehfeeutdfggedvffdvieejheeileeujeeftdeh
    gfegteeiheeinecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepje
    dtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:cfHOX7aaombx1_GPiKns3e8a2SZ3kphcnFHXkBY25zjfYOIfRKq6xQ>
    <xmx:cfHOX6XP5oLs-R-NR7ys47pFdX_FlmoMAZ3PuKOvU367RjHo6Fn2qg>
    <xmx:cfHOX5lrNNmCsp1rDV0Nc4cPOqkvlbxfyKnG2h_6B1Tvd7sraHb8zQ>
    <xmx:cvHOX3bUAA-zXccOap6wS5gQYInQL_6f855Ca7NyP-cPdnXWOPIHXg>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 947EB24005A;
        Mon,  7 Dec 2020 22:22:24 -0500 (EST)
To:     Maxime Ripard <maxime@cerno.tech>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
 <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
 <20201207161259.z6no7m2xqwb2jrju@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
 documentation
Message-ID: <4ceaf71c-dbac-4dc3-7921-d59a40fbece7@sholland.org>
Date:   Mon, 7 Dec 2020 21:22:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207161259.z6no7m2xqwb2jrju@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 10:12 AM, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Dec 07, 2020 at 05:05:03PM +0100, Wilken Gottwalt wrote:
>> Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
>> compatible SoCs.
>>
>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>> ---
>>  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 63 +++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>> new file mode 100644
>> index 000000000000..2954ee0b36a7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
>> +
>> +maintainers:
>> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun8i-hwspinlock
> 
> This can be a const instead of an enum, and since it was introduced with
> the A33 it should be sun8i-a33-hwspinlock. There's a lot of SoCs in that
> family, some without that IP, and we could even see new SoCs in that
> family with a different IP at some point.

I just looked at the A31 ARISC blob, and it uses the hwspinlock hardware
as well, with the same MMIO address and gate/reset bits as A33-H3. So
the first compatible would actually be sun6i-a31-hwspinlock.

Cheers,
Samuel

>> +
>> +    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x1000
>> +      maxItems: 1
> 
> There's no need for those comments
> 
>> +
>> +    clocks:       # phandle to the reference clock
> 
> This should be the description, and it's fairly obvious so you don't
> really need that comment.
> 
>> +      maxItems: 1
>> +
>> +    clock-names:  # name of the bus ("ahb")
>> +      maxItems: 1
> 
> You don't need clock-names if there's a single clock
> 
>> +
>> +    resets:       # phandle to the reset control
>> +      maxItems: 1
> 
> Same thing than for the clocks
> 
>> +
>> +    reset-names:  # name of the bus ("ahb")
>> +      maxItems: 1
>> +
> 
> Ditto
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +
>> +  - |
>> +    /* H2+ based OrangePi Zero */
>> +    hwspinlock: hwspinlock@1C18000 {
> 
> Unit-address's are lowercase
> 
>> +      compatible = "allwinner,sun8i-hwspinlock";
>> +      reg = <0x01c18000 0x1000>;
>> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
>> +      clock-names = "ahb";
>> +      resets = <&ccu RST_BUS_SPINLOCK>;
>> +      reset-names = "ahb";
>> +    };
>> +
>> +    /* H6 based OrangePi 3 */
>> +    hwspinlock: hwspinlock@3004000 {
>> +      compatible = "allwinner,sun8i-hwspinlock";
>> +      reg = <0x03004000 0x1000>;
>> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
>> +      clock-names = "ahb";
>> +      resets = <&ccu RST_BUS_SPINLOCK>;
>> +      reset-names = "ahb";
>> +    };
> 
> Different examples should be different items on that list, but both are
> essentially the same binding so you can drop one.
> 
> Maxime
> 

