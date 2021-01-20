Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426132FD5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391227AbhATQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:37:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391278AbhATQfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:35:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611160451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s6YwzblmrfTgol1+mj0JWdAyYJ9jse9PBLRY6rHGxHk=;
        b=NBWFx1L86X8PRBN5+rCLOjbaTNYVvbpKsI+x5FFA36uLn/YbSmJcxyIdAWlk3hGq8l0sSL
        60NNT+l4xUHmc/lqcJZ8TK8WioWu/mZjHTWMtXA4b4TV3RBzJKXjy6k6G22h1XqLNTOa6w
        ym5XpKQ9RB8z6z0fUSmIGAwO5x6K1zU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B95ADAC9B;
        Wed, 20 Jan 2021 16:34:11 +0000 (UTC)
Date:   Wed, 20 Jan 2021 17:34:05 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
Message-ID: <20210120163405.GA23459@blackbody.suse.cz>
References: <20210106042239.2860107-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20210106042239.2860107-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2021 at 08:22:39PM -0800, Roman Gushchin <guro@fb.com> wrot=
e:
> Imran Khan reported a regression in hackbench results caused by the
> commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages"). The regression is noticeable in the case of
> a consequent allocation of several relatively large slab objects,
> e.g. skb's. As soon as the amount of stocked bytes exceeds PAGE_SIZE,
> drain_obj_stock() and __memcg_kmem_uncharge() are called, and it leads
> to a number of atomic operations in page_counter_uncharge().
>=20
> The corresponding call graph is below (provided by Imran Khan):
>   |__alloc_skb
>   |    |
>   |    |__kmalloc_reserve.isra.61
>   |    |    |
>   |    |    |__kmalloc_node_track_caller
>   |    |    |    |
>   |    |    |    |slab_pre_alloc_hook.constprop.88
>   |    |    |     obj_cgroup_charge
>   |    |    |    |    |
>   |    |    |    |    |__memcg_kmem_charge
>   |    |    |    |    |    |
>   |    |    |    |    |    |page_counter_try_charge
>   |    |    |    |    |
>   |    |    |    |    |refill_obj_stock
>   |    |    |    |    |    |
>   |    |    |    |    |    |drain_obj_stock.isra.68   <--- draining old m=
emcg
>   |    |    |    |    |    |    |
>   |    |    |    |    |    |    |__memcg_kmem_uncharge
>   |    |    |    |    |    |    |    |
>   |    |    |    |    |    |    |    |page_counter_uncharge
>   |    |    |    |    |    |    |    |    |
>   |    |    |    |    |    |    |    |    |page_counter_cancel
> [...]
> -	page_counter_uncharge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, nr_pages);
> +	refill_stock(memcg, nr_pages);
I noticed that refill_stock(memcg,...) switches the local stock to
memcg.

In this particular call chain, the uncharged memcg is the old memcg of
stock->cached_objcg. The refill_stock() then may switch stock->cached to
the old memcg too. If the patch leads to better performance, then the
switch probably doesn't happen at this moment (and I guess
stock->cached_objcg and stock->cached can be independent to some extent,
so the old memcg in one needn't be the old in the latter).

In conclusion
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


Michal

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAIW3kACgkQia1+riC5
qSjIDg/+OWLUkCU/1PcQV9wwl/12JhETFBj0oDT5zlWzYvHDEoi0O1d6SV3+l6tf
n96FqVl0o8GJHTcy8CjDLrpi/211liRdT8BxB0EJ19SyWCbf6BFgHvOfGRxp8icF
ZDJD7MwhF2/KNaGC4SRbbhTBHoQsYHkTEN/qA1iSAzdnTtqAQo3zr15kRAEKsMnM
NgbI21Zz8n5StjQleSwiEctlnuQsARPYEUvJM1KWOt9OVnhkjBXg39gCJhyKeKoS
le8tO5Jct9FMA4kKYTsTWxAGRl9uVee/8APINY2MRwidcyGOlKX8aEg47rtzcv00
4eDj82XMFq0JFO1leJzE7r2fk9B8G1zXfHWmsU2Mg2QWGUHKQKuHBfcGkzxsTdIH
HxlORL+J4JQkxNzZnxcwbl7GB/ajkLxJNSud78WUlhyfrhMa3kRs/Qt9SUqk5IE6
TjYoHnlwMlFgQxIArkI1U8ZZ6BLtftE19TfDVBViNHdUjXY4uGLdtQofIz1QdD53
Q4QrhO6jm2HM4Qo/BJIXycBtl0u93eY7yKAe3m/cj5HhR0BOirmBesthTJAixH30
+nnXCvW5JMe0WRmNCZy5k4cYY7o8w1hIuQoMRKT8HTbfyn5c057GM1tpHAnM3WBf
imloDVzNDlyN5TbSYFvh5gDvrBI0krDI1oxU9tDxTOMwKDitL2Q=
=pRyS
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
