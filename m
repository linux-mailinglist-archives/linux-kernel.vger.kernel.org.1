Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE532B1BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:17:02 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891A22223C;
        Fri, 13 Nov 2020 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605273421;
        bh=ynZPqiLwAmzb4vQWpYxkMKvNY6HII1AJEbdXwo8IGB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqf5hSovtfLI0xSHdrv4WMEVG5tg3htGgd19Z2M0YWbW/OSC6PhBIe1UeLqd7t0KD
         EY/TLmMKVyStZJtjN7p2Tj/8nwD7jitF4r6uv9ew/jeIJMYRIOvQ3dhg3ONGyp15Ko
         j9Dmn04FDaYutCssE11LykWJdX3vfntmvfXzYiJA=
Date:   Fri, 13 Nov 2020 13:16:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 2/4] regulator: debug early supply resolving
Message-ID: <20201113131645.GA4828@sirena.org.uk>
References: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
 <f9cba575580369e46661a9278ee6c6a8d8564c2a.1605226675.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <f9cba575580369e46661a9278ee6c6a8d8564c2a.1605226675.git.mirq-linux@rere.qmqm.pl>
X-Cookie: No solicitors.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 01:20:27AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Help debugging the case when set_machine_constraints() needs to be
> repeated.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Please when sending patches containing a mix of different kinds of
patches put any fixes at the start of the series before anything else,
including new features and trace additions like this one.  This makes it
much easier to send things as fixes without unneeded dependencies on the
new stuff.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+uhz0ACgkQJNaLcl1U
h9A01AgAgjkAkfrGdwBuR2bkj3LiIPyBQHNP9g+7HGBj1zYwRdrOrOSjjMmfHxhg
BCptjsT31zPsEhGaAXrO7q9niP6Ls5Wt32EOro8LnQy4pUbzBYuiYaZroDxjfqAF
Qn2EJ7cOaXin5BV9D/bGJ7Y321YVrYUgoQkdlBGR6SGM8drKmwMGRZybExgNh0on
ckTwehj3q0CS3jiOyVjJVEuHjKi25NaVQs66GcurJCOKY/+KLrCLH7uy7lVq7KKp
F+rbcZYlOVNanl1llOGCw2u75/ojtgIKBCJ58uT1zb79jTnRMEtFqZezED2xpFRR
9XGYwFw9Mpv9/ep4pewE56KzVhYj3Q==
=DUBS
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
