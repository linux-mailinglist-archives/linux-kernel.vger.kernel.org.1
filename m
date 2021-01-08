Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA15B2EEFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbhAHJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:46:05 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37869 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbhAHJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:46:04 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D9012580561;
        Fri,  8 Jan 2021 04:44:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Jan 2021 04:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=t
        TtMNGskLOtyD7vtLn+5d15eH73b6jHQkp3x9E3BXt4=; b=mpQj9E0ih0BacLBI9
        EyBqDyEi4/siFyN3iiI6PUpfUI2mkQz58BL4xQhZI+eSDYt6/jLRbpcA1oBMp5D9
        rX+pMiQtqt5iMcxiha+qpQCX/4oTiIwX7Iqvswmd0gSpDE/oocyMHiiExgGM8bsD
        L8dLLBuhPcuBQMQpuMZfWcHH4Ni7S4FuW12lgc8dimOfd3WbwpUTWCbc8GoEm3SD
        K63Gtk4msfaZ2EOPuFI7ZGKo1xeEzBZ3ypYPj1mVfUDbZhv4legn/2Gq+W61+hFk
        2bfRgjYNaB1/MXl4GL+FaNsb0NBI1qkULH4yN4/qfumijfdrf2ZSUSRL/o4XNMiL
        Qhj+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=tTtMNGskLOtyD7vtLn+5d15eH73b6jHQkp3x9E3BX
        t4=; b=UCn/KRtAmfT8TzrqE3VWYSPzJe5sSsc8mYA7qz9H/Y2f8VaXVCZdzBuqF
        aAs2bAQ7S1xYORf2L6IPA87Ei6Ad/AWx0nOEXYfL6oXWT9aFhmvjEZoMZofwljAY
        eFrY8rt9yjx79KIMehFj8NGI4EnwACaVZqjVhGw66nxvW7A78MR4B84qaBuOQikJ
        cZyO8hBUPO8kTwDTJgYaQz3stFNjBZl7qdPRnfTd5/arUzQ9/vqBkdh3bs9vPwrl
        6EQfi6SSpRfJ4Wp/gxN1j1gZvpCxFjMOnbq/oxj/rnUXRhvxXnwoNoPSAnHheTpU
        h/0MIsJt4i8zZdHf5GlSZ7BU7w3ZQ==
X-ME-Sender: <xms:lyn4X-wnFz6wg11q9hv3PncZtk39Jx2wOJWxhC9i9iaPlPHWZF_FXQ>
    <xme:lyn4X6QjQPtgOV06Di7o9sDPzV4Y76zNnx3k2LdCm5dW4h1lMS_G5XWNwcGrRQqPe
    2mplMhVWt4CSOEjiUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lyn4XwXd5KRLowX-BX3xDL0fqXnsggYrvPJWc8mWEgvdVbTJJ_ahDQ>
    <xmx:lyn4X0gFhC8IRXGlF0eNYw1QY8bpHccykgkuTw_AKX8nE2x4WySuQA>
    <xmx:lyn4XwC0mGIfn9iHK7vu7oZImIr1vf3r_8dQIfgjgcJboTVQHdzB9A>
    <xmx:mSn4X5ILsnD77hT3KMeg3GmckIX8l2N3wys1M9RheFs5NBtLAR7rSw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0807324005E;
        Fri,  8 Jan 2021 04:44:54 -0500 (EST)
Date:   Fri, 8 Jan 2021 10:44:53 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
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
Subject: Re: [PATCH v3 01/10] dt-bindings: irq: sun6i-r: Split the binding
 from sun7i-nmi
Message-ID: <20210108094453.7uk5lj6j6gdmydiw@gilmour>
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210103103101.33603-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Thanks a lot for working on this

I'm fine with the rest of the work, but I have a couple of questions

On Sun, Jan 03, 2021 at 04:30:52AM -0600, Samuel Holland wrote:
> The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
> functionality compared to the sun7i/sun9i NMI controller. Among other
> things, it multiplexes up to 128 interrupts corresponding to (and in
> parallel to) the first 128 GIC SPIs. This means the NMI is no longer the
> lowest-numbered interrupt, since it is SPI 32 or 96 (depending on SoC).
>=20
> To allow access to all multiplexed IRQs, the R_INTC requires a new
> binding where the interrupt number matches the GIC interrupt number.
> For simplicity, copy the three-cell GIC binding; this disambiguates
> interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
> binding (SPI 0) by the number of cells.

It's not really clear to me what the ambiguity is between the NMI and
the SPI 0 interrupt?

In general, it looks like switching to a 3-cell binding with the GIC SPI
value looks weird to me, since the GIC isn't the parent at all of these
interrupts.

If the ambiguity is that a stacked irqchip driver needs to have the same
interrupt number than the GIC, and that the 0 interrupt for the NMI
controller (used by the PMIC) and is actually the 32 (or 96) GIC
interrupt and thus breaks that requirement, can't we fix this in the
driver based on the compatible?

Something like if the interrupt number is 0, with a A31 or newer
compatible, then add the proper offset in sun6i_r_intc_domain_alloc?

Maxime
