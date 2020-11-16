Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB562B49F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgKPPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:52:23 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37725 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730396AbgKPPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:52:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EAF12B5A;
        Mon, 16 Nov 2020 10:52:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 16 Nov 2020 10:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ctEwiJErU9TBRfjIMhDk86gxCUg
        nkz6lu3VDXGXwxUc=; b=Tire05xoGPf+svFa2zjzfTlcrFUE0fnH54GM+bK6A0n
        lK3X9gEv5YngoR/ypkGG2Kz6a/rwZQOGHlfFHwOes6JnsnTkVneaQ6yzfxvorHvZ
        cwiR0130dwbYxCcKqx3mlhoE3zvL3LKSjGlk66BA4Kx6zYk5wuuD2GMRIdxaNkkN
        hP+2PC/qOGyKg9Vvr+TIVEBhzO6JSYJ2h/ykOy89QqLIpy9gsKAW2Bi6qTiZVgMq
        iFIDcHcILEh1363aIRj5DCkLLL2Bw4/0r0vxZcYHFxYiyKRprWhH/YWlLBgGm19c
        MfPyrUQqc8pKw+tCf4+g+10IlAqVJEMQ+1hubNfhhTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ctEwiJ
        ErU9TBRfjIMhDk86gxCUgnkz6lu3VDXGXwxUc=; b=U/X0MiLYoL77rE8rGGxV2i
        AipzjDiasd6Z4HZNxaZXfnlzJxar3heyXPD8zxF7pt+q6sKOEYpsShbigWDbfH5O
        wXyBlShO6y/SVY041imXkRlWy/PhUmIm0Io2AnV90Sd5LeJxpVMN3JhL8L1fo9kI
        18GnhThXLeLzZZdISFqwtAI1YEbqiLs6gRzMdDRQGNuh7X0NTjwFAT4QBFYElqEE
        5Tw/V8cD7233axOMJjxH/RlhA8LSqpUYxnVCPqVdqLGa5wD3lphFKQlT5UmcWjaj
        5UvoY64JdQAk66Pv0rpTDD+3WCktYWNvYD23SPHBbaHp40z4jpAJRVmo89Qb+Nbw
        ==
X-ME-Sender: <xms:NKCyX1RmlpTUhUC2Zflvb4klllV302lkPX6wNBtx_T7ZdTEffggzNg>
    <xme:NKCyX-wlX9maACj_I60CbH-MXjZ3QM0cjUU3ekmVJPLur09uqWZm09q83LwTzp28Q
    MHPfbJ3g9eIpFgjbQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NKCyX62FhZ69wN2bBnu569srUfWajRE4DItjqUt4SMSbAjCk9hdfPQ>
    <xmx:NKCyX9DEUvtTdhCROq-HQ16IgiLt0TsH52Z0E1YFo4vwbioQbLC9yg>
    <xmx:NKCyX-hwFGvAHxwN_388uCPVrPG0SEauDnTLqrfRXmjYMnUWKDB7ag>
    <xmx:NaCyXxuzFaa9FLx_w16XW8iQBi1ZkgvZsWPSWMUOwH1i4f0d0C8RAw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72920328006A;
        Mon, 16 Nov 2020 10:52:20 -0500 (EST)
Date:   Mon, 16 Nov 2020 16:52:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jernej.skrabec@siol.net, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: configs: sunxi: enable Realtek PHY
Message-ID: <20201116155218.fqr7tzooc5i6nnzg@gilmour.lan>
References: <20201112202652.27676-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5g56njjhtgpegdqa"
Content-Disposition: inline
In-Reply-To: <20201112202652.27676-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5g56njjhtgpegdqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 08:26:52PM +0000, Corentin Labbe wrote:
> Lot of sunxi boards has a Realtek PHY, so let's enable it.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks!
Maxime

--5g56njjhtgpegdqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7KgMgAKCRDj7w1vZxhR
xeF+AQC24Q1koS8gGd7kqh/WQyze3or/jhHzJKT9hU2rte/3YgEA4QRudqAUntYq
rS0dKEDHsLWT5N/S7s8ley0x8H6pcwk=
=JLJM
-----END PGP SIGNATURE-----

--5g56njjhtgpegdqa--
