Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93542A9B44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgKFRxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:53:46 -0500
Received: from shelob.surriel.com ([96.67.55.147]:35504 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKFRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:53:45 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kb5va-0001y7-U8; Fri, 06 Nov 2020 12:53:34 -0500
Message-ID: <0f50046d0195d857bf7dc5a61db0a59795c3e06b.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        mhocko@suse.com
Date:   Fri, 06 Nov 2020 12:53:33 -0500
In-Reply-To: <20201106030511.396-1-hdanton@sina.com>
References: <20201105191508.1961686-1-riel@surriel.com>
         <20201106030511.396-1-hdanton@sina.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-F/6ayGlYGx6A27zYSP72"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F/6ayGlYGx6A27zYSP72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-11-06 at 11:05 +0800, Hillf Danton wrote:
> On Thu,  5 Nov 2020 14:15:08 -0500
> > Matthew Wilcox pointed out that the i915 driver opportunistically
> > allocates tmpfs memory, but will happily reclaim some of its
> > pool if no memory is available.
> >=20
> > Make sure the gfp mask used to opportunistically allocate a THP
> > is always at least as restrictive as the original gfp mask.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  mm/shmem.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 6c3cb192a88d..ee3cea10c2a4 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1531,6 +1531,26 @@ static struct page *shmem_swapin(swp_entry_t
> > swap, gfp_t gfp,
> >  	return page;
> >  }
> > =20
> > +/*
> > + * Make sure huge_gfp is always more limited than limit_gfp.
> > + * Some of the flags set permissions, while others set
> > limitations.
> > + */
> > +static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
> > +{
> > +	gfp_t allowflags =3D __GFP_IO | __GFP_FS | __GFP_RECLAIM;
> > +	gfp_t denyflags =3D __GFP_NOWARN | __GFP_NORETRY;
> > +	gfp_t result =3D huge_gfp & ~allowflags;
> > +
> > +	/*
> > +	 * Minimize the result gfp by taking the union with the deny
> > flags,
> > +	 * and the intersection of the allow flags.
> > +	 */
> > +	result |=3D (limit_gfp & denyflags);
>=20
> Currently NORETRY is always set regardless of i915 and if it's
> determined in 1/2 then the i915 thing can be done like
>=20
> 	return huge_gfp | (limit_gfp & __GFP_RECLAIM);

No, if __GFP_KSWAPD_RECLAIM or __GFP_DIRECT_RECLAIM are
not set in either huge_gfp or limit_gfp, we want to ensure
the resulting gfp does not have it set, either.

Your suggested change
would result in __GFP_KSWAPD_RECLAIM
or __GFP_DIRECT_RECLAIM getting set if it was set in either
of the input gfp variables, which is probably not the desired
behavior.


--=20
All Rights Reversed.

--=-F/6ayGlYGx6A27zYSP72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+ljZ0ACgkQznnekoTE
3oOSCgf+JjD5NVfyruktXHepTt3ldZco3DpqfgNwKKgJEPErbxqbu78pJrYMsKgW
mRqzSfsEAxG6pvXZmm9lFbWS3MLou1UTyccSiehxdw9k9qvYW5lxsmniQz2/tjur
9PcQk4Ekp/+Ujdd/7vXBPcJ9KX3WzzCl5X10Y1h2Xlt2U24cw2Zjl2QLrfttH0IQ
pvH50zCO7K02ug4dV/zIjW4lcOj1PVBnopEoJmS55UNjEW1JODi3T0XpUPRrSDWp
uHhpImeuSHO/MgqUl2rY/c0ofJM9tZ3uZVFGUU6/796LMs1yHdX6vsWlPnVQuq4M
FpM+4SAEaK62lT8GHDVqP3gFFa/Oyw==
=GlII
-----END PGP SIGNATURE-----

--=-F/6ayGlYGx6A27zYSP72--

