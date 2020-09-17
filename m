Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A326D070
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgIQBND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIQBMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:12:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:12:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so503505ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVFEQ2ojzPXsy6/BeRJx9bRw+Riz8xGIOrZymfMmFx0=;
        b=hCWvmjETmGnj8dUIeEh40To0bivwiX4baV3SR2d+cyGlVkknWwoi6Y+qun6337DBn3
         6vkj+oNBHIvrog4mWgYHGc1SHsSTVZOo9flRSF7hlnkIxSv04V4sQXiXlkddxIFiu++W
         qclMQQaZarvaopfB5zwebgXTvvXK2+yqK3ZPBEnoTmz/wDoWbdZOauruH+KPcLwYO7lH
         4pzDhGIDAPMWaZFoPW8FMDDsSFCM0nJUv4puoYBtq8Y/8fKLHvSo0i/eT1JLoFqxmC+V
         PPMJ7Dr+J98VTyKN2NhTgEh8GhFMx0MbbLSn3s7QtluAj87WfYg3ktn2mRD19++UB0/J
         0iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVFEQ2ojzPXsy6/BeRJx9bRw+Riz8xGIOrZymfMmFx0=;
        b=q5EFfo489DqGCCmxPSNeqdek8vTJXsPTxOzK/nQFcggfozL9UldqE0gZAPwQpJk5lz
         4EUqYwv3AEEHIXAXfj9uuGvPr+Twl+vl5H9J3Bq3sW6FijEiOkOgR0fu71cMgxVZWshg
         /a6Q7JE/9X1F0ds0BwDJyIbOg+WKyqan0Hb67GhbZJW6uwvBWsaOXMJw2cLYxwP/9rO6
         f48/Fs+Z0ETJgEv28h5mw1ldd7mTa4mP/luJTxy+Wcp07jLi1N1R4VAT+GEiMmgEuy03
         tSUzkKDZdSFxuV4E4TYGvdCFfyD3ArCZYT3oywvSjZkMkWHO6iR1ddv+A5rmEAqzuzID
         1Atw==
X-Gm-Message-State: AOAM533JWjqJMhIp6KVMVWhxKSvN+RSG7WXi9N2iZg97taYGphKWQW+m
        Fjhw0ChMo+StnZavotbjpzVmsdtQrzA9s/Q++bsO8Q==
X-Google-Smtp-Source: ABdhPJz5EIVwc296/t23ooatEw7C3O5jedtlzyePX2E6TSDGKVSVz/hsQc16mfeeNDN1rP+EeMd6vcK2o0IJLrqcj2E=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr8747331ljz.58.1600305168793;
 Wed, 16 Sep 2020 18:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202659.1378404-1-guro@fb.com> <20200910202659.1378404-4-guro@fb.com>
In-Reply-To: <20200910202659.1378404-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Sep 2020 18:12:37 -0700
Message-ID: <CALvZod7qbM8iM0eafOWXEBjyK_K4HZLztyh0wtsVncnmHrotEg@mail.gmail.com>
Subject: Re: [PATCH rfc 3/5] mm: memcontrol/slab: use helpers to access slab
 page's memcg_data
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> To gather all direct accesses to struct page's memcg_data field
> in one place, let's introduce 4 new helper functions to use in
> the slab accounting code:
>   struct obj_cgroup **page_obj_cgroups(struct page *page);
>   struct obj_cgroup **page_obj_cgroups_check(struct page *page);
>   bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs);
>   void clear_page_obj_cgroups(struct page *page);
>
> They are similar to the corresponding API for generic pages, except
> that the setter can return false, indicating that the value has been
> already set from a different thread.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Nit below.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/memcontrol.h | 48 ++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c            |  4 ++--
>  mm/slab.h                  | 27 +++------------------
>  3 files changed, 53 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0997220c84ce..48d4c2c1ce81 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -375,6 +375,54 @@ static inline void clear_page_mem_cgroup(struct page *page)
>         page->memcg_data = 0;
>  }
>

I think adding comments on these functions would be helpful.

> +#ifdef CONFIG_MEMCG_KMEM
> +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> +{
> +       return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> +}
> +
> +static inline struct obj_cgroup **page_obj_cgroups_check(struct page *page)
> +{
> +       unsigned long memcg_data = page->memcg_data;
> +
> +       if (memcg_data && (memcg_data & 0x1UL))
> +               return (struct obj_cgroup **)memcg_data;
> +
> +       return NULL;
> +}
> +
> +static inline bool set_page_obj_cgroups(struct page *page,
> +                                       struct obj_cgroup **objcgs)
> +{
> +       return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
> +}
> +
> +static inline void clear_page_obj_cgroups(struct page *page)
> +{
> +       page->memcg_data = 0;
> +}
