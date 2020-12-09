Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89642D4B52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbgLIUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:11:58 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40942 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLIUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:11:57 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DD72E1C0B7A; Wed,  9 Dec 2020 21:11:15 +0100 (CET)
Date:   Wed, 9 Dec 2020 21:11:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scripts: switch explicitly to Python 3
Message-ID: <20201209201115.GA29040@duo.ucw.cz>
References: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some distributions are about to switch to Python 3 support only.
> This means that /usr/bin/python, which is Python 2, is not available
> anymore. Hence, switch scripts to use Python 3 explicitly.

Should python be mentioned in Documentation/process/changes.rst ?

Best regards,
								Pavel
							=09

--=20
http://www.livejournal.com/~pavelmachek

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX9EvYwAKCRAw5/Bqldv6
8mPBAJ99fegSm0IeQopWiVlGS2S2/F68cQCgjGbA6EIPd2dez9BcEkfsotn4af4=
=rWbt
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
