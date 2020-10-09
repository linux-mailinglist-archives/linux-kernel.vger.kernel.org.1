Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE792889E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgJINdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgJINdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:33:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5225AC3F;
        Fri,  9 Oct 2020 13:33:47 +0000 (UTC)
Message-ID: <7b030a00d866f869acb4dea729df5fc93d561558.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Fri, 09 Oct 2020 15:33:46 +0200
In-Reply-To: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
         <20201001161740.29064-2-nsaenzjulienne@suse.de>
         <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
         <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
         <20201002115541.GC7034@gaia>
         <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
         <20201009071013.GA12208@lst.de>
         <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
         <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
         <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QKDQqezONyqKzfC6bWKQ"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QKDQqezONyqKzfC6bWKQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-09 at 11:13 +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 10:36, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> > > On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > Sadly I just realised that the series is incomplete, we have RPi4=
 users that
> > > > > want to boot unsing ACPI, and this series would break things for =
them. I'll
> > > > > have a word with them to see what we can do for their use-case.
> > > >=20
> > > > Stupid question:  why do these users insist on a totally unsuitable
> > > > interface? And why would we as Linux developers care to support suc=
h
> > > > a aims?
> > >=20
> > > The point is really whether we want to revert changes in Linux that
> > > made both DT and ACPI boot work without quirks on RPi4.
> >=20
> > Well, and broke a big amount of devices that were otherwise fine.
> >=20
>=20
> Yeah that was unfortunate.
>=20
> > > Having to check the RPi4 compatible string or OEM id in core init cod=
e is
> > > awful, regardless of whether you boot via ACPI or via DT.
> > >=20
> > > The problem with this hardware is that it uses a DMA mask which is
> > > narrower than 32, and the arm64 kernel is simply not set up to deal
> > > with that at all. On DT, we have DMA ranges properties and the likes
> > > to describe such limitations, on ACPI we have _DMA methods as well as
> > > DMA range attributes in the IORT, both of which are now handled
> > > correctly. So all the information is there, we just have to figure ou=
t
> > > how to consume it early on.
> >=20
> > Is it worth the effort just for a single board? I don't know about ACPI=
 but
> > parsing dma-ranges that early at boot time is not trivial. My intuition=
 tells
> > me that it'd be even harder for ACPI, being a more complex data structu=
re.
> >=20
>=20
> Yes, it will be harder, especially for the _DMA methods.
>=20
> > > Interestingly, this limitation always existed in the SoC, but it
> > > wasn't until they started shipping it with more than 1 GB of DRAM tha=
t
> > > it became a problem. This means issues like this could resurface in
> > > the future with existing SoCs when they get shipped with more memory,
> > > and so I would prefer fixing this in a generic way.
> >=20
> > Actually what I proposed here is pretty generic. Specially from arm64's
> > perspective. We call early_init_dt_scan(), which sets up zone_dma_bits =
based on
> > whatever it finds in DT. Both those operations are architecture indepen=
dent.
> > arm64 arch code doesn't care about the logic involved in ascertaining
> > zone_dma_bits. I get that the last step isn't generic. But it's all set=
up so as
> > to make it as such whenever it's worth the effort.
> >=20
>=20
> The problem is that, while we are providing a full description of the
> SoC's capabilities, we short circuit this by inserting knowledge into
> the code (that is shared between all DT architectures) that
> "brcm,bcm2711" is special, and needs a DMA zone override.

Yes I understand this and I sympathize with it, not the most beautiful thin=
g
out there :). But that's only half the issue, as I said, implementing this
early at boot time is a tangible amount of work and a burden to maintain ju=
st
for one board. So this is the compromise we discussed with the DT maintaine=
r
(RobH). The series sets things up so as to be able to implement the right
thing transparently to arm64's architecture when deemed worth the effort.

Ultimately, if you're worried about inserting knowledge into the code, aren=
't
we doing that, in a more extreme way, when imposing an extra unwarranted zo=
ne
to the whole arm64 ecosystem?

Note that I'm more that happy to work on alternative solutions, but let's f=
irst
settle on what would be acceptable to everyone.

> I think for ACPI boot, we might be able to work around this by cold
> plugging the memory above 1 GB, but I have to double check whether it
> won't get pulled into ZONE_DMA32 anyway (unless anyone can answer that
> for me here from the top of their head)

Don't know much about what ACPI memory cold plugging involves, but we'll st=
ill
need a proper ZONE_DMA32 (i.e. spanning the whole 32-bit address space) for
RPi4.

Regards,
Nicolas


--=-QKDQqezONyqKzfC6bWKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+AZroACgkQlfZmHno8
x/5PlQf+P8QLXrJShl8jG/06exIg90GTMkjn9WMCdvUp6fq+rQCD/XEZW+RmqybB
4hu4TrASI2evkAQUhOw3BuyxEblsrWJrM7ySV9t2bOIAQ+XP4/UVVDg+PP4z310h
QCVHOSyB9OeKVgPMyrm16+Eb8C+cpHIP29TCjTbP/0hiJEWkIzrJE+h+9Vl/JNMs
WBQmbxIzUZK8GlivpqbkbHXaPyo2Fa+Yf4NB/JJB11nRwLrFsA2Ka6yyu0ZVp/CF
gZ2nu1pm9P4DVwpaTrqEdB7g4ghRjHjWH7qxYNLQPm98gB0LZjHrZSXm4sL3pBt3
ZOjgS3QZ6gYgCZIwChD3fk/qcqtRXw==
=tHjf
-----END PGP SIGNATURE-----

--=-QKDQqezONyqKzfC6bWKQ--

