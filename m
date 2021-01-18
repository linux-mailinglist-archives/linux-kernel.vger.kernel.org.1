Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA672FA4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393396AbhARPi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:38:57 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60627 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406004AbhARPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:34:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id CD7C2580777;
        Mon, 18 Jan 2021 10:34:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Jan 2021 10:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zEV4AIWcoiZrOVbHJMmk0z8fXDP
        z4tgbxNm9kHV5Zhk=; b=PMgiL4XEzB2CzFBZ36vPO5O0c05F0AnOyK0JuanXlYI
        O9UE4HEEPA5kDmfOICOyQUW4S7SFtynbpALJBsNUP3cum3FUs1Tv8pVGVvzv52CE
        qSwciHoSx6qusRk76MD0kkc5IfxXSykxr8KmXEqTtgzAA4GoL3netm1WdmrjQGGp
        QejZ9MSFi+hhWgVAQNdvjfjTJvYOj5lNb4QpM/UtpXUDlxOQo2IdNcTVdI+W8wqF
        ynqLwToAVxul7cBRDvzIVCmR8N4C6oSihOu8XlksDFjiYzsnKqTlWXS5eXGoLvYL
        iPLt8SRv/AR47R1xWJ+hOuXlVGGf75cAINo0h7nBfUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zEV4AI
        WcoiZrOVbHJMmk0z8fXDPz4tgbxNm9kHV5Zhk=; b=sCzn3TUtj5iYiY3dPh+fr7
        2dicY0rztHeI6RXUm6mV+KSMi6Dcm50br5WQJSRb8FkYK7KrtYb09NhjRGnbgdRd
        lcMSpHUDEQ6OjtTdTgDUth2tpFyyJ0fNyJv4M42eMQn7pb7PZ9hhzPKc/xTUFVFQ
        c5wWzu0l3E1/MS4Ya4/2At4i0hc1AhMZvj2unt57tf7ZX0G+Ag/vzYJUxD2n0rEq
        K6Km7m68g3tLpY9gc5xsK7aSyiUq0BxlwwUxX2Ev60a4S8ARw2C+xiKW8qwNBSQT
        P84+g317SaJkppBG9xwx4mIXIdudixrfKnLAGBZ9OOyXq/EtYhlVkr78JikOxV2Q
        ==
X-ME-Sender: <xms:aKoFYDH9iEPtqHEqh4zn7LO3OOB3HbgEZZt63jdNVcmgo7c1In5fUw>
    <xme:aKoFYJ-GjpcIUQATNpX0XZFXkErgkbKrcrHNj4e69Y_gSUYoG0Aia0sZNGlnHA37v
    OdTou_Mb6GnBfOHrgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aKoFYFIjCEMQVBuLRYYHM7daAGoVGtoB8vW2UFvHnSJLtFBdaFhFpQ>
    <xmx:aKoFYEa-SLqZFOP0DqvdvGN9w5kPYggYM9vHqhPvFTbuK1Fb-A080w>
    <xmx:aKoFYHJrPrF3MMyho5CIKz8hf0opuRCaW8g0MUAOZJyN5F-SgoNZ9Q>
    <xmx:aKoFYBf_gzzaqseOFsrenNrgg6Sp58Sp-KllsyjiV-XMqfiWeKJtNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BB6D24005C;
        Mon, 18 Jan 2021 10:34:00 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:33:59 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 16/21] phy: sun4i-usb: Add support for the H616 USB PHY
Message-ID: <20210118153359.xeen6ejv74xreu3a@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-17-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i77g547vq4vyvw2u"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-17-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i77g547vq4vyvw2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:43AM +0000, Andre Przywara wrote:
> The USB PHY used in the Allwinner H616 SoC inherits some traits from its
> various predecessors: it has four full PHYs like the H3, needs some
> extra bits to be set like the H6, and clears a different bit in the
> PMU_UNK1 register like the A100.
>=20
> Name all those properties in a new config struct and assign a new
> compatible name to it.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--i77g547vq4vyvw2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWqZwAKCRDj7w1vZxhR
xW5YAQD7SSQ/gs38FhQp1T/Q/IO0aInJ894sAVdeJb0sGSWQOgD9Gg4PbmYkOs41
mZysMoppKT9Fz/aLBxFHDvYhLJaJAAo=
=nN+h
-----END PGP SIGNATURE-----

--i77g547vq4vyvw2u--
