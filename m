Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8131F1B4859
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDVPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 11:16:22 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37477 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgDVPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:16:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0F9FB588;
        Wed, 22 Apr 2020 11:16:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Apr 2020 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=K3JL55BKy3pQriQom4+MtaW7jsP
        YmntwUFT5KMhRuQs=; b=hyEkT/gFMRGAocalMZuIhxxhTxJa1ifUBbBQJEJtCdI
        7PtJsPzqx+NL1/c9YyN847yCVhtON3L7BQAOzuiVqZEZHAfxyFsl7GZzng21IWe8
        njPwtoEr1hShmhrMqBGLR4lm7QUJz86dExH+gQ0b/IABAk4XZGWWwW/SzFAcszca
        kIA6ZWQ2xMOwQaes9flt620h0PAJxjHRoQvUoCrTWG55UxUIeGv3GPrYzLg1cP+r
        iYup3w949OPpghONUSixYQhF/AcLfV69j+gOSkXuDRCXRUgy/T82cW67cgRf2dfC
        ti+Y2abj1bxycK4uOy5RGj6Y7ijPEoHE7ChgOc+gpww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=K3JL55
        BKy3pQriQom4+MtaW7jsPYmntwUFT5KMhRuQs=; b=2i41h+vlKhAVbJqFM96Rz5
        aKddvLmyd3OwjemDWWjv2v/OflBoS1ncGhyHBF0lrg+EQ09p8nRrrk3+PmpAYTVK
        lJqGGwmpKVLSERyyBJrSJGBay6Umi6+Ltt0IYPGpEeFoTQzXF9kSiEpYnR1Emci8
        p/vL+mtAz2qIc8HhrPsqMlIE9r9ZVt33m/0tiLA6m+OcO7JE12LUQKMCewFOFdNc
        oCYy9NJZek3jvkoRNwokmlxcT1EsyrmxPkJvaSyci69/isNCg+zj24MbX7WEUb/n
        6C6zlvZm5LTKizLc2b5BrUMGrT5RokHORsoyqGptyoSBQ8jbKvko+WtV6APMI+Ng
        ==
X-ME-Sender: <xms:wl-gXkhZZc3YsQwHryhpO1rIpVJ-_XbOtXd6UgA4eqYJpzkAlP2Exg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wl-gXpWgaAIz4dtia8XW8vRjbcfoGZ-YQUjvxWqY3huvPJ-ePsD2FQ>
    <xmx:wl-gXu1GLVU4recSgbJsaQMu7-GvMpBTdviC9zvcckUf4kuwjgPZEg>
    <xmx:wl-gXnHAD7OAK22eC_7Lt0LBbnIvrsYL4qVUDmWWnem2UiCAQjD9Lg>
    <xmx:w1-gXkgiDvGXmzyJ-8qPPpHZuGzHrZJh2hDHrsMJJDFv2WxAFQLUKA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 106493280069;
        Wed, 22 Apr 2020 11:16:17 -0400 (EDT)
Date:   Wed, 22 Apr 2020 17:16:16 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Disable SPDIF by default
Message-ID: <20200422151616.httmhmo2tbd4m4eu@gilmour.lan>
References: <20200422041502.7497-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rqslophvmxvu46lr"
Content-Disposition: inline
In-Reply-To: <20200422041502.7497-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqslophvmxvu46lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 21, 2020 at 11:15:02PM -0500, Samuel Holland wrote:
> As of v5.7-rc2, Linux now prints the following message at boot:
>=20
>   [   33.848525] platform sound_spdif: deferred probe pending
>=20
> This is because &sound_spdif is waiting on its DAI link component
> &spdif to probe, but &spdif is disabled in the DTS. Disable the
> audio card as well to match.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

The patch looks good, but don't we have some boards with SPDIF enabled that
should be modified accordingly?

Maxime

--rqslophvmxvu46lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqBfwAAKCRDj7w1vZxhR
xX+ZAP4levrp2LGRrm2REbub/4kkmFLtqMUooUPXTR9I0VEcUwEA/JrFpuWGRqmc
jpVGK8i/K0xogp3yuhFWU605yt7xwAs=
=uyxK
-----END PGP SIGNATURE-----

--rqslophvmxvu46lr--
