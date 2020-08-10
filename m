Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4A240601
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgHJMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgHJMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:38:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37E520678;
        Mon, 10 Aug 2020 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597063093;
        bh=w6IZKvqKLF7y9Px742Kp6ZtUkscApoCbd/4wUWC9sqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/0VuUFKQ0RTEK4drzfEK+JG7k4GXBWKHtG/NeI5JrP+oZ6eUJV/PFr8mu1nssNaI
         LrFqNZB0kXvbFoO7CVkNcmcl5MRcOLrX0OE7jhKMb5SOMIiZ3qmP5xJGYKyLjc9Lkb
         ea5/jtBcAI/o1xLiJBpmi6VEHpNWDSIUaQNA11Vo=
Date:   Mon, 10 Aug 2020 13:37:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: fix pointer table overallocation
Message-ID: <20200810123747.GC6438@sirena.org.uk>
References: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
 <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2020 at 10:44:25PM +0300, Dmitry Osipenko wrote:
> 09.08.2020 22:21, Micha=C5=82 Miros=C5=82aw =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > The code allocates sizeof(regulator_dev) for a pointer. Make it less
> > generous. Let kcalloc() calculate the size, while at it.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators cou=
pling customization")

> Hello, Micha=C5=82! Thank you for the patch! Not sure whether it's worthw=
hile
> to backport this change since it's an improvement, I'll leave it to Mark
> to decide, otherwise looks good to me.

Yeah, this is more a performance improvement than a fix.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xP5oACgkQJNaLcl1U
h9DTewf5AZYWZdq5rIJAtK5PuXAjhHQRvCfaiElnTBPxIhBKlhjmNs7MjlDxsLdK
iRTiXuJbBJvtZnUILDQ8MziCk57SuYU2+enrm+BtQqbMeFBnzxDs9ih67FEXponS
UrEGz9rSNG9mtRXKr0K8fM2PgvoDvgHV/NyjyqaJhPPd5g5EL4zzBaoAy8UTlnED
ceuWbYIxEYrFEwIsUt5+eYw+MkVwtOFNbaa6Kkk84tkmeH4eHEO6+y4j1Fn9vs/5
Dn7+gbtRza4PoDUF7K15nC65IDS8nbWUaDVYEX9zU4YjN8iKVuPr5mjaHfAJjPHA
3t32P2zYfVvwFbwjWdsESC2+oSjEjg==
=Qp3A
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
