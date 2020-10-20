Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9124F2940F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395021AbgJTQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389033AbgJTQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:57:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D16C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:57:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m20so2793646ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bq8GoxVyo7gYf7b14RQXOf1f0F80lNlq4H2QZVhqpxs=;
        b=GlmFnKSun8DV43nTlPdV+XO2Gf5tvurJdBjQjMLyLJc7GzalEIG6ugrLcrOYrvLNVL
         eI5ABURDeNtLlU9DzOsIDes1PDJPHBqJqWO4J/+b/mL4oAoA+ps0nCFliPaCVagdn0VK
         VeVW0OmGjSuAT3AUYEc6lveH9NPknQ95fx20WayIvbHHE/D6wCDfBmlEWHhgEPV7xBDW
         qCnqbqc3SlT6jIC261l88VcYxFYzPZTvSFKbRdW0lURyl9ADY2a2SGJkmDeiJKXhmpRn
         IxqCFW+Z225MyB+sKga38zg1TqgidiuYm0cfcCRV1K7LJqct8Rp5DhUNHjWFF8SRldiK
         1+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bq8GoxVyo7gYf7b14RQXOf1f0F80lNlq4H2QZVhqpxs=;
        b=Mtc3WNzBPX11pj9hfnNahfSocHaX3H1JChHDUVakoB6PJL1qsMlLTbXnAln8nuiYZw
         IreaZLQBCUFp+gp7E0VShabt5gzKj1grT5K5T8V81A22d0DHVAsj8nC8p7t/zzsoEV+U
         NxmPWwIgXcM6Slwbs48wyO/PiFkGgC2y+Dv/DHQWQ6LMYWynux+tVZEMyuCynepGWwAn
         vz5bdPSoYCH2WSWjSqkgYJKbRrw8zXdfURSAB3yVi8uBJ/G9o6xeGUJ9lRLm/p5GSaJJ
         IwvnIuC1gCoOENDtiZZxidrnC/yFJ0XUrTGVHTRGOhScyQRPq7JWR/HwUEUmV3da9k9j
         1J6A==
X-Gm-Message-State: AOAM533vAkaN2SuVPI/BVBmK1dm1lu6AsRui0Z42LNGniCUyTDA1+Ajv
        W8LJ4RKvd6GakpO+LIMNdIYHFcOlmjEO1iQJSUeeOw==
X-Google-Smtp-Source: ABdhPJyP/DA7JLtU7l6FFKLqDzXFS9L6C8jNSI7xsOJZaUVquq/DPfMLt8k9HTf5vT6Xt1piKgc+oG8QTp5H3VgE7F4=
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr1475971ljg.192.1603213022378;
 Tue, 20 Oct 2020 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <87lfg2ob83.fsf@suse.de> <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de> <87eeltvwg4.fsf@suse.de>
In-Reply-To: <87eeltvwg4.fsf@suse.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Oct 2020 09:56:51 -0700
Message-ID: <CALvZod45mAzyo9LNR4YtX_3J0gZJDagYTNv8NbJAuXzwK5A2DA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
To:     rpalethorpe@suse.de
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 6:49 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Richard Palethorpe <rpalethorpe@suse.de> writes:
>
> > Hello Shakeel,
> >
> > Shakeel Butt <shakeelb@google.com> writes:
> >>>
> >>> V3: Handle common case where use_hierarchy=1 and update description.
> >>>
> >>>  mm/memcontrol.c | 7 +++++--
> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index 6877c765b8d0..34b8c4a66853 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >>>
> >>>         spin_lock_irqsave(&css_set_lock, flags);
> >>>         memcg = obj_cgroup_memcg(objcg);
> >>> -       if (nr_pages)
> >>> +       if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
> >>
> >> If we have non-root memcg with use_hierarchy as 0 and this objcg was
> >> reparented then this __memcg_kmem_uncharge() can potentially underflow
> >> the page counter and give the same warning.
> >
> > Yes, although the kernel considers such a config to be broken, and
> > prints a warning to the log, it does allow it.
>
> Actually this can not happen because if use_hierarchy=0 then the objcg
> will be reparented to root.
>

Yup, you are right. I do wonder if we should completely deprecate
use_hierarchy=0.
