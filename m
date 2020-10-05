Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337162831D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJEIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:22:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50661 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgJEIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:22:47 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 568295C009D;
        Mon,  5 Oct 2020 04:22:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 04:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=144E1nORHU6Bi8RuTX18+KNYJSQ
        CiEOAZG3PvFOe/rg=; b=QF13/8vx/MPgHH/SbSRNgxR2VPugP5QCSaQMowgymL7
        cS7n92a5r9SORGM8+waS+B6d1Mbv4JCeiFW9d6OLvIUdh6bT6ef+6V7onMp+CBll
        fT2DVAXMr2tMti4yXN2dPRwxELc80Wf8o8gQt1PyZFFaEwpW9GPjtVhbdUDVqVes
        hJnbepYmp5AD4SjOis50SVgQSUIL1Z0No05LAyJrIIkjsysBp9Ym/e9SE/pV2ydI
        RA7fWyRCnwzuSh0Ca7nkNgWJZRluDixjzIeyuNBW5WVavVZlGI5Stldv3wTP/p4/
        xYHiPdZMQu8EkHUkQs/XKniSKaol0V4JhDG67o1btpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=144E1n
        ORHU6Bi8RuTX18+KNYJSQCiEOAZG3PvFOe/rg=; b=NKo8VrA3uArRcP4fBIICj0
        hMBEEqPfeCh/JttBfA87bZVBd9Nqzo9iHXbBJxMMQZZj1OnWK5sqsoT0RVyeAGLo
        7MEpkY9liSirzdZfWEGQHLiTHpM3EVMbagPGiKAcYNmAUtFY0L+Atke3WczFrS45
        WDO/wGgzqa0zRaOKGgAT7DPmeNR/0N6MiyGCkEHRRRo8C/RycxGgpJVz9y67y9+p
        /hbLdlHCSjG2h3KXh7oSWYqsNvgoa0aYei5Dw/vdLcAFtDSBbdsBjYh8tOSWBt3N
        vls+ggj0HT18A0wqeBgZEx5SgHXTCm/lxUg16Gkp3dR9KsLjl4I+nqAybnILIGyA
        ==
X-ME-Sender: <xms:1dd6X3lEAhDjkQeyUelTPbiGkofB6o3pNkusx97Iwks_l-CsnnDzPA>
    <xme:1dd6X635_S_ERr8q-GO9dNep-_WmGAfwZ-8rsa5pI_M8X1ssBmPGdCq0E94jKiU02
    VEircHmlH_w31wTYbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1dd6X9oUUcblLQEO8JGjSJxYcH8QR3SLnH0EedPYoFaW1aJgGchqvg>
    <xmx:1dd6X_koHdMtyauXz1S3WAiAxfEsPaYJd-hOJwLQCeIY_pEnZF1rBw>
    <xmx:1dd6X13sCQZHV9UCeBp3iL8kfEGplz_8GBQqgXYiHuTgOABA6cSA4A>
    <xmx:1td6X9-Y7oHG9MouGi1dYcQhyr2MIvt_78g3nSnv7cxOZ2xJhNWmbA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB9793280063;
        Mon,  5 Oct 2020 04:22:44 -0400 (EDT)
Date:   Mon, 5 Oct 2020 10:22:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] Try to fix DT schema problems for V3-series DTs
Message-ID: <20201005082242.l472pdzlvetviqnh@gilmour.lan>
References: <20201003234842.1121077-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="enchfjewrm6jusjp"
Content-Disposition: inline
In-Reply-To: <20201003234842.1121077-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enchfjewrm6jusjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2020 at 07:48:42AM +0800, Icenowy Zheng wrote:
> This patchset tries to fix DT schema verification errors that exist in
> V3-series device trees.
>=20
> The first patch drops bogus properties that is not needed in PineCube
> DT, and the second one adds compatible to the binding.
>=20
> Icenowy Zheng (2):
>   ARM: dts: sun8i: s3: drop bogus cells for CSI subnode on PineCube
>   dt-bindings: sram: sunxi-sram: add V3s compatible string

Squashed the first one and applied the second, thanks!
Maxime

--enchfjewrm6jusjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rX0gAKCRDj7w1vZxhR
xVyMAQCsTeJd42SblbuSgz65lzJaD1Bx4i1I6ZntEAzEPHcx8wD/eQLFAAQesNm8
tg5QKOLRIuP3BTaH55ov64VhUkA8sQA=
=fLzg
-----END PGP SIGNATURE-----

--enchfjewrm6jusjp--
