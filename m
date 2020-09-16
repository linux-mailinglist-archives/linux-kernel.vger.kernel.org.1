Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5369026CCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIPUut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIPQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEBD2224D;
        Wed, 16 Sep 2020 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600273754;
        bh=vQuddypePWopKLwAeXnG8RvvPYBE/eT7ts8KwaQnsQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezAIWE6xWR+4vx9EUMOKzP4uUHtW8t33dINp+B6G02NO6teVRteWeuLrmiyDwtObL
         LVQwxDKXTLM6dQDszN1x7uzI7qGoquXdrGzxzRqE1O6Sf4J1PPVjD+jeE3VfnWyhbm
         OZsPWcnuYSXWojUxcDse0OZnSuzNuV8dj2AC/Ywc=
Date:   Wed, 16 Sep 2020 17:28:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Ricardo Ribalda <ricardo@ribalda.com>
Subject: Re: [PATCH] regmap: Add support for 12/20 register formatting
Message-ID: <20200916162824.GC6374@sirena.org.uk>
References: <20200916160552.1062243-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20200916160552.1062243-1-ribalda@kernel.org>
X-Cookie: I'm shaving!!  I'M SHAVING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 06:05:52PM +0200, Ricardo Ribalda wrote:
> From: Ricardo Ribalda <ricardo@ribalda.com>
>=20
> Devices such as the AD5628 require 32 bits of data divided in 12 bits
> for dummy, command and address, and 20 for data and dummy.

What exactly is the format you're trying to describe here?  It sounds
like there's two blocks of padding in here (I'm assuing that's what
dummy means) but what's the exact arrangement here and what are the
commands?  It sounds like this might not work ideally with things like
the cache code (if it makes things seems sparser than they are) and
might not be obvious to someone looking at the datsheet.

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9iPScACgkQJNaLcl1U
h9C4SQf8CSVdFJ5EzmgHk9nbgny+S72hZbixYAJ4GavSxz5Ls2tWOLWR8S4nSo5H
lvvzIMCrhVSViGNuf9XaVtGctzV5oQCapCKQd1apyAh6I76nxHXS/OkwmTdxYQuE
2wet5zy/vACtbEAZkBjnmqoX1SAk2OJXw5ZlmNdeeUygpQGTnfbXSthEOSq6wjXk
OhrN+U/jK6oXAvCWShi0SZVLimLDXhg+j5geYpFVvUopOjs2qrBQAh7Lny04QEl3
tPontOsJ8Uuiw+u/LENQsVebfNejJTn/18Cq93DCDfOylRxxBc3mVnONuZKaq5U5
oLuXtxVijTVlB+oGNBgXfhQPa22EBQ==
=gqak
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
