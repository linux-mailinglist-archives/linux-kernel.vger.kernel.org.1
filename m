Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0162A9CA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgKFSqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:46:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:46:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B18D4AD52;
        Fri,  6 Nov 2020 18:46:31 +0000 (UTC)
Message-ID: <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     James Morse <james.morse@arm.com>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Date:   Fri, 06 Nov 2020 19:46:29 +0100
In-Reply-To: <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
         <20201103173159.27570-2-nsaenzjulienne@suse.de>
         <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TnJp0vXFQpxxgYpSGy1Q"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TnJp0vXFQpxxgYpSGy1Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, thanks for the review. Some comments/questions below.

On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:
> Hi!
>=20
> On 03/11/2020 17:31, Nicolas Saenz Julienne wrote:
> > crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> > ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> > boot table initialization, so move it later in the boot process.
> > Specifically into mem_init(), this is the last place crashkernel will b=
e
> > able to reserve the memory before the page allocator kicks in.
> > There
> > isn't any apparent reason for doing this earlier.
>=20
> It's so that map_mem() can carve it out of the linear/direct map.
> This is so that stray writes from a crashing kernel can't accidentally co=
rrupt the kdump
> kernel. We depend on this if we continue with kdump, but failed to offlin=
e all the other
> CPUs.

I presume here you refer to arch_kexec_protect_crashkres(), IIUC this will =
only
happen further down the line, after having loaded the kdump kernel image. B=
ut
it also depends on the mappings to be PAGE sized (flags =3D=3D NO_BLOCK_MAP=
PINGS |
NO_CONT_MAPPINGS).

> We also depend on this when skipping the checksum code in purgatory, whic=
h can be
> exceedingly slow.

This one I don't fully understand, so I'll lazily assume the prerequisite i=
s
the same WRT how memory is mapped. :)

Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
prerequisite.

Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend on
having the linear mappings available. I don't see any simple way of solving
this. Both moving the firmware description routines to use fixmap or correc=
ting
the linear mapping further down the line so as to include kdump's regions, =
seem
excessive/impossible (feel free to correct me here). I'd be happy to hear
suggestions. Otherwise we're back to hard-coding the information as we
initially did.

Let me stress that knowing the DMA constraints in the system before reservi=
ng
crashkernel's regions is necessary if we ever want it to work seamlessly on=
 all
platforms. Be it small stuff like the Raspberry Pi or huge servers with TB =
of
memory.

Regards,
Nicolas


--=-TnJp0vXFQpxxgYpSGy1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+lmgUACgkQlfZmHno8
x/5+dgf+Pf8JjmucAPuXan1nTGcvtuILsP3sC+cq8tqi84bsKFRFACqHN5J2rXwK
ZzRX2RyPQDWT3O3Fbp7i/wYt2XDie598NvbIozdZ6ojULPL1FEUwn/6f2Eb2uuPE
bMSfZt/hTSa7wEESYeNV2gLjAb/bsA7Y4kxy8sDrTIJl44vJLbcdbE1MGX7wyBSi
YtNOajCrqpvkiXofu5+d6TFJLGALl27t2uLIuBMZU9OK5bkS7As75nsyPnRjwtQp
cwLHdyNtpgY1PJ2Za6gJyvyykaz8RAlgWbxeAANcdn6lGtVgDEcwVs/d25skS2k3
KY4U5Ag5+Nextbi5cic+Ep4C2Pfb3A==
=8Wzl
-----END PGP SIGNATURE-----

--=-TnJp0vXFQpxxgYpSGy1Q--

