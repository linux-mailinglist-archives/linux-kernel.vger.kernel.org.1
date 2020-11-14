Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7542B2B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 04:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKNDky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 22:40:54 -0500
Received: from shelob.surriel.com ([96.67.55.147]:35020 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:40:54 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kdmQa-0001Ct-TF; Fri, 13 Nov 2020 22:40:40 -0500
Message-ID: <05f80e300fd4907b99837b5973db8985b7312d3f.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri, 13 Nov 2020 22:40:40 -0500
In-Reply-To: <20201112112242.GA12240@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
         <20201105191508.1961686-3-riel@surriel.com>
         <20201112112242.GA12240@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7F+/Ry5KAuETO7mOz6Ly"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7F+/Ry5KAuETO7mOz6Ly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 12:22 +0100, Michal Hocko wrote:
> [Cc Chris for i915 and Andray]
>=20
> On Thu 05-11-20 14:15:08, Rik van Riel wrote:
> > Matthew Wilcox pointed out that the i915 driver opportunistically
> > allocates tmpfs memory, but will happily reclaim some of its
> > pool if no memory is available.
>=20
> It would be good to explicitly mention the requested gfp flags for
> those
> allocations. i915 uses __GFP_NORETRY | __GFP_NOWARN, or GFP_KERNEL.
> Is
> __shmem_rw really meant to not allocate from highmeme/movable zones?
> Can
> it be ever backed by THPs?

You are right, I need to copy the zone flags __GFP_DMA
through
__GFP_MOVABLE straight from the limiting gfp_mask
into the gfp_mask used for THP allocations, and not use
the default THP zone flags if the caller specifies something
else.

I'll send out a new version that fixes that.

> ttm might want __GFP_RETRY_MAYFAIL while shmem_read_mapping_page use
> the mapping gfp mask which can be NOFS or something else. This is
> quite
> messy already and I suspect that they are more targeting regular
> order-0
> requests. E.g. have a look at cb5f1a52caf23.
>=20
> I am worried that this games with gfp flags will lead to
> unmaintainable
> code later on. There is a clear disconnect betwen the core THP
> allocation strategy and what drivers are asking for and those
> requirements might be really conflicting. Not to mention that flags
> might be different between regular and THP pages.

That is exactly why I want to make sure the THP allocations
are never more aggressive than the gfp flags the drivers
request, and the THP allocations may only ever be less
aggressive than the order 0 gfp_mask specified by the drivers.


--=20
All Rights Reversed.

--=-7F+/Ry5KAuETO7mOz6Ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+vUbgACgkQznnekoTE
3oOgAwgAnHvtaJsxMpPNHFkPcrZjE8Zp6LrUY1qDU9vffSUstHg6juSUyEmmPUcy
EsKzmfsV7QJz8kdMvBZW0MzrjJOQHNqlYTY3F9pv2ndFKy6WZe7WiCzXhH/VTHdk
YDuDdNHJEjmL6kP/gaJMtYStbWxYv2fsxpGF0tq22Qn0FCAiLdLOXZD0699lOmxm
kdMdYb0hJ8Gxj1YP6nW9bqb4KIH0MPFkxUgqb+B/DVxq63VA6mv+Iumzq705IhGW
ymNXaBGXT8ZT8cgVbVQ5mzQcZolASKdmjE6pMJh5Y55LPo+54gUUubYC1j6TGrIk
UCdzdX1+pAGEnCvbdgf/3m14JkNNvg==
=KN5R
-----END PGP SIGNATURE-----

--=-7F+/Ry5KAuETO7mOz6Ly--

