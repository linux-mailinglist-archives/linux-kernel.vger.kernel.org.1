Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8E2062FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 23:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393256AbgFWVKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 17:10:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53282 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391456AbgFWVJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:09:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5C8731C0C0A; Tue, 23 Jun 2020 23:09:53 +0200 (CEST)
Date:   Tue, 23 Jun 2020 23:09:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Andi Shyti <andi@etezian.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 061/206] Input: mms114 - add extra compatible for
 mms345l
Message-ID: <20200623210952.GA4401@amd>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195319.967295572@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20200623195319.967295572@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> MMS345L is another first generation touch screen from Melfas,
> which uses mostly the same registers as MMS152.
=2E..
> Add a separate "melfas,mms345l" compatible that avoids reading
> from the MMS152_COMPAT_GROUP register. This might also help in case
> there is some other device-specific quirk in the future.

Compatible is not documented in the right place, and noone is using
this binding, so this does not really change anything.

I believe this should be dropped from -stable.

Best regards,
     									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7yb6AACgkQMOfwapXb+vK44QCgqCqBMt78n1XUPNT3eatjDDQ/
4CsAoIWom2YMiDqboLKO153hX/5261f+
=x3W9
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
