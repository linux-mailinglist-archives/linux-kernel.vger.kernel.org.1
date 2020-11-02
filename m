Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAE2A26F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgKBJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:28:30 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59511 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbgKBJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:28:30 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5A0A4ED5;
        Mon,  2 Nov 2020 04:28:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 04:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=hyPH+I4uz31S5t0WSmm+l9Ovj+M
        oWykjrHJP9/OmnVM=; b=dcoNU+0W0GktPcSHaOgb9S1+DThbrW1FGvz7c5LCOjI
        wqYruK3XqUdIYmfsI/e57RusndsPh7U119v1v36X3ZovNiRC556lBEgs8cwFVtYd
        azSAxx2hlpvWW1p3WvAj0WfwnkoWQDiqcsH90cHae3/wER+rtpVQ9vNR8A/5ntHG
        1HfYZ274ziWKFqGpSSHVABx3MFtgkpRzvRcJLp9CJjZYTUoNdpLNLLIsHz9Jl3G9
        2xH2QhC/vvOvFCDW/PbDi7NtXET4QbsDneJ9za1qKPBeBVJbRoHP+aVpXW9rYT9e
        XFBm6R6D3zYuAg3UiWobpFyAPm+u3as1AVg2tAhr63g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hyPH+I
        4uz31S5t0WSmm+l9Ovj+MoWykjrHJP9/OmnVM=; b=pcPp7KINtUm0UZGuXA9jbX
        N55m4vAyxBBI5eHOTHVDkmG3BUzumthLXOqe9/7s0u9V5ONFTT76C/li9ILP8CgI
        337FDQNc2u9KAObbK+4AphuvC3m/3wL/lZTGFGuXPhnK34qsrcsOk7BALE78zQgn
        RTG8gJWm1rwqfDyoaWrAet8fl4qEymm6RpLqXS1Oi8a4dkTh23RmrWBZlmBcfJj6
        6VUUEaanvZkvDg+8lp+W4FCjxgLml5NMS/yb6trcqratXE/rmqjmAigswXTaVh89
        e4h9B3iQqRoIwTdUHU82bI7PyYtJD3md9e43m3GqqnlDR1Hssmw+f8AQLwnTfR8g
        ==
X-ME-Sender: <xms:PNGfX55dvYHXJkAvxEznVH0CIU8bywuawXeSZdffmxQGvu9MBJ1UZw>
    <xme:PNGfX27sWvl92ut6LHVqinJJg9UPd_GyJcx11csKtv3oTXg995L8k8gtiA4ffetax
    fld6DCynAICbGD7iWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:PNGfXwfX6Swfs8WOFaKmHtqV0JxMJts3FfEgiUlj-BK4wmzxQXcsow>
    <xmx:PNGfXyJEGMh68QHab3MGR3rAokhPCzhVWasIo1kSkWUnbq0paftN0w>
    <xmx:PNGfX9JSJ4eA8-ZDQ5KBXfOdXEC71VIyhHaB-XWHfyDslSPAq8400A>
    <xmx:PNGfX7gbCFUFcgrOnGUIY9omvc5xwtfet9zUaOAr-TyntlCjnuEddw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E93A63064683;
        Mon,  2 Nov 2020 04:28:27 -0500 (EST)
Date:   Mon, 2 Nov 2020 10:28:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 1/9] ARM: sunxi: Add machine match for the Allwinner V3
 SoC
Message-ID: <20201102092826.ihve6ohnbc2lqqc3@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swk44vaarxminkyd"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-2-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swk44vaarxminkyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:29PM +0100, Paul Kocialkowski wrote:
> The Allwinner V3 SoC shares the same base as the V3s but comes with
> extra pins and features available. As a result, it has its dedicated
> compatible string (already used in device trees), which is added here.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Applied, thanks!
Maxime

--swk44vaarxminkyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/ROgAKCRDj7w1vZxhR
xRfTAQDwvnZaS/MIr0zppQiQ4zDs7hWAJYeVlts0j/rj1bbDhgEAxBh+NuxjN0oZ
q8dtlHSuvDVlSF8U+rfnkzDyrCpToQI=
=mHUE
-----END PGP SIGNATURE-----

--swk44vaarxminkyd--
