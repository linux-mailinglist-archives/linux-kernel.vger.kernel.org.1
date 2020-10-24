Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB5297DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762755AbgJXRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:53:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50068 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762749AbgJXRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:53:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kWNix-0001VD-Js; Sat, 24 Oct 2020 13:53:03 -0400
Message-ID: <e8bb0a68d2881d01143701eb81aee94b2448fd68.camel@surriel.com>
Subject: Re: [PATCH v4] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Date:   Sat, 24 Oct 2020 13:53:03 -0400
In-Reply-To: <20201024020922.GH20115@casper.infradead.org>
References: <20201023204804.3f8d19c1@imladris.surriel.com>
         <20201024020922.GH20115@casper.infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EsNs16WKP7UDH8iBf2MT"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EsNs16WKP7UDH8iBf2MT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-24 at 03:09 +0100, Matthew Wilcox wrote:
> On Fri, Oct 23, 2020 at 08:48:04PM -0400, Rik van Riel wrote:
> > The allocation flags of anonymous transparent huge pages can be
> > controlled
> > through the files in /sys/kernel/mm/transparent_hugepage/defrag,
> > which can
> > help the system from getting bogged down in the page reclaim and
> > compaction
> > code when many THPs are getting allocated simultaneously.
> >=20
> > However, the gfp_mask for shmem THP allocations were not limited by
> > those
> > configuration settings, and some workloads ended up with all CPUs
> > stuck
> > on the LRU lock in the page reclaim code, trying to allocate dozens
> > of
> > THPs simultaneously.
> >=20
> > This patch applies the same configurated limitation of THPs to
> > shmem
> > hugepage allocations, to prevent that from happening.
> >=20
> > This way a THP defrag setting of "never" or "defer+madvise" will
> > result
> > in quick allocation failures without direct reclaim when no 2MB
> > free
> > pages are available.
> >=20
> > With this patch applied, THP allocations for tmpfs will be a little
> > more aggressive than today for files mmapped with MADV_HUGEPAGE,
> > and a little less aggressive for files that are not mmapped or
> > mapped without that flag.
>=20
> How about this code path though?
>=20
> shmem_get_pages() [ in i915 ]
>   shmem_read_mapping_page_gfp(__GFP_NORETRY | __GFP_NOWARN)
>     shmem_getpage_gfp()
>       shmem_alloc_and_acct_page()
>         shmem_alloc_hugepage()
>=20
> I feel like the NORETRY from i915 should override whatever is set
> in sysfs for anon THPs.  What do others think?

It looks like currently the only way to get a THP
allocation with __GFP_DIRECT_RECLAIM and without
__GFP_NORETRY (which does nothing without
__GFP_DIRECT_RECLAIM) is to explicitly do an
madvise MADV_HUGEPAGE on a VMA.

I am not convinced the i915 driver should
override a userspace madvise.

--=20
All Rights Reversed.

--=-EsNs16WKP7UDH8iBf2MT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+Uaf8ACgkQznnekoTE
3oNrlgf+IvnPSk5SIIzWtcHHyoBUttjdDn/ziiCG76djIOfJPxDT1MjfNQIfpfyX
tB4txq8aA/m+oj6GMwO59Jlc9+R7Fyj8C21io14RQXJRCamjkRqWqOl5g82AHrq4
Pi8D7hYOV5bHFk1HoODZaj5JGHYi6bq8NS4tVftu5UEXR+eVrwfdwn/0Hgt+EEjP
8zIXZp59TZon1abCGaCangNHFbcn5krBDyQl1sAazwSxdxnnpb2o33+8cwOIugYI
u442yl7EvM14AWN0DtYCdbk26SNPThNxTuT1MszAIqouUFTsyepruNcmP/+2mo43
M7K0Ce1tT3gjj7Lrh7ZfOuaR8sRxbw==
=x0QG
-----END PGP SIGNATURE-----

--=-EsNs16WKP7UDH8iBf2MT--

