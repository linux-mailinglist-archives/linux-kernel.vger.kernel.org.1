Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A292C5B83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404750AbgKZSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:04:25 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40104 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404742AbgKZSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:04:25 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kiLcu-0003WL-9h; Thu, 26 Nov 2020 13:04:16 -0500
Message-ID: <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Date:   Thu, 26 Nov 2020 13:04:14 -0500
In-Reply-To: <20201126134034.GI31550@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
         <20201124194925.623931-3-riel@surriel.com>
         <20201126134034.GI31550@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-67VJL8SKwNL83SFfDlDI"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-67VJL8SKwNL83SFfDlDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-26 at 14:40 +0100, Michal Hocko wrote:
> On Tue 24-11-20 14:49:24, Rik van Riel wrote:
> > Matthew Wilcox pointed out that the i915 driver opportunistically
> > allocates tmpfs memory, but will happily reclaim some of its
> > pool if no memory is available.
> >=20
> > Make sure the gfp mask used to opportunistically allocate a THP
> > is always at least as restrictive as the original gfp mask.
>=20
> I have brought this up in the previous version review and I feel my
> feedback hasn't been addressed. Please describe the expected behavior
> by
> those shmem users including GFP_KERNEL restriction which would make
> the
> THP flags incompatible. Is this a problem? Is there any actual
> problem
> if the THP uses its own set of flags?

In the case of i915, the gfp flags passed in by the i915
driver expect the VM to easily fail the allocation, in
which case the i915 driver will reclaim some existing
buffers and try again.

Trying harder than the original gfp_mask would
change
the OOM behavior of systems using the i915 driver.

> I am also not happy how those two sets of flags are completely
> detached
> and we can only expect surprises there.=20

I would be more than happy to implement things differently,
but I am not sure what alternative you are suggesting.

--=20
All Rights Reversed.

--=-67VJL8SKwNL83SFfDlDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+/7h4ACgkQznnekoTE
3oNYDwgAgSEz682PGBHWXeILtW9myPB2wDN8OOoSivRAGnVaJpQNflUsNke/pHMK
ONtKDDwMRqE11vzjbqZUYPFfpYeDLyizno01z2j0NzrqU4pKBBYUZb32q6Nd39eU
nZfpUtSxVWTS/r/GiC7BVwqJF/SkVQ8io8nlWZX2Thku6jdbo28spalaDw2hqIRV
978iyF1ljYpA20x6tZyZK5krhBecGqDHW4HDpuoo/ut8lj0IcXWQ3nFfzDLSkYIY
hfU/Ltl3+59OYya4ghvJ9BlpiLHTon/2lPEDdbQrrjzcxai663iuwzuNwA00S4PY
xrgK853amtt+fS4wx1brw3JZyWJXnA==
=Eoqq
-----END PGP SIGNATURE-----

--=-67VJL8SKwNL83SFfDlDI--

