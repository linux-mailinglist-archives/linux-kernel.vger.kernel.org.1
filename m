Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99242288BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbgJIOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:38:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:39214 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbgJIOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:38:32 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kQtXK-00076v-Lf; Fri, 09 Oct 2020 10:38:22 -0400
Message-ID: <82a7690e181cf1995e733120dad828e628cb80d9.camel@surriel.com>
Subject: Re: [PATCH 0/2] mm,swap: skip swap readahead for instant IO (like
 zswap)
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com, sjenning@redhat.com,
        ddstreet@ieee.org, konrad.wilk@oracle.com, hannes@cmpxchg.org
Date:   Fri, 09 Oct 2020 10:38:22 -0400
In-Reply-To: <8b68bf5f6b041a75a62a1908214279a45722dda6.camel@surriel.com>
References: <20200922020148.3261797-1-riel@surriel.com>
         <20200922101250.527d9e676fefbb4c8d0cd5b9@linux-foundation.org>
         <8b68bf5f6b041a75a62a1908214279a45722dda6.camel@surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k60RIuQHusUl9KWWws/D"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k60RIuQHusUl9KWWws/D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-05 at 13:32 -0400, Rik van Riel wrote:
> On Tue, 2020-09-22 at 10:12 -0700, Andrew Morton wrote:
> > On Mon, 21 Sep 2020 22:01:46 -0400 Rik van Riel <riel@surriel.com>
> > wrote:

> > Any quantitative testing results?
>=20
> I have test results with a real workload now.
>=20
> Without this patch, enabling zswap results in about an=20
> 8% increase in p99 request latency. With these patches,
> the latency penalty for enabling zswap is under 1%.

Never mind that. On larger tests the effect seems to disappear,
probably because the logic in __swapin_nr_pages() already reduces
the number of pages read ahead to 2 on workloads with lots of
random access.

That reduces the latency effects observed.

Now we might
still see some memory waste due to decompressing
pages we don't need, but I have not seen any real effects from
that yet, either.

I think it may be time to focus on a larger memory waste with
zswap: leaving the compressed copy of memory around when we
decompress the memory at swapin time.  More aggressively freeing
the compressed memory will probably buy us more than reducing
readahead.

--=20
All Rights Reversed.

--=-k60RIuQHusUl9KWWws/D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+Add4ACgkQznnekoTE
3oMWOwf/Y2Os9TF60rmXZz3GfPj0PJEwiaZahgqw980IbInRx2YG3rrcnYvLUW9h
54bhIK65h/q94iDktf1y4XHEW8vkHDQalV5794DMw7ensXC97swrHaQ8s66nQgnQ
TNlffRJghZgQa7ERNQ1pzDrDIlSUGqgu1a2OT0EJIlBvD5qlxEIB1k363HHpc906
md9AzXF+Rigj9AV9+6BCtb/ROGj7bbT8OMuRD19MbHBSF2SkaR9rjawkkdYMHWdd
kRBlO2GYJDrO1wxBBBeqSYgI+TcH1o3vhDG1Cb3PPV4GB/BuLgORf8N8Bx1380pd
7U0KZ2FnGOYrBWeb3ufFUyIWc33/6w==
=5PNd
-----END PGP SIGNATURE-----

--=-k60RIuQHusUl9KWWws/D--

