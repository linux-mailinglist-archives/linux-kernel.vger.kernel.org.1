Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633DD28EFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgJOKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:05:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgJOKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:05:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C81D4AD6B;
        Thu, 15 Oct 2020 10:05:12 +0000 (UTC)
Message-ID: <eb355b9d3167d4c9575fe568d413ed4ff30078bb.camel@suse.de>
Subject: Re: [PATCH v3 5/8] dma-direct: Turn zone_dma_bits default value
 into a define
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Date:   Thu, 15 Oct 2020 12:05:11 +0200
In-Reply-To: <20201015053808.GA12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-6-nsaenzjulienne@suse.de>
         <20201015053808.GA12218@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ooBe/nz7Sn01MZB7Rrs+"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ooBe/nz7Sn01MZB7Rrs+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 07:38 +0200, Christoph Hellwig wrote:
> On Wed, Oct 14, 2020 at 09:12:07PM +0200, Nicolas Saenz Julienne wrote:
> > Set zone_dma_bits default value through a define so as for architecture=
s
> > to be able to override it with their default value.
>=20
> Architectures can do that already by assigning a value to zone_dma_bits
> at runtime.  I really do not want to add the extra clutter.

I'll remove it then.


--=-ooBe/nz7Sn01MZB7Rrs+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IHtcACgkQlfZmHno8
x/6RQAf9GxOfgIudy6fJqG6B49H9h6IDJ4zv4+4QQwBXduPrUsL/C3Y0sFDL3fYB
60lEZWhAHKEvOCXo2nIUPE1mBXJwbMGEvvC6COTHvszK6mGKbtm/2tQF8ZTW3Vq0
CW/yxdpH3bYmMv+SAHFwhVJlujIqEQztQ8nsULO1vqU0G1+LI+E5u4LRIc352ZXd
zHi4ICHDOysIlB9I1OqICUDxnhPCUGXgqngrGYb6hrL/D/uiEv1e7kKdKHJU6Frz
R+8GUJ3FxMx6etC5hdGCmkqontX65U2Tyd3PXbj7pLBPLXo90SZnOh4lxc/rKhgm
bYh8stzAm1gcJzuYsOxrYy2qj1lWFg==
=B+5L
-----END PGP SIGNATURE-----

--=-ooBe/nz7Sn01MZB7Rrs+--

