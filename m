Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F182A27C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgKBKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:09:22 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47915 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728354AbgKBKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:09:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 85F94E88;
        Mon,  2 Nov 2020 05:09:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/NakyHQmhYRjPUmZpOmPUU3FHaM
        5AO536Wo/iwSFo/M=; b=iNZI8mVnF6TbQIO3SAXg3e4LtK+BCxX36SWHFmBQIlY
        WCUPXjH0gEiR5a6tU8MNtL7AcqBN4FBVbsBfFZO/HK6j0e3t/IZlUoqBWWmJSReB
        wD8QsqX3m0K/z6NEynY7K1wR+VIcVY9Gsylyy7insyiM8dvcx2wfHIQKVqiFjyum
        382NUPsYewDDS8rFg7Bn4WeZ7/rAcx79AZL/Dh2n+U0AXmvzAEXdBVTXitRWCK1k
        mfwn//ZQ5W3RrHYF+TuIHaGD9g6V5nWSsLnednd0AbMcpNwGKDFvQjeDB3WYCR9G
        2kf65grhAQAq6yiTjCXx6FrHfNXTuWiOoBhlB7VSMIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/NakyH
        QmhYRjPUmZpOmPUU3FHaM5AO536Wo/iwSFo/M=; b=p5vyfxtEptxNlBXlGi01Yz
        yQVUDVM0LB0GxGZwake4Mbn0d5BCpMr1y2vSyMbw/tLEF1aTtGlOxbS1ocWrN6/J
        G+Ywki4qAjwKtcPJcnvRkGPe0a+Sy5ezQCybq9FoNtyTwcyUwsVP9IN+I7tcdEjR
        kPR13mLCzbBXNfph0QNj7pw49rD6V6Iz0QZEytbDUjM6nFyowKGs19P6mrJX9OuY
        daS1oYoCgCRKDJRkvZ/QDQfWGE/TyonEsM9rLQLKGsZcMvMdNHiioC9gqjDSiRfG
        H8ZHW2wtVXiBhAG/uopnwmth1bA+qKvJfZ0NE9jJxQdI5x+Gc/vbE/CWTy4fwJnw
        ==
X-ME-Sender: <xms:z9qfXx_xyAXRpmyg7DyA_TqAmxAstoUchHZe5w6fDghm4sWpgMSQHQ>
    <xme:z9qfX1ugunH5RDJmVTa-UlGHRZkhe7H4L2rj9qOGFVQQ53GUeP9YZ1ksVdLC5Ngze
    6H5jGf9mb-J58w7a-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:z9qfX_BgzM1aksGF_3dadFsYZoP8hozLD69EGtDQyTeN0kO55uV0Bw>
    <xmx:z9qfX1dSQAFQFFJA7k-VR7Uc7ANbTjJO_xsEujQYrnh8k5WdzzkS3g>
    <xmx:z9qfX2P91OhGIgZf6RjB0vqKhu21MRDbng87Mx9GNEXmVDkiU9muMA>
    <xmx:0NqfX93j1YSb9ucGzh8RQNbB_kbxbKKLpycoddEaG8zkLlJRGJfQ8Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EFC2306467E;
        Mon,  2 Nov 2020 05:09:19 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:09:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/9] dt-bindings: irq: sun7i-nmi: Add binding for the V3s
 NMI
Message-ID: <20201102100918.7vutmnkiwvumgkyf@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-5-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqw2inug7o6mch4d"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-5-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oqw2inug7o6mch4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:32PM +0100, Paul Kocialkowski wrote:
> The NMI interrupt controller takes a specific compatible for the V3s.

Why?

> Add it to the device-tree bindings documentation.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwi=
nner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-co=
ntroller/allwinner,sun7i-a20-sc-nmi.yaml
> index 8acca0ae3129..52364c2200ef 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,su=
n7i-a20-sc-nmi.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,su=
n7i-a20-sc-nmi.yaml
> @@ -26,6 +26,7 @@ properties:
>        - const: allwinner,sun6i-a31-sc-nmi
>          deprecated: true
>        - const: allwinner,sun7i-a20-sc-nmi
> +      - const: allwinner,sun8i-v3s-sc-nmi

This should be sorted

Maxime

--oqw2inug7o6mch4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/azgAKCRDj7w1vZxhR
xUWhAP9UWzYwXvyG9MERjCl035DtOuLkNFIxodLyehVkNIl+qAD/cLcea8w/l0qs
0sdHTnzkGDjd4nemohIuoL4ts5rIpgk=
=SXVG
-----END PGP SIGNATURE-----

--oqw2inug7o6mch4d--
