Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90026156F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbgIHQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731994AbgIHQsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:48:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726BC206E6;
        Tue,  8 Sep 2020 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599583691;
        bh=GC58VD0aHC2+QqxNhQJV7DDEZXLDOWxd0dJJGbYPoSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnjHYP6kFg8ov7KH+qVef3jZYg6LadGxGOb+OUPPTTKVecZL2DA2Pz13dXaaOlgF7
         CV/4RJEHCcHPJMxN/4+SilQis3g1gv4D6/bfTau1H/efVfdB6cNdSFBuUb6Fyy6gIf
         rvB6wMYm8jwgKBb0X3y6rXxefvt0vYKOO30/0tN4=
Date:   Tue, 8 Sep 2020 17:47:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: Re: [PATCH] regmap: debugfs: potentially duplicate the name string
 of the config
Message-ID: <20200908164726.GG5551@sirena.org.uk>
References: <20200908152859.26279-1-dafna.hirschfeld@collabora.com>
 <20200908153559.GF5551@sirena.org.uk>
 <455274f0-718c-9247-da29-6122687720eb@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <455274f0-718c-9247-da29-6122687720eb@collabora.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 06:07:56PM +0200, Dafna Hirschfeld wrote:
> Am 08.09.20 um 17:35 schrieb Mark Brown:

> > It does not follow that the name should be copied, it equally follows
> > (and is expected by the API given that the common case is that the name
> > is a static string assigned at build time) that the caller should not
> > free the string while the regmap is active.

> I see that the same copy is already done in function __regmap_init in drivers/base/regmap/regmap.c
> added in patch 8253bb3f82554 "regmap: potentially duplicate the name string stored in regmap"
> so I thought I'll do the same.

Hrm, right.  In that case why not just use that copy we've already
taken?

> > > This fixes an error
> > > "debugfs: Directory 'dummy-' with parent 'regmap' already present!"
> > > where the name was freed in function of_syscon_register before
> > > it was accessed.

> > Fix the caller.  It is *very* much unclear to me why a syscon would be
> > assigning a name for a regmap it creates in the first place.

> I'll have a deeper look.

Whatever happens that caller looks like it shouldn't be creating an
additional name unless I'm missing something about the context.

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XtZ0ACgkQJNaLcl1U
h9BiRwf+MfaQsN9ucmS7s5wsCpCqOGHkER22A2d9L5nmFg+9Qpsl3A6J4c/gHHxD
679P1H6vt751AjZqZuk2auaA2lHNGjiKqasbLKejZfTE2CA0jYnN+iX8WyjOhNNI
uW622IE/rYs4IvS8yM9qBipZJH1KRuljzI3db++GAnYuoJjjhxGM7Dcs2Lwk4om4
LU6DGItxpbuMhfWugzBiaLKkK7mhulUT6bKM0ZacLCVQFVlAAkeMgDm1B2XtVYUA
UX5of4ulw0YZnX5yF3oI76s7X1CV60RvnUM1YVGJuy3Ur8oNERkL8GVp5f0RdgUw
LCnfChUpRu5ppYdO2DwBtn2wtNVA7A==
=vkzj
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
