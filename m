Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56E61AC4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409752AbgDPOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 10:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898467AbgDPNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:44:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD67E2076D;
        Thu, 16 Apr 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044698;
        bh=snRnga8S3q3vsaYCmAP03fkjTBXuSOsepDap/jIwXP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGBzQG8YnW20VgZOhlGgqU12o0CkFX4VG7Ydi68tBQqQKZGcDtrLAkfj4zAatLP4S
         SHadyLe5WJFq3CSEDUhx3F2Bcio61yMP8gVuOXopCCWSzIRO2KfjEUXT2VBhqQqg8q
         zRJiJvrCIlSb+3a1oKTrdyQX13/+eadI8eix7r0A=
Date:   Thu, 16 Apr 2020 14:44:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
Message-ID: <20200416134455.GK5354@sirena.org.uk>
References: <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
 <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
 <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
 <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk>
 <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:16:39PM +0200, Cl=E9ment P=E9ron wrote:

> But if multiple regulator is not an issue and as each request is logic.
> The first in device_init assure to enable the regulator and the second
> in OPP assure the voltage level.

> Maybe we can just fix this warning?

Well, if you have a tasteful way of doing it I guess.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YYVYACgkQJNaLcl1U
h9APaQf7BtqZqetd7uhRm5gffzYPSfvm4bcCrPVV9ASVVUFZ1CFUrj4E03sCV0mr
gcX2OORCWnie93PZ7jwOBQvxNAXC4Sa2lOwXkRAHyI//4XCoq7ug9rPyQXf2kxAY
31VFYC2qJt0F9J5sK1cObsLBNhKjyb06H+smycNnEQgBYqFYnyfDKS/rkQgOovV6
uUgYk8QtqOj3SaDTKzuwG8woUG1k6n+tnQ0+1VfhDLUaItNUeL2GaVPc2mRLQQdR
NiwppMywkWOEOT0kMYWxm9VvHR21PRtqmki0Rj9ROnM3gBqp9OjbCv9mDY1Nscx1
IQpUfGcBkx5H0YuBfq0erq+1m5QOtA==
=nyjc
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
