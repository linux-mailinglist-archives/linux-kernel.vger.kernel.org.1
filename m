Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8652A0DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgJ3SqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgJ3SqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:46:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1AF206DD;
        Fri, 30 Oct 2020 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604083581;
        bh=XyrEe9Gcfh+0x4dtsnOlf3pZdGqIPBd2velt068peaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjH8U21DIQtE2ViZ8Qu2Mfql194wpBkOU5B8oJZIOutyLpucYxxzBIDM/+s+T/qNW
         E1TQRViMUhDKcJzaUBoCq0M/csNLsTKG+klSKV9iyP3jjZRf+7hYpUWblIprmOeYgb
         mJj9QCCLi/dS8lbbmUh4Wa7zzVfXoouSbF48PG5I=
Date:   Fri, 30 Oct 2020 18:46:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: MSM8996 depends on COMMON_CLK
Message-ID: <20201030184613.GK4405@sirena.org.uk>
References: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
 <a55d71fd-d5b1-26f9-c3f0-7f2ff91bef07@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="08ATZu8fEq0x2T3M"
Content-Disposition: inline
In-Reply-To: <a55d71fd-d5b1-26f9-c3f0-7f2ff91bef07@infradead.org>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--08ATZu8fEq0x2T3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:31:25AM -0700, Randy Dunlap wrote:

> Ping. I am still seeing this kconfig warning in linux-next 20201030.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--08ATZu8fEq0x2T3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cX3QACgkQJNaLcl1U
h9Bxgwf9EuOJbzQV1GpWxesW/kvtkASRPNpaKeiv1BMbxPRfx2Kb2FyVoOZU0+7d
PjeJEgQHzETyT3vHYz8AT34DZGSq/+PXygoScPiSqKkQiyIY2CeQFkoQbivA6gSl
Z8tCZCQ2voUq3trdSwxCVnxLUB45TePEQrdM7Y34azyqLRHQI7xJZkmLI7LFQQA9
04+czJ17zD4eGXQ6oSmyJxUoTZO85zB2+cw84rNykHJBTm8qBXS5ZZAsZ4d9SFGU
vOX7w9un6IZSWHgtlWfOkTn+p0FBFCowcIv1HT/EW451FFY1tmjXLCicd1R1QuUL
fE0mmHQlgvCViEy8Vaws8J8OjTDVhg==
=Z8YZ
-----END PGP SIGNATURE-----

--08ATZu8fEq0x2T3M--
