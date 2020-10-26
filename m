Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A302298BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773533AbgJZLUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:20:44 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45031 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1773521AbgJZLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:20:41 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D532686F;
        Mon, 26 Oct 2020 07:20:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 07:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=uFfn1rBgDYLMt3mqNkoVdgLP7ue
        5sVQfLWuu0Xpbtjk=; b=o6B1KXhaMcWyAcaBAMQDq+dc011pRk9yQhBE9l3FUJi
        J1TPjFmbAFLFR6Nikk1xoaOcyEDZep+qX+fpyMatrreLLXagR7DrCcg+dpO+i1Mu
        OjPeTirJmrNeArG6hA8wjW2WgZly9JnuVx2He5vC3TzAocOSrNJ6u3mO1d98VyAL
        PN/OWYIYErmOaIHf5lQrwiyYXJEDeQEDEgrEtZsbqKCAutXSHYpK79U5b57fdj+o
        etKEBVMQ+jWWmD9lb8ZQkfEbMWv1hdsyBXF8bP/geFOgQxwBBcduSxkXYxLn1UM6
        aDsOO0Iv5IxH1MpAqFJ3h0610FJlgWgFu2DeQUJ9FEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uFfn1r
        BgDYLMt3mqNkoVdgLP7ue5sVQfLWuu0Xpbtjk=; b=j1Wm4H7Xhg/e3YbUKd++nN
        mApYH+gx2/eZ9craXxs6AzlL3hJYlbMoIdmF4TN8RGcbYd1CidikABGHuxt7xaGN
        Nr159kpB8jpt5QOCEzEx0z69O6vNZ/bELJq9/6bzLkfVwZRqLHf7KHt/r/CCpoc+
        jQK1XEFPdE645BGNdlG5S8XJn4wi3qjdsIp7X86kY+IT1+XVRGriVhcm5FnJCR0n
        IG0jImvrqG1CtXNRrEaq1KEd1OAncL5gVAiVK09iMNS05DCyqBh1QgyfNMsLLfGN
        g4yU0VKjvoQIVCdAinZTdpRgkttyqZgrHtv0IRn9qnV7WDfXVAE0JiECOl1bmhvg
        ==
X-ME-Sender: <xms:BbGWXyFHfFJbu7ImInmnQAqJyuamktuUIoX8cG93YNPOX1T8OxgEyQ>
    <xme:BbGWXzULND81Xl3ezIEAY6FbZyhXzIIbTts8HEXpV_OY6d6frLpk-yYhONnjrHZQj
    _tIGyi2p-gRaiS4jR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeeigddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BbGWX8K7du1FZUJtmNIHXgVZSiwjYf6pMJUTQDtLcGbSmiDsjJL5ww>
    <xmx:BbGWX8Gp-V99RLXu2kMnv4JOUkcKSmZDlSBF6QkTVq2dSvXmtNr7Uw>
    <xmx:BbGWX4VxAESS91x2aCGMJmqJ3yW_CIFdtgk43ekPqmpkIYc8EU4SQA>
    <xmx:B7GWX_TADWRSlLx4yUcWhlcIp8nu504JaK7PPsdLFA2yhLZccMPntQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C22F3280064;
        Mon, 26 Oct 2020 07:20:37 -0400 (EDT)
Date:   Mon, 26 Oct 2020 12:20:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Message-ID: <20201026112035.bwhjohjf4wie5nov@gilmour.lan>
References: <20201026073536.13617-1-mtwget@gmail.com>
 <20201026073536.13617-2-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5eztmnd4pg3wnonc"
Content-Disposition: inline
In-Reply-To: <20201026073536.13617-2-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5eztmnd4pg3wnonc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 26, 2020 at 03:35:36PM +0800, Yu-Tung Chang wrote:
> The ZeroPi is another fun board developed
> by FriendlyELEC for makers,
> hobbyists and fans.
>=20
> ZeroPi key features
> - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> - 256MB/512MB DDR3 RAM
> - microsd slot
> - 10/100/1000Mbps Ethernet
> - Debug Serial Port
> - DC 5V/2A power-supply
>=20
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 87 +++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index efc9118233b4..9392a9a3f7e7 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -246,6 +246,11 @@ properties:
>            - const: friendlyarm,nanopi-neo-plus2
>            - const: allwinner,sun50i-h5
> =20
> +      - description: FriendlyARM ZeroPi
> +        items:
> +          - const: friendlyarm,zeropi
> +          - const: allwinner,sun50i-h3
> +

There's a typo here, it's supposed to be sun8i-h3 instead. I've fixed it
up and applied for 5.11.

Thanks!
Maxime

--5eztmnd4pg3wnonc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5axAwAKCRDj7w1vZxhR
xcwfAQD3eUliple5NButWjkaGthwXXCxkslsUzwr+joAx9XfMQEAoquNkLYV/SA1
bIhVUJ9J2ZUo/3i9zIbwk4l42WxnzgI=
=f8M0
-----END PGP SIGNATURE-----

--5eztmnd4pg3wnonc--
