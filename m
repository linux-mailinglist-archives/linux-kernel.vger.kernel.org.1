Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F328EFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgJOKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:03:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbgJOKDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:03:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74A35AD52;
        Thu, 15 Oct 2020 10:03:16 +0000 (UTC)
Message-ID: <5eb3087cf1759f1b64c41831df86713be2a8be9d.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce
 of_dma_get_max_cpu_address()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Date:   Thu, 15 Oct 2020 12:03:15 +0200
In-Reply-To: <20201015054244.GD12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-4-nsaenzjulienne@suse.de>
         <20201015054244.GD12218@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DdaQVRcydG0pvZBFwUQg"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DdaQVRcydG0pvZBFwUQg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 07:42 +0200, Christoph Hellwig wrote:
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +	phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> > +	struct of_range_parser parser;
> > +	phys_addr_t subtree_max_addr;
> > +	struct device_node *child;
> > +	phys_addr_t cpu_end =3D 0;
> > +	struct of_range range;
> > +	const __be32 *ranges;
> > +	int len;
> > +
> > +	if (!np)
> > +		np =3D of_root;
>=20
> Requiring of_root to be passed explicitly would seem more natural
> to me than the magic NULL argument.  There doesn't seem to be any
> precedent for that kind of calling convention either.

I inspired that behavior from __of_find_all_nodes(). I'll change it.


--=-DdaQVRcydG0pvZBFwUQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IHmMACgkQlfZmHno8
x/6x2wf3cODezG/BkxVJ0lm2jJwlIZdgVp6ej6JYJYQvyHPC1WK/PAQWv9VIZkFs
GkeoZcY+R3e8DJl3ka1/MMzqgpnhNJyK3WA0oYNO2fui0l/zj8Lx434XoPRckQjv
25uH8IkIVnU+uuPlCA4jrLrZRhRXsym29I2LS4qb6hMgOjR9rpjnv3dcUUgBzV0M
0oj7uENKePzPXrUfdSzyw/LWsWenHxgk6gzTSrbXeQ3L3x3NEEOfj1GdkOhaVgT+
v6vTCd2JIlcXT++CJjPaRMQKh1ymDOTnCixIvyQmsCc+kcVFTXhGqw0iBBc9uQzr
5wdzzRu2njggoZZdIr3y0OATsR/b
=L2vU
-----END PGP SIGNATURE-----

--=-DdaQVRcydG0pvZBFwUQg--

