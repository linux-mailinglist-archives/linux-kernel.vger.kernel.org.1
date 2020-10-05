Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA14283D55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgJERdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:33:07 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35418 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgJERdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:33:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kPUM6-0000l1-SW; Mon, 05 Oct 2020 13:32:58 -0400
Message-ID: <8b68bf5f6b041a75a62a1908214279a45722dda6.camel@surriel.com>
Subject: Re: [PATCH 0/2] mm,swap: skip swap readahead for instant IO (like
 zswap)
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com, sjenning@redhat.com,
        ddstreet@ieee.org, konrad.wilk@oracle.com, hannes@cmpxchg.org
Date:   Mon, 05 Oct 2020 13:32:58 -0400
In-Reply-To: <20200922101250.527d9e676fefbb4c8d0cd5b9@linux-foundation.org>
References: <20200922020148.3261797-1-riel@surriel.com>
         <20200922101250.527d9e676fefbb4c8d0cd5b9@linux-foundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1HlrNNuV+v0YHd1dQ6AW"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1HlrNNuV+v0YHd1dQ6AW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-22 at 10:12 -0700, Andrew Morton wrote:
> On Mon, 21 Sep 2020 22:01:46 -0400 Rik van Riel <riel@surriel.com>
> wrote:
>=20
> > Both with frontswap/zswap, and with some extremely fast IO devices,
> > swap IO will be done before the "asynchronous" swap_readpage() call
> > has returned.
> >=20
> > In that case, doing swap readahead only wastes memory, increases
> > latency, and increases the chances of needing to evict something
> > more
> > useful from memory. In that case, just skip swap readahead.
>=20
> Any quantitative testing results?

I have test results with a real workload now.

Without this patch, enabling zswap results in about an=20
8% increase in p99 request latency. With these patches,
the latency penalty for enabling zswap is under 1%.

Enabling zswap
allows us to give the main workload a
little more memory, since the spikes in memory demand
caused by things like system management software no=20
longer cause large latency issues.

--=20
All Rights Reversed.

--=-1HlrNNuV+v0YHd1dQ6AW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl97WMoACgkQznnekoTE
3oOuNAf/VvedH4o2JVSglsPQJhfZtcQGs3NKxtf4aeYMG6zaraNif96uDsLkPXg6
FyglKUUold3TutubxTQCmlzaLg1Pzgd78Y5zjDrn1sUDgbADbIxBSYBrm9S092GE
40JpStSZilhDIQmW/FL3GdIwiKgzrHZCRacKv0PWQiXZuWm15jLMPWX6RcnrGbQI
ZKqGQ031JDlyvrUuHnOKvPAj1GkjLOcRbfv8HMbREGuExhUTMmEE5JB5t+GYYkzk
0NV4kt2KWN0j2fV/h+qdXc04uVdljhb7I18ffoG4LV/lPUIRN47K+ljXwgkbVGPP
H34Pi6YbUfgBwqEULfZfLxKW+BUUPw==
=HycA
-----END PGP SIGNATURE-----

--=-1HlrNNuV+v0YHd1dQ6AW--

