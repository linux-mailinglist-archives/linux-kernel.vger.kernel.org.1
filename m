Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553372B2B20
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 04:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKNDoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 22:44:21 -0500
Received: from shelob.surriel.com ([96.67.55.147]:35042 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:44:21 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kdmU8-0001JI-Om; Fri, 13 Nov 2020 22:44:20 -0500
Message-ID: <84effe90c3ee13fbfa6e732d2e3b3d9b557d1be1.camel@surriel.com>
Subject: Re: [PATCH 1/2] mm,thp,shmem: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Date:   Fri, 13 Nov 2020 22:44:20 -0500
In-Reply-To: <20201112105258.GZ12240@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
         <20201105191508.1961686-2-riel@surriel.com>
         <20201112105258.GZ12240@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-otlc1Hj05zsRUDVw4HK7"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-otlc1Hj05zsRUDVw4HK7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 11:52 +0100, Michal Hocko wrote:
> On Thu 05-11-20 14:15:07, Rik van Riel wrote:
> >=20
> > This patch applies the same configurated limitation of THPs to
> > shmem
> > hugepage allocations, to prevent that from happening.
>=20
> I believe you should also exaplain why we want to control defrag by
> the
> global knob while the enable logic is per mount.

I added that to the changelog for the next version of
the patches.

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
> This begs some numbers. A little is rather bad unit of performance. I
> do
> agree that unifying those makes sense in general though.

The aggressiveness is in changes to the gfp_mask, eg by
adding __GFP_NORETRY. How that translates into THP
allocation success rates is entirely dependent on the
workload and on what else is in memory at the time.

I am not sure any
numbers I could gather will be
representative for anything but the workloads I am
testing.

However, I did find an issue in hugepage_vma_check
that prevents khugepaged from collapsing pages on
shmem filesystems mounted with huge=3Dalways or
huge=3Dwithin_size when transparent_hugepage/enabled
is set to [madvise].

The next version of the series will have a third
patch, in order to fix that.

--=20
All Rights Reversed.

--=-otlc1Hj05zsRUDVw4HK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+vUpQACgkQznnekoTE
3oMiXAgAqQFQLZCkPNXA5l/N7WEMWji2pTMavF9GX5YIzJD5EowvnAUv4EQvyFFN
ZMYSkoHVvQSHiT3OqdrWMXEgx/FJU1aSj0DQX9GWYtA8QLR30WeDReqmlD6P//Ud
FB37RuszfWHMh/hSdtrk0BrvSVtPAxEiFitPFEsek8WRTUIkMaaiwigIcrL77ooB
5Q1AuNhA4UplVmdG3dZlHB6J8ECPIYkSk/bmYviraDmwqFW17tkUwzl+S6cBGncd
Ay0TmrHQvII+a+HCdT11I1QJlgp4dDMg2Cbc2VEVK0pZoAsEGuyS3j0bPRxoxV3u
6Hd4G/mGZhXxPuVoMxKx8z2hFAB8Lg==
=ZErD
-----END PGP SIGNATURE-----

--=-otlc1Hj05zsRUDVw4HK7--

