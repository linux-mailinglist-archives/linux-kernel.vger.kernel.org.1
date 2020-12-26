Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE372E2DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 11:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgLZKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 05:36:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:38340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgLZKgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 05:36:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AEAAACBA;
        Sat, 26 Dec 2020 10:35:59 +0000 (UTC)
Message-ID: <407ae3b1d7da3d1e7aa3e815e1af27832b914aa5.camel@suse.de>
Subject: Re: [PATCH 1/2] arm64: mm: update the comments about ZONE_DMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     ardb@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        xiexiuqi@huawei.com
Date:   Sat, 26 Dec 2020 11:35:58 +0100
In-Reply-To: <20201226033557.116251-2-chenzhou10@huawei.com>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
         <20201226033557.116251-2-chenzhou10@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yzrYLKX+HQDF7PmSpu8s"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yzrYLKX+HQDF7PmSpu8s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-12-26 at 11:35 +0800, Chen Zhou wrote:
> Since patchset "arm64: Default to 32-bit wide ZONE_DMA", ZONE_DMA's
> size is fine-tuned. In the absence of addressing limited masters,
> ZONE_DMA will span the whole 32-bit address space, otherwise, in
> the case of the Raspberry Pi 4, it'll only span the 30-bit address
> space. Update the comments.
>=20
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

> =C2=A0arch/arm64/mm/init.c | 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 75addb36354a..7b9809e39927 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -53,10 +53,11 @@ s64 memstart_addr __ro_after_init =3D -1;
> =C2=A0EXPORT_SYMBOL(memstart_addr);
> =C2=A0
>=20
> =C2=A0/*
> - * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first 1G =
of
> - * memory as some devices, namely the Raspberry Pi 4, have peripherals w=
ith
> - * this limited view of the memory. ZONE_DMA32 will cover the rest of th=
e 32
> - * bit addressable memory area.
> + * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is fine-tuned=
.
> + * In the absence of addressing limited masters, ZONE_DMA will span the
> + * whole 32-bit address space, otherwise, in the case of the Raspberry P=
i 4,
> + * it'll only span the 30-bit address space. ZONE_DMA32 will cover the r=
est
> + * of the 32 bit addressable memory area.
> =C2=A0=C2=A0*/
> =C2=A0phys_addr_t arm64_dma_phys_limit __ro_after_init;
> =C2=A0static phys_addr_t arm64_dma32_phys_limit __ro_after_init;



--=-yzrYLKX+HQDF7PmSpu8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/nEg4ACgkQlfZmHno8
x/4/tAf9G70tDzHyXfBIunFJFLQvW3GCHcT82gHS+ffxslDWgtK1BXWxoT9tnxaA
EZITup2zjYfiWsSGUQofJ9XsJ7HxxyvFWV4+f62eDslJLCJIN/EG244u1O66dc1J
G4fokAvbIDuL0S8eIWPZkUH8r/7PAYa6nh22FwcmAC4Y4f8rzGvWfOZUJwvWjQUj
LZSZ029UpufqKDX+cTu2/7IxQjVMprxWZiSSIU5HY8BPk3h9AaUInCAVB9rbTNSk
A75pCCu823yYdf6XO16Ura9rFHJOFp+B2xGsJq6pnDg/hUAI7qLjyBGvVi6UjDQC
HJTYqbRw5ApNUiIH6j2ZyM8HTJ9mUA==
=iIgg
-----END PGP SIGNATURE-----

--=-yzrYLKX+HQDF7PmSpu8s--

