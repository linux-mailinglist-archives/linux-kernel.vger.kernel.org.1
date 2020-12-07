Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFB2D0D06
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgLGJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:30:23 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37267 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbgLGJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:30:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 00603DF3;
        Mon,  7 Dec 2020 04:29:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 07 Dec 2020 04:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=vbF8WW7CyrcnZrNWHTuh2+g4Y8D
        NKb3GWebWG/hH5AQ=; b=RY6+FWXVA1YNnwVsl6Zg6wDacS7/4O0ZNfEuBpzQ2Q6
        L+TJyqZRGoA5wW0cUWvxCPmsnujZvfIApX7G7UDPePCLDhhpWUKV6Rq2zNwfky32
        QzSZCJUBLChNJj4YQEPsKskEwQNEKII60gtK5A7FycGpnqc0ZLOUGV0Rp8DcLH2v
        KF5UkUHTfOq6TrzgKw5w74uHRn4MIyZf/t6GaYSPwU5vF76VqRqs6n9CtWeH1ZSC
        y4iiIyIy4rOIRBJv3hWqIpF+RnUqlhQV7RWmfbM/2R9yDga+Z2LzROK9XhDfl791
        wBrdgN5ZWKXClWAyejFxqsoSe1wF28EAnjvbBuSsARA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vbF8WW
        7CyrcnZrNWHTuh2+g4Y8DNKb3GWebWG/hH5AQ=; b=DH7X4j4XG1ULQLJ/Kx5QXz
        9PZCcSBq+TVAKsJhBelY7v0XzIwMofk0thaQgMz2+PuQwwT7e9aYjpm1RbhoeAdb
        jJM3eshs6E//vJl/0lDGAiEDykFY8b3hoX551bOuJg86hGBNMpzRy3mP1dr1Z1tu
        u5WlQDiD87xnpOEPq1Pj/82m6g8Qsm1S1tjfr13/wiD8ohKSRYPufLVwkt3SmEuN
        TkmWteWpnuJb5uPxRDu/XyfF4xDJppsZ0BdzJ5/lktLQZw3xXGmlVHq4BBcpBbqJ
        xVW2Q7Qz6d70R+CYe976wdz2PaDX7GrSzEgwBUfm1IoBYxRS3ba239d/apk23vJw
        ==
X-ME-Sender: <xms:6_XNXxZfKcVDx2yOrxSBXJ2HcFW2rvt5vKF_HAlnuooTqE3T44KJuA>
    <xme:6_XNX8sr63fiE07A1jC9RlvSmxnYxwpAQIDPggwllpUN2AISxiNsniQStHjoX655Q
    w5aUP_c7KSBbvnmriI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnheptdeugeelfffhveehjeel
    udeugeeuiedvudevfeehhfegtdffheegiedvgfettdetnecuffhomhgrihhnpehgihhtsg
    hoohhkrdhiohdpghhoohhglhgvrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6_XNXzG6Mp2RSU5CFGnbQ7EYSwKtW2edWipqdXftdZeX9r4IyqiQFg>
    <xmx:6_XNX3xE31bx39IbkGY4Ls4ognxKHrMjNgNgw0qMk6BirZy2xYVeMg>
    <xmx:6_XNXyiZZXNvFr76YxulH-6TbzwwnkW9u4bvlWGIPqN_A3gmsJvcRw>
    <xmx:7PXNX3R7Swobb_uuPPdVfmUlKTmB0BxFScTfmuj5-jxASB2SMXePtA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43A051080064;
        Mon,  7 Dec 2020 04:29:15 -0500 (EST)
Date:   Mon, 7 Dec 2020 10:29:14 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun6i-a31s-sinovoip-bpi-m2: add gpio-line-names
Message-ID: <20201207092914.3ampg2vyd7a53ku4@gilmour>
References: <20201202195144.2105036-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7jfbuasin4xcqjn"
Content-Disposition: inline
In-Reply-To: <20201202195144.2105036-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7jfbuasin4xcqjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 08:51:47PM +0100, Michael Klein wrote:
> Add gpio-line-names as documented on gitbooks [1] and in the
> schematics [2].
>=20
> [1]: https://bananapi.gitbook.io/bpi-m2/en/bpi-m2_gpio_pin_define
> [2]: https://drive.google.com/file/d/0B4PAo2nW2KfnRERWNnJGSGxJbmM/view
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

QUeued for 5.12, thanks
Maxime

--l7jfbuasin4xcqjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8316gAKCRDj7w1vZxhR
xUo1AP9bBUPPL4p2wFCMNaLSyyY+dZhSjdDwj09cLOi31qnjWQEA/DijqVO2aCuL
Y0leVWiODEjzD3hZ/ZQv5XZTkRB6FwE=
=77M9
-----END PGP SIGNATURE-----

--l7jfbuasin4xcqjn--
