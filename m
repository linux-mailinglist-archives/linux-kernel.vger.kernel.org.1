Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9D2FDF75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393215AbhAUCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbhAUAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:54:27 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86644C061799;
        Wed, 20 Jan 2021 16:51:55 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLkP36cXsz9sWX; Thu, 21 Jan 2021 11:51:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611190311;
        bh=4XY02JUHw2V8ifw4fSSSuVxTks+mIDisjW6+cTQT458=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqDlZUwyebpTERTojlYKcGcNn7aZwNmTQnugbnLgC+tKQ1F5WfthFA87USMCYLQME
         ugrZqpJEy87bLF96YisDZ6e9aPFdgZf47meCln+0O5/lehWnbV5hdXsD2VBbtFZssR
         GiCn83vMeQVg9wWpEezwDDU6alhwCZspZyJaOm7o=
Date:   Thu, 21 Jan 2021 11:44:57 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 3/5] scripts: dtc: Remove the unused fdtdump.c file
Message-ID: <20210121004457.GD5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 12:36:45PM +0530, Viresh Kumar wrote:
> This was copied from external DTC repository long back and isn't used
> anymore. Over that the dtc tool can be used to generate the dts source
> back from the dtb. Remove the unused fdtdump.c file.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Doesn't this make updating the kernel dtc from upstream needlessly
more difficult?

> ---
>  scripts/dtc/fdtdump.c | 163 ------------------------------------------
>  1 file changed, 163 deletions(-)
>  delete mode 100644 scripts/dtc/fdtdump.c
>=20
> diff --git a/scripts/dtc/fdtdump.c b/scripts/dtc/fdtdump.c
> deleted file mode 100644
> index 7d460a50b513..000000000000
> --- a/scripts/dtc/fdtdump.c
> +++ /dev/null
> @@ -1,163 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * fdtdump.c - Contributed by Pantelis Antoniou <pantelis.antoniou AT gm=
ail.com>
> - */
> -
> -#include <stdint.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <ctype.h>
> -
> -#include <fdt.h>
> -#include <libfdt_env.h>
> -
> -#include "util.h"
> -
> -#define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
> -#define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))
> -#define GET_CELL(p)	(p +=3D 4, *((const uint32_t *)(p-4)))
> -
> -static void print_data(const char *data, int len)
> -{
> -	int i;
> -	const char *p =3D data;
> -
> -	/* no data, don't print */
> -	if (len =3D=3D 0)
> -		return;
> -
> -	if (util_is_printable_string(data, len)) {
> -		printf(" =3D \"%s\"", (const char *)data);
> -	} else if ((len % 4) =3D=3D 0) {
> -		printf(" =3D <");
> -		for (i =3D 0; i < len; i +=3D 4)
> -			printf("0x%08x%s", fdt32_to_cpu(GET_CELL(p)),
> -			       i < (len - 4) ? " " : "");
> -		printf(">");
> -	} else {
> -		printf(" =3D [");
> -		for (i =3D 0; i < len; i++)
> -			printf("%02x%s", *p++, i < len - 1 ? " " : "");
> -		printf("]");
> -	}
> -}
> -
> -static void dump_blob(void *blob)
> -{
> -	struct fdt_header *bph =3D blob;
> -	uint32_t off_mem_rsvmap =3D fdt32_to_cpu(bph->off_mem_rsvmap);
> -	uint32_t off_dt =3D fdt32_to_cpu(bph->off_dt_struct);
> -	uint32_t off_str =3D fdt32_to_cpu(bph->off_dt_strings);
> -	struct fdt_reserve_entry *p_rsvmap =3D
> -		(struct fdt_reserve_entry *)((char *)blob + off_mem_rsvmap);
> -	const char *p_struct =3D (const char *)blob + off_dt;
> -	const char *p_strings =3D (const char *)blob + off_str;
> -	uint32_t version =3D fdt32_to_cpu(bph->version);
> -	uint32_t totalsize =3D fdt32_to_cpu(bph->totalsize);
> -	uint32_t tag;
> -	const char *p, *s, *t;
> -	int depth, sz, shift;
> -	int i;
> -	uint64_t addr, size;
> -
> -	depth =3D 0;
> -	shift =3D 4;
> -
> -	printf("/dts-v1/;\n");
> -	printf("// magic:\t\t0x%x\n", fdt32_to_cpu(bph->magic));
> -	printf("// totalsize:\t\t0x%x (%d)\n", totalsize, totalsize);
> -	printf("// off_dt_struct:\t0x%x\n", off_dt);
> -	printf("// off_dt_strings:\t0x%x\n", off_str);
> -	printf("// off_mem_rsvmap:\t0x%x\n", off_mem_rsvmap);
> -	printf("// version:\t\t%d\n", version);
> -	printf("// last_comp_version:\t%d\n",
> -	       fdt32_to_cpu(bph->last_comp_version));
> -	if (version >=3D 2)
> -		printf("// boot_cpuid_phys:\t0x%x\n",
> -		       fdt32_to_cpu(bph->boot_cpuid_phys));
> -
> -	if (version >=3D 3)
> -		printf("// size_dt_strings:\t0x%x\n",
> -		       fdt32_to_cpu(bph->size_dt_strings));
> -	if (version >=3D 17)
> -		printf("// size_dt_struct:\t0x%x\n",
> -		       fdt32_to_cpu(bph->size_dt_struct));
> -	printf("\n");
> -
> -	for (i =3D 0; ; i++) {
> -		addr =3D fdt64_to_cpu(p_rsvmap[i].address);
> -		size =3D fdt64_to_cpu(p_rsvmap[i].size);
> -		if (addr =3D=3D 0 && size =3D=3D 0)
> -			break;
> -
> -		printf("/memreserve/ %llx %llx;\n",
> -		       (unsigned long long)addr, (unsigned long long)size);
> -	}
> -
> -	p =3D p_struct;
> -	while ((tag =3D fdt32_to_cpu(GET_CELL(p))) !=3D FDT_END) {
> -
> -		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */
> -
> -		if (tag =3D=3D FDT_BEGIN_NODE) {
> -			s =3D p;
> -			p =3D PALIGN(p + strlen(s) + 1, 4);
> -
> -			if (*s =3D=3D '\0')
> -				s =3D "/";
> -
> -			printf("%*s%s {\n", depth * shift, "", s);
> -
> -			depth++;
> -			continue;
> -		}
> -
> -		if (tag =3D=3D FDT_END_NODE) {
> -			depth--;
> -
> -			printf("%*s};\n", depth * shift, "");
> -			continue;
> -		}
> -
> -		if (tag =3D=3D FDT_NOP) {
> -			printf("%*s// [NOP]\n", depth * shift, "");
> -			continue;
> -		}
> -
> -		if (tag !=3D FDT_PROP) {
> -			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n", depth * shift, "", tag=
);
> -			break;
> -		}
> -		sz =3D fdt32_to_cpu(GET_CELL(p));
> -		s =3D p_strings + fdt32_to_cpu(GET_CELL(p));
> -		if (version < 16 && sz >=3D 8)
> -			p =3D PALIGN(p, 8);
> -		t =3D p;
> -
> -		p =3D PALIGN(p + sz, 4);
> -
> -		printf("%*s%s", depth * shift, "", s);
> -		print_data(t, sz);
> -		printf(";\n");
> -	}
> -}
> -
> -
> -int main(int argc, char *argv[])
> -{
> -	char *buf;
> -
> -	if (argc < 2) {
> -		fprintf(stderr, "supply input filename\n");
> -		return 5;
> -	}
> -
> -	buf =3D utilfdt_read(argv[1]);
> -	if (buf)
> -		dump_blob(buf);
> -	else
> -		return 10;
> -
> -	return 0;
> -}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAIzokACgkQbDjKyiDZ
s5JdRA/+LEoYwlHACnK4yyiPQPUaFka5d6Us8H3Rgd5bIurBfI2o0fpxOrVOW9Mq
MJqboHrnBoDvYmIn1VuD7N2H2+hCDOH6mC1lre+oF6ZvS+1vfEJuH4K3/axY6qMu
RLh/lw1J3qrEUItOcSm+qmT0ipmve2RBPDa5IYGvgrNiofaT8HrXdFxIbaOtTcAk
OWh7NhWOuftmh5UsH/7kHgY5WMMB9OQx2R0Q6ZF7c4T+z5RIWohBta/QKDfhPH+S
N8tklZW1QO4EjarX5W6hk8gKxv/fBcfRmjYm0iS6K0kZQtxYSXVY/nudpI84VCz2
bWJe1u5UEa05DY6GiRqMgcFgTyhd3kfKhiV+xCWXV/DWPantN3IFIMLXCNDRI5Sq
ZtIKHkjKDKwJ57g4OHZeyQCgVWsLUAtsMHGs7552XychgWXvXCCJF4x269JvGYvN
gSFd3lWqmopnant08nc3yYEgBMfFajNBwHq2KaQqOalwg9jgvP/UzjQInPEHiuqy
DMQnuVmipwxM6sGj592OkrexBtslXclhbJ6znkbHIKhHpT/qowjXdGW98wTMdDAY
p3zQtU3nJbSaexW2CDvRNX6kkD7Z8OuHURtyctU3o6yKzhOgCd9tn0vPM0fP6CAM
iqzvPxOLyTt50NYSW4lYD7yQKpaw+tctq9Da/SlZOZ1n0LyTyBo=
=X8WY
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
