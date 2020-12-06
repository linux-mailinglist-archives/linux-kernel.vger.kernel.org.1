Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC42D074E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgLFVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLFVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:23:46 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D93C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 13:23:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cpzts34czz9s0b;
        Mon,  7 Dec 2020 08:23:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607289783;
        bh=QXJv5rQAuvJXSdzKHz5CVLKM0VuBTaxgnfWWdCcPApU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VvVSo2EVyfcCio4gDwUyVwFLbSQZpyue/az25GosgosbjEda5ASRUdw/KOGLzHxdG
         bKrm6tJlLsuXs9bnEtaFYqF4ldRwIvhA7UAaE3832p+fEj68jCJxwhew2e/Q8iD2B+
         nO0B4r18sBDGY7Ku9OuSKwB+dBctdyavn8NTiuPkYfJ2F2q1G7dsfc2z1GG4XzrdNV
         h90ravuKZdSCazToPwEoSMnl/g2OPlVWv8KDXYG470yYM+CrHph6zC0ZHAlbdo3ZnL
         9skof3IR6VAzjDVB2ve1ZZjXREJoEnMzVgPB7g83mVN96WvnH3JX+jCw4Qf3ZR0pN4
         /GiwuretCyLtQ==
Date:   Mon, 7 Dec 2020 08:23:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hui Su <sh_def@163.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        catalin.marinas@arm.com, will@kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][next] arm64: fix the mm build error in mm/kfence/core.c
Message-ID: <20201207082300.38f5207f@canb.auug.org.au>
In-Reply-To: <20201205172207.GA4097@rlk>
References: <20201205172207.GA4097@rlk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sSZisTaGwE5c11mY0g8zusg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sSZisTaGwE5c11mY0g8zusg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

[Cc'd Andrew Morton]

On Sun, 6 Dec 2020 01:22:07 +0800 Hui Su <sh_def@163.com> wrote:
>
> When I build kernel with ARCH=3Darm64, the building errors came out like
> this:
>   CC      mm/kfence/core.o
> In file included from ../mm/kfence/core.c:21:
> ../arch/arm64/include/asm/kfence.h: In function =E2=80=98kfence_protect_p=
age=E2=80=99:
> ../arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of
> function =E2=80=98set_memory_valid=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>    12 |  set_memory_valid(addr, 1, !protect);
>       |  ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> which introduced by commit d54febeba2ff ("kfence: use pt_regs to
> generate stack trace on faults").
>=20
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  arch/arm64/include/asm/kfence.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfe=
nce.h
> index 6c0afeeab635..4d73e34da59d 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -4,6 +4,7 @@
>  #define __ASM_KFENCE_H
> =20
>  #include <asm/cacheflush.h>
> +#include <linux/set_memory.h>
> =20
>  static inline bool arch_kfence_init_pool(void) { return true; }
> =20
> --=20
> 2.25.1

Added to linux-next today.  I think it actually fixes patch "arm64,
kfence: enable KFENCE for ARM64" since that actually introduces the
set_memory_valid() call?

--=20
Cheers,
Stephen Rothwell

--Sig_/sSZisTaGwE5c11mY0g8zusg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/NS7QACgkQAVBC80lX
0Gx/XAf+OE391j6jUIK/ujTlOgChCFCuytOwxQCwYIeO1CDnZsEv6giKomsQwFiD
SvPBszinqCFafCWjheWRPo+BMPWzlo78EYrRdtRGCA5tc380ZsJq5U+dPsVnXN4S
rtiuGLpY7yXF570HiZlVSmTb6+jH78oe7tWLiYd+tVXggW8UNNX1RQaEYy3COSQt
zbKYLoFdwfASyvceoklniBKSaut4MSqiGcbNP7ypx50/jxKEv8ZpR7tlweoqsW+H
6mcSrnp/biAyCI6GwchfeJDK13Y6rtx7nY29C6RyMoNBeW3i8gtXhBVISXU0GmQF
Wh4Cz7FOSV7wrr0Yc+rrp+ghIaZ8Ag==
=bS46
-----END PGP SIGNATURE-----

--Sig_/sSZisTaGwE5c11mY0g8zusg--
