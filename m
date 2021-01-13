Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF292F46F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbhAMI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:58:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50919 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbhAMI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:58:37 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 387175C03E8;
        Wed, 13 Jan 2021 03:57:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 13 Jan 2021 03:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UOvpylTFBHcb6wV7RUAlGcRLgch
        DGCCF4vrolkr/AD4=; b=shdc1Dq+AVihbve606zEZuyBUbTDzBdgA+7khMDUIAR
        l0ssrTB2o3tChN+h4meLHlEMKMKdDeGohh/g3EPPaz7ItbETz1xb/f1ucNkH4AS4
        BNM5LZhpsfG+HxCZwtAtfEwW0KS6yNKZZ+a7+C1Wy7h/ucks9NucUVto/AvfQuWp
        zDojJ4094x/Zt7qUWpwSoU8A8mmRkN0uR32ZelaWQ6X0lfuu/jo8hHD9jebmiMKF
        dqrhk4T2YeAs5Oc9pi2ZqWuZw5DJwY3/q4bRTQTvmNfSAAdmI6MzrIgAf5FiOrVV
        SAvYL1Mi9jez5X1LAr7zA6c9LHjA+/8QQy+I37yAu3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UOvpyl
        TFBHcb6wV7RUAlGcRLgchDGCCF4vrolkr/AD4=; b=a90wmmVUYx+Gf1XkaMnDLw
        ZSmn/yZDMob4O3DGCzUDSJPpaV9Ra2UfF+eHQH5LHfqh5OmtuW+5zLn9XULjqAHj
        AhRxGyPlJAIn+Gq+PDCIKbOx3dK+lfciPQI8N9h+dFMa8boTRVSMwngcc72b6v7x
        oedxzHLfO4ZT/CLNa+Kxi7+7TTLTMXWTBBQ5pVsGfSwktAO5WR5wdWAIM70SnGj0
        PKIkjbIjcVfk6qCk6kkmMeEZZYsnrY6SpDyWDCfKYSuTfku1QKe0ZjaaZdLnsR01
        7mDBWmLK0fX87JBXYI/OTCly+YrQVj58w6XJOoITQO0EBfv4/M2M8/vmPMLhoUYg
        ==
X-ME-Sender: <xms:-rX-X_aIQmwMaC2L_oQ9GgijgL91sY5q6jh46wK_IVF0dGKlKdzyLA>
    <xme:-rX-X-ZwH74qyZXMHT-Y5kcTkfIqhHCBe7ntr42ofEgn3JRwOE_VVpQIWf-kRJxPs
    HH5pxLyftMo3t8qIBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:-rX-Xx8OOrIDAlWHLBGfMLpRinLBhT8UtsMiQx3-DlxL-OpiPywUEA>
    <xmx:-rX-X1pJ3zbgc_MgoUI_H6P-bE86XpXe2gcVzpH19Iyf6ujgfGe5bg>
    <xmx:-rX-X6rbNOC3BSjtrUCEfmGhrUhCnND6UjdTZv57BVNboOGS3pkvEw>
    <xmx:-7X-XzlTYP-x_c7A3cZBKRN7fcf8YzTukOHJXwBQdv3zE_XURwwbJw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A4C11080059;
        Wed, 13 Jan 2021 03:57:29 -0500 (EST)
Date:   Wed, 13 Jan 2021 09:57:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: PineH64 model B: Add bluetooth
Message-ID: <20210113085728.5zoyva2xgui2p6fb@gilmour>
References: <20210110211606.3733056-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uh3qaqwnoytcsyvw"
Content-Disposition: inline
In-Reply-To: <20210110211606.3733056-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uh3qaqwnoytcsyvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 10, 2021 at 10:16:06PM +0100, Jernej Skrabec wrote:
> PineH64 model B has wifi+bt combo module. Wifi is already supported, so
> lets add also bluetooth node.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks
Maxime

--uh3qaqwnoytcsyvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/61+AAKCRDj7w1vZxhR
xbKIAQDPgxJaFmc9FuZRVPmO0Y0lJ4pVGKLNZ1f8XIXdU1yM6AD+NROKgl76wxKQ
Pw24DuAe/1IWiHgSy3Km4lZ3jdbubAk=
=38gt
-----END PGP SIGNATURE-----

--uh3qaqwnoytcsyvw--
