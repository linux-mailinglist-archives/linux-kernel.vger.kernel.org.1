Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46F52731DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgIUSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUSYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:24:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335C7221E2;
        Mon, 21 Sep 2020 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600712641;
        bh=HRXFmeB3Lq27fSD0zpaFp06z6HUYGQPD8Q8dBigA6pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4TO6CHKbtKu5i7B82i29p/gKoiV+l9c/Vx2/HUXPVLSZ1wKslkTz1fA5IYcqcoT4
         6VWPl9VznYH0dJRo47t05G8m3um496pt0b2/FU8ysvRJ98u7jpVOEgHuPjENtNbejD
         Kak8qL99y7GvRCK9zAjE+Cdkiqbsy1Zw0RXF1xPw=
Date:   Mon, 21 Sep 2020 19:23:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20200921182309.GF4792@sirena.org.uk>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-3-peron.clem@gmail.com>
 <20200921122918.kzzu623wui277nwr@gilmour.lan>
 <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 07:15:13PM +0200, Cl=E9ment P=E9ron wrote:
> On Mon, 21 Sep 2020 at 14:29, Maxime Ripard <maxime@cerno.tech> wrote:

> > Also, Fixes tag?

> I think this only happens when 20/24bit is enabled so the issue has been
> introduced in this series.

For a situation like that a note in the changelog about "in preparation
for adding X support which will make this matter" helps.

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o74wACgkQJNaLcl1U
h9BEkgf+Kdv4mdGPqpwCfZgrxhHr8llfJlEj472gWX8L58vMy5mvAKDByP19BQW2
V9tAlfOFNQ9RwwneG7mDjx/gdJOLB8SbnlcY1CJIZYT8HVZqMpNf9yxgK0cN3BBG
T1mFy3hejhnJ9E1l2SCmZiU5rRutUrdUfpThzmtblmz0+Osu1ZJnW3wox9B5ntS7
pe4wDkLATwov+b3q/67r4MMejRlAar97VFvkn49bAEK5nSnlKtMDVX2bhaMNU5cL
8bvQMBxlRDsvtEoytUlggCP39t3bIomY6mjc9h9AteG+YVvvb8E99pf6iOaCiXBY
QerGSJWszRFXfhWVKucqXFZif17wFw==
=qBM3
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
