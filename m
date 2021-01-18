Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F62F9C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbhARJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:23:08 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57777 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388420AbhARJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:13:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D89E2135F;
        Mon, 18 Jan 2021 04:11:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Jan 2021 04:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+SBL1gY+jQ03Zxdw/U2FwonJEj2
        kkbMC/Uq8/Ow8Sco=; b=Au0da3PnRsK8SESzkw6VKx1eyFztH9hPx7f11kR4JgI
        RcCkzOalXtHJL/2CNJRBl96sbSVsjyD3OnwurtaW5z8TDQjnkiivtSStKA9OxmeA
        DLgSY2qSenjjSMLlLfc5O+uECffE78+AN9s5HoKK2rYpcI8f5Lj2hLsiup0CDoPz
        rlaXSymqXS88J9Hmibb3jvuCZxNgYjZvAt2F0HWdFDHWP7kDyjXvLIxgeO4FZK2Z
        JuOLInL/YfdL2GRg/+k6jN2AxkhI7KCovdaF1w+SMA43qFedTDCluGB/DsH3rjW3
        KNN6fauIjJXqkwsQR2/S1zmI+MH7qgCeqJRknDBQAFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+SBL1g
        Y+jQ03Zxdw/U2FwonJEj2kkbMC/Uq8/Ow8Sco=; b=puBMouY9T2z2KqQ38zm74s
        iZIiPBQpv/7b6wGG4D/2oSUSdQQJp0xmuWStygrNZGS77Rt3MUySAhx91IIFUG39
        f4hMl1xH0klIFnufFaDmISdgqCjje7X7WFcd0rFsDp+hDAhYhgFEg+I3ACgFi7BS
        wRkW8GX6hpJauHfW4uKE9gJPHiJZt2bUIeV42davunhnhpZv8v+nCd5FoE2mxiif
        geqHFFxQVcsRMERqDbKKO/X/5hCrZ6cGAMnQNXAigxsVr7G5DItKr24C/uJeIz8s
        MJlQV+ACsVlI7XR+81WzN7xKOrXpc2ALw6iHF3W1Uh0D9Mrib3Bplw2gD7+FWMAA
        ==
X-ME-Sender: <xms:vFAFYISgDhWDXE19wdvwzVbke4J2gmPY9bLXY8RkVOp8NJ7ymbk0KQ>
    <xme:vFAFYFwMF9WX8kRY60pb5IHXpwdBr8KcjhP4soM_3Cs6r8qaGqonrwXHEyG_kxZ6l
    RWjrb7HCbWKBttLinE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vFAFYF1DG5T8IssAztbA-J0wHt295HSUNkV4WW9NoG5bNOUIz14MTw>
    <xmx:vFAFYMCowJIuZulGn4NrRnTPPUI-fdU85SzmJUtZsKTe1uRdC8tBXQ>
    <xmx:vFAFYBge6ODUERbY22CijfEXwJ04SpOZaB2ONzE4Pe50G_0i5cgRQQ>
    <xmx:vFAFYBfkTWxlGfbK7Mt-K-x2FKXeZT13v27wHVrA7i_p_LVoRuW-5Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 112B11080057;
        Mon, 18 Jan 2021 04:11:23 -0500 (EST)
Date:   Mon, 18 Jan 2021 10:11:22 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: h2-plus: bananapi-m2-zero: Increase BT
 UART speed
Message-ID: <20210118091122.k6jolfna5cskdwva@gilmour>
References: <20210116103710.245617-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajctxrre2mco3c3o"
Content-Disposition: inline
In-Reply-To: <20210116103710.245617-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajctxrre2mco3c3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 16, 2021 at 11:37:10AM +0100, Jernej Skrabec wrote:
> Bluetooth module on BananaPi M2 Zero can also be used for streaming
> audio. However, for that case higher UART speed is required.
>=20
> Add a max-speed property.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks

Maxime

--ajctxrre2mco3c3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAVQugAKCRDj7w1vZxhR
xbrLAP9SvgvMWwxU+veIJLg51Y170F5m8hJxfQ31ybedPBQc2wEA1MLtBrdqTpAM
8xQy1ihxAXqVZAh1sQ9zvGfmm4er4wA=
=y2jw
-----END PGP SIGNATURE-----

--ajctxrre2mco3c3o--
