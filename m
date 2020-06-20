Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82C201F56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgFTAyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 20:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFTAyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:54:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6203AC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:54:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so13422837ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1Zzb/YH7KK7g4B3gpHmcrvtbS/clG6lnsYGl+Nt3CQ=;
        b=XLAkPIqQDNtfpKcGbVT66ecMYqc2ApOSFph62D5YkIXZYA5IUI0ixA2Dj6qoFUhl1E
         DKV7nqeT+2W1otypAeM1A8APGWSWLR5Mt+9s9SUchXCDeD6ERY0Ck98+tiBTj3AtvAlC
         Wkz7h+nio40MzTjy/6JssloW5iW3WZhwFQZC4SHN1eAoHS2job9kpvHorgUjo7AKKCv7
         i+umxG9t5srTI3l9+b1EZijxMMYbJxKntFfYZ93oWswEZxkSnlSA+W/KyVhcCG3RzmgN
         uPEtCNrBXia6UJmyPkZExpsxTpOSXsdeM+X+sgcYJlOFcBz/dGOjlYPu5yzBvJMCyGtw
         sBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1Zzb/YH7KK7g4B3gpHmcrvtbS/clG6lnsYGl+Nt3CQ=;
        b=i0OEWeAX+ir+OekCDgjfvuCnRN36v4o8pLDneJS++kZ/85IXPOja4b67g+2OVCDE0B
         dPw4USTZl5GHN4WGewsA01Jhuc2R/15ga2PWWUl3GtFfu6D+7HIEeHp05vh0Y51p0RCT
         ToG9CUyQLYNoFpgJ4ZqhBGmRiwzxTdqgEerRxtnMV0BW2CdWY/Bm27cvOFmrtsCeru7v
         a7s4b0jqeLPZOfLBvV8A+SzuQQHpIwoDnEdDGHaGwo2gZ8wGlNsebtzIGAgd0KQI9cwa
         dOiXTwQuNnEZDUQxnvLhM3nJ87UN7KtmhM02RuzwmtjPWBhTmwBRDUkYpdZar0UjEsIF
         VxMw==
X-Gm-Message-State: AOAM530iBZIdqlxR558fErA21VwU4Qus6HI9yS5ALcYRBlv5sRpQ7bxM
        SoaG14NNhKeOjEJNP2aEft+DvOzhxopVX2kXVJHm2w==
X-Google-Smtp-Source: ABdhPJywvT8t0FEhjBuufjoP3vm0IL2Ab8QmLOj+1lqlyKw36jZA8SIysg8bpDyw4lfFdLYSwrKbIywWNwk2FDcb8gQ=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr3121956ljp.347.1592614475596;
 Fri, 19 Jun 2020 17:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-10-guro@fb.com>
In-Reply-To: <20200608230654.828134-10-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 17:54:24 -0700
Message-ID: <CALvZod5z0vRMXdHZPK=j3hDdqvcHjKy6wF=DaU9=2YKOuQ5kUg@mail.gmail.com>
Subject: Re: [PATCH v6 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> Switch to per-object accounting of non-root slab objects.
>
> Charging is performed using obj_cgroup API in the pre_alloc hook.
> Obj_cgroup is charged with the size of the object and the size
> of metadata: as now it's the size of an obj_cgroup pointer.
> If the amount of memory has been charged successfully, the actual
> allocation code is executed. Otherwise, -ENOMEM is returned.
>
> In the post_alloc hook if the actual allocation succeeded,
> corresponding vmstats are bumped and the obj_cgroup pointer is saved.
> Otherwise, the charge is canceled.
>
> On the free path obj_cgroup pointer is obtained and used to uncharge
> the size of the releasing object.
>
> Memcg and lruvec counters are now representing only memory used
> by active slab objects and do not include the free space. The free
> space is shared and doesn't belong to any specific cgroup.
>
> Global per-node slab vmstats are still modified from (un)charge_slab_page()
> functions. The idea is to keep all slab pages accounted as slab pages
> on system level.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
[snip]
> +
> +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +                                               struct obj_cgroup **objcgp,
> +                                               size_t objects, gfp_t flags)
> +{
> +       struct kmem_cache *cachep;
> +
> +       cachep = memcg_kmem_get_cache(s, objcgp);
> +       if (is_root_cache(cachep))
> +               return s;
> +
> +       if (obj_cgroup_charge(*objcgp, flags, objects * obj_full_size(s))) {
> +               memcg_kmem_put_cache(cachep);

obj_cgroup_put(objcgp)? Or better to do that in memcg_kmem_put_cache().

> +               cachep = NULL;
> +       }
> +
> +       return cachep;
> +}
> +
