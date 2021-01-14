Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4122F60F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbhANMRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:17:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45277 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbhANMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:17:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 604A113A5;
        Thu, 14 Jan 2021 07:16:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 07:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3Ag0xDZDJJDpScu1QNNpjHOhB8+
        xQOGIpIIJQtqIZRU=; b=kkgYzpUJA5tHA0nv4oE+6J+vdXw3Ub1nVdyXQSwaRVQ
        5qCMtWOUalhBrQFXFGKpVOMLVjOKbrg8UQyrQglJp+DSt750qfL460GY2Y8NeyKw
        YqfLaIw5o4lx3Rs66VHBMrBsSLW0mASGLOaEwmYk77ixkucbPrAs8p+9GRmerFiC
        +s3FUDqe4pZEcSMuIWvaOxNTsEW+0yV7yith29eLDmfpFNt/rRGyEkKaOfK6j1C2
        CkSuktYNZRsWbN2jD2d4wFWaI2O9vBOEYiBMNTt6Cf0+BkWhMACn0JIDzWA2WUCl
        CrxESmBIYGFtM2jgJ3NAeawj4gHyK6Vi/RMpf452Qmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3Ag0xD
        ZDJJDpScu1QNNpjHOhB8+xQOGIpIIJQtqIZRU=; b=JRzZaL7+VSqqgG1ttTQk0v
        dY6SQV2qeKB/ZiHOHLs3DvhG/Cqt8kMNrmToXomxXm4r8oPfl+34RuqjwQUYG9Gy
        SsWCC3WKkM+vRPTo+Wnk9TpdMgYT7RRYOPCyAxN9iMrI0duBZlxM3woW7KBRoCjD
        yr9BVCYFhDxsxFg3ukP9BWbSey69HVe3tNV6LrUR9s2knyOvrBbPhPyJDn65B3gZ
        eBd97eReEh8VUW0PgtAUkheVwgMoX5afG73OuML8je7i3g2u0foH3UD/gEW+b4gG
        QJSrrkoMcyH4E82Mc+1gsLLlcsV4E38A7GuWm+L5KfRL9qaK9RtSknEJBKF1bNow
        ==
X-ME-Sender: <xms:HzYAYJg8nmKdt3S5xK6A6HCfAjZQ6ddBLPsm4deBOwFBd7M0cd-4Nw>
    <xme:HzYAYOB45hv_0EHjJAmJ9lDqASCNisDRZVvFWUVaMnpy-vhtYvjjNZ73PysD7IWSm
    oLIGsMMHh5wd1y1B60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HzYAYJEPm5c8ouLSfy8go3cYv1QWU3RDKf9N_-7vpA2u8FwTUAmTDw>
    <xmx:HzYAYORSkTmEaT7WZv5WDvWVnqfadPjRpWId1uSLFDMV_pQYPyLDAA>
    <xmx:HzYAYGznzHGSIqNN8XhQCBdeeZbO5z2iDOCb7oL60f0mGfw-oWqnYg>
    <xmx:IDYAYBz7X5pkI5j_bEuKweHHBFZyHawZmlJz9RwWTUUMGG65YrdubA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A3D4B240062;
        Thu, 14 Jan 2021 07:16:31 -0500 (EST)
Date:   Thu, 14 Jan 2021 13:16:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] sunxi: Support IRQ wakeup from deep sleep
Message-ID: <20210114121630.t62p34smv5zlidl2@gilmour>
References: <20210112055950.21209-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2tgn3qtuqtglz5y3"
Content-Disposition: inline
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2tgn3qtuqtglz5y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 11:59:40PM -0600, Samuel Holland wrote:
> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
>=20
> This series replaces the existing chained irqchip driver that could only
> control the NMI, with a stacked irqchip driver that also provides wakeup
> capability for those multiplexed SPI IRQs. The idea is to preconfigure
> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
> as soon as it receives an IRQ. It can also decide how deep it can
> suspend based on the enabled wakeup IRQs.
>=20
> As future work, it may be useful to do the chained->stacked conversion
> on the sunxi-nmi driver as well.
>=20
> Patches 1-2 add the new bindings.
> Patch 3 adds the new driver.
> Patch 4 adds wakeup capability.
> Remaining patches update the device trees to use R_INTC where beneficial.
>=20
> With appropriate firmware and configuration, this series allows waking
> from (and it has been tested with) the RTC, NMI/PMIC (power button, A/C
> plug, etc.), all GPIO ports (button, lid switch, modem, etc.), LRADC,
> and UARTs. I have tested this patch set on the H3, A64, H5, and H6 SoCs.

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--2tgn3qtuqtglz5y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAA2HgAKCRDj7w1vZxhR
xQh3AQD6XtIvWKtyOViqkNzCFhWteyGB2pagOcYAiqU8YWMjUAD8DBXOAOOSlz3N
7kble8hHsKjZ4p4cz6+B3ODUQJ8dawA=
=U5/e
-----END PGP SIGNATURE-----

--2tgn3qtuqtglz5y3--
