Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F419B2769FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgIXHDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgIXHDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:03:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB93C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s205so1782632lja.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KSXeJNq+Xr4jWAThO8iIjuiWOvcEFVr8SMOrGe2NoE=;
        b=GhFI/gl6kFqXiEDuE3FPfaSt7hceaV8hQm6cQf2ykZ/fNnQntksX+59ZaXfUmgdHeg
         Zb58toA3r6HMVq7c2K4TdOLrtIiaMhX70eIcIXN3BOLnEBoqSH2o0jHHu8FQrEiA5nez
         94HgtlhUBKdnmJVxKUP7bXqfl9PG+n1WOQR+N7d0Qwyadg7tOnFOPUBUhY7AiHH7e4x7
         KWBxId+qgL9+DiX2hB/HDvhpPOHGP7qa3dxOCEs1UilXK70I70xc4ZI9KZ0cf1bnGV7F
         4lUcGLDUvdBjEwX0hSn4m3xKBh/TmMmA1gRxEU6R4td3PEdNtVBhmWpSoEBIcPeGpxYB
         ScYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KSXeJNq+Xr4jWAThO8iIjuiWOvcEFVr8SMOrGe2NoE=;
        b=pmKMZUGrSqJUN+oCQYckZw11rc7ftAywEnbNvOZ4sIMNyyvR4MCMgMFFa2hEUimzDI
         ubMaMDd7CndYWhvTNckdlWuMKFiGf6lrp52let0qY08zTqrEdiWG4LWAkY/9TYCL/CSq
         q+1BxWdoLHqNi/6vEddh7LBN4Ijr87HpjljaPA+flpuaP0b25wGsaPeVuK6NLM60MVD1
         f5YzRjDRjyae3GZztd8TW9gMxrHByURsjXaOWFzd25qavsl4s2zxY1T3iQ63fv8MjCAW
         qDVsZwtaV8KBQmCIvCq1gLDF/sEgK5cFJzrUPbNyV+4ncsMlG0hjpfUt4FKLKIghx1PN
         C0FA==
X-Gm-Message-State: AOAM533q9di7QdDK8FDwxJzuYKakx9w/UsFZ2hmxNsyWE5I3V0XGVLmZ
        1heipgb+QVeFxfywX8IMIANGtAtVuL/rVX2B1r+3zg==
X-Google-Smtp-Source: ABdhPJza3TCUYaALDfzVNapCIPEm4jBGARVMkuVOHiD7+PUs9atZGtrzYeuUE9cT0RRmbqKGc+VrkgbphX7AuEjHesg=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr1038271ljc.192.1600931026364;
 Thu, 24 Sep 2020 00:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200922203700.2879671-1-guro@fb.com> <20200922203700.2879671-4-guro@fb.com>
In-Reply-To: <20200922203700.2879671-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Sep 2020 00:03:35 -0700
Message-ID: <CALvZod7RrmVG4d2XeJJnphG0rkv+iR7e3=S0AtppE7SW4zb20A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        SeongJae Park <sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 1:38 PM Roman Gushchin <guro@fb.com> wrote:
>
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
>
> Let's formalize it using page memcg flags, defined in page_memcg_flags
> enum and replace all open-coded accesses with test_bit()/__set_bit().
>
> Few additional flags might be added later. Flags are intended to be
> mutually exclusive.

Why mutually exclusive? I understand mutual exclusion between non-slab
kernel memory and objcgs vector but future feature might not need to
be mutually exclusive.

One use-case I am thinking of is actually using a couple of bits here
to store more idle (or hot) age by future extension of DAMON. That
would be for user memory (anon or file and not slab or kmem) but
multiple bits can set.

>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ab3ea3e90583..9a49f1e1c0c7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -343,6 +343,11 @@ struct mem_cgroup {
>
>  extern struct mem_cgroup *root_mem_cgroup;
>
> +enum page_memcg_flags {
> +       /* page->memcg_data is a pointer to an objcgs vector */
> +       PG_MEMCG_OBJ_CGROUPS,
> +};

If you agree with my next comment then I think PG_MEMCG_LAST_FLAG and
MEMCG_FLAGS_MASK should be introduced in this patch instead of the
next one.

> +
>  /*
>   * page_mem_cgroup - get the memory cgroup associated with a page
>   * @page: a pointer to the page struct
> @@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
>  {
>         unsigned long memcg_data = page->memcg_data;
>
> -       /*
> -        * The lowest bit set means that memcg isn't a valid
> -        * memcg pointer, but a obj_cgroups pointer.
> -        * In this case the page is shared and doesn't belong
> -        * to any specific memory cgroup.
> -        */
> -       if (memcg_data & 0x1UL)
> +       if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
>                 return NULL;
>
>         return (struct mem_cgroup *)memcg_data;
> @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
>   */
>  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
>  {
> -       return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> +       unsigned long memcg_data = page->memcg_data;
> +
> +       VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> +                                              &memcg_data), page);
> +       __clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> +
> +       return (struct obj_cgroup **)memcg_data;

Wouldn't the following be more future proof?

return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);

>  }
>
>  /*
> @@ -437,7 +442,7 @@ static inline struct obj_cgroup **page_obj_cgroups_check(struct page *page)
>  {
>         unsigned long memcg_data = page->memcg_data;
>
> -       if (memcg_data && (memcg_data & 0x1UL))
> +       if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
>                 return (struct obj_cgroup **)memcg_data;
>
>         return NULL;
> @@ -453,7 +458,11 @@ static inline struct obj_cgroup **page_obj_cgroups_check(struct page *page)
>  static inline bool set_page_obj_cgroups(struct page *page,
>                                         struct obj_cgroup **objcgs)
>  {
> -       return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
> +       unsigned long memcg_data = (unsigned long)objcgs;
> +
> +       __set_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> +
> +       return !cmpxchg(&page->memcg_data, 0, memcg_data);
>  }
>
>  /*
> --
> 2.26.2
>
