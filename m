Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5515A2EF4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbhAHPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:40:57 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44163 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbhAHPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:40:57 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8C7655809F4;
        Fri,  8 Jan 2021 10:40:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 08 Jan 2021 10:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=w
        zE4Xrlr85o2LDUmxu12BY27nXBk/vs8oX2BctH7gpY=; b=OB05wj/N36tgoDEj+
        Y6gTPjheckq8pegEU+T12Z0y5uqZaWOPQMKW0X8cLovE0woRVIOVv4qI5GjHZ7tN
        SpCAi9Vlg5qGgpVYpTiXcuzEM4NHMLzENMOKdCAYCACzcmoXv8AMZYOR93gkbXgl
        NzmCsAxwIS7svajZhBXPC0nQe7tJVQ+uQ8I4bb7nYYopm1zK9IGvDY0x8stShqzy
        yJ7H4BJyi1t3PGL5XL9ZI/cj/7XxXovMETI8X9znOYrO1P2566SGcDzfXdNBSsQV
        8pljzSaOn4MM+c9w6t++ugNZsvM/8sm8/aV952CxiZB33324ii+6GhlCdxUDzcFK
        o/0fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=wzE4Xrlr85o2LDUmxu12BY27nXBk/vs8oX2BctH7g
        pY=; b=DxYZeLybui59agxGluKta8KblDIDCo0PjgGOOitFWGEwEu3LrAortWgPa
        l1an28jNfBiK/tzzfTOsf0dFAh8vWRCDQXfV9009hKDlVQDpcrXROLHkiza5f5vd
        eXzZ01ZNRiQ5Ca5HPHrXTiovKSx6jJbbQn1AUHWLaq1Iunv5IzlHMUuyUQFjUUV5
        GlGrqRm6e8raBB3VUxm7tn8FLbTO3e9+6qJyIsPHkvCedP65Q64Oy32DwQYslL8c
        e82VEQI0LwgMccp8qa2Vkrhu24HDc5UhQz7DDlLYOZh5tH+blbWUkBKHD9GreIDC
        EZPQwTBxvp78kbmDo9OIQQ9EGGc9Q==
X-ME-Sender: <xms:2Hz4Xyygb5ALVC2zRLGetqstJAQq3tS35weGdtGX4sAL0d7mduVtWA>
    <xme:2Hz4X8MCOPAcDIe_gDYLSX_iJXyVBbZZ96s1pKCcZovEmzC5WmFyK9TCqL93eMWBr
    NGJh6v2WmmAcNb6PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeghedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:2Hz4X2qgiTcaEwvYw6uVla6NUcEx8I-_kvGBPC1YZ4z1v6zIk8MGhg>
    <xmx:2Hz4X9HjM2I1uPAeUucN3pEJ_zHVUCzN3AtvqEyc9T9pqdLYWo1mIg>
    <xmx:2Hz4X7o1X5Vf0qYr4A991OBIpA1R1aANgrv_rTsrm4PFU66fGuOR1g>
    <xmx:2nz4X4W9LV3y_UKja-NN2IDrw06VPxZcXzWv1PKyhoBIfCgVb1TyQw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD8F11080059;
        Fri,  8 Jan 2021 10:40:07 -0500 (EST)
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-2-samuel@sholland.org>
 <20210108094453.7uk5lj6j6gdmydiw@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 01/10] dt-bindings: irq: sun6i-r: Split the binding
 from sun7i-nmi
Message-ID: <e6ab1926-e69d-1e66-32d8-19870625ee17@sholland.org>
Date:   Fri, 8 Jan 2021 09:40:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210108094453.7uk5lj6j6gdmydiw@gilmour>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/21 3:44 AM, Maxime Ripard wrote:
> Hi Samuel,
> 
> Thanks a lot for working on this
> 
> I'm fine with the rest of the work, but I have a couple of questions
> 
> On Sun, Jan 03, 2021 at 04:30:52AM -0600, Samuel Holland wrote:
>> The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
>> functionality compared to the sun7i/sun9i NMI controller. Among other
>> things, it multiplexes up to 128 interrupts corresponding to (and in
>> parallel to) the first 128 GIC SPIs. This means the NMI is no longer the
>> lowest-numbered interrupt, since it is SPI 32 or 96 (depending on SoC).
>>
>> To allow access to all multiplexed IRQs, the R_INTC requires a new
>> binding where the interrupt number matches the GIC interrupt number.
>> For simplicity, copy the three-cell GIC binding; this disambiguates
>> interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
>> binding (SPI 0) by the number of cells.
> 
> It's not really clear to me what the ambiguity is between the NMI and
> the SPI 0 interrupt?

Here's the ASCII art I will include in v4:

            NMI IRQ               DIRECT IRQs          MUXED IRQs
             bit 0                 bits 1-18           bits 19-31

  +---------+                     +---------+   +---------+  +---------+
  | NMI Pad |                     |  IRQ d  |   |  IRQ m  |  | IRQ m+7 |
  +---------+                     +---------+   +---------+  +---------+
       |                            |     |        |    |      |    |
       |                            |     |        |    |......|    |
+------V------+ +-------------+     |     |        | +--V------V--+ |
|   Invert/   | |    Write    |     |     |        | |  AND with  | |
| Edge Detect | |  PENDING[0] |     |     |        | |  MUX[m/8]  | |
+-------------+ +-------------+     |     |        | +------------+ |
           |       |                |     |        |       |        |
        +--V-------V--+          +--V--+  |     +--V--+    |     +--V--+
        | Set    Reset|          | GIC |  |     | GIC |    |     | GIC |
        |    Latch    |          | SPI |  |     | SPI |... |  ...| SPI |
        +-------------+          | N+d |  |     |  m  |    |     | m+7 |
            |     |              +-----+  |     +-----+    |     +-----+
            |     |                       |                |
    +-------V-+ +-V-----------+ +---------V---+  +---------V----------+
    | GIC SPI | |   AND with  | |   AND with  |  |      AND with      |
    | N (=32) | |  ENABLE[0]  | |  ENABLE[d]  |  |   ENABLE[19+m/8]   |
    +---------+ +-------------+ +-------------+  +--------------------+
                       |               |                   |
                +------V------+ +------V------+  +---------V----------+
                |    Read     | |    Read     |  |       Read         |
                |  PENDING[0] | |  PENDING[d] |  |   PENDING[19+m/8]  |
                +-------------+ +-------------+  +--------------------+

There are two overlapping ranges of IRQs supported by the controller,
and so there are two different IRQs you could call "IRQ 0":
  - Bit 0 of PENDING/ENABLE/MASK, aka d==0, the NMI
    - This maps to bit 32 of the MUX register range (SPI 32)
    - This is what the old binding calls "IRQ 0"
  - Bit 0 of MUX, aka m==0, aka SPI 0, the UART0 IRQ
    - This maps to bit 19 of PENDING/ENABLE/MASK
    - This is what the new binding calls "IRQ 0"

You can see this insertion in the middle of the MUX range when looking
at the mask of implemented MUX bits in the A31 variant:
  0xffffffff,
  0xfff80000, <<< this gap here is for the 19 direct IRQs
  0xffffffff,
  0x0000000f,

If you call the NMI "IRQ 0", then there is no way to specify the muxed
IRQs. SPI 0 maps to bit 19, but so do SPI 1-7. So if I was to specify
"IRQ 19", you wouldn't know which of those 8 muxed SPIs I am referring to.

On the other hand, if you call the first muxed IRQ "IRQ 0", then there
is an unambiguous number for every interrupt supported by this driver.

> In general, it looks like switching to a 3-cell binding with the GIC SPI
> value looks weird to me, since the GIC isn't the parent at all of these
> interrupts.

The GIC is *a* parent of all of these interrupts, and is *the* parent of
the NMI.

> If the ambiguity is that a stacked irqchip driver needs to have the same
> interrupt number than the GIC, and that the 0 interrupt for the NMI
> controller (used by the PMIC) and is actually the 32 (or 96) GIC
> interrupt and thus breaks that requirement, can't we fix this in the
> driver based on the compatible?

No, while the NMI is direct "IRQ 0" at this irqchip, it is *also* muxed
"IRQ 32" at this same irqchip.

> Something like if the interrupt number is 0, with a A31 or newer
> compatible, then add the proper offset in sun6i_r_intc_domain_alloc?

If you translate 0 to 32, then you cannot represent muxed IRQ 0 (the
UART0 IRQ) at all.

> Maxime

Cheers,
Samuel

