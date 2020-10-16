Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0329022F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406382AbgJPJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:47:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406221AbgJPJrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:47:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602841627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDB5UEUrkBNCh2xtKefDnttBa3itZcKarLkBKMAP85c=;
        b=GHhY115QpXOP/li/piMyOcErB3jxQAbmT6uDTeto7iEt7jEEWDFm46UWJgxB4J70q7CxEx
        Y9R+JypcumFRJAyZvNv3+bF70X6pTJk+b/87IhZz5Oire3KSpPPdvRmWezqnb2y3L7LfJs
        Mr50b0oRnRY9v94DQAmV5cY48PP8mRg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACAD6ACF1;
        Fri, 16 Oct 2020 09:47:07 +0000 (UTC)
Date:   Fri, 16 Oct 2020 11:47:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, ltp@lists.linux.it,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201016094702.GA95052@blackbook>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20201014190749.24607-1-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> SLAB objects which outlive their memcg are moved to their parent
> memcg where they may be uncharged. However if they are moved to the
> root memcg, uncharging will result in negative page counter values as
> root has no page counters.
Why do you think those are reparented objects? If those are originally
charged in a non-root cgroup, then the charge value should be propagated up the
hierarchy, including root memcg, so if they're later uncharged in root
after reparenting, it should still break even. (Or did I miss some stock
imbalance?)

(But the patch seems justifiable to me as objects (not)charged directly to
root memcg may be incorrectly uncharged.)

Thanks,
Michal

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl+JbBAACgkQia1+riC5
qSjC0w//aMd+WraEXQVcGywU5HBwq4ZhMLA8dUsyH97TuiT8gtiKLwMm/uwbS7HC
D7h+DRxt7TdyUrTAqmmQpqbfDL1hBRUXvBHpy8SxLYqulPYmSpt2WIKNP7ph3e6J
A4RGJqUxI5p0tepxMYD9ixRNaGH8mR7koXgGsxBsFTgXOnQiwwDbJuXoVcf4zpAR
Niel4m7H4BHrzqeas8NQMN6oe+cLyMVz3M3pH/GCNwDRztVFSe+23ygJYxZ3R+3M
Kd7FGn/Ny8izuDDEL786DojBi+uar+FlXMKPvhk6WJqGKsmMs63vxpClKnHECJ0d
V/7ZQlqQeFkjyp1No+JnGOQbHUlgX4J9LQwF1mI9PpOP6u1enzk2briQ7GA1+kEd
bMC8oyFdALFTUFqZNaNOKdrFLp2cTJLzxmy7FxGEfBtVkey/FGSFLFwPhi7EGKnQ
fyIsIlZJnPE0LqNkj3WUJquGpA6YJLlJHsXAn79UI2qZaHLBH0IiebP8fUmkAwwX
rg9v6BuK1/jOEJK79L6dTPrkbnuhyCpM79ww3opWdg67VOLdaPvvD14VL7ovPClE
QO2p4PRN8soZo+bjSP0wx8N1FDKMsn0DN8GWdblqKxlS3rPltNcIjx7HZs1Nf8ef
uMFg1Tf61euYE/nJxP7sxBMW+I+O6OtGo8Z15FqmjhO4K6UJv3c=
=pMdi
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
