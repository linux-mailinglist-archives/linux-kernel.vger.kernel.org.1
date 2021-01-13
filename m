Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045FF2F4650
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAMIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:21:33 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42961 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbhAMIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:21:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 667DA5C0576;
        Wed, 13 Jan 2021 03:20:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 13 Jan 2021 03:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZJsjaocw9Pk6aOpZYBiht2QvMxn
        NAp9d3CIT5u5UeKI=; b=vQL0aTNUQFG38MxrlAdRyDoA5jRk2VeTpSlap36sD+y
        YB+wtobrkzTdd51caSr5GVOFj6yLYyTTJztzKs66hWKFLQyt7ZluOMYPEz5HKl9F
        w287F4lZwjnTmRSWy89auAoAL37gCSnTPhrpmk5EI80aHn4DR8YCF7+PRLFbWgDH
        Lr9tX3l4FNGtewr56Uk5dYpH5D3XmJvxc8WLJfwi6hTpV2UYarqEa3fMn6ETqLt0
        z76XchwkoIn+vdEeP/UWCoV/dESYFBMRnU3uuoe2s6O5Gm6+n16SnfBZZ4G3a+zW
        twhtOOUg7+L3eWojQhk5yRqjBHJkD9MJ/W2408MnWng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZJsjao
        cw9Pk6aOpZYBiht2QvMxnNAp9d3CIT5u5UeKI=; b=cxVS4GLIuqPcpYMMCafkIw
        gOAybv9dvJNNnTY0CICUgy/zzFjtmOLJJqWCQge5FQESleUhz2AxQERx2O0TCaqj
        WRqDCeIdq1BXGjwYR7a1/+avBKVaR9ThK8XU4iqyb2FaCVTl6eC6gvJikF7jrEwH
        AhA338oyq3mCrjb/X+cC05eflROhPsjz4CqqgtZ5xmdaayZQOAFe8naFNXfY4Hmb
        Yzp3RYUft/xlGBK80fYC6kjiW38nANmYqs4AvbIuotVZJI5t31bKA4K1Z0D0/bLD
        lEh63sppxlAj8BB3D17xDKUXxrziJY0f/MxW1ssohEt/uFKw0PRhOJsjymJ0GoQg
        ==
X-ME-Sender: <xms:Uq3-X_RIdTQ27F_EkvgKsWmm2v53FCkCG8Ljkm5lCS595OSt0JTKqg>
    <xme:Uq3-XwvJ4PagrdccSNf8w-b_j15ONhEN1vrYgQuZKyyS4flFR5OKJTzDgH5QHPch_
    DpSj5ZjKZLfiXEB4xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Uq3-XxtxnpMyChJwd1jK0X_MeMFWuGLmRa2UqADitW8aGn5bw3yoHw>
    <xmx:Uq3-X2xXo6Q2G7oIS-br--OBmQD-M40XllT_KIOGy0jcB2U4q4s8Ng>
    <xmx:Uq3-X3hKpihhp9ol1PKisldKnRXdNlQgjttZYv4l3dbf1o1TAaw6Ng>
    <xmx:U63-XznKW07YKcaB20S-lEQZUmdxNkp6dSM2GwJtk2XeOy5fCL9N8g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD0951080057;
        Wed, 13 Jan 2021 03:20:33 -0500 (EST)
Date:   Wed, 13 Jan 2021 09:20:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergio Sota <sergiosota@fanamoel.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun5i: add A10s/A13 mali gpu support
 fallback
Message-ID: <20210113082031.foa3kzodk6zxqj54@gilmour>
References: <20210108103819.322901-1-sergiosota@fanamoel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzehxqhmyvsmno52"
Content-Disposition: inline
In-Reply-To: <20210108103819.322901-1-sergiosota@fanamoel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzehxqhmyvsmno52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 11:38:19AM +0100, Sergio Sota wrote:
> The A10s/A13 mali gpu was not defined in device tree
> Add A10 mali gpu as a fallback for A10s/A13
> Tested with Olimex-A13-SOM / Olimex-A13-OlinuXino-MICRO
> "kmscube" 3d cube on screen (60fps / 10%cpu)
> Versions: Lima:1.1.0 EGL:1.4 OpenGLES:2.0 Mesa:20.2.2
>=20
> Signed-off-by: Sergio Sota <sergiosota@fanamoel.com>

Applied, thanks
Maxime

--wzehxqhmyvsmno52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/6tTwAKCRDj7w1vZxhR
xSp8AQD/zV00xouTidXvD/st6pAAAnYwgL40SAbfKj+E7joeswEArfhhKydwf4et
P/NHuAihw1bVP8h1uiIR30YN8DRgPA8=
=NOns
-----END PGP SIGNATURE-----

--wzehxqhmyvsmno52--
