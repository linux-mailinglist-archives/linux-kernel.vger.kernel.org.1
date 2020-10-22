Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989F52962EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901932AbgJVQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:41:00 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34856 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897708AbgJVQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:40:59 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVde2-0001c1-45; Thu, 22 Oct 2020 12:40:54 -0400
Message-ID: <62fc8d07474acaccb65a9e20a4ebc0127e417f05.camel@surriel.com>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Yu Xu <xuyu@linux.alibaba.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 22 Oct 2020 12:40:53 -0400
In-Reply-To: <f0b4a9de-1f2f-4147-e188-c946207fb29e@linux.alibaba.com>
References: <20201021234846.5cc97e62@imladris.surriel.com>
         <f0b4a9de-1f2f-4147-e188-c946207fb29e@linux.alibaba.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-292l4+Z5viPK7NhuvnQt"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-292l4+Z5viPK7NhuvnQt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-23 at 00:00 +0800, Yu Xu wrote:
> On 10/22/20 11:48 AM, Rik van Riel wrote:
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
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >=20
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index c603237e006c..0a5b164a26d9 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
> >   extern void pm_restrict_gfp_mask(void);
> >   extern void pm_restore_gfp_mask(void);
> >  =20
> > +extern gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct
> > *vma);
> > +
> >   #ifdef CONFIG_PM_SLEEP
> >   extern bool pm_suspended_storage(void);
> >   #else
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9474dbc150ed..9b08ce5cc387 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -649,7 +649,7 @@ static vm_fault_t
> > __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >    *	    available
> >    * never: never stall for any thp allocation
> >    */
> > -static inline gfp_t alloc_hugepage_direct_gfpmask(struct
> > vm_area_struct *vma)
> > +gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> >   {
> >   	const bool vma_madvised =3D !!(vma->vm_flags & VM_HUGEPAGE);
> >  =20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 537c137698f8..d1290eb508e5 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1545,8 +1545,11 @@ static struct page
> > *shmem_alloc_hugepage(gfp_t gfp,
> >   		return NULL;
> >  =20
> >   	shmem_pseudo_vma_init(&pvma, info, hindex);
> > -	page =3D alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY |
> > __GFP_NOWARN,
> > -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> > true);
> > +	/* Limit the gfp mask according to THP configuration. */
> > +	gfp |=3D __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> > +	gfp &=3D alloc_hugepage_direct_gfpmask(&pvma);
>=20
> It is fine to reuse `alloc_hugepage_direct_gfpmask`, but
> `pvma.vm_flags & VM_HUGEPAGE` is always false here, thus,
> `vma_madvised` in `alloc_hugepage_direct_gfpmask` will always
> be false.
>=20
> That is why I chose to do the gfp_mask fixup in `shmem_getpage_gfp`,
> using `sgp_huge` to indicate `vma_madvised`, although with some silly
> mistakes pointed out by you, in another mail thread.
>=20
> It will be better if vma_madvised is well handled in your solution.

OK, let me send a v2 that does that!

By just passing a correct gfp_mask to shmem_alloc_and_acct_page
we can also avoid the gfp gymnastics in shmem_alloc_hugepage
that Michal rightfully objected to.

--=20
All Rights Reversed.

--=-292l4+Z5viPK7NhuvnQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+RthUACgkQznnekoTE
3oNW0Af/ZErgA5cOrDiHMkRlcH76fPdw8whz+iN9/tqmguNEPBLntOEkULl+gH8n
aHiI0F8OIt8oZTWoA4JowhOx1VCadr30XVaiNFym/3audu+Hsh9i8kf4FKGwxxb6
9khP8JubPidppIIBnt8q3TQvnFH/I5J6op2W2DKTs9lNFjxHkVzMpJDVyOm7i0Iq
b+7yWS5RtJ2pszvI7T8BDT+UkWdB8Sl6mEC11SWaSGXm6X38viZVixG23PY/ZIl6
G9xoM2YYKcwqmb9aupwJuw2Xwei1q6aCnpTEEZ8eDdu8KLg5czCBjd9pyKZmqqSi
gQs/ORiXvPLraSX2sZaLksh1PenTLw==
=6hGB
-----END PGP SIGNATURE-----

--=-292l4+Z5viPK7NhuvnQt--

