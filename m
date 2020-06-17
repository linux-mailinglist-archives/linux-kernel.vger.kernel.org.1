Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BFC1FC58A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 07:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFQFI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 01:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgFQFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:08:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB79C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:08:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p15so442434qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSxlgyWtSoXSmG1hmoYzEM444NpFB+T4fXxIpsIpthk=;
        b=M7+46Mbq0O0SaclOTpKcRrjHwmidJX6jYuBGOcEZ74jIc/ta25h4mCJTNKo4bq+83q
         7Uf886njOoRqxWR8QDZ7/RsRA5Sugeo26726COXuet5ealArLVgpNAm7WzKWvnkh7F1+
         Jw3mYYda8xVnPjMlyXz7F265CnwLEXNnmmS2yFdk8jlUxSipLaxR2UNlpiT1HHST/Czj
         QSitAsKXFmaKnXzUHNsFAZbaKlGpWROPZnVrleXd4ToGLrxLx3T/hNICu+ms2dOXC6Ou
         8DrfE25X06wx/PoqcbLlyhSZSJRF5gJSApRzvsVNAvoz2+qX/vNn52K5xsuuaSGiOkJ0
         6LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSxlgyWtSoXSmG1hmoYzEM444NpFB+T4fXxIpsIpthk=;
        b=hiOFFmCJiblpk9lh4lKfMrtIIZYByRf81jxk975WrAUkzayQeHlFqOaoHMKGfBaPuF
         50LqH/Xsj3/C4OVvguJJhAX2ah/Exm52e1MCR0XJ3iJV6GQkSIGI8KC9UagNFXKy1VLq
         Ne7Qma0GDLaoIvjAysYgVW1pDHO6MApPbUFcwMoNAZz8NQ33OyTbcgPkbdUTbukPpGQw
         EZnRCHYt+2iAL8d3cw7iUjHXEAUBcRG4KrxnS/Zv4q42bPGpzr/NWVMBhMt6T5O8W4pT
         4Fv9Y0o2emI2qIAeHCwzsTHf42GBLhI3l/qf8RmG20kh2ImSgx93ZzNX0zw1ecaHboTJ
         dAsg==
X-Gm-Message-State: AOAM533G7l0ausc8qHzh0TGhGPA+Bj9ycWlcAbnYkD4c7JSW/wxBxUxu
        2SlCG+iFC6VGVIitP00FAAUAlpl3D+cnAOyIlYGrRrDR
X-Google-Smtp-Source: ABdhPJz7N8RtOL+jmqif9kGxaS4c46DrOpN8lqkzazFSK/+moVt8Qzr4sDusq4/Vi8wkxzE0zK4f3ge4DurCHG3LqFA=
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr5937206qvl.88.1592370536428;
 Tue, 16 Jun 2020 22:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com> <20200616113601.a8ab80635b6434efe43d2ffc@linux-foundation.org>
In-Reply-To: <20200616113601.a8ab80635b6434efe43d2ffc@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 17 Jun 2020 14:08:45 +0900
Message-ID: <CAAmzW4NLzfDe_RCXJKXDy+zcYmNA_Uo6_MY8Ob4t0wV8yg3j2A@mail.gmail.com>
Subject: Re: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age
 nonresident information alongside anonymous pages"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 3:36, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Tue, 16 Jun 2020 15:16:43 +0900 js1304@gmail.com wrote:
>
> > Subject: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age non=
resident information alongside anonymous pages"
>
> I'm having trouble locating such a patch.
>
> > Non-file-lru page could also be activated in mark_page_accessed()
> > and we need to count this activation for nonresident_age.
> >
> > Note that it's better for this patch to be squashed into the patch
> > "mm: workingset: age nonresident information alongside anonymous pages"=
.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/swap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 667133d..c5d5114 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -443,8 +443,7 @@ void mark_page_accessed(struct page *page)
> >               else
> >                       __lru_cache_activate_page(page);
> >               ClearPageReferenced(page);
> > -             if (page_is_file_lru(page))
> > -                     workingset_activation(page);
> > +             workingset_activation(page);
> >       }
> >       if (page_is_idle(page))
> >               clear_page_idle(page);
>
> AFAICT this patch Fixes: a528910e12ec7ee ("mm: thrash detection-based fil=
e
> cache sizing")?

No,

This patch could be squashed into the previous patch,
"mm: workingset: age nonresident information alongside anonymous
pages", in this patchset.
I intentionally do not unify them by my hand since review is required.

Thanks.
