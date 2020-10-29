Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060FE29F642
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgJ2UfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJ2UfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:35:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BFDC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:35:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 184so5018726lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XV2GOJYljlEE+y8Fc2upH2so5LQLqqQFfNl/qA4qXms=;
        b=ZDafbgdWjCYVWb2fYN22STVuj4OuN68Nk3oJX2aD4PBwf6emSzHP79/hypkJKAypWU
         39EfEDu9Bc9wTVDFhx+C0to6aZ56jTsTIq3joLV1KilN3iGKc94/TwETmzHNovo7OqpV
         v5V29xRb3fdut5xJdax8hQGV57s2384VMJeksTLBSUezvvBM+nnTkXacAma1QueQ5zJL
         VKXkL0TEgTsihNQXg9cOyUB4E1xY2yQY4VdiFnvcMcC08TaWFxXjZEJ2tX/xlZdAT+2J
         jxoi5Z6RM6TWwOJH3cRUf3YnNkuDLX8v5F+kDq8HSmRip2hmjbQX5s4eu0sywa/qjihw
         5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV2GOJYljlEE+y8Fc2upH2so5LQLqqQFfNl/qA4qXms=;
        b=uWQZrO7e5DG+9+dhPWnxH3L5xzsOApATX+su45cWMTRnPvdXxlO1HIgH9mSArMpNsg
         Nv5gGAA6+HVCHdza2KIOdGtqPS+bbIFdncYpwUiEi7nxG2xu1690YhyhjMThGTMnJdVS
         Qr4BSmHWyeOg6OSzBzj3kb2dS4eVzcLZsn7D3m/yAIzi7WGId0+sI/FlCC5WzsEV7i/N
         PcWyT3wEe02S1PYU7A2doGr7891kvdSAoch/devA8MmcrI+Yl7n9nWQFL8eh2X8ChzMd
         k2l7VK4f/f2T3leO1v+cJC//R3eKFEO8a0umET2hPuSx4nyc0M4fMAIm8/jyFrl2i7N7
         3ouA==
X-Gm-Message-State: AOAM531JVIYqX3chHTitQtMlIeXCBP+RVLntBEBfKvwUmKMlLvSKJKIa
        scZees8PnCYX6oYDhRyqbiqYjGJpUCdswNOoeBeJVg==
X-Google-Smtp-Source: ABdhPJzToJVR9lbEl9kreiI8zU1CLCJ/Mn6i7FmBBW6CH96l0Neszh4F9GkSq7pRBLOFabPREx6qJEeYRpYZo/lG0pU=
X-Received: by 2002:a19:85c2:: with SMTP id h185mr2405045lfd.494.1604003708840;
 Thu, 29 Oct 2020 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com> <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 13:34:57 -0700
Message-ID: <CALvZod65MhzQiwGgLM89_gZzCFDaeSZofn08viPgcvra0JRvSg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Oct 29, 2020 at 10:10 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Oct 29, 2020 at 08:48:45AM -0700, Shakeel Butt wrote:
> > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Consider the following memcg hierarchy.
> > >
> > >                     root
> > >                    /    \
> > >                   A      B
> > >
> > > If we get the objcg of memcg A failed,
> >
> > Please fix the above statement.
> >
> > > the get_obj_cgroup_from_current
> > > can return the wrong objcg for the root memcg.
> > >
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  changelog in v2:
> > >  1. Do not use a comparison with the root_mem_cgroup
> > >
> > >  mm/memcontrol.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 1337775b04f3..8c8b4c3ed5a0 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > >                 objcg = rcu_dereference(memcg->objcg);
> > >                 if (objcg && obj_cgroup_tryget(objcg))
> > >                         break;
> > > +               objcg = NULL;
> >
> > Roman, in your cleanup, are you planning to have objcg for root memcg as well?
>
> Yes. I'll just change the for loop to include the root_mem_cgroup.
>

Then do we really need this patch since it's not tagged for stable?
