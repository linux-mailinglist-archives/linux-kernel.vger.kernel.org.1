Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6E288562
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgJIIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:36:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732613AbgJIIgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:36:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F7D6AC7D;
        Fri,  9 Oct 2020 08:36:06 +0000 (UTC)
Message-ID: <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
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
Date:   Fri, 09 Oct 2020 10:36:02 +0200
In-Reply-To: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
         <20201001161740.29064-2-nsaenzjulienne@suse.de>
         <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
         <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
         <20201002115541.GC7034@gaia>
         <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
         <20201009071013.GA12208@lst.de>
         <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HZps7YTW5opz4O9P41Ik"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HZps7YTW5opz4O9P41Ik
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > > Sadly I just realised that the series is incomplete, we have RPi4 use=
rs that
> > > want to boot unsing ACPI, and this series would break things for them=
. I'll
> > > have a word with them to see what we can do for their use-case.
> >=20
> > Stupid question:  why do these users insist on a totally unsuitable
> > interface? And why would we as Linux developers care to support such
> > a aims?
>
> The point is really whether we want to revert changes in Linux that
> made both DT and ACPI boot work without quirks on RPi4.

Well, and broke a big amount of devices that were otherwise fine.

> Having to check the RPi4 compatible string or OEM id in core init code is
> awful, regardless of whether you boot via ACPI or via DT.
>
> The problem with this hardware is that it uses a DMA mask which is
> narrower than 32, and the arm64 kernel is simply not set up to deal
> with that at all. On DT, we have DMA ranges properties and the likes
> to describe such limitations, on ACPI we have _DMA methods as well as
> DMA range attributes in the IORT, both of which are now handled
> correctly. So all the information is there, we just have to figure out
> how to consume it early on.

Is it worth the effort just for a single board? I don't know about ACPI but
parsing dma-ranges that early at boot time is not trivial. My intuition tel=
ls
me that it'd be even harder for ACPI, being a more complex data structure.

> Interestingly, this limitation always existed in the SoC, but it
> wasn't until they started shipping it with more than 1 GB of DRAM that
> it became a problem. This means issues like this could resurface in
> the future with existing SoCs when they get shipped with more memory,
> and so I would prefer fixing this in a generic way.

Actually what I proposed here is pretty generic. Specially from arm64's
perspective. We call early_init_dt_scan(), which sets up zone_dma_bits base=
d on
whatever it finds in DT. Both those operations are architecture independent=
.
arm64 arch code doesn't care about the logic involved in ascertaining
zone_dma_bits. I get that the last step isn't generic. But it's all setup s=
o as
to make it as such whenever it's worth the effort.

> Also, I assume papering over the issue like this does not fix the
> kdump issue fundamentally, it just works around it, and so we might
> run into this again in the future.

Any ideas? The way I understand it the kdump issue is just a shortcoming of
the memory zones design.

Regards,
Nicolas


--=-HZps7YTW5opz4O9P41Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+AIPIACgkQlfZmHno8
x/7ixwgArMPUc2i51aFQ1Vewm9MoFEcZuXJtOXO+kufsCRa58yp7GAAVBhH6IBHb
QfxFIDcQrHnSeOcYjCYeFjT1fH8Hg0NusddHoN+1A0dcFJltSmn6We+abDhmHj8M
xtBmhNjGmlvNqZrJdhqqhvT421GIj0cSZZX9ZVfGmFVLb8ALsmRiNaNAzmhkitzI
QMcbZEoCn9M76MC+EsRI6pwpTQsXkuN3XWKqNE8hXVtqXQEBkGqZgZcc6I3OY4MX
mj6kolVLJ/mr785/1E/8qehLDT6J1lg/lH0G6GtMCBagDRfU4cKj/LXr8L/UXtIm
lRJY0eAY18TiA9o655u+JyGxXFqeuQ==
=shiA
-----END PGP SIGNATURE-----

--=-HZps7YTW5opz4O9P41Ik--

