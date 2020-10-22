Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85C29618C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901304AbgJVPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:16:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34696 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901297AbgJVPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:16:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVcK3-0000pJ-7H; Thu, 22 Oct 2020 11:16:11 -0400
Message-ID: <f33747ae2787388ec89e587f5f14a767560b882e.camel@surriel.com>
Subject: Re: [PATCH] mm/shmem: fix up gfpmask for shmem hugepage allocation
From:   Rik van Riel <riel@surriel.com>
To:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org
Cc:     hughd@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        VlastimilBabka <vbabka@suse.cz>
Date:   Thu, 22 Oct 2020 11:16:10 -0400
In-Reply-To: <11e1ead211eb7d141efa0eb75a46ee2096ee63f8.1603267572.git.xuyu@linux.alibaba.com>
References: <11e1ead211eb7d141efa0eb75a46ee2096ee63f8.1603267572.git.xuyu@linux.alibaba.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NO2+ukY9FXiPfB4rJuJV"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NO2+ukY9FXiPfB4rJuJV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-21 at 16:09 +0800, Xu Yu wrote:

> @@ -1887,6 +1930,7 @@ static int shmem_getpage_gfp(struct inode
> *inode, pgoff_t index,
>  	}
> =20
>  alloc_huge:
> +	gfp =3D shmem_hugepage_gfpmask_fixup(gfp, sgp_huge);
>  	page =3D shmem_alloc_and_acct_page(gfp, inode, index, true);
>  	if (IS_ERR(page)) {
>  alloc_nohuge:

This looks it could be a bug, because the changed
gfp flags are also used for the non-huge allocation
below the alloc_nohuge: label, when the huge allocation
fails.

Using a separate huge_gfp variable would solve that
issue.

However, your patch also changes the meaning of
SHMEM_HUGE_FORCE from "override mount flags" to
"aggressively try reclaim and compaction", which
mixes up the equivalents of the anon THP sysctl
"enabled" and "defrag" settings.

I believe it makes sense to continue keeping the
"what should khugepaged do with these pages?" and
"how hard should we try at allocation time?" settings
separately for shmem the same way they are kept
separately for anonymous memory.

I also suspect it is simplest if shmem uses the
same "how hard should we try at allocation time?"
settings from the "defrag" sysfs file, instead
of giving system administrators two knobs that they
will likely want to set to the same value anyway.

Coincidentally, I have been looking at the same
code on and off for the past month, and also sent
a patch to the list to fix this issue yesterday.

I suspect my patch can be simplified a little more
by directly using alloc_hugepage_direct_gfpmask to
create a huge_gfp flag in shmem_getpage_gfp.

https://lore.kernel.org/linux-mm/20201021234846.5cc97e62@imladris.surriel.c=
om/

--=20
All Rights Reversed.

--=-NO2+ukY9FXiPfB4rJuJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+RojoACgkQznnekoTE
3oMtbAgApfrn8Wh8rXaZFyRMK7jp9ky7Ndr5yPFJhHrs4RVL7Je7En4oVt0Phy/i
Rq5EWBARSLBngRvfvXm13N7SQZXk8aNWQLIwgyFjGLm+BTVAJBp9i2+2QzYZxRCf
IbMBIM3M+awJNjOZ0iw/h82V4PjOv5l5e59poYF4T15G+qqP/HXwbVJFUuRX5pAH
+a7q6olFIlBl17huVrakuYgi3AHWyYUs4zAoxvhlzIQ+bcR+v1tDmP8BWFv0/Pc/
ELZ+yzlK9gxAKNZBUP8bjxNri7ZxXsR1+OyNG9aOwbnQioCvKFcglt9gn6CGGzZ8
baU0hds485oQsDY374u6q9qFQ8VuFA==
=Xew8
-----END PGP SIGNATURE-----

--=-NO2+ukY9FXiPfB4rJuJV--

