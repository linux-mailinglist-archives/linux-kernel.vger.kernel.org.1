Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBE2C5BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbgKZSO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:14:58 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40134 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404196AbgKZSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:14:58 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kiLnD-0007lT-Rk; Thu, 26 Nov 2020 13:14:55 -0500
Message-ID: <8f2428a049f2c29f092782699bcb3af76bf72b6a.camel@surriel.com>
Subject: Re: [PATCH 3/3] mm,thp,shmem: make khugepaged obey tmpfs mount flags
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
Date:   Thu, 26 Nov 2020 13:14:55 -0500
In-Reply-To: <eda496c8-e248-c8fe-e7bd-f7e71d20e499@suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
         <20201124194925.623931-4-riel@surriel.com>
         <eda496c8-e248-c8fe-e7bd-f7e71d20e499@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pjHMC/LhDPh+SjBdooxx"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pjHMC/LhDPh+SjBdooxx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-26 at 18:18 +0100, Vlastimil Babka wrote:
> On 11/24/20 8:49 PM, Rik van Riel wrote:
> > Currently if thp enabled=3D[madvise], mounting a tmpfs filesystem
> > with huge=3Dalways and mmapping files from that tmpfs does not
> > result in khugepaged collapsing those mappings, despite the
> > mount flag indicating that it should.
> >=20
> > Fix that by breaking up the blocks of tests in hugepage_vma_check
> > a little bit, and testing things in the correct order.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Fixes: c2231020ea7b ("mm: thp: register mm for khugepaged when
> > merging vma for shmem")
>=20
> Looks ok. But, it we have sysfs thp enabled=3Dnever, and shmem mount
> explicitly=20
> thp enabled, then shmem mount overrides the global sysfs setting and
> thp's will=20
> be allocated there, right? However, khugepaged_enabled() will be
> false and thus=20
> khugepaged won't run at all? So a similar situation than what you're
> fixing here.

Indeed, that is somewhat similar. Whether or not shmem
allocations attempt huge pages is controlled by both
the file /sys/kernel/mm/transparent_hugepage/shmem_enabled
and mount options.

This patch makes khugepaged treat the mount options
and/or
sysfs flag as enabling collapsing of huge pages in case
enabled =3D [always] for regular THPs.

Should I send another patch on top
of this that causes
khugepaged to be enabled when regular THPs are disabled,
but shmem THPs are enabled in any way?

--=20
All Rights Reversed.

--=-pjHMC/LhDPh+SjBdooxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+/8J8ACgkQznnekoTE
3oNbZgf/diF51qurPmCQ6k1Qm78hFdIIcawa0JQGueXEj9erGFEInRK6t0fHlhKM
FdbfTqlwRq1bPMQiuTvdDkpKHr/D1wX4aDh9UnAQ4oeOLsLHwF1k+HJh/XRjjDmx
WwF68eL6mR6nNX28xjB7IPE9j3TjcHKHHrIcl0zhohf9zfv3Clk+idnFbO/1W8ns
9WBfK1+QClmspFfTw91d9nh20Q0m0sYL15CoEymbl+VKu3CIq6Cwf3IGIRJkmmtN
3u5HIiaBUyZrflSaLJcvqAkwg/afi5nPdDuAhgXA6WyW+c4ICRgyOQthZ2EWN/bE
OIcIgCHTz4a1+AguzTF9AEpw7R+Flw==
=/Xou
-----END PGP SIGNATURE-----

--=-pjHMC/LhDPh+SjBdooxx--

