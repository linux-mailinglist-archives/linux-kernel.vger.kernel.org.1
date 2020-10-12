Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941AB28BCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbgJLPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:44:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33533 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390227AbgJLPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:44:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CE5E85C012C;
        Mon, 12 Oct 2020 11:44:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 11:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=k8WjplE7TKDeiOHJMijYVwUdqt6
        jZCuTNquxdHTd0/w=; b=FeT6WezKJw4PSkzh7P8odROA4nYlnKkoKXiCsSBdWzp
        cv4wt1oGVgKeUQGYoEz6KikXivl2hkRjPiDGhwTW63pYUPHJqbGolb/SqCWrmBUy
        fCtqeo0/5tB22S/NwJfLV/gu/6bzngdP8JtJfVE6EcklKtrfn6lF6dwNt1PP58E/
        AdwWMTlMFWWccHp0q0AXfS0o+fMCPU5gMeRddu9wP4A57SDrbC/qDpjrJ8CXSqzK
        vpq7GtdfC6o7yXuZy5QiooRZuD0QpPPpqFHlXtaw+sZ336qQ+agYjxJCanbpJmsU
        3Bnbin+fQ1NleU0slkW1gLDTaS2Djze0HrD89nAHEdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=k8Wjpl
        E7TKDeiOHJMijYVwUdqt6jZCuTNquxdHTd0/w=; b=j8RxdLpnFYkhij5+sEMQuQ
        m5tCG6IDJGR/pR+/Jc4bK8rKmXD4W19EBCIiAku4rn6tHMrvGxb7yY5nsXQDP0tJ
        Po/SH9EnK7kXRctQXYo+a+hOF4wij2BM6xyWGDCRuFjvU5ypkKbt4pQFX7u35ZfA
        hC09+w9YO1EPCnWcYj4x81IhQdTrAHHMrsB5X7R/b+7QXkdgga84pGBOhk5ifqvj
        ybvw5ARJ+1ah/Ojk8NKWJZFG2ME1cijUvhdVrtZN57ShrISxQgpwi0GCD8f/SiN3
        m093xngHOKmYbb5QpVLix7Q/XJsN1dPi9vPl5FfDgcmAyeRDzBrxhVEijcPXl41A
        ==
X-ME-Sender: <xms:5XmEX7xSr8qkag6s_GK8Gl3Lu4xs6o_p2aOtwt59vKrAprR9JVw57Q>
    <xme:5XmEXzQ-QWbAiyib33sJur1gKMma3ORiJtPGD49L6SmLFVjVcgFtlwaWhY-IfgKaH
    XBrq7qzZwEwiLYkXWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5XmEX1WM-o5kyqjQ45IpceBm8DaiILxhws0UArJYyYz_ZVTwVjtRYA>
    <xmx:5XmEX1iKAVQ28ZoA3varM_rz52do84ptpnKKOLd0fQFCWwwzWF-8xw>
    <xmx:5XmEX9C7Vjw8gQMLWWaCow6dTiDKVY5QNTn9JjEC4IbvTHzha3DwOg>
    <xmx:5XmEX8Ozy4bIKnBWSLu5N9o6ZJXwbcD7w-CvszqaRkWoS6hOmY3Dww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C05F03280059;
        Mon, 12 Oct 2020 11:44:36 -0400 (EDT)
Date:   Mon, 12 Oct 2020 17:44:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: pinetab: Drop unnecessary
 address/size-cells information
Message-ID: <20201012154435.ayna7dgn5nnetinn@gilmour.lan>
References: <20201011211514.155266-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cn4ygwyl7vrddtdr"
Content-Disposition: inline
In-Reply-To: <20201011211514.155266-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cn4ygwyl7vrddtdr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 11:15:14PM +0200, Cl=E9ment P=E9ron wrote:
> make dtbs_check warm about unknown address/size-cells property in the
> pinetab device-tree.
>=20
> This is because these information are not necessary.
>=20
> Drop them.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Queued as a fix for 5.10

Thanks!
Maxime

--cn4ygwyl7vrddtdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4R54wAKCRDj7w1vZxhR
xenRAQDM1n7LRZJH9FoRcCy16GL7cI3K0XLvqFtcBRyyo1IzyAD/euDk7uh9h1Uz
80aT/6pWuT4KxO4Je4cneMmA6VTavgs=
=/ZI4
-----END PGP SIGNATURE-----

--cn4ygwyl7vrddtdr--
