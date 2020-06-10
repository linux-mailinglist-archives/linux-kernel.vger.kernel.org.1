Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745D21F4BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 05:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFJDge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJDge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:36:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B55BC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:36:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n141so817527qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aBzWfu6PYILWg2j3aS8PQuGNOo2mBUXz1sdOHwFASq8=;
        b=GTT4UOjnbvADpeBBDcqmxNG7mHejYGDfpXDJ1EFsXzrEr70MiZnHVa4vgWWKPZGG2F
         RDxFGHM+yyXzc31YyIYvQMJ1NP6uXQJQ9SldIiN9Tzy+mZOseaJWV9urIK2zzmcvFDbE
         m9VW+McKLnbvEps+GK1vMatvQxd8fH+UNu72DBJ5dDIKURp/gnYIJX2s4Jg1nwLIwEH6
         Yt5Vr2VTgcWHBC6TnvK0UASfK7nzC7YohvTmfMqoGvj0HlYOkEH7uzmml3iiZiM3EOJj
         ivDHKwWNLfp1jlnMuNVkAG1HVtM/8kD9l9aehvhG6jlqGiPf27xuwkK6UUL4Xee0ZLsj
         F+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aBzWfu6PYILWg2j3aS8PQuGNOo2mBUXz1sdOHwFASq8=;
        b=o8nb28C/pq+o9P8aWDHsmCMq3R2lnfKSmxwt6B0xWaoiWWsLbLZSiPaLkGL7uhDqmz
         tb99qiNgzdhjEfbBeyH0HZFECH0DAJ2bLLp6R6RIDdFLReYNPNwSjjNCual3I36OYO4/
         C8kbt0VHWTrHhImjO/FDiEg6PQhyUSPeWkx2WoO8WBvju7moNAS/86PVPhdmqofpkNDd
         rDuye94NKZFmF/0xfIzk92Z7f4zYy1YdiiwjH/sW+9K9WC3gs8cbBxllq8WV83aPsOTL
         9kmia9TPKI436j3Aa7suBescbW14gnlBRnHo/lqusJ7WgYL1okdK1fDNidnquNmXocs4
         hpmQ==
X-Gm-Message-State: AOAM533VS6D8qxXuQpFUvV7zsoaYaEH6rjdBAQBR3VquSE+teYy4U/W6
        5HNNZwO+V70ZWPwg0effEotHC4HDL4DMYmkE6aw=
X-Google-Smtp-Source: ABdhPJywZfnO60S6seREwSn/a2B+vcyRU8DkseeMHE9qNJ9A+8sndMMjGDnrNRrxCmw342kTaSPyxg0sXG0aJHStcYQ=
X-Received: by 2002:a05:620a:a4a:: with SMTP id j10mr1076370qka.272.1591760188869;
 Tue, 09 Jun 2020 20:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-7-git-send-email-iamjoonsoo.kim@lge.com> <20200609135325.GH22623@dhcp22.suse.cz>
In-Reply-To: <20200609135325.GH22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 12:36:14 +0900
Message-ID: <CAAmzW4P3hfq_KnCAQ0MQd2oEG8o4LFyFXr_ZS6R8TnRgsGivJg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] mm/hugetlb: make hugetlb migration target
 allocation APIs CMA aware
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:53, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:57, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is a user who do not want to use CMA memory for migration. Until
> > now, it is implemented by caller side but it's not optimal since there
> > is limited information on caller. This patch implements it on callee si=
de
> > to get better result.
>
> I do not follow this changelog and honestly do not see an improvement.
> skip_cma in the alloc_control sound like a hack to me. I can now see

new_non_cma_page() want to allocate the new page that is not on the
CMA area. new_non_cma_page() implements it by not specifying
__GFP_MOVALBE mask or removing this mask.

hugetlb page allocation has two steps. First is dequeing from the pool. And=
,
if there is no available page on the pool, allocating from the page allocat=
or.

new_non_cma_page() can control allocating from the page allocator in hugetl=
b
via the gfp flags. However, dequeing cannot be controlled by this way so it
skips dequeing completely. This is why new_non_cma_page() uses
alloc_migrate_huge_page() instead of alloc_huge_page_nodemask().

My patch makes hugetlb code CMA aware so that new_non_cma_page()
can get the benefit of the hugetlb pool.

> why your earlier patch has started to or the given gfp_mask. If anything
> this should be folded here. But even then I do not like a partial
> gfp_mask (__GFP_NOWARN on its own really has GFP_NOWAIT like semantic).

Will not use partial gfp_mask.

Thanks.
