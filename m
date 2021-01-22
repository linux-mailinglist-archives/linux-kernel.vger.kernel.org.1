Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03CB2FFA00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbhAVBfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:35:09 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42205 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbhAVBfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:35:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EF2C21834;
        Thu, 21 Jan 2021 20:33:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Jan 2021 20:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=W
        gcBGgOaSIyMT8TligKY0WdxImQrH4d4UDt8M5c2E80=; b=iOfCLLqy7jE+oy9Tm
        FhfVVQfpKpWcSK5kRV4YW2x3A6HGerEFT6Lm4uCiAsS1p5O1T31cJCcA0w97bu1a
        03cvxRmRrSKfwXguipyfGGIrp1YlG9B0uZqI4184M4qu5o4iR2oAJ0lI1XNBmTgc
        ERSRe1OgMM3IKmuTFcHb2Ppd0Jn404LYOx/mjkRYDny7xRt+Atscbujt/b1r0zjj
        WPpEPXdSKpC6ibr5zkt1FBAPiir1ovgojgDsG253y/FnhXdijk90hwZhgQUkomss
        qgXmJ5mP7kDgewqIfOIBUStwTna5igjlVOoOrGYMoC99nGJSgV2h8IuSgfBUptl+
        cTBfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=WgcBGgOaSIyMT8TligKY0WdxImQrH4d4UDt8M5c2E
        80=; b=He/s5kEOHVPgcWaZuL6C9CEhWl1jI8cXbha1jjRgZzRJ3WyFrj0Y6usCM
        AhAW8bnScpLo1EQ69fyBXLifIuPqicPB1x7aeqSFRN270OVTixblui1JC/9mKYzP
        Fu9ghPkNCwOR0BpMyeTJrqAK5OYhDAvxpwVIyT/ZaxKc+qILCIBmkPg+rNOjHPUJ
        /sbbNaMpPzhFjhb9vVRC5DNcFW4D+0w3oaEpRlQP8ZHBD2scGvcCqeJyCSYwDCO2
        Lf0Qs4prMo3tFQvWOsaRfCbvVTca9H1RHqFuaaRnb0OpCYVQGACE4bZ1ZifsXsU4
        +egMyZw82O4RsFoBLUJmfPlsvNnjg==
X-ME-Sender: <xms:gysKYP3aAfG0q6b0zB9_cZbIXVocCZzmKZtrozwNhkvB--LBTHdCMA>
    <xme:gysKYOGnu9e6BD2vQIVY23fcLr9Ki-71Qr_f-sfbKIPI8_82nncjfu-HNJQW1pqba
    zKmF3qN5g6oTQ8sjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedvvddttdefhefgieektdeuvdduhfeileevieeujeehuefggedvueei
    tdduleffieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejtddrudefhe
    drudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:gysKYP74hkzMl0CGu0a3FwwX5FQKwBN80obSbH-6FdsKkHZtudmG0g>
    <xmx:gysKYE2kN-yYa-1GnUHbXYyeqdPEJw6QevJdTM585aP1b5BgzjFN5w>
    <xmx:gysKYCHnjQqIgLzbKcziJtl1_McZVPeWHAOFP1EfEmdjpjJCC4NSYw>
    <xmx:hCsKYF3sUqLRBTmAIINE7sazIHMmBPl9sf0ySDYQktS1Ik1BPSMQOQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01AEE1080059;
        Thu, 21 Jan 2021 20:33:54 -0500 (EST)
To:     Marc Zyngier <maz@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210118055040.21910-1-samuel@sholland.org>
 <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Message-ID: <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org>
Date:   Thu, 21 Jan 2021 19:33:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 2:35 PM, Marc Zyngier wrote:
> On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
>> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
>> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
>> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
>> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
>> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
>>
>> This series replaces the existing chained irqchip driver that could only
>> control the NMI, with a stacked irqchip driver that also provides wakeup
>> capability for those multiplexed SPI IRQs. The idea is to preconfigure
>> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
>> as soon as it receives an IRQ. It can also decide how deep it can
>> suspend based on the enabled wakeup IRQs.
>>
>> [...]
> 
> Applied to irq/irqchip-5.12, thanks!
> 
> [01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
>         commit: ad6b47cdef760410311f41876b21eb0c6fda4717
> [02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
>         commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
> [03/10] irqchip/sun6i-r: Use a stacked irqchip driver
>         commit: 4e34614636b31747b190488240a95647c227021f
> [04/10] irqchip/sun6i-r: Add wakeup support
>         commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003
> 
> Please route the dts patches via the soc tree. Also, I had to
> manually fix the first patch as it wouldn't apply on top of
> 5.11-rc4 (which tree has it been diffed against?). Please
> check that the resolution is correct.

This series was based on sunxi/for-next, which contains commit
752b0aac99c7 ("dt-bindings: irq: sun7i-nmi: Add binding documentation
for the V3s NMI")[1].

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=sunxi/for-next&id=752b0aac99c7e0b179875cdfa102d378ccb794a2

> Cheers,
> 
> 	M.
> 

