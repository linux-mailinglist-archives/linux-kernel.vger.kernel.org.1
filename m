Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948F42C86FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgK3Ok4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:40:56 -0500
Received: from shelob.surriel.com ([96.67.55.147]:54784 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgK3Ok4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:40:56 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kjkLR-0000v7-Ii; Mon, 30 Nov 2020 09:40:01 -0500
Message-ID: <0bf4037559563bd51f6ac68d659e9f886387fa7e.camel@surriel.com>
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Date:   Mon, 30 Nov 2020 09:40:01 -0500
In-Reply-To: <20201130100053.GD17338@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
         <20201124194925.623931-3-riel@surriel.com>
         <20201126134034.GI31550@dhcp22.suse.cz>
         <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
         <20201127075214.GK31550@dhcp22.suse.cz>
         <1f089a155d7501fb156da34744d282ae1f3d02f7.camel@surriel.com>
         <20201130100053.GD17338@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MwKFZQvAu7UAtgs7ip0f"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MwKFZQvAu7UAtgs7ip0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-30 at 11:00 +0100, Michal Hocko wrote:
> On Fri 27-11-20 14:03:39, Rik van Riel wrote:
> > On Fri, 2020-11-27 at 08:52 +0100, Michal Hocko wrote:
> > > On Thu 26-11-20 13:04:14, Rik van Riel wrote:
> > > > I would be more than happy to implement things differently,
> > > > but I am not sure what alternative you are suggesting.
> > >=20
> > > Simply do not alter gfp flags? Or warn in some cases of a serious
> > > mismatch.
> > > E.g. GFP_ZONEMASK mismatch because there are already GFP_KERNEL
> > > users
> > > of
> > > shmem.
> >=20
> > Not altering the gfp flags is not really an option,
> > because that would leads to attempting to allocate THPs
> > with GFP_HIGHUSER, which is what is used to allocate
> > regular tmpfs pages.
>=20
> Right but that is a completely different reason to alter the mask and
> it
> would be really great to know whether this is a theoretical concern
> or
> those users simply do not ever use THPs. Btw. should they be using
> THPs
> even if they opt themselves into GFP_KERNEL restriction?

I suppose disabling THPs completely if the gfp_mask
passed to shmem_getpage_gfp() is not GFP_HIGHUSER
is another option.

That seems like it might come with its own pitfalls,
though, both functionality wise and maintenance wise.

Does anyone have
strong feelings between "limit gfp_mask"
and "disable THP for !GFP_HIGHUSER"?

--=20
All Rights Reversed.

--=-MwKFZQvAu7UAtgs7ip0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl/FBEEACgkQznnekoTE
3oMGOAf/cwgErDAEtBf5TbUyPbr3g7+END1IDIIyQm7IAI7NhbuuikStX+3cDdEp
FJPP/hOHqEj3+X9j6wFwovpsnhac8C/iuCoif5QJ+5HyJbDGCcK7EKxubdTHZMD0
jyJG0U2M8XACDoXiImhfZ0P61mWeYAoOl7S+CLtAP/XcM067M2Jp+q5F+ARZRN94
2pr4z+A2xHoShqWdG/BX6pOX5O27yggZaQejLLU0uPulbitd8WP4X0zY2h4IyKtL
jD2p25Wcax8mvZJhNM/0V00/diPwI8nm6SgJIG4eGg1FKB+KkUhY9jzh8icE7vuO
LKi4pLDIHziGqlsa1Cm1MLXbVj5F2Q==
=a55D
-----END PGP SIGNATURE-----

--=-MwKFZQvAu7UAtgs7ip0f--

