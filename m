Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F471C5CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgEEQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgEEQEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:04:13 -0400
Received: from localhost (p54B335A1.dip0.t-ipconnect.de [84.179.53.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BCE206A4;
        Tue,  5 May 2020 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588694653;
        bh=UPUCU3eUar7iY9cJbizcok3tqdxkqvfWgxtd4KniG9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpyx0GW/MEFsaJ/3a8hJQAhv87YOfwuY2VCRaz2f23rAvywCCpVGpGI62SPlvU69i
         M6PyJEGWsX8kBfF4OIpUBzoH6UU6urADCJP1Lvy+RrPyzkDrdWg3+P38CzNeDwJ73w
         fcgb2+iKwsiUevl4QPm+FOQRnr/WwxiojXAm3VSs=
Date:   Tue, 5 May 2020 18:04:10 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/5200: update contact email
Message-ID: <20200505160410.GH2468@ninjato>
References: <20200502142642.18979-1-wsa@kernel.org>
 <877dxsdl5e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <877dxsdl5e.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > My 'pengutronix' address is defunct for years. Merge the entries and use
> > the proper contact address.
>=20
> Is there any point adding the new address? It's just likely to bit-rot
> one day too.

At least, this one is a group address, not an individual one, so less
likey.

> I figure the git history is a better source for more up-to-date emails.

But yes, can still be argued. I won't persist if you don't like it.

Thanks!


--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6xjnoACgkQFA3kzBSg
KbaTsxAAizU7yVpsyfvJAhLroyGpAVRj7LysT+H5JlZ8JjJ4uDpEhOhL4Hzr5QO4
T4RfB4o+1xmKc0pwT2BOUteCO05S2hRH6+cwel++k+vWjCnKUBxeinylK+ixk4+V
P8QWDo/gFuqUtsm/Wb6PtBR8otMVa0FajdEPuaAkhi2OPQjO/2DvffSHT4c3VAtI
HY4pIIbwaaCiAalCse6IrqkuJT90A0ZDM9oRTZOIaryVkkTHHkBNmB7PKu4viJic
yS3yH+R0e5yBGEre6FkwL1z2CCNAGNXeBQ23gvq3glJAQIQyfBYgnO+lQFD8lZzq
Cb8E69+sastbZnUBKAK7GR5xvBYJImCxN35PRakdd8/pLHcdKgwIWu1B9PTO5xQP
avv3RmViYiSqfRJa5MSWqPu04zkJCYxy/w6yskdPHqhpG+7x1grsLO9hFBWxDN18
KDQaMtcgGzQbGzhxXnB8aZGJOEOTGrmlCxE35WQ5t3uGQe09hHTKuaUri288LXwH
7mK08jCqhMDavvLaUPngPz4IkdiAv8yZaK3LH4ikMQ4bKTJXhpnwfHYEswLP9FQq
Qcrm3tGBksw5Ld3sncU+ENfhhVaoIyxWxxjTp+WQVI+jMjWGCuJ1hy57iPonXfKn
2LEqI9lEf2iukddWH32wj4eivgYf6UHnf91Y5FoePzMf197dID4=
=bFLt
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
