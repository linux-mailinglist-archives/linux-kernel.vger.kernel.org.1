Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05EF2DCDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLQIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:45:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:58638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQIpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:45:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53BB4AC7B;
        Thu, 17 Dec 2020 08:44:32 +0000 (UTC)
Message-ID: <93832374535cb46419e921f5ee02ecabfe2cc83d.camel@suse.de>
Subject: Re: [PATCH] arm64: Kconfig: select ZONE_DMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Date:   Thu, 17 Dec 2020 09:44:31 +0100
In-Reply-To: <20201217080802.29023-1-peng.fan@oss.nxp.com>
References: <20201217080802.29023-1-peng.fan@oss.nxp.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eWZy3Scs/7uuot7vpnD0"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eWZy3Scs/7uuot7vpnD0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,
sorry for the inconvenience, this is most probably related to these changes=
:
https://lore.kernel.org/linux-arm-kernel/20201119175400.9995-1-nsaenzjulien=
ne@suse.de/

On Thu, 2020-12-17 at 16:08 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> ZONE_DMA should not be disabled, otherwise arm64_dma_phys_limit is
> left uninitialized and cause swiotlb have IO TLB above 4GB which
> might crash some platforms
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> Not sure whether need to address code to initialize the variables or
> force select ZONE_DMA

What is the cause for the swiotlb related crashes? I assume it's DMA into a=
n
address too high for the bus, but it might be something else.

I figure you have a setup with ZONE_DMA32, ZONE_NORMAL and !ZONE_DMA.

First of all, I'd suggest you try arm64's defaults (all zones enabled), the
series I mention above should fix most of the issues we've had with
ZONE_DMA/ZONE_DMA32 in the past. We now parse DT/ACPI and only create two
distinct DMA zones if really needed. Otherwise ZONE_DMA spans the whole 32 =
bit
address space.

That said, IMO we're not doing the right thing in the !ZONE_DMA && ZONE_DMA=
32
case, and this should fix it (I didn't test it):

- #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
+ #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit ? : arm64_dma32_phys=
_limit)

Regards,
Nicolas





--=-eWZy3Scs/7uuot7vpnD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/bGm8ACgkQlfZmHno8
x/4iTQgAoAfA95ea1Tklzkk7Ocxe3cSd4ZsszNphIXPEqhdkTgF364hsAjI8zp2x
2kyzDNFVod0ECra/DvplsR0itivTsthkblZMoLX7spaxNDpprEHL90Gg523KOTX/
uiChxY6xvsW8JZk8Ufp6/xxuKF8i2+s15joq3geJALzvGoac2P+K9aLuEZXctluN
S5WCkbdYoLxoAyUCRY58rZXl//lnvnKzfHcrA/eWgUhVed1euwFQznDnl75Lcjfb
8sdh9mEanNsFZgd+Dok54O8hyb4p9Yd1P1nfCnE85C14oSiL4IVHRfXcQmdoQvl+
MP/U1Ndyh+6CR2M5lOcLYDhjtEIqcQ==
=1qYh
-----END PGP SIGNATURE-----

--=-eWZy3Scs/7uuot7vpnD0--

