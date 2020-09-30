Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5527F60E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbgI3Xfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgI3Xfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:35:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:35:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so4273728lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC8CI2ke9jAFUpO6Co2LbsAK2GppzR0D9YtgZMZXg44=;
        b=diZHKDET5rO8jvr/fdB7nmT7XwckVn/UpajXpihkv/H9QFyJGVYPljBcgJCkMQ/YD3
         bo72M6bQKvjWyTIpXkG6dePz+G9mAZSVeCud+dbcWLaGRxa+K7awIkm4VRotazC1r0Xf
         ppyQiii6NVGDeiTrwFy7yM9KMtH6vANz7Yw4pEnD69fHVqntTwc6zK19m9SgOTRtzn0O
         d4U4fPtk7de+Y9CT4SJatuZXp6LvnCEU+wwaMVymqe+StnAm6z+Otbp5zRyRw5GcbVJt
         lAZtyO4tjoa6fk+rBeMx/4piZah+aSm8TOa7dyeTziYL4GSjDL9z6dqdfHiQFlOrj/Hq
         Tr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC8CI2ke9jAFUpO6Co2LbsAK2GppzR0D9YtgZMZXg44=;
        b=ADo0OFvjBdLMSOmQZRn3GaK3iEp7M0mejnLXrtDadHaCW2thIEhs0i1sZvgC0GM9kJ
         5xkBWQZCkT+fEeSxRO5U1V+Hv7Vs2U0M4ugs+/ADV2asDbRmxAs+WVy3PnSOwx1y8QNT
         k4z6zNAwegGsfFbALwdaZSDpig98eK1T986WwVm/8TbR0pz+Ykw1v8NN0oemL0GPmy4Y
         0Qw9uptt2NszzNIzjktQgzV83dy0/S70/ZOjqRgdqJ8eiCmLfUa3eybJGIL/vEdCmM/w
         Hq5et9KwwyA/ax0k3Wda5OTw0klrZCIcrxAZXJPapmrtyviyY7y7mGCemDhAFLuGCybK
         Po0A==
X-Gm-Message-State: AOAM531+Sjh7rwb6+fowLjTY8Sizp5K7I2GBh95Z27/PHt6PaDA7XpYr
        4ByrmWFF/AqKw4/+qtHeoan+e5/+P+gaJ/JqScX8aA==
X-Google-Smtp-Source: ABdhPJz7aaNnBs7Sg579FwOOrYFrkhMrAPLz6RJ3pfRUQKrzLvH0tfQc5JeVzfiwHWrBEP3pU+2BurqrBd/7DkdkbyY=
X-Received: by 2002:a19:604e:: with SMTP id p14mr1486668lfk.385.1601508949201;
 Wed, 30 Sep 2020 16:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200929235920.537849-1-guro@fb.com> <20200929235920.537849-4-guro@fb.com>
In-Reply-To: <20200929235920.537849-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Sep 2020 16:35:37 -0700
Message-ID: <CALvZod5gMu1OaAspWPQnhCXOmT7U9-cbwBvK83efSYreaNWKNw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: introduce page memcg flags
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 4:59 PM Roman Gushchin <guro@fb.com> wrote:
>
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
>
> Let's formalize it using page memcg flags, defined in enum
> page_memcg_data_flags.
>
> Additional flags might be added later.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

One nit below:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/memcontrol.h | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d4d15c04bbaf..35f846c6b89b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -343,6 +343,15 @@ struct mem_cgroup {
>
>  extern struct mem_cgroup *root_mem_cgroup;
>
> +enum page_memcg_data_flags {
> +       /* page->memcg_data is a pointer to an objcgs vector */
> +       MEMCG_DATA_OBJCGS,
> +       /* the next bit after the last actual flag */
> +       __NR_MEMCG_DATA_FLAGS,
> +};
> +
> +#define MEMCG_DATA_FLAGS_MASK ((0x1UL << __NR_MEMCG_DATA_FLAGS) - 1)
> +

Nit:

#define PG_MEMCG_OBJCGS (0x1UL << MEMCG_DATA_OBJCGS)

and use this macro below.

>  /*
>   * page_memcg - get the memory cgroup associated with a page
>   * @page: a pointer to the page struct
> @@ -404,13 +413,7 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>          */
>         unsigned long memcg_data = READ_ONCE(page->memcg_data);
>
> -       /*
> -        * The lowest bit set means that memcg isn't a valid
> -        * memcg pointer, but a obj_cgroups pointer.
> -        * In this case the page is shared and doesn't belong
> -        * to any specific memory cgroup.
> -        */
> -       if (memcg_data & 0x1UL)
> +       if (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS))
>                 return NULL;
>
>         return (struct mem_cgroup *)memcg_data;
> @@ -459,7 +462,12 @@ static inline void clear_page_memcg(struct page *page)
>   */
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
> -       return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
> +       unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
> +       VM_BUG_ON_PAGE(memcg_data &&
> +                      !(memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)), page);
> +
> +       return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>
>  /*
> @@ -474,8 +482,9 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  {
>         unsigned long memcg_data = READ_ONCE(page->memcg_data);
>
> -       if (memcg_data && (memcg_data & 0x1UL))
> -               return (struct obj_cgroup **)(memcg_data & ~0x1UL);
> +       if (memcg_data && (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)))
> +               return (struct obj_cgroup **)
> +                       (memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>
>         return NULL;
>  }
> @@ -490,7 +499,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  static inline bool set_page_objcgs(struct page *page,
>                                         struct obj_cgroup **objcgs)
>  {
> -       return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
> +       unsigned long memcg_data = (unsigned long)objcgs;
> +
> +       memcg_data |= (0x1UL << MEMCG_DATA_OBJCGS);
> +
> +       return !cmpxchg(&page->memcg_data, 0, memcg_data);
>  }
>
>  /*
> --
> 2.26.2
>
