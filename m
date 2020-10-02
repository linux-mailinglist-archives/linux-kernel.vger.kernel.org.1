Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BEE281044
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgJBKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:03:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:03:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601633032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xShwnns1sZmu50F4PGsDB78YoAb2/a84doWxwWdQAao=;
        b=EO4uUzWSbENtuiq0XnbdzwUPSfuTzfNHcZI8XZJjRguG48J0SrZxcdQiLcStNq9QTdKUGY
        8S2T1NBlmqqWHSFC4s1DKW6giHm8i0xtJlmeLXVPK8bB8vNZx+I4f5HNJUu+hKxXAIRugf
        OXCcD4zK1aMsofHcbmD4kr4n6lmBuOw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 352C1AC2B;
        Fri,  2 Oct 2020 10:03:52 +0000 (UTC)
Date:   Fri, 2 Oct 2020 12:03:50 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201002100350.GC24008@blackbody.suse.cz>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
 <20201001170036.GA29848@blackbook>
 <20201001172713.GA500308@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20201001172713.GA500308@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 01:27:13PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> The activation code is the only path where page migration is not
> excluded. Because unlike with page state statistics, we don't really
> mind a race when counting an activation event.
Thanks for the explanation. I see why the accessor trio is justified.

> I do think there is a bug, though: mem_cgroup_move_account() should
> use WRITE_ONCE() on page->mem_cgroup.
If this were a bug, wouldn't be the proper approach
rcu_assign_pointer()/rcu_dereference() pair?

Michal

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl92+wMACgkQia1+riC5
qSjoXBAAijzh02/9TXGICO7j+GMJCp6nN4wR6sLgCwSepvipg9XWa14yJiDqRzy1
hHVRStm2iKcS3jGsCWsz0qvE+k9CDosua5asddxwfQXWggJszaTzkrTEkBIj/iIW
jFR8sMzmgfHSIo+m93FvRT/QHoZC1s4+J/PauBwvUwCLN0kB6/V964HIbt+m6zKO
xAzczqa6H/JMFPovVu6gGguT8dZqA847COfuD3+J8ZkK3ZUTu74epXEAjJarkokQ
ibkZwuEVOzqoB3CuCugb2dO0W6bqcFXqZw6T4V1FG54QwpoBiq9/kGcG7Z3djIr2
15kRQIbE7JqtLJQMYD+oXbLpKoUUXXZkuhUNWh8ozrX5m4kBeXkIeOpCEZlHqYrH
Mc8ydvwx+Ajy0oofmDqqNKd8aV/9bBAVQpqxsZD/fRjIzkaT20HQnTMtK6UgnsH4
2gw5NCGv0EiCEBhpdWIlwFoaNMOinYeZwr+nPVK4WZLSyZZyPcBFdIW+7O7WkfPK
n39mmmngFevD/EP2iCyC8hhZ6Uht+qVeVHVpHKvE82NgrDfUSuhoKbJBNoYQrIV3
57MLMrP/RACcxU/3D06asMPg08k36b3yV5TuSDcu3E/PlLpZnwlQEblws8+120/k
xKEnW1XoA2zRaOB1ojkNy+YcyBOlmdPFMRjAgKffEc4U6wZbNcw=
=Qjsf
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
