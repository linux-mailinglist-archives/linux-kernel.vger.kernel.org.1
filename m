Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73AD28147F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbgJBNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:53:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56838 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:53:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kOLUf-0007D4-LO; Fri, 02 Oct 2020 09:53:05 -0400
Message-ID: <656725362af9bd757a281f0799a0bb9c9b2487bd.camel@surriel.com>
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Sebastiaan Meijer <meijersebastiaan@gmail.com>
Cc:     akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, willy@infradead.org
Date:   Fri, 02 Oct 2020 09:53:05 -0400
In-Reply-To: <20201002070333.GA21871@dhcp22.suse.cz>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
         <20201001123032.GC22560@dhcp22.suse.cz>
         <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
         <20201002070333.GA21871@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BFY58aSTZaJWRrNfOho7"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BFY58aSTZaJWRrNfOho7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-02 at 09:03 +0200, Michal Hocko wrote:
> On Thu 01-10-20 18:18:10, Sebastiaan Meijer wrote:
> > (Apologies for messing up the mailing list thread, Gmail had fooled
> > me into
> > believing that it properly picked up the thread)
> >=20
> > On Thu, 1 Oct 2020 at 14:30, Michal Hocko <mhocko@suse.com> wrote:
> > > On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > > > > yes it shows the bottleneck but it is quite artificial. Read
> > > > > data is
> > > > > usually processed and/or written back and that changes the
> > > > > picture a
> > > > > lot.
> > > > Apologies for reviving an ancient thread (and apologies in
> > > > advance for my lack
> > > > of knowledge on how mailing lists work), but I'd like to offer
> > > > up another
> > > > reason why merging this might be a good idea.
> > > >=20
> > > > From what I understand, zswap runs its compression on the same
> > > > kswapd thread,
> > > > limiting it to a single thread for compression. Given enough
> > > > processing power,
> > > > zswap can get great throughput using heavier compression
> > > > algorithms like zstd,
> > > > but this is currently greatly limited by the lack of threading.
> > >=20
> > > Isn't this a problem of the zswap implementation rather than
> > > general
> > > kswapd reclaim? Why zswap doesn't do the same as normal swap out
> > > in a
> > > context outside of the reclaim?

On systems with lots of very fast IO devices, we have
also seen kswapd take 100% CPU time without any zswap
in use.

This seems like a generic issue, though zswap does
manage to bring it out on lower end systems.

--=20
All Rights Reversed.

--=-BFY58aSTZaJWRrNfOho7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl93MMEACgkQznnekoTE
3oM2fgf/QtTnRf6iTyspPZhRqxZnXaDD8urYvTIfEZQeun7dIZsjsY7hO1GE+kLl
XI0X40UGXcCHbgi+YFxAjjoqsf2zRLK2mnzIyU/9baXolq+tepDEtSNZ+2qiCtAF
Muw+BEEU6680aP5AFl0RYvsO8WwbnmGfeTslLsJNf9ZJMCs4AYlaS9tairWMhXGw
ZUyoLjz8tJywNUc3gufu65KNE1nIXNHyxKVeEFJmBzEobRmiVLG1c3Fsz+cTC2Ue
zqaIZpAqS1H7RL3u/E01oSHhd6mDDc/PdDRkpcuyfuKdL5EGUuyoXzNhGEARvt4Z
4UkK0E03+bjtnKtyAkKqZ3KDh6h45g==
=hVUa
-----END PGP SIGNATURE-----

--=-BFY58aSTZaJWRrNfOho7--

