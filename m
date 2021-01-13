Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC02F46DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAMItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:49:14 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35805 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbhAMItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:49:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A8AC5C03A6;
        Wed, 13 Jan 2021 03:48:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Jan 2021 03:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=54FC/UrhpoPn3dwBbob71WsFOF+
        RG/zilAC6ndIFeJ4=; b=L7YQ88jSPHsL/s4rPZKDqgzSM2gfSRsNNuTWy7XXlhd
        9EjF22n8DAhKKOdM3fnWSOAEhZVSqHuDUwJzDQKJT3iGw/DnkZlIL2rVRqJvDM4i
        wdaHhfN/WFBrIV092d+NbPR/qVNm4udMSQX+O5VT+h+hVpPraXE/Gmi5er1fMOEb
        +FtJfoRR+oOtGjpNt9PN9qxjpBhuW2lPM+ufD9F8YLbUoOZlDD83mF7y33IhOOw7
        AKJJ8UOBGCTdLTuYYpAEJSaP+hNtqloCfZqrJFuUWHsyZD1A+pig8NxhrDtrSmSP
        UpOj+pj4Zaf/74DJZ/sW8U5M4lLdlqEfK5nBhAscovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=54FC/U
        rhpoPn3dwBbob71WsFOF+RG/zilAC6ndIFeJ4=; b=mXEHiI89sGndK5hA5yvBFz
        eUI/0EMjHhvuy7YX7G+NR3Q1E3qhGcH27F/6WbJVH4PCkpipMGw/DndwbKiApsEM
        it+6Oh+0Ta90T4GiTrLsER1gJ8SGqIUXAqAP5qLxNj8Qy+RV+ntr8UPpFFuL/b9a
        aFyPreWQP2uMWcR4bPuSxmDwTxgkMLE/JS3OUYDmgQ/LF85ukT4IvYji1ihKfL2k
        8qP/IfWdJeQyOiakV99okrTw0c46t9uNOwhpztYyFjarl6Cues4RBaJutKY78IZq
        15v5W7y49MjjzS90oeuS6PlUu33yhgXt1AQoVD9L96V5DhT5xZSbLSkuKA214jlQ
        ==
X-ME-Sender: <xms:2bP-X3lDszcVZIVkAIOUmFHxhFYdD9DT5xXF4XhIEy8a2U7T8k2rvQ>
    <xme:2bP-X62MdC-M8B3TcyO0-TcjZUQi1bksQTea35ffYUVGyp8duE_-83zjufOzaS2OJ
    Sc0h9aT-dYx_JUxYJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnh
    epleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieehgedunecu
    kfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2bP-X9qr35cc5YDK8ndamD0soQU46HD2IPKJR68oYA1wZjzcoWYFTw>
    <xmx:2bP-X_lzfVzvfl_SbUWDLUKCWz6nvYMQBoZRi7do7St1GUDqj6xPWA>
    <xmx:2bP-X13baytSsObXiZAv78PPL2sfNyAEfxjfcARaYTNABd2PdveqWQ>
    <xmx:2rP-XymcfobYvEEAMVGm6s-0dMAempdOxKVTim2bN5zTzBh6eibl_Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E17ED240062;
        Wed, 13 Jan 2021 03:48:24 -0500 (EST)
Date:   Wed, 13 Jan 2021 09:48:22 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: sun8i-codec: Increase
 #sound-dai-cells
Message-ID: <20210113084822.4rx67gcgqnb63agu@gilmour>
References: <20210113060615.53088-1-samuel@sholland.org>
 <20210113060615.53088-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="voku56fj7iadly7o"
Content-Disposition: inline
In-Reply-To: <20210113060615.53088-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--voku56fj7iadly7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 13, 2021 at 12:06:09AM -0600, Samuel Holland wrote:
> Increase sound-dai-cells to 1 to allow using the DAIs in the codec
> corresponding to AIF2 and AIF3.
>=20
> The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
> with no impact to the driver, so this is a backward-compatible change.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-=
codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-co=
dec.yaml
> index 67405e6d8168..3e02baa1d9ce 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.y=
aml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.y=
aml
> @@ -12,7 +12,7 @@ maintainers:
> =20
>  properties:
>    "#sound-dai-cells":
> -    const: 0
> +    const: 1

We should make it clearer that 0 is still ok, but is deprecated

You can do it with:

oneOf:
  - const: 1
  - const: 0
    deprecated: true
    description: >
      Whatever

Maxime

--voku56fj7iadly7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/6z1gAKCRDj7w1vZxhR
xbcAAQD8BOXQ4mhrW8k34p2W/LdnOcWWWyDGx6stQULk2BU7VwD/X5vR9Bpz5gzT
EYllDxi05aukw+nSebapy6q+jWFy/wk=
=SsHU
-----END PGP SIGNATURE-----

--voku56fj7iadly7o--
