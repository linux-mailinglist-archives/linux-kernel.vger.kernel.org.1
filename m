Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23A28EFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgJOKFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:05:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgJOKFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:05:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07720AC5F;
        Thu, 15 Oct 2020 10:05:49 +0000 (UTC)
Message-ID: <e14f6d6b12962da6cd32462b02b0bf051444894b.camel@suse.de>
Subject: Re: [PATCH v3 6/8] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Date:   Thu, 15 Oct 2020 12:05:47 +0200
In-Reply-To: <20201015053948.GB12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-7-nsaenzjulienne@suse.de>
         <20201015053948.GB12218@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OaOQtpsUFcwLROOxxpTG"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OaOQtpsUFcwLROOxxpTG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 07:39 +0200, Christoph Hellwig wrote:
> On Wed, Oct 14, 2020 at 09:12:08PM +0200, Nicolas Saenz Julienne wrote:
> > +	zone_dma_bits =3D min(zone_dma_bits,
> > +			    (unsigned int)ilog2(of_dma_get_max_cpu_address(NULL)));
>=20
> Plase avoid pointlessly long lines.  Especially if it is completely trivi=
al
> by using either min_t or not overindenting like here.

Noted


--=-OaOQtpsUFcwLROOxxpTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IHvsACgkQlfZmHno8
x/511ggAimtLNT1WNeWV5A+8xmnbf6JaeGSMxX4cRu7fCOEQY3+w1xLBF994fK2Z
kHNQZKeMTUpyU5J1peNUeL52DcoXp3z8htpZnX/w3v1RR8SRfii+A/t0d0uFKMeo
v7Fs/E4MHQDQWCfOBFCZM3htkNroqUEPAqYokg3He813rN9XLva43uK4ZovOHOC6
9JN/hGr8SIH4ETOtshdRr5vOtXWfDNAvF1xXn/7GBiZQvK4JqYn+xQQH2+Of8X+G
hF6lOhwA0/OZr33K5Dg0E+8wBDFGYwkX8UQ4BQpQC6vplNalO7Uo3TtQdqrEPB6W
L9yUr3CbkmXh5Uo5Wl5oa/bf5phnpw==
=NZRQ
-----END PGP SIGNATURE-----

--=-OaOQtpsUFcwLROOxxpTG--

