Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0F294162
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395492AbgJTRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:25:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395362AbgJTRZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603214706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkUZcV0RHvBQCtddDCi8Jl1PDarJsxHvw9FO675doK0=;
        b=kWO2SM7cpF0FkTdM/cFGdvR38/5kht/iq0z+RnxlxCeAi5dvBHQol/wc3WHvyyHjkzIpqx
        dyZbzFhkUgIa1XkoKodi3De9X0nGHMAA7IXmWm9mk71t6uxW/ztMBrpqDV3guj3y/7q7be
        x6zD1ouQqeadG5LlZlgJaudBsBbh69I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFD9DADCC;
        Tue, 20 Oct 2020 17:25:05 +0000 (UTC)
Date:   Tue, 20 Oct 2020 19:24:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     Shakeel Butt <shakeelb@google.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201020172402.GD46039@blackbook>
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <87mu0hwik7.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Tue, Oct 20, 2020 at 06:52:08AM +0100, Richard Palethorpe <rpalethorpe@suse.de> wrote:
> I don't think that is relevant as we get the memcg from objcg->memcg
> which is set during reparenting. I suppose however, we can determine if
> the objcg was reparented by inspecting memcg->objcg.
+1

> If we just check use_hierarchy then objects directly charged to the
> memcg where use_hierarchy=0 will not be uncharged. However, maybe it is
> better to check if it was reparented and if use_hierarchy=0.
I think (I had to make a table) the yielded condition would be:

if ((memcg->use_hierarchy && reparented) || (!mem_cgroup_is_root(memcg) && !reparented))
	 __memcg_kmem_uncharge(memcg, nr_pages);

(I admit it's not very readable.)


Michal

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl+PHSwACgkQia1+riC5
qSiqORAAmQO74JHeb74RQGqy+cE/teEdvHO884KVh6QnHVdHqekJdJ1f+9FhN0/B
Yn0Ou7ySZDTT9X3dtRKX/eP7jjF6wRtyP9GD2T6a6XG5LGSGh3lLjsVnYTkq4Bef
C5xqA/fUoSsJClVHwzyWEhfboLwXlgJmFIOoa2uhrZpIO39jIppNu4Vwslrpznaj
qtPdaHNa5PDlXruFNdKxzLVPvrvrmEaLdM0a+8CGD81pENDrTXdSBNnAgnwi6zA/
aK/co/Kt8BJBs+SKQCBIFyEH/HTGfHtYm15vfuYHOU7SDWGNtH1+BAzeVQw5jrAK
qZHR2w5D5RJ2lLU33j/7yHYcdHIv8CShM7CE8LN4JkcSoZZGbSsUpd6LYth6jptW
/EhIYQQ7Ub+JTBGP5nbe78vO8P/qInBy7/R4jWyKk1F7sJa30ktqQTcfYPI9L2Fp
QwrkvMSm0RrJ9MkAyy7NPhkB5hASdDtdGEumWHSKB+KJDLjiE74QAV1qmlsTiUbn
CDkmCc8eMBeIHAjDq2dDT8ed6uXY7GHd+wWIFuYbwo6EJtCwhYCtmVfpnMY03QG4
+qoSzv5g9ADW/WwdeHnIcFujFUD012hmuLN5iQvrRs8iuxAvRlIuK8iNjvgJbK9Z
F74NC2z/cOUKtA3fGrNCmMfQ52oLgbg/iMQAwRPAZVilCXH1s/c=
=IzbP
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
