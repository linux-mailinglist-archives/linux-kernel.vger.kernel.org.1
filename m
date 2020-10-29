Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3329F072
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgJ2Ps7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgJ2Ps6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:48:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A582C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:48:58 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l2so3967775lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6hFvPTvw/59UWHjYIOWZNWhefGQ9eQg3cKC2KPGwCM=;
        b=stI5fekXpQhrvKoARPS6AF6qpqpjEK9uc1LX1KLKNec1z0x6yaI9ATroJZ6+pRrtiJ
         FvADZnyT/zRZVVgZVWol+0ltxgd6Y5ix42oFmmPz1B4V3VaTnokEqQhsTYWVICBUWIku
         9Fk5j0+BjuxdxZRChwMI39Yk9ngWlL3BcekHDWpvHzItzJBoi6KSCSEv6qaof6slywA6
         Z9ycEF1H96wb+5jRFrczxm3/mBE78YGj9HFBmUeyT77Ei7G5GWeT7iG/OlQqsUaiNa81
         mZ/65I1f9jDxJXkblfK/CmELlWosZmafXB34IDtR+1D72hSzwMd7skKYuGU3X9dTZ3t0
         F1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6hFvPTvw/59UWHjYIOWZNWhefGQ9eQg3cKC2KPGwCM=;
        b=cvwpcTMO6siogOKbkWrB3pl+4LL2lHw2ULzrcnYCchTuin4QiMdMbMTaLHwYVeN5+I
         JcFqdJSD34LARN/TvEr+J3AAN86k8QcwgRNehV28XRVIA8pJ/1zBaaQ1nUnoXh9BV75W
         YjqknVlyhPc4qyE9yj9oNBn/DdEH96xZMqOwqXUxLpxh0KNJ3aE8KLSTL6LOGhchs9EK
         9wdK1kVYoxSn8zJ0XnchKD9DVTTRtYLKzWPX0XBe0nOTaO+u0tbcqt8sgrrQJ73jljCH
         w0sD3QWkmOO/56T0xBAQz0R6pwe+EyIrj+9v30SCeaJV5z22YO5lT6WmUDp7nsl5q7NX
         AWLQ==
X-Gm-Message-State: AOAM530kl2RgJ2Qdb934KhcWMsRvagRsYxK8v/N/kGtCbnobrznHJQHz
        J2BRhNSx/nP98UOnRASPd38hGFh5/mZgmahss1JSwQ==
X-Google-Smtp-Source: ABdhPJxTeNSGR9ZhUcP7bCxdClKAWwUmdsXRiTkBvntA3ByspyxCe98ZHStsm58VJLsmgWs1OAlSIfc2hUNNsH6YU7A=
X-Received: by 2002:a19:2355:: with SMTP id j82mr1723817lfj.385.1603986536474;
 Thu, 29 Oct 2020 08:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 08:48:45 -0700
Message-ID: <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Consider the following memcg hierarchy.
>
>                     root
>                    /    \
>                   A      B
>
> If we get the objcg of memcg A failed,

Please fix the above statement.

> the get_obj_cgroup_from_current
> can return the wrong objcg for the root memcg.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  changelog in v2:
>  1. Do not use a comparison with the root_mem_cgroup
>
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1337775b04f3..8c8b4c3ed5a0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>                 objcg = rcu_dereference(memcg->objcg);
>                 if (objcg && obj_cgroup_tryget(objcg))
>                         break;
> +               objcg = NULL;

Roman, in your cleanup, are you planning to have objcg for root memcg as well?

>         }
>         rcu_read_unlock();
>
> --
> 2.20.1
>
