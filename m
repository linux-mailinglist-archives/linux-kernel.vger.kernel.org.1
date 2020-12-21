Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF572DFF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgLURgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgLURgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:36:46 -0500
Date:   Mon, 21 Dec 2020 17:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608572165;
        bh=AOjG8iPu1EM33o04NBrFFlDxBK+9tjL4EZ2EZDTIS/c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLcLJbdgS8bUvh3NJwaiEDAo/YTcFInTve0P/ImeWGi+MSbnPsKPsN7vdU8+eDxJy
         /KeD9iuQKVy+PGrhBn5Jyks7GeATaX0NdNXMdP06E93KSb01e9U8c0efQQls0vlvkR
         uXfj7+18ngGN/m9aGX1iuSorgv0iHVnLIkspEubwo3GW/Sx4CVAnqMtERgEByy68iv
         BX/TV2FnDFKUV9BJQpcJsOtA0huhAB3LpHEFvvfGKZrI4fuRP1kz1c4rBShV1Bab9T
         ujoyzJgdRCwQrOIYBqEDBfbcIMdcWST2ln6Le2cQB4BvaOg9eQFnbCK42cDvCguHa3
         2rSkjbwDSQRYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulators: bd718x7: Add enable times
Message-ID: <20201221173550.GC4521@sirena.org.uk>
References: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
X-Cookie: Remember: use logout to logout.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 07:38:07PM +0100, Guido G=FCnther wrote:
> Use the typical startup times from the data sheet so boards get a
> reasonable default. Not setting any enable time can lead to board hangs
> when e.g. clocks are enabled too soon afterwards.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/g3PUACgkQJNaLcl1U
h9Bp9wf+PZimP2+eXUWhTz0S990GWuZN5kWVvhEARzlOFIqRiARwRG6keOZd/NZ2
gB71TwOrCRPzCuK6bLcc0+mkRCQ3Ja10KT1FXwcmu9i/Rs8+EunmMOULBHQlnDiG
cHsdrigYNEEwc2ZNUF9DVEtwEH9TDEtRs2UNTZy2jDuuk2fwVDgHK4/8D1Nq+zty
jHhD82MxEv2h7zxJWgTHe/hllMhxz9ui23lAkBzXIx7YowJ2tTQkAx0Wu5yBRRxz
4KcSuw3tKumbbiaTtCrD3Y8crP83q1SRnTfWx+FHifi73Gxv+kHAF86qlH0ihC9z
dUY2i1/9VFb+zEVgJ5KU2jeuOY90AA==
=/CQM
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
