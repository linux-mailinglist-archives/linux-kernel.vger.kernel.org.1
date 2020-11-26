Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9792C5CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbgKZUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:14:43 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40312 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKZUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:14:43 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kiNf1-0007dD-UQ; Thu, 26 Nov 2020 15:14:35 -0500
Message-ID: <0db03554214e8a84c890a03ff6502e3c75db7c56.camel@surriel.com>
Subject: Re: [PATCH 3/3] mm,thp,shmem: make khugepaged obey tmpfs mount flags
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
Date:   Thu, 26 Nov 2020 15:14:34 -0500
In-Reply-To: <cc08c0b4-84b3-5aa0-4c96-03f3767eec56@suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
         <20201124194925.623931-4-riel@surriel.com>
         <eda496c8-e248-c8fe-e7bd-f7e71d20e499@suse.cz>
         <8f2428a049f2c29f092782699bcb3af76bf72b6a.camel@surriel.com>
         <cc08c0b4-84b3-5aa0-4c96-03f3767eec56@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Iko6vb8mwgrbi/3mSMUt"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Iko6vb8mwgrbi/3mSMUt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-26 at 20:42 +0100, Vlastimil Babka wrote:
> On 11/26/20 7:14 PM, Rik van Riel wrote:
> > On Thu, 2020-11-26 at 18:18 +0100, Vlastimil Babka wrote:
> > >=20
> > This patch makes khugepaged treat the mount options
> > and/or
> > sysfs flag as enabling collapsing of huge pages in case
> > enabled =3D [always] for regular THPs.
> >=20
> > Should I send another patch on top
> > of this that causes
> > khugepaged to be enabled when regular THPs are disabled,
> > but shmem THPs are enabled in any way?
>=20
> I think it would make sense. Although it might involve counting
> thp-enabled shmem mounts and only run khugepaged when there are >0 of
> them.

That seems feasible. I can do that as a follow-up 4/3
patch after the Thanksgiving weekend :)

--=20
All Rights Reversed.

--=-Iko6vb8mwgrbi/3mSMUt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl/ADKoACgkQznnekoTE
3oNeeggAtfMYAJ9ersho1Vt9x7gbzcYm5Hu/TcvWCZFOppy2qXS5kdq+7X+QTKaW
XUdI72CexjKGTZ8ZnLP5qb+LSUZ7JTJkve86wXiG+cFCoN416qFwpq796hpMBfRe
1JJCn6WHyU89o4bMknSxrQUCZ3NVFZNDI/noBgJ/cdlYh6Y/yL6UwnS4zuX2hCIq
2yliRmHApgXBA8kGyVrcxNtQldSynxEt/BESel2VkgbX2HUwEUNnQopECukFYsjv
AeaNYNUhKaN/NI5G73JEqCGBKNr6kfLuZPNgq/HqraLKTmnkDN5Zll4dCdHj8u3x
iGTzJWNjzdLqxMHM2kWmHX/hk/mOKA==
=wldL
-----END PGP SIGNATURE-----

--=-Iko6vb8mwgrbi/3mSMUt--

