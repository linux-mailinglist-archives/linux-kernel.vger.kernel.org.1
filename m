Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E42731FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgIUSaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:30:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6067C20758;
        Mon, 21 Sep 2020 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600713017;
        bh=RIG1o2W+S0fOozltrMezM0wKniQZjIj8tj49IFeycQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjWSgetkuu30PE+jVlTKOITp/D4bMu9VafoSjGjApUWBn2ecvVK2LCbjtTrwBSs9i
         N96XP+fPh1z0gqX4hot0BvUoGmaGl3l3OzQgclsVmYQAZfSNupk6M4v2WNba8tuvm4
         oTSGr3na8bgWrU7OVNMSdljPAw5bjrnzr21MhPDI=
Date:   Mon, 21 Sep 2020 19:29:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
Message-ID: <20200921182924.GG4792@sirena.org.uk>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-10-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
In-Reply-To: <20200921102731.747736-10-peron.clem@gmail.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.

It makes life a lot easier if you batch all the DTS changes together
rather than randomly mixing them in with code changes, it both makes
it clearer what's going on and makes things easier to handle.

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o8QQACgkQJNaLcl1U
h9B3ogf9EEYaugeaZHYesvCMIRKvpSknwNalCvYT60A0SQGx2KNLn7X2PGd95CPY
KC6cgEQ89lTdbrGiAkaE9SXZp1kM6lhQs5Lg/3F/zvf8m9zMtOBTfumTFwN6v050
S8+sufsVctKcu4ztR0tLDIss5iVlklDm5EwmAHxfzk6tb3K8oZBhV0SsZldoDmFU
T1zMh8OeJshpm34jx1kat93A0xKmXJdtc2ER6wvn/dSftwd0+34YBACD2G0iC4jx
ttK0Q4Iq2mois+J7HrJWpEm7jo/dmKxuXvpKGlhr7YDS8LTK4teq3Re/tWJ/6i8H
E2/MBNAuorphpOUuKd1kYaHbsa7z0g==
=iKNi
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--
