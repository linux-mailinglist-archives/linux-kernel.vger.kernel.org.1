Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA81A6EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgDMWIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 18:08:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgDMWIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:08:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 491N6J281sz9sQx;
        Tue, 14 Apr 2020 08:08:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586815689;
        bh=wyJ5Ku0tpctX6z5I08U4hjECv+MDUzrMNPZd62YCA4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J1Oca4X7B6Esxn0VLY5O7z1EYgVwqIsX6rlNHjxAPuk7/OwZIZLnHJvP/bbSwotLJ
         QT+bsW++LX0tG1BFFEKYYImS72bQ0oF0nTGr1P41YGHwZi03I8738AyjRWpO45T7wP
         LsOoHbNInzUr5LhPZZp9jzCskAhJ5XtdVul2AX27tmllidSAeQm9/vLFkqZFVffmbw
         z0agGeP+7qFECLAn+8bbDuVsrXBQXFVF+rq30qDZm+IrUR2LjugONYcdBJvGMU4YEw
         hLSp9SjNCPJnnH4nAKWldFrbj1oK76rVKo2zmAS/Ie96Hz33sTAvp8BmsWrLJL+zol
         cnwwLqHAAyq3Q==
Date:   Tue, 14 Apr 2020 08:08:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sh: mm: Fix build error
Message-ID: <20200414080807.78ac80d0@canb.auug.org.au>
In-Reply-To: <20200413161542.78700-1-linux@roeck-us.net>
References: <20200413161542.78700-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TE+C4ztpmHm5MtnELXTQ1RR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, 13 Apr 2020 09:15:42 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
>   415 |  if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot)
>       |     ^
> arch/sh/mm/init.c:424:1: error: expected expression before '}' token
>   424 | }
>=20
> Obviously never even compile tested.
>=20
> Fixes: a332976e0184 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index b9de2d4fa57e..8d2a68aea1fc 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages =3D size >> PAGE_SHIFT;
>  	int ret;
> =20
> -	if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot)
> +	if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot))
>  		return -EINVAL;
> =20
>  	/* We only have ZONE_NORMAL, so this is easy.. */
> --=20
> 2.17.1
>=20

I'll put this in my fixes tree until someone else picks it up.  Now
that the patch has reached Linus' tree (and its SHA1 is stable), the
Fixes line should be

Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")

--=20
Cheers,
Stephen Rothwell

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6U4scACgkQAVBC80lX
0GzuaggAiunNmiGzWHsiJnhwckuvgfzuWDgnMD1AlVndH55MC0HoiVLjhi0HzjHn
ISkQ50OgghtXu1p5lxBpUQc4xmyDV2pvo408xOf6Oufd8V2S23DEMZR3wQdIqNCu
8Uk34qbrdPRqjG/eZb0J9J5u3xQ1BOwZnZWG2MsMQ/tBLJQ4BBcQ2ShL9vlhLPJQ
ivKFnNEDwGgFEcyTCMDhWqnoZqVMpEzGfD3F/HVii8ChhaNw2ctMhJ1awG8W1efK
mWABEU/bhLog84txiMICSRlPiJFT8hcfr5PsIF7P6fbCsh55alXLUh4j33ycOCEX
sUCnljlP3VbfgBEIBxy/o+7gkU8N2w==
=D2Bg
-----END PGP SIGNATURE-----

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR--
