Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8053F2968E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 05:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369837AbgJWDlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 23:41:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37652 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438665AbgJWDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 23:41:06 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVnwk-0002Zy-37; Thu, 22 Oct 2020 23:40:54 -0400
Message-ID: <932f5931911e5ad7d730127b0784b0913045639c.camel@surriel.com>
Subject: Re: [PATCH v2] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Oct 2020 23:40:53 -0400
In-Reply-To: <alpine.LSU.2.11.2010221909060.1001@eggly.anvils>
References: <20201022124511.72448a5f@imladris.surriel.com>
         <alpine.LSU.2.11.2010221909060.1001@eggly.anvils>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BJM2GNRtwHK+6VjEB0tP"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BJM2GNRtwHK+6VjEB0tP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 19:54 -0700, Hugh Dickins wrote:
> On Thu, 22 Oct 2020, Rik van Riel wrote:
>=20
> > The allocation flags of anonymous transparent huge pages can be
> controlled
> > through the files in /sys/kernel/mm/transparent_hugepage/defrag,
> which can
> > help the system from getting bogged down in the page reclaim and
> compaction
> > code when many THPs are getting allocated simultaneously.
> >=20
> > However, the gfp_mask for shmem THP allocations were not limited by
> those
> > configuration settings, and some workloads ended up with all CPUs
> stuck
> > on the LRU lock in the page reclaim code, trying to allocate dozens
> of
> > THPs simultaneously.
> >=20
> > This patch applies the same configurated limitation of THPs to
> shmem
> > hugepage allocations, to prevent that from happening.
> >=20
> > This way a THP defrag setting of "never" or "defer+madvise" will
> result
> > in quick allocation failures without direct reclaim when no 2MB
> free
> > pages are available.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
>=20
> NAK in its present untested form: see below.

Oops. That issue is easy to fix, but indeed lets figure
out what the desired behavior is.

> I'm open to change here, particularly to Yu Xu's point (in other
> mail)
> about direct reclaim - we avoid that here in Google too: though it's
> not so much to avoid the direct reclaim, as to avoid the latencies of
> direct compaction, which __GFP_DIRECT_RECLAIM allows as a side-
> effect.
>=20
> > @@ -1887,7 +1888,8 @@ static int shmem_getpage_gfp(struct inode
> *inode, pgoff_t index,
> >       }
> > =20
> >  alloc_huge:
> > -     page =3D shmem_alloc_and_acct_page(gfp, inode, index, true);
> > +     huge_gfp =3D alloc_hugepage_direct_gfpmask(vma);
>=20
> Still looks nice: but what about the crash when vma is NULL?

That's a one line fix, but I suppose we should get the
discussion on what the code behavior should be out of
the way first :)

> Michal is right to remember pushback before, because tmpfs is a
> filesystem, and "huge=3D" is a mount option: in using a huge=3Dalways
> filesystem, the user has already declared a preference for huge
> pages.
> Whereas the original anon THP had to deduce that preference from sys
> tunables and vma madvice.

...

> But it's likely that they have accumulated some defrag wisdom, which
> tmpfs can take on board - but please accept that in using a huge
> mount,
> the preference for huge has already been expressed, so I don't expect
> anon THP alloc_hugepage_direct_gfpmask() choices will map one to one.

In my mind, the huge=3D mount options for tmpfs corresponded
to the "enabled" anon THP options, denoting a desired end
state, not necessarily how much we will stall allocations
to get there immediately.

The underlying allocation behavior has been changed repeatedly,
with changes to the direct reclaim code and the compaction
deferral code.

The shmem THP gfp_mask never tried really hard anyway,
with __GFP_NORETRY being the default, which matches what
is used for non-VM_HUGEPAGE anon VMAs.

Likewise, the direct reclaim done from the opportunistic
THP allocations done by the shmem code limited itself to
reclaiming 32 4kB pages per THP allocation.

In other words, mounting
with huge=3Dalways has never behaved
the same as the more aggressive allocations done for
MADV_HUGEPAGE VMAs.

This patch would leave shmem THP allocations for non-MADV_HUGEPAGE
mapped files opportunistic like today, and make shmem THP
allocations for files mapped with MADV_HUGEPAGE more aggressive
than today.

However, I would like to know what people think the shmem
huge=3D mount options should do, and how things should behave
when memory gets low, before pushing in a patch just because
it makes the system run smoother "without changing current
behavior too much".

What do people want tmpfs THP allocations to do?

--=20
All Rights Reversed.

--=-BJM2GNRtwHK+6VjEB0tP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+SUMUACgkQznnekoTE
3oNthQf/U4n+Z+LJjh1eCpke+camzlMm5ur9wTB4SrnOY3YXawlFNOkheJmdkWqJ
6HtLvcNZTtCfLSsjAbtg+B5aJOE7vz+XnNaMYAsS6j2sQWZzxBtJ+DKX7pzW9s97
2l8EtQ8p/Wt0Bg25tohSMcRfrFMxKPOZCdRH3fdl64RAGCHUCX+Pgn0HOT0ZyD20
UmEZj/TQhOzkWpthfkWRj/Umnpe7qcim22IFgqfGM9m/ZFdm16UrfhMzQcBgjTvr
8Vd8QysMoMn6UQX4RlTdxyTtSdeZzu1omHgchDbIprk+1GBj5UgYNlGoCmDgZv6C
ORaWkGOqNDxn5YyNca/VYYHFMl1a2A==
=70J/
-----END PGP SIGNATURE-----

--=-BJM2GNRtwHK+6VjEB0tP--

