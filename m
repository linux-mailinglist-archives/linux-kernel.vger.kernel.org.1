Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970882C1498
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgKWTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:40:09 -0500
Received: from shelob.surriel.com ([96.67.55.147]:34044 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgKWTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:40:08 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1khHgm-0000JQ-AI; Mon, 23 Nov 2020 14:39:52 -0500
Message-ID: <482cd78039988c1fd8bbc6fd27d366ef8240fd80.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Mon, 23 Nov 2020 14:39:51 -0500
In-Reply-To: <20201119093842.GC12284@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
         <20201105191508.1961686-3-riel@surriel.com>
         <20201112112242.GA12240@dhcp22.suse.cz>
         <05f80e300fd4907b99837b5973db8985b7312d3f.camel@surriel.com>
         <20201119093842.GC12284@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZaYzvldGh7aMYruBgXCN"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZaYzvldGh7aMYruBgXCN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-19 at 10:38 +0100, Michal Hocko wrote:
> On Fri 13-11-20 22:40:40, Rik van Riel wrote:
> > On Thu, 2020-11-12 at 12:22 +0100, Michal Hocko wrote:
> > > [Cc Chris for i915 and Andray]
> > >=20
> > > On Thu 05-11-20 14:15:08, Rik van Riel wrote:
> > > > Matthew Wilcox pointed out that the i915 driver
> > > > opportunistically
> > > > allocates tmpfs memory, but will happily reclaim some of its
> > > > pool if no memory is available.
> > >=20
> > > It would be good to explicitly mention the requested gfp flags
> > > for
> > > those
> > > allocations. i915 uses __GFP_NORETRY | __GFP_NOWARN, or
> > > GFP_KERNEL.
> > > Is
> > > __shmem_rw really meant to not allocate from highmeme/movable
> > > zones?
> > > Can
> > > it be ever backed by THPs?
> >=20
> > You are right, I need to copy the zone flags __GFP_DMA
> > through
> > __GFP_MOVABLE straight from the limiting gfp_mask
> > into the gfp_mask used for THP allocations, and not use
> > the default THP zone flags if the caller specifies something
> > else.
> >=20
> > I'll send out a new version that fixes that.
>=20
> Can we make one step back here and actually check whether all this is
> actually needed for those shmem users before adding more hacks here
> and
> there?

It doesn't look like that is needed, after all.

The i915 driver seems to support having its buffer in
highmem, the shmem_pwrite and shmem_pread functions
both do kmap/kunmap.

--=20
All Rights Reversed.

--=-ZaYzvldGh7aMYruBgXCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+8EAcACgkQznnekoTE
3oPd6gf+K9bMnqk68rVZ68I36e/78wBXaOu/OpnKOSIt/EI35lRcZvejcl36syMi
61OV+ktbCT06mvNfLW+rPFs2C+0kIhaCbpHHBxrZ/BCqyK1yJpLU0/ga0WJXTKWd
uDckzvHWhsjJIU5PknfrPYerOmIzXEwo7AtiK1po+xxuyLhdSW0hsTlf63IJwrLE
PrCBhqyjionteIwo3Oa+sZXzLVialNfTy0JAhLyjPfguf0Niv10UNKFHrhKs5ps9
ez1OV4d+0kOXU+ozTqjhOjy1la2YJoKug8N3jcTVyCFDYiOCrDoAglYoWzKDJTot
DJ52bJIE4KkIZd8n2fydlpDBuXVVUA==
=+auh
-----END PGP SIGNATURE-----

--=-ZaYzvldGh7aMYruBgXCN--

