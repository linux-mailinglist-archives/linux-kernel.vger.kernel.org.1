Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E625E2F9C69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbhARJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:22:38 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35309 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388113AbhARJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:13:34 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A73745BF;
        Mon, 18 Jan 2021 04:11:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Jan 2021 04:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sNatjfCCJ4k/1qMlePtHKBU6lZX
        7A1FzNnd0WJpbQ9c=; b=lBR/cYFAjSO5wPKgXiNaMQftufE2Mj0zewsjAxG2aiM
        Nu0sq3vn/RGQ5nVb1j6Aym0/N10JdJlK/RUlPkjJsSXRUIligL5c68N70rAWpXxo
        vDUFAAhAg8drljlZVHvLBgwP/RZtxEzVSOoUvqpJSAT/4G3Lli8b2Gg0SWHAOQEO
        h0cVJkeVV9iaEmoC6lLpnkt9ipIq2IplYwZjsWoJKZCJ/PttykMfbV2WXBXhusTI
        mgcpZqrbeUL/uyYL9r+MaFQlyk6r0S3dDE20ZCnWRt7texUsQpbid6klf70Ca1hz
        ZNXTvUVQKpX1PTHictbHQ1ffWSyqJCL3SVrb7nZOKQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sNatjf
        CCJ4k/1qMlePtHKBU6lZX7A1FzNnd0WJpbQ9c=; b=SD2K89zx5/SBUaDYivVOM9
        RZ1HCjJ0oMVxHu/NFNtAJOqjOMFrvl+0vsFZ94BgAWit6+R72GfAPzh0jR3LKZn9
        l94CQpxTSO5F78YlIh+gU28X1qXh4wmMYMUMEd1mka4QG024dK4oJVGjFawz+twq
        MT7YmX0e+WarEkd5bU8vB0FTKLlQr1di/TPy5K4V1BmPlD1T8V2qeWoehKmMKcuz
        aorWy4A9Yf9usQd4iwELDh3Ufo3qc2WUs7UNuEntB6A4vexP/iX16B0ev+GfseKx
        YCIvxOA7pnaRMbXFjX+MZLiu0+2/Yh9rSHsG6Q2fvy5yTY9ZTKkvty3nQ+7VIMKQ
        ==
X-ME-Sender: <xms:qVAFYMHlLQAg8T5b4aiekBc34q6XvabuqCdn78qCQVCRJtugxYqR-g>
    <xme:qVAFYOxuIylYXS0qxIsw7S7k9VSuiOpbJii_C1jVsevidDNj7VjDMf5OEhx1WMB8c
    dCRAgXbCKfZ4q_ZP34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qVAFYFuQ5JHywchM-9AEwqCtKD5fuzaP-N4wn_QRRkYemWPMJaayTQ>
    <xmx:qVAFYD1M0v01S7Q4w-avVSAzE3ZjpwlYRYkY11LC4EeMq9zqC-tjUA>
    <xmx:qVAFYI8qckxQMdvGWtPTFDaY-0xkdnN5Pj8XbRiTEZhxKxCkZh_XyA>
    <xmx:qlAFYIGxwJ3_I4rSHLycYodoxsfys7kI-L-TgCJsDyFW7OfTGdGzQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 737D11080059;
        Mon, 18 Jan 2021 04:11:05 -0500 (EST)
Date:   Mon, 18 Jan 2021 10:11:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sunxi: bananapi-m2-plus: Increase BT UART speed
Message-ID: <20210118091103.rgsu7zf2ogauu5dw@gilmour>
References: <20210116105228.847073-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otdlbzqmmunyr6or"
Content-Disposition: inline
In-Reply-To: <20210116105228.847073-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--otdlbzqmmunyr6or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 16, 2021 at 11:52:28AM +0100, Jernej Skrabec wrote:
> Bluetooth module on BananaPi M2 Plus can also be used for streaming
> audio. However, for that case higher UART speed is required.
>=20
> Add a max-speed property.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks
Maxime

--otdlbzqmmunyr6or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAVQpwAKCRDj7w1vZxhR
xSqzAP4+Ezgu9kD31iiMrK7nhOH8gkPj1reKeVKAAzNcJ//ZmAEAn/2zgNoydPl5
1p6LXsRq3zVBcn2FYU87C97XnINTngk=
=sMgx
-----END PGP SIGNATURE-----

--otdlbzqmmunyr6or--
