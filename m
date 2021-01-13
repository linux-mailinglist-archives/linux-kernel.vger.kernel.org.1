Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8402F4CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAMOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:00:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:60430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbhAMOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:00:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17911AB92;
        Wed, 13 Jan 2021 13:59:39 +0000 (UTC)
Message-ID: <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     drinkcat@chromium.org, devicetree@vger.kernel.org,
        heikki.krogerus@linux.intel.com, saravanak@google.com,
        peterz@infradead.org, xypron.glpk@gmx.de,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bgolaszewski@baylibre.com,
        iommu@lists.linux-foundation.org, grant.likely@arm.com,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        xen-devel@lists.xenproject.org, dan.j.williams@intel.com,
        treding@nvidia.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Date:   Wed, 13 Jan 2021 14:59:34 +0100
In-Reply-To: <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
         <20210106034124.30560-3-tientzu@chromium.org>
         <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t4If4GPTxFUMkhdNPchG"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t4If4GPTxFUMkhdNPchG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Tue, 2021-01-12 at 16:03 -0800, Florian Fainelli wrote:
> On 1/5/21 7:41 PM, Claire Chang wrote:
> > Add the initialization function to create restricted DMA pools from
> > matching reserved-memory nodes in the device tree.
> >=20
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> > =C2=A0include/linux/device.h  |   4 ++
> > =C2=A0include/linux/swiotlb.h |   7 +-
> > =C2=A0kernel/dma/Kconfig      |   1 +
> > =C2=A0kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++-=
-----
> > =C2=A04 files changed, 131 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 89bb8b84173e..ca6f71ec8871 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -413,6 +413,7 @@ struct dev_links_info {
> > =C2=A0=C2=A0* @dma_pools:	Dma pools (if dma'ble device).
> > =C2=A0=C2=A0* @dma_mem:	Internal for coherent mem override.
> > =C2=A0=C2=A0* @cma_area:	Contiguous memory area for dma allocations
> > + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
> > =C2=A0=C2=A0* @archdata:	For arch-specific additions.
> > =C2=A0=C2=A0* @of_node:	Associated device tree node.
> > =C2=A0=C2=A0* @fwnode:	Associated device node supplied by platform firm=
ware.
> > @@ -515,6 +516,9 @@ struct device {
> > =C2=A0#ifdef CONFIG_DMA_CMA
> > =C2=A0	struct cma *cma_area;		/* contiguous memory area for dma
> > =C2=A0					   allocations */
> > +#endif
> > +#ifdef CONFIG_SWIOTLB
> > +	struct io_tlb_mem	*dma_io_tlb_mem;
> > =C2=A0#endif
> > =C2=A0	/* arch specific additions */
> > =C2=A0	struct dev_archdata	archdata;
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index dd8eb57cbb8f..a1bbd7788885 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -76,12 +76,13 @@ extern enum swiotlb_force swiotlb_force;
> > =C2=A0=C2=A0*
> > =C2=A0=C2=A0* @start:	The start address of the swiotlb memory pool. Use=
d to do a quick
> > =C2=A0=C2=A0*		range check to see if the memory was in fact allocated b=
y this
> > - *		API.
> > + *		API. For restricted DMA pool, this is device tree adjustable.
>=20
> Maybe write it as this is "firmware adjustable" such that when/if ACPI
> needs something like this, the description does not need updating.
>=20
> [snip]
>=20
> > +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> > +				    struct device *dev)
> > +{
> > +	struct io_tlb_mem *mem =3D rmem->priv;
> > +	int ret;
> > +
> > +	if (dev->dma_io_tlb_mem)
> > +		return -EBUSY;
> > +
> > +	if (!mem) {
> > +		mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> > +		if (!mem)
> > +			return -ENOMEM;
> > +
> > +		if (!memremap(rmem->base, rmem->size, MEMREMAP_WB)) {
>=20
> MEMREMAP_WB sounds appropriate as a default.

As per the binding 'no-map' has to be disabled here. So AFAIU, this memory =
will
be part of the linear mapping. Is this really needed then?

> Documentation/devicetree/bindings/reserved-memory/ramoops.txt does
> define an "unbuffered" property which in premise could be applied to the
> generic reserved memory binding as well and that we may have to be
> honoring here, if we were to make it more generic. Oh well, this does
> not need to be addressed right now I guess.




--=-t4If4GPTxFUMkhdNPchG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/+/MYACgkQlfZmHno8
x/57/wf8DfucOc1/3ySk20PkRc6qv7RWXbGw5RAUSZfXGpnHv1mAOnBMd6ProWeU
mJiYuCGcljwaI92Dc4Yca/JpWSeZmXWl/HZ+T0GIF9SegR36L8j5Fwop/zptM3kF
Je0VZZ/VIXKkgr7rp0yqFNRFB0vGuXdQz022npLJ4YKgyN1uvEaVgVCEeKuB/gSc
7BYPkilOLaUXaBxRcA6l7mcQZc4vqCMW3Lzl/9IM+mKhrhFllZI3pvBFnWed+k2J
JVdA5hjLI3QQrsXYH8+AfKlhLjzzMCGn5E5Gw1IPluIoeObgEwwLfYuMHbOvFplQ
3LHRL6KrY2rpsuzPeVMDM0TFPae/Hw==
=L05t
-----END PGP SIGNATURE-----

--=-t4If4GPTxFUMkhdNPchG--

