Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2216C28EED7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgJOIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:55:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJOIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:55:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8886BAD07;
        Thu, 15 Oct 2020 08:55:40 +0000 (UTC)
Message-ID: <d2b9b819c3245d80964959ab9544ae83aee470de.camel@suse.de>
Subject: Re: [PATCH v3 1/8] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Will Deacon <will@kernel.org>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Date:   Thu, 15 Oct 2020 10:55:39 +0200
In-Reply-To: <20201015084008.GB4537@willie-the-truck>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-2-nsaenzjulienne@suse.de>
         <20201015084008.GB4537@willie-the-truck>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LqkvVPGxKWHS4SdfYKKx"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LqkvVPGxKWHS4SdfYKKx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 09:40 +0100, Will Deacon wrote:
> On Wed, Oct 14, 2020 at 09:12:03PM +0200, Nicolas Saenz Julienne wrote:
> > crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> > ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> > boot table initialization, so move it later in the boot process.
> > Specifically into mem_init(), this is the last place crashkernel will b=
e
> > able to reserve the memory before the page allocator kicks in and there=
 is
> > no need to do it earlier.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  arch/arm64/mm/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Please can you cc me on the whole series next time? I know different
> maintainers have different preferences here, but I find it much easier to
> figure out what's happening when I can see all of the changes together.

Will do.

Regards,
Nicolas



--=-LqkvVPGxKWHS4SdfYKKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IDosACgkQlfZmHno8
x/5b8gf/WNSZvoD1xtpKjt8jTMpQspe3cPPxx3dpnpf7yyIFDV2xDx1fyq+Mpgad
krP9EbmaQcdA3u87hnSWp1EdJ0b1fGQQooiORSHOG+aQk4sfG/pOtFMt0WtxPyPf
r5KkkqLrh0x+ro0UB1BjEThi48JfY3mXrBjsohVFeytePlBk0HetZtyfWf5JxyCY
ZEHDUqbeYqhpWS3CfAfu5R3o5QFD4j4duokshFeptOcz2qFULFMKDFhVPbIIQE8x
Oydt2nCcFSDExbev7dHLEh0QmSY3vSd9F2c3nN0cw1y7M1MB2xc5XKLfLSgPgpY8
LQ4wQNIocmuUtgHQR8Blet63XHBeNw==
=Fb5G
-----END PGP SIGNATURE-----

--=-LqkvVPGxKWHS4SdfYKKx--

