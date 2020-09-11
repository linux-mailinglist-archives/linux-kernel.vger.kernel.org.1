Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C062266891
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 21:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgIKTKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 15:10:42 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:39760 "EHLO
        1.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIKTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:10:40 -0400
Received: from player737.ha.ovh.net (unknown [10.108.54.141])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 260969CA8F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 21:10:35 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id F01A5C9A58B6;
        Fri, 11 Sep 2020 19:10:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G00563ebb549-6379-4903-9510-438db0f803e1,
                    B3063C92EDE29B5A09E12E435EF56C89C4C75BBC) smtp.auth=steve@sk2.org
Date:   Fri, 11 Sep 2020 21:10:26 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix references to nommu-mmap.rst
Message-ID: <20200911211026.349af8bd@heffalump.sk2.org>
In-Reply-To: <20200812092230.27541-1-steve@sk2.org>
References: <20200812092230.27541-1-steve@sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/AuRstjFKFLZyfdUTEZCfQ9i"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 14675542335775460851
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeekffdvhfejkeffudekhedvtddvhfeiheehvdehkeetkedufeejffeuueevvddvnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AuRstjFKFLZyfdUTEZCfQ9i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

This is still relevant as far as I can tell; master and docs-next still have
references to the old nommu-mmap.rst.

Regards,

Stephen

On Wed, 12 Aug 2020 11:22:30 +0200, Stephen Kitt <steve@sk2.org> wrote:
> nommu-mmap.rst was moved to Documentation/admin-guide/mm; this patch
> updates the remaining stale references to Documentation/mm.
>=20
> Fixes: 800c02f5d030 ("docs: move nommu-mmap.txt to admin-guide and rename=
 to ReST")
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  init/Kconfig | 2 +-
>  mm/Kconfig   | 2 +-
>  mm/nommu.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/init/Kconfig b/init/Kconfig
> index 2dd5531dae98..8d5fefd1f229 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1957,7 +1957,7 @@ config MMAP_ALLOW_UNINITIALIZED
>  	  userspace.  Since that isn't generally a problem on no-MMU systems,
>  	  it is normally safe to say Y here.
>=20
> -	  See Documentation/mm/nommu-mmap.rst for more information.
> +	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
>=20
> config SYSTEM_DATA_VERIFICATION
>  	def_bool n
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d41f3fa7e923..29e239497718 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -387,7 +387,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
>  	  This option specifies the initial value of this option.  The default
>  	  of 1 says that all excess pages should be trimmed.
> =20
> -	  See Documentation/mm/nommu-mmap.rst for more information.
> +	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.=
=20
>=20
> config TRANSPARENT_HUGEPAGE
>  	bool "Transparent Hugepage Support"
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 64539971188b..e8e2c5bb6f0a 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -5,7 +5,7 @@
>   *  Replacement code for mm functions to support CPU's that don't
>   *  have any form of memory management unit (thus no virtual memory).
>   *
> - *  See Documentation/mm/nommu-mmap.rst
> + *  See Documentation/admin-guide/mm/nommu-mmap.rst
>   *
>   *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
>   *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
>=20
> base-commit: e176b7a3054eef44a22f6ca3d14168dcf9bad21e
> --=20
> 2.20.1
>=20

--Sig_/AuRstjFKFLZyfdUTEZCfQ9i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl9by6IACgkQgNMC9Yht
g5zJug/+PuyOts/ThOL3MseC1uGD+F/sYHoE+CzyUG3QBb+FwbsNVlnOPNNRbcSY
OcTG8r/fgx4sLGWbBGeFBTcvD2CR77bHkMbZ1y+SH7O10nN9yDAZlCpmUks/oazL
1RqgC5wLu3zZ3wJ7iLR0Dl9lkN9qbxaV+wj1hUr+AAOIapmHtzXagGQgtI3Wyzds
ChFTxUrMdMSS9cXrXtrUrQhU2DupiO56U4fIT8TkG7QgeFoGHmlgcxKSnKAG6lZ8
R9uZFsuzn9TfQGCItThWkA2RersrgZNru/hKwqDLfNby3Enzs9dI/BZxz+BF0twO
qeFd5cMCfEXyftuXfnOnK1Aof7uTpHZaNKs+JWLNDL2NiMps84MSpHzn9D/sDJN6
CCibbMf0MZiuplrK/7zGaw1gToP8u9lpRlfEnFxhV0TGikW2s0N0xJAPJ7dRzdvo
s03lYMnvdzLwAB+Ti4ZIqwR/TnE+6Q3vBFv+HsYEpbVo2TQl/DvcMpP+L34k9/E0
gXTeubC25JV63alRxYs/qp0YcLcBCzrp6st0Mzve28m7mURHE9KpCePZshvryDOY
opz8cpIUHu3ryZDjkgaUR5+rAZp8EzWSBDxAuKmJ/lmbm8P4F0ljCuN1qcvOgm9V
EJh0eOoqPOZUcIJ4LtUb/KRmQV1UQGUOWcrSaZib9MXXObqhLzU=
=sUfx
-----END PGP SIGNATURE-----

--Sig_/AuRstjFKFLZyfdUTEZCfQ9i--
