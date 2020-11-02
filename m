Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003582A30DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKBRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:06:54 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44779 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbgKBRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 67953EB1;
        Mon,  2 Nov 2020 12:06:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 12:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=uLJUrvpF319aY4AhzM7riVobLoy
        Kzicn9yfJOYNVd1o=; b=k4nWLTvgApzLaYFjOL5MXWO/B1gMmrqlGiWxjcOgyC0
        v+wN4m6kDFfVv2Qju/11ebFNPPHyZK2c+6qiOyCpfW9+vYzJ+4tNAH26S2TxxmvB
        7JcJIWJC+1c6iBhGH0NWvEaFLfcvXw0nWzGwSpmmuWLz3yIWMlICXeAoIThGv8r+
        p5+7ilOeFRRG2J3BoDOSN1vo5XXTac3U1UTiuWUlZDTY2gNLDTfXL9mDZvc2/wd3
        X5nigwSnKefZG5lDMN+6vfdDIuqSVACi/M2E6t8AwIaEnzgUNkxe5UrniR9sZLXK
        VAAvWGdpd/ainEM69qD/dt1esHKT53lxxgaAAD8uCMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uLJUrv
        pF319aY4AhzM7riVobLoyKzicn9yfJOYNVd1o=; b=MB6qZxQVv/8NG2yhowVe32
        l902PSY7ftZs0k4VGjJt63OiRGm4GHE2ynxv6ketc5wIIWLeXqk24PsADOa7ZKVK
        8mP0sLcP/zPEfcpPUIsNkVIo2+Y/x0EclVVZPErlWPnanSj9wiH+6Zr3Lf6YrluT
        rEH7XlScdOIbe5daDrXJ9GetFx/U+mmu+a5V0CuVXSNCjjHwMaba/Oe9+oYH/JXw
        mCLnDKK90dIWsJHtkHCydy7qK2punDJG3ZFgANkeJd2QBNW+s412IsTifmyfyXSZ
        ZZiBtWQ5o4SN5AebJzQCZMGPDnE571o4KI91KGQX/vchmwTDN9BL0KrgTHtHhPUg
        ==
X-ME-Sender: <xms:qjygXxuspPppaRy1TAFQCVh3MFpqMmA-NwvMH0TAa69k5HzIB-z3Rw>
    <xme:qjygX6ellwWq-0Q4p1ctqLTeuyvw54XFpIi8hwrLEjCCvK71y7lnyjuG0lIj-QB0V
    wruUY1RQCzlSSUCutA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qjygX0zquR9PgtWS12THzA9zlqjVjcp_CZDfCRddpwyEEKZGjvobvQ>
    <xmx:qjygX4N2nLUbD3T7dLNbO2U3SIKcBCCQAjJNtjVMkb98XyQPUUbdPg>
    <xmx:qjygXx_sH_0dMWO3gi_m8SRRMcgqo4MqTGGM_caV1Dgij9wPTL0irw>
    <xmx:rDygXxxO0bSgPUXA04EWEQ37JVt-jenQeVQayDqOlSO356Sc5W3PRw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD8EE328005A;
        Mon,  2 Nov 2020 12:06:49 -0500 (EST)
Date:   Mon, 2 Nov 2020 18:06:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on
 Ethernet PHY
Message-ID: <20201102170648.64w3annfe72ppakn@gilmour.lan>
References: <1604326600-39544-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="coo27kwkpohhsfqz"
Content-Disposition: inline
In-Reply-To: <1604326600-39544-1-git-send-email-pgreco@centosproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--coo27kwkpohhsfqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:16:40AM -0300, Pablo Greco wrote:
> The Ethernet PHY on the Bananapi M1 has the RX and TX delays enabled on
> the PHY, using pull-ups on the RXDLY and TXDLY pins.
>=20
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
>=20
> Fixes: 8a5b272fbf44 ("ARM: dts: sun7i: Add Banana Pi board")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Applied thanks!
Maxime

--coo27kwkpohhsfqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6A8pwAKCRDj7w1vZxhR
xX+yAP4nc1OpLwJbroeYz9j10cZwGP2/JJSHUW9IPS8fBqtVcQD9Fm8DM/6XZDeK
N7iU/x6BV0xH6+LdIdLypwqEDKkpEg8=
=PFUp
-----END PGP SIGNATURE-----

--coo27kwkpohhsfqz--
