Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC84B3000AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbhAVKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:50:14 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36743 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbhAVKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:48:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B4CE91719;
        Fri, 22 Jan 2021 05:47:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Jan 2021 05:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TuLz8uyT/KsWR+GLOl1HI6AK7nd
        v/I2HMlxYHOPNOxQ=; b=uu1yGzRJ4IvXW0i0Y9Z4///3SXnTtMXGMVqc53Y8Zrr
        fotYuWK0kTA02pEk71tSYANAJtNAGcVu6YHMZn3z1MZw+INFO2TfUFVEWHV1WpB3
        63gBRgNIdWl38gYEw1GwGDGCL4JDxsbhWNBpFLuXSvfjS7MhagD2PlrDnkV649Qm
        7uo1D3gOWkIvPRp7EtY1fjI2e3NG5Od+fNuCHEoo1EUlSbnHZinUQ3dqLUtUw7qD
        xUGRu4YPBNYWtlLx2AdLCctLfFvr+9rXfc0Mo+9ip/xj1cMsrEaNhhYZnmBVJ9XP
        HagurlFWjTIqlsLTY9jR6OqJconA0y7eUJ8sjnHXS2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TuLz8u
        yT/KsWR+GLOl1HI6AK7ndv/I2HMlxYHOPNOxQ=; b=V6AG+QBXg0kci+LdLwA7Sa
        HPBFXJndc2RzFaYsF3TK4Rquanm093BEYCPeo/vSB6m2RrzffTsMqTHwQVQJYYu8
        cnsFZMvv65tCfa5tQzFjVA6FE4meYDzMrS+1B/HuV7BnaBhlJ0PolJwyp0o+Ufyl
        qMdCbz/8UZIKC0xYg8Wea6AS4czCtFynVpg/6YIKhV1eVE+gDoPkApx0pxQjYyMX
        wD6ueKVHykqWzVYlUn7Vdhr5ofNZjayoNu+0Hlbf1uAXcY+7SRFhS/aW4Xk25eK0
        4c8RqfS3H6IgYEGzHbNORUnGNYWGr4+PkjKodZXHN58UqnKYmgZnheaXfTQwTytA
        ==
X-ME-Sender: <xms:LK0KYCrKIvwC1wuRdSGLCbouRYc8rTO4teS3X1eFswyyzL2fdL2guw>
    <xme:LK0KYArsH6-X15HN9zeJ23EbmhyZha6ausgrwfYz034YHo0j0b7h1CQcOeufX5o_4
    EYi5qlbjaICP-jLEF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LK0KYHPUQHsnteEKCpqJXJ7U6suuZ5lXSVKnOgrTYHP8ee6EXsFcJw>
    <xmx:LK0KYB4zYZLywfUaXs5Uq5cJqLRW_AeQlD4FYF5LFF8ngYZ3sC6yaw>
    <xmx:LK0KYB58OwfYelivVrtIOKLV4jt6E6Wrf52POsBAvaviqf2RWkLiOA>
    <xmx:La0KYMaM5F1QWHLE1CgiZtxGODpdp2ciQGNRrUrbb2Pr_y7VDymeCw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC47224005C;
        Fri, 22 Jan 2021 05:47:07 -0500 (EST)
Date:   Fri, 22 Jan 2021 11:47:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Message-ID: <20210122104705.bo2x22ef56hdj26q@gilmour>
References: <20210118055040.21910-1-samuel@sholland.org>
 <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
 <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6nduqjefy55djukm"
Content-Disposition: inline
In-Reply-To: <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6nduqjefy55djukm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 07:33:54PM -0600, Samuel Holland wrote:
> On 1/21/21 2:35 PM, Marc Zyngier wrote:
> > On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
> >> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
> >> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handl=
es
> >> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
> >> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
> >> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
> >>
> >> This series replaces the existing chained irqchip driver that could on=
ly
> >> control the NMI, with a stacked irqchip driver that also provides wake=
up
> >> capability for those multiplexed SPI IRQs. The idea is to preconfigure
> >> the ARISC's IRQ controller, and then the ARISC firmware knows to wake =
up
> >> as soon as it receives an IRQ. It can also decide how deep it can
> >> suspend based on the enabled wakeup IRQs.
> >>
> >> [...]
> >=20
> > Applied to irq/irqchip-5.12, thanks!
> >=20
> > [01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
> >         commit: ad6b47cdef760410311f41876b21eb0c6fda4717
> > [02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
> >         commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
> > [03/10] irqchip/sun6i-r: Use a stacked irqchip driver
> >         commit: 4e34614636b31747b190488240a95647c227021f
> > [04/10] irqchip/sun6i-r: Add wakeup support
> >         commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003
> >=20
> > Please route the dts patches via the soc tree. Also, I had to
> > manually fix the first patch as it wouldn't apply on top of
> > 5.11-rc4 (which tree has it been diffed against?). Please
> > check that the resolution is correct.
>=20
> This series was based on sunxi/for-next, which contains commit
> 752b0aac99c7 ("dt-bindings: irq: sun7i-nmi: Add binding documentation
> for the V3s NMI")[1].

I assume merging the DT bits alone would break things? If so, I guess we
can wait for 5.12 to be released before merging it

Maxime

--6nduqjefy55djukm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAqtKQAKCRDj7w1vZxhR
xXIiAQCF77s6vDL5LxjULCf7wDCYyp/5nflTWRqwSN4qMhpvTQD/eM8WCGM/ggUS
0IkX6WMGWFm2/SO55RdvBY1Q7p/sqgc=
=lbbe
-----END PGP SIGNATURE-----

--6nduqjefy55djukm--
