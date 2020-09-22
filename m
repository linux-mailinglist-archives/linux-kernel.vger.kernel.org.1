Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB652740E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIVLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:33:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46952 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:33:18 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kKgXj-0000Pi-RK; Tue, 22 Sep 2020 07:33:07 -0400
Message-ID: <f196b291874bad247315174fadebeaaf2426d986.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,swap: skip swap readahead if page was obtained
 instantaneously
From:   Rik van Riel <riel@surriel.com>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Huang Ying <ying.huang@intel.com>
Date:   Tue, 22 Sep 2020 07:33:04 -0400
In-Reply-To: <CAC=cRTP3Em2C7tRpbFyHztnjAvUMFn-9t1yqFCb=yc3MavpUcg@mail.gmail.com>
References: <20200922020148.3261797-1-riel@surriel.com>
         <20200922020148.3261797-3-riel@surriel.com>
         <CAC=cRTP3Em2C7tRpbFyHztnjAvUMFn-9t1yqFCb=yc3MavpUcg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8MKjSXOxtDuFixMXbchb"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8MKjSXOxtDuFixMXbchb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-22 at 11:13 +0800, huang ying wrote:
> On Tue, Sep 22, 2020 at 10:02 AM Rik van Riel <riel@surriel.com>
> wrote:
> > Check whether a swap page was obtained instantaneously, for example
> > because it is in zswap, or on a very fast IO device which uses busy
> > waiting, and we did not wait on IO to swap in this page.
> > If no IO was needed to get the swap page we want, kicking off
> > readahead
> > on surrounding swap pages is likely to be counterproductive,
> > because the
> > extra loads will cause additional latency, use up extra memory, and
> > chances
> > are the surrounding pages in swap are just as fast to load as this
> > one,
> > making readahead pointless.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  mm/swap_state.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index aacb9ba53f63..6919f9d5fe88 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -637,6 +637,7 @@ static struct page
> > *swap_cluster_read_one(swp_entry_t entry,
> >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t
> > gfp_mask,
> >                                 struct vm_fault *vmf)
>=20
> Why not do this for swap_vma_readahead()
> too?  swap_cluster_read_one()
> can be used in swap_vma_readahead() too.

Good point, I should do the same thing for swap_vma_readahead()
as well. Let me do that and send in a version 2 of the series.

--=20
All Rights Reversed.

--=-8MKjSXOxtDuFixMXbchb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9p4PAACgkQznnekoTE
3oOotQf/SOLtQCYmAlruLunQUSY8oebSOdi8lRDlN0/RmW3HMSPFoNgGUTTXZrpg
HwNm1Ads9KRHPnGhm734NJo4y35cY3Gbp32TlF/LGx67dGa3u8eNKsh0KCEcvBOY
yLq6vm+q6+FAjDwUvGnXLhk3NUSsUsLKf/dFQVG6EOnS/9yzwBNTQGUmBjpVgHl2
5diVd6cbrds2KIWyffAPuV7uj2qWX/HoHtS0Nhw3olCYhxBUVDUkks8gvF9LTl18
tha1rkkURTYVdOUQcpwenif1t+kWkpmSZuNeM/C6+9A1BbU/PDYitVjq3GFj2PcI
WI8ur3DrcKI8ac/86hJjBi161rkWww==
=hW7V
-----END PGP SIGNATURE-----

--=-8MKjSXOxtDuFixMXbchb--

