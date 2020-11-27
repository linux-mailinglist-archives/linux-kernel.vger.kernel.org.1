Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2F2C6C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgK0Tfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:35:52 -0500
Received: from shelob.surriel.com ([96.67.55.147]:41944 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgK0TEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:04:23 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kij1v-0007WR-DO; Fri, 27 Nov 2020 14:03:39 -0500
Message-ID: <1f089a155d7501fb156da34744d282ae1f3d02f7.camel@surriel.com>
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Date:   Fri, 27 Nov 2020 14:03:39 -0500
In-Reply-To: <20201127075214.GK31550@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
         <20201124194925.623931-3-riel@surriel.com>
         <20201126134034.GI31550@dhcp22.suse.cz>
         <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
         <20201127075214.GK31550@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RB8Eea94dyjyyrlX+Tly"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RB8Eea94dyjyyrlX+Tly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-11-27 at 08:52 +0100, Michal Hocko wrote:
> On Thu 26-11-20 13:04:14, Rik van Riel wrote:
> >=20
> > I would be more than happy to implement things differently,
> > but I am not sure what alternative you are suggesting.
>=20
> Simply do not alter gfp flags? Or warn in some cases of a serious
> mismatch.
> E.g. GFP_ZONEMASK mismatch because there are already GFP_KERNEL users
> of
> shmem.

Not altering the gfp flags is not really an option,
because that would leads to attempting to allocate THPs
with GFP_HIGHUSER, which is what is used to allocate
regular tmpfs pages.

If the THP configuration in sysfs says we should
not
be doing compaction/reclaim from THP allocations, we
should obey that configuration setting, and use a=20
gfp_flags that results in no compaction/reclaim being done.

--=20
All Rights Reversed.

--=-RB8Eea94dyjyyrlX+Tly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl/BTYsACgkQznnekoTE
3oNVKwf/YO7U3RY5EPlAxFp0mzT+lGD3lKNx4dwZIkDqYpubeNo7+9Tc7+w8piu3
d1c07oZ5+r047lNnKx45UvzFdk1nBmO/Fc1QrV+e5inquCH+cSeYGOFelzOIF2k3
lASvGfF2tF634Z9MgpRPdLT2U/LS6o7e6B94n8SiKV0LXVxQH07UbhriQrSp62BV
9CjGfdWnDv+REXxQ0f0yvSShBgUWhnyKijcGia9CTSoszzOj3LvlD8jvdi6/RT13
x/bEhNGUFvTlfoNVYLRpZe3TUrXxEaXO4YfX9eiTEEM2EJcfNk9SWi/kuVelKdIv
Djk8hPni4259RnY0+c9hUEse4ok76g==
=NORH
-----END PGP SIGNATURE-----

--=-RB8Eea94dyjyyrlX+Tly--

