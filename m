Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60D2E371C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgL1MWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgL1MWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:22:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1050D20867;
        Mon, 28 Dec 2020 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609158119;
        bh=ZS7RUVKRP6wl2s9Oldv/OnnMPXjJxUml71Xrcq40DLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afv795xo56065rW5LAgNEsf0rNu4PmmmcqZl/xI+8vIF/LcSKDW9LKKis24EfvvZP
         BAPoF+l9viA2KajTts/hFLBlUKqws1L/xsQrlufX3v43rXqc4qeJWpOEwtBRqf/J2o
         6ily0+NOM6BqpHc8STVegwas8jVnwBJDJuRBpCzIT9/iJy2cnq/fnAlYUQzKXJKVFN
         L//31rdtvGIsEmjIUPE6t+dk8oC9zM1G3JtZBlyvDkouPAgLfMyCmpDrfv/VZwNGQ0
         tI33pIOybeJCY/g7jzq4qW7YnMFkK4W5KDXDzHq7EaVqfCl/F3hpZY9TQr7yOvBQfm
         /9Fc6+hxPlDsw==
Date:   Mon, 28 Dec 2020 12:21:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201228122138.GA5352@sirena.org.uk>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-2-hdegoede@redhat.com>
X-Cookie: To see you is to sympathize.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2020 at 10:12:19PM +0100, Hans de Goede wrote:
> The Linux Arizona driver uses the MFD framework to create several
> sub-devices for the Arizona codec and then uses a driver per function.
>=20
> The jack-detect support for the Arizona codec is handled by the
> extcon-arizona driver. This driver exports info about the jack state
> to userspace through the standard extcon sysfs class interface.
>=20
> But standard Linux userspace does not monitor/use the extcon sysfs
> interface for jack-detection.

This seems like the wrong layer to fix this problem at, this issue will
apply to all extcon devices that can detect audio.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/pzdEACgkQJNaLcl1U
h9Dh6Qf/UA5yTQvJa66elOCTvssl6VA4RzwILRf1mJoZYFl7zb2LHfzSVv6R3Uxa
fNwQ5bphvGiDEToSULOtBujQIemOvFOZVJVxZ5ireFZJevoOFa3IHGae9XxFdG7M
CEIBKMtl9ZFTQAMGqE8tTduASOyflLJtoGY2Vj9a/FlnE8Rad/Ufib/GDlpQ4suQ
gK/Ng5bXWPcz/IooJDcsVr0grhWFtcKBifnRj6wnJ635gys/VUegIHiBuHzZCPtQ
klbL6XE0YebmQUFUGQklaFCgbUtQUVoSCoAcmaREWRcHOtIIMBwfw14ZikBw8U8P
4WnGOj4lhtL8cg9bZjOlquZ4w1mX6w==
=frXM
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
