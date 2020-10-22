Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB6296253
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509803AbgJVQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:06:07 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34810 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509103AbgJVQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:06:06 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVd6I-0001B5-5w; Thu, 22 Oct 2020 12:06:02 -0400
Message-ID: <1b2d262c30bd839ac433587532a27ad800df4771.camel@surriel.com>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 22 Oct 2020 12:06:01 -0400
In-Reply-To: <20201022155022.GO23790@dhcp22.suse.cz>
References: <20201021234846.5cc97e62@imladris.surriel.com>
         <20201022081532.GJ23790@dhcp22.suse.cz>
         <004062456494e9003b0f71b911f06f8c58a12797.camel@surriel.com>
         <20201022155022.GO23790@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wvz+2MOzMn/WApU4E/BN"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wvz+2MOzMn/WApU4E/BN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 17:50 +0200, Michal Hocko wrote:
> On Thu 22-10-20 09:25:21, Rik van Riel wrote:
> > On Thu, 2020-10-22 at 10:15 +0200, Michal Hocko wrote:
> > > On Wed 21-10-20 23:48:46, Rik van Riel wrote:
> > > >=20
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index 537c137698f8..d1290eb508e5 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -1545,8 +1545,11 @@ static struct page
> > > > *shmem_alloc_hugepage(gfp_t gfp,
> > > >  		return NULL;
> > > > =20
> > > >  	shmem_pseudo_vma_init(&pvma, info, hindex);
> > > > -	page =3D alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY
> > > > |
> > > > __GFP_NOWARN,
> > > > -			HPAGE_PMD_ORDER, &pvma, 0,
> > > > numa_node_id(),
> > > > true);
> > > > +	/* Limit the gfp mask according to THP configuration.
> > > > */
> > > > +	gfp |=3D __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> > >=20
> > > What is the reason for these when alloc_hugepage_direct_gfpmask
> > > provides
> > > the full mask?
> >=20
> > The mapping_gfp_mask for the shmem file might have additional
> > restrictions above and beyond the gfp mask returned by
> > alloc_hugepage_direct_gfpmask, and I am not sure we should just
> > ignore the mapping_gfp_mask.
>=20
> No, we shouldn't. But I do not see why you should be adding the above
> set of flags on top.

Because THP allocations are higher order and optimistic,
and we want them to:
1) be annotated as compound allocations
2) fail (and fall back to 4kB allocations) when they cannot
   be easily satisfied, and
3) not create a spew of allocation failure backtraces on
   the (serial) console when these THP allocations fail

> > That is why this patch takes the union of both gfp masks.
> >=20
> > However, digging into things more, it looks like shmem inodes
> > always have the mapping gfp mask set to GFP_HIGHUSER_MOVABLE,
> > and it is never changed, so simply using the output from
> > alloc_hugepage_direct_gfpmask should be fine.
> >=20
> > I can do the patch either way. Just let me know what you prefer.
>=20
> I would just and the given gfp with alloc_hugepage_direct_gfpmask

That would miss the three things we definitely want
from above.

--=20
All Rights Reversed.

--=-wvz+2MOzMn/WApU4E/BN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+RrekACgkQznnekoTE
3oNChQf/UY8pCMckiHFSU+R6OCOYkOQNWfU+qtKY18MVaPiqBOKsZ7F6rdDmyeUg
ZlJxLSo8R0lz6Fnk2RRU4A0L8zQCaVVQjXw/XQTeb6e+6SP7uWczXiCuezzxnpxO
S49OLYoK47qVbp/FI6yEesOFHE3dh0k4WQXvbRwI+Z63p7HB99Yw/hFo9VD0BCzx
Ja+S3E0nakrTsobwTtAVBfi3xRabUN901EaL9C0khrW2hQcf1f2tV85d9oQTvrT8
WDjBgeoxIRhpbFdv2X9+xymGhcwYk43DEL3RGBOYKhov0uovA50dVW5WnjtiXfhy
NsZ4nffWqm4LmVUZFTBKfm/IxAsJZw==
=S5Ks
-----END PGP SIGNATURE-----

--=-wvz+2MOzMn/WApU4E/BN--

