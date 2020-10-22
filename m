Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A93295FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894954AbgJVNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:25:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34480 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507061AbgJVNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:25:28 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVaan-0007zP-Jb; Thu, 22 Oct 2020 09:25:21 -0400
Message-ID: <004062456494e9003b0f71b911f06f8c58a12797.camel@surriel.com>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 22 Oct 2020 09:25:21 -0400
In-Reply-To: <20201022081532.GJ23790@dhcp22.suse.cz>
References: <20201021234846.5cc97e62@imladris.surriel.com>
         <20201022081532.GJ23790@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-S6o55Dk7sGpm11/Uyo3G"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S6o55Dk7sGpm11/Uyo3G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 10:15 +0200, Michal Hocko wrote:
> On Wed 21-10-20 23:48:46, Rik van Riel wrote:
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
>=20
> I remmeber I wanted to unify this in the past as well. The patch got
> reverted in the end. It was a long story and I do not have time to
> read
> through lengthy discussions again. I do remember though that there
> were
> some objections pointing out that shmem has its own behavior which is
> controlled by the mount option - at least for the explicitly mounted
> shmems. I might misremember.

That is not entirely true, though.

THP has two main sysfs knobs: "enabled" and "defrag"

The mount options
control the shmem equivalent options
for "enabled", but they do not do anything for the "defrag"
equivalent options.

This patch applies the "defrag" THP options to
shmem.

> [...]
>=20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 537c137698f8..d1290eb508e5 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1545,8 +1545,11 @@ static struct page
> > *shmem_alloc_hugepage(gfp_t gfp,
> >  		return NULL;
> > =20
> >  	shmem_pseudo_vma_init(&pvma, info, hindex);
> > -	page =3D alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY |
> > __GFP_NOWARN,
> > -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> > true);
> > +	/* Limit the gfp mask according to THP configuration. */
> > +	gfp |=3D __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
>=20
> What is the reason for these when alloc_hugepage_direct_gfpmask
> provides
> the full mask?

The mapping_gfp_mask for the shmem file might have additional
restrictions above and beyond the gfp mask returned by
alloc_hugepage_direct_gfpmask, and I am not sure we should just
ignore the mapping_gfp_mask.

That is why this patch takes the union of both gfp masks.

However, digging into things more, it looks like shmem inodes
always have the mapping gfp mask set to GFP_HIGHUSER_MOVABLE,
and it is never changed, so simply using the output from
alloc_hugepage_direct_gfpmask should be fine.

I can do the patch either way. Just let me know what you prefer.

> > +	gfp &=3D alloc_hugepage_direct_gfpmask(&pvma);
> > +	page =3D alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0,
> > numa_node_id(),
> > +			       true);
> >  	shmem_pseudo_vma_destroy(&pvma);
> >  	if (page)
> >  		prep_transhuge_page(page);
> >=20
> > --=20
> > All rights reversed.
--=20
All Rights Reversed.

--=-S6o55Dk7sGpm11/Uyo3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+RiEEACgkQznnekoTE
3oNyPQf8DJWaHRulqI0zU7h6A5fMQC9csTAy5hwygvjAL5MDI3WbuVIqhOYxJJmZ
8m89mr7foiLfsSiyAGXvF3cQ1ysyxjp4ddg/YJFmSS2aQ4j7DQ+pu5mr/CQFvcje
fRmNgXKnh4LJkRW6wX/5RX7U13xNL3Qi0C5K5Vg1Nn0pr9ujq6Aq5qPoyICtYl3K
ENbI6QZMdXZPglqwB/cUxIsFtqOr9WLfPls0ytHm6dspB7JGzQyXRiYi5G8afzmz
6qhBECGY9EPQWZ6kOJwb0efKz+FlhI6owJ7S4oeCyv4pt4byihxEbfVqC2+4BrVm
p3V23yuYKliuaOXexp5PhhWgMjQwaw==
=IxrV
-----END PGP SIGNATURE-----

--=-S6o55Dk7sGpm11/Uyo3G--

