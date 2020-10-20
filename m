Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A475294075
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394595AbgJTQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:55126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394585AbgJTQ1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:27:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603211236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzYcROWuVOVd8ipDDT9hgv+k46oTwcfYxWb+oVaSXs4=;
        b=DV8KuQTmR4sinkZeP4ARKfFF8Bl8hg/X3enbY0qekdkeaQ11/ycvVkPD4pXcHOdhRS3u+A
        oAfX1zi0UJxQLjnRh52dyEYDQwa+d9jeVM80QfpUfNmiGfRp/8xZApxEVQMtjz7vuIe8a4
        /D1zbogUDlWk8Vjhce4CutBBjoNtRaM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B27EAC82;
        Tue, 20 Oct 2020 16:27:16 +0000 (UTC)
Date:   Tue, 20 Oct 2020 18:27:14 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201020162714.GC46039@blackbook>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Mon, Oct 19, 2020 at 03:28:45PM -0700, Roman Gushchin <guro@fb.com> wrote:
> Currently the root memory cgroup is never charged directly, but
> if an ancestor cgroup is charged, the charge is propagated up to the
s/ancestor/descendant/

> The root memory cgroup doesn't show the charge to a user, neither it
> does allow to set any limits/protections.
An appealing claim, I'd like this to be true...

> Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> However, it's not based on page counters (refer to mem_cgroup_usage()).
...and it almost is. But there are still exposed kmem and tcpmem counters.


> To avoid multiple identical checks over the page counters
> code, for_each_nonroot_ancestor() macro is introduced.
If the assumptions behind this patch's idea were true, I think the
implementation would be simpler by merely (not)connecting the root
counters and keep the traversal as is.

> direct ascendants of the corresponding root memory cgroup's page
s/asc/desc/ ;-)

Michal

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl+PD90ACgkQia1+riC5
qSjDuA//Wm7T97tLWHY64gjWUvx1R3ROAlPEceShGwKYdOE93BUbmeIK33gh+JlF
XS9K7//xLTozIipTH4yA0+Yo+8WaxvdE+MCBSKjyzTGCs/YlZRcVUZQTLQlXztVM
+jOOnQ49nznWYrbsPBh16/FzHm/MYAiZk4ZZXlZtbGzKemH+bwkPfy/E5XkxlFm7
EFqagyTdT53oaec7llA85f0O7RHZzHbfiWQx3LVBi21cEtf/Drui1gNjlRP5Q2S0
qz2DgfKBhUgOhtQa2pFznJtQTtjNlPYaP7XLL2HiXDjHgN+S+q/Z/yZuYYRjZdyL
xy017aWL24RCCtHqOmS58/i1yPGAraxVl1SJnL+0/6Mib1/7dT1XvnNqW7HzrZxW
WKZihtdr2Zgaj9i+gJmc3QUdHiGu4TFYYM2VYwSdEVGoD2oqWGn19XG+oo7Zwold
mnJc6Gc6/ASNnVuNsukqoTbkT66pOLL7JFqK8ehsVH+NEfIDmElAykEvBbhEIiIu
mqeV5H0GztrQ1FQsq99Ov43bbO/acdgcFi3SX0/XCWQK4G5rmtWYFj40fsuHfYVX
JUgjPa5wGHXd/pmKrcrodA0FRhBJSAsEVDT9AzzVEnU/TnDdMmYz123Fgh3fyLr1
BM2eBYT/iM4b9F5f+CHQNNQfKaHdtLdvtUwt/H2JLq/eUtySExk=
=xnZY
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
