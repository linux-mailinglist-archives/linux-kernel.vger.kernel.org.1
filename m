Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558982E2DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLZKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 05:35:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:38202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgLZKfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 05:35:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EC79AD0F;
        Sat, 26 Dec 2020 10:35:00 +0000 (UTC)
Message-ID: <653d43ed326e6a3974660c0ca2ad8a847a4ff986.camel@suse.de>
Subject: Re: [PATCH 2/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     ardb@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        xiexiuqi@huawei.com
Date:   Sat, 26 Dec 2020 11:34:58 +0100
In-Reply-To: <20201226033557.116251-3-chenzhou10@huawei.com>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
         <20201226033557.116251-3-chenzhou10@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ttraNiikuS3d3EHqG2nf"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ttraNiikuS3d3EHqG2nf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen, thanks for looking at this.

On Sat, 2020-12-26 at 11:35 +0800, Chen Zhou wrote:
> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
>=20
> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
> enabled, otherwise, reserving in ZONE_DMA32.
>=20
> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA3=
2")

I'm not so sure this counts as a fix, if someone backports it it'll probabl=
y
break things as it depends on the series that dynamically sizes DMA zones.

> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---

Why not doing the same with CMA? You'll probably have to move the
dma_contiguous_reserve() call into bootmem_init() so as to make sure that
arm64_dma_phys_limit is populated.

Regards,
Nicolas

> =C2=A0arch/arm64/mm/init.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7b9809e39927..5074e945f1a6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -85,7 +85,8 @@ static void __init reserve_crashkernel(void)
> =C2=A0
>=20
> =C2=A0	if (crash_base =3D=3D 0) {
> =C2=A0		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base =3D memblock_find_in_range(0, arm64_dma32_phys_limit,
> +		crash_base =3D memblock_find_in_range(0,
> +				arm64_dma_phys_limit ? : arm64_dma32_phys_limit,
> =C2=A0				crash_size, SZ_2M);
> =C2=A0		if (crash_base =3D=3D 0) {
> =C2=A0			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",



--=-ttraNiikuS3d3EHqG2nf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/nEdIACgkQlfZmHno8
x/58fAgAo/JlSNiKD9iXK2qb3QBSd4FhVpD5uFEaRPFGZJ2gROTApl9USk8jOMSS
cr6z6lVl9fw+MD6xN2ceEPAFIMzlrurME4WUgZMcFoN0gLRAcW9iAlQUCQh+offk
22zl7NwD8fUYmtpWZIa3J72Ycol9q7aUotz62jcurryjO7tw1a6x3yUV2oyVJ2fq
gH+k7ozVZowGWWyW3vWU66kq7pFUuKxA/2ruehWI1cfFYardeVGpDYQTCZgerxSH
O73DfB9WdPMSz/iJFau8Nvj5/Jn/bmNlN7hLhcKgzf7kH+PKkLKtTAGQRMpHW33m
oVYuRWBQN8vbtkK4q8d/+n1HI3CZwg==
=0ERD
-----END PGP SIGNATURE-----

--=-ttraNiikuS3d3EHqG2nf--

