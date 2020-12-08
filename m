Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE42D2C41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgLHNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:52:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17404 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgLHNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:52:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcf850c0000>; Tue, 08 Dec 2020 05:52:12 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec 2020 13:52:11
 +0000
Date:   Tue, 8 Dec 2020 14:52:09 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jon Hunter <jonathanh@nvidia.com>, <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Correct GV11B GPU register sizes
Message-ID: <X8+FCbks0dax2L4J@ulmo>
References: <20201124121842.1037035-1-jonathanh@nvidia.com>
 <20201207231352.GA1028809@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SgBijrdidYl9vHVJ"
Content-Disposition: inline
In-Reply-To: <20201207231352.GA1028809@robh.at.kernel.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607435532; bh=fWqPJzjNUscFj9GXRUEemj4XCu9f++72F4CFR7aVVhY=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=Tr+fPKYiuQE15LXIorLahEZcQ2JOKYenNG0ZLNCjSlBTfa11bmTNmYxtRKgVkzCtT
         6r75qJVV6ZRIq5XshwO+Cld/osiwMq/+QZn7yo4U1Gu8z11fuxNfKcQrorhbz3OfEr
         9hXbJUU3P8MnkRCc+KRnmvG0OL6mgv2YtbkiVWwY1vuS50vxjtK3DxJIZJvYYAT9pV
         3FPFRBT2raMa3Cqu51BL7bFvm21x0CBLwNOd66+UvvODxTAOqqXe7KcGDjdmOed3OY
         efUpSScXNYhbGc4+7CtAukpAlQRotmWW7Zl2Ye6VH8x+sNuJyiSAA0Tp1tSryzFtmN
         s32dyY1Sg5QhQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SgBijrdidYl9vHVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 05:13:52PM -0600, Rob Herring wrote:
> On Tue, 24 Nov 2020 12:18:42 +0000, Jon Hunter wrote:
> > Commit 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> > added the GV11B GPU device-tree bindings information but incorrectly
> > added an additional 0 to the size of the addresses in the example.
> >=20
> > Fixes: 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20
> Applied, thanks!
>=20
> But really, it's just an example and rather than fix trivial things in=20
> txt bindings, convert them to schema please.

The conversion to schema of this binding was part of a series I sent out
earlier this year converting a bunch of Tegra-related bindings. At the
time you had requested that rather than converting one binding after
another it might be easier to review if whole directories were converted
at a time.

I've been struggling to find time to do so, so I wonder if you'd prefer
me to send out that series again, or perhaps in smaller chunks? That
sounds better than not doing any conversions at all because I lack the
time to do whole directories at once.

Thierry

--SgBijrdidYl9vHVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/PhQkACgkQ3SOs138+
s6HPjQ//b8CnYazZ5sGhEy9akF/49A5bvoPj+VrjT+8MHSNvTZGJXXoTGN7Uhq0/
vP1MTSX5Gs0HDWGNMea1NJaLz2O7rdeQ0nxu0jXJoByp5NJbk6eRWP0Q8JNUCkmc
gWbFp4dQr3P7uv/gEYDO4LXnKw+G6280ZpqR2TA0REXF5XeBFADOOvVSvRfP8jzH
oa9O7O2NegfxYlgZmJHsm2MkdCtesrCHm1mwY+5R6KkRBXDH2+DX/n/OAku/zCra
lOU+PQF55vRrfbCWcQqGQAVmBiZANEjwjapfXDKC9Yz3dWwqXGxDyM9y0a7S9aN2
BB4eX4PbN5lr4iSVKqjAniDzTkALCI6XNlLiL/zGHyeMDfaOiQeBXMHs+zz0edYt
ogfQQFeH87GJir0nzmHs1qOB38LcxY8U5q8lnt27qE4uN9p7AvQ6x3YzU1EfelrA
8+Y0ZAMIIsVaXqFNNl2GnedPrFiILQCUTpeXi7ElBkOV/qsQoYxQBaxGkE02/hXI
wrLqiFNR0lK4EBb3iOuv3N+IVr1d/OCvh9C+1pAF3MSQh3WUcfRnrR77TeTAvqRc
JA6389oTr9tcMQJHI7q80kyavsB07u/oOxEunfCa+ljGWEgNAWMNXuw6CqwbjGHm
MPWtX/y1ib5mcchHJ0YIH0kdwSNTgPoniGHoYKS3bakz/Ed8Pu0=
=aEVr
-----END PGP SIGNATURE-----

--SgBijrdidYl9vHVJ--
