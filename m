Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E862042AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgFVV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgFVV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:29:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:29:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k15so3473923lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umdWjH1ky+XmZZj0sm8b6f6B8XCVb8FTSoaNh4N336Y=;
        b=rUqHnhObUca52Ets+8Fc+3aHjatnCWxqYD8OVOF3UfR6z5eh4yI3+b/i1CmYPXZhnu
         ZjQ/0AZYcCZCZ+8mFv7NUCaX+H94Uvz0A8WPwCrw2oF1QuzMhigtABomWAZN4vMMn/WB
         iM2slPaQvce+bUMlBGEyIPf1qUUI7+hNeH755x1Lub1WxaWcLdJmrjY+zNoqxFMVbRTY
         5TZMO7fLQ2Z69Xg1Nm0PWDLhxZOLhyFEEd062QJ7+Wvk7JSYQP/eDu5x7TfzSHlFOXHZ
         eY1+w+K4cp3Uz7xoQzXPEocD+Dxl3OsZHr0DV3s7K21R+lP+7b+2wFucveD8wYDZGKF4
         oGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umdWjH1ky+XmZZj0sm8b6f6B8XCVb8FTSoaNh4N336Y=;
        b=rz7G40j64+b0GgLDToXRvx85HIYCncZV+Xj3wwE8Ktv2YoRrx5pDUaSip3zH44s9hO
         LL8Fq1qW8RvZ/KfiDt5KuPrgB8Yt92yyi1cQH+JBDPVsoTpCWeViYxAd/8CTeCO0D+8+
         74R1bs1qNa4hYzxvaePMPF5hphmjpF+K8D5IdRzbvjy/M60t42tcuf8qMmOkYbIlBekO
         2jcXO8+PndNWffQW/fKG+qhPpZcFtlGimpe7v/ld08CNg126vNNNlAGBL+KMdZCCpQt4
         vC4TBLU3OU1kuwfED+POC8Za5iNqHsSI2uzrMqvtmJU1UZ8GGPaAMKwWVkC6CXKfMuBd
         9hSQ==
X-Gm-Message-State: AOAM533RtgXcuWzln4djBcsYYglWbOHsNLTqCuxdfkVcfRJqryDxliTx
        wvOvyqcyC7Y9kxpus6JJaBtQAmHRmJRSdQrooYAAgQ==
X-Google-Smtp-Source: ABdhPJy3nOR0wjchd+j1NHjop2IkMr3XrhTqYeEOyjbug3rDK3yReNMgtsM1uZTpzmtzwrYjZlH3mwndQC12cbTUYdA=
X-Received: by 2002:a19:4301:: with SMTP id q1mr10843586lfa.96.1592861345936;
 Mon, 22 Jun 2020 14:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
 <20200622203739.GD301338@carbon.dhcp.thefacebook.com> <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
 <20200622211356.GF301338@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200622211356.GF301338@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 14:28:54 -0700
Message-ID: <CALvZod4aEgbP-CPd3=dC3922SGiYBdEMCm_tsGt5xZUx1ekTDQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
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

On Mon, Jun 22, 2020 at 2:15 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 22, 2020 at 02:04:29PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> > > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > Instead of having two sets of kmem_caches: one for system-wide and
> > > > > non-accounted allocations and the second one shared by all accounted
> > > > > allocations, we can use just one.
> > > > >
> > > > > The idea is simple: space for obj_cgroup metadata can be allocated
> > > > > on demand and filled only for accounted allocations.
> > > > >
> > > > > It allows to remove a bunch of code which is required to handle
> > > > > kmem_cache clones for accounted allocations. There is no more need
> > > > > to create them, accumulate statistics, propagate attributes, etc.
> > > > > It's a quite significant simplification.
> > > > >
> > > > > Also, because the total number of slab_caches is reduced almost twice
> > > > > (not all kmem_caches have a memcg clone), some additional memory
> > > > > savings are expected. On my devvm it additionally saves about 3.5%
> > > > > of slab memory.
> > > > >
> > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > ---
> > > > [snip]
> > > > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > > > >                                               struct obj_cgroup *objcg,
> > > > > -                                             size_t size, void **p)
> > > > > +                                             gfp_t flags, size_t size,
> > > > > +                                             void **p)
> > > > >  {
> > > > >         struct page *page;
> > > > >         unsigned long off;
> > > > >         size_t i;
> > > > >
> > > > > +       if (!objcg)
> > > > > +               return;
> > > > > +
> > > > > +       flags &= ~__GFP_ACCOUNT;
> > > > >         for (i = 0; i < size; i++) {
> > > > >                 if (likely(p[i])) {
> > > > >                         page = virt_to_head_page(p[i]);
> > > > > +
> > > > > +                       if (!page_has_obj_cgroups(page) &&
> > > >
> > > > The page is already linked into the kmem_cache, don't you need
> > > > synchronization for memcg_alloc_page_obj_cgroups().
> > >
> > > Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
> > > here is the SLUB percpu partial list.
> > >
> > > So in theory we need something like:
> > >
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 0a31600a0f5c..44bf57815816 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> > >         if (!vec)
> > >                 return -ENOMEM;
> > >
> > > -       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> > > +       if (cmpxchg(&page->obj_cgroups, 0,
> > > +                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> > > +               kfree(vec);
> > > +
> > >         return 0;
> > >  }
> > >
> > >
> > > But I wonder if we might put it under #ifdef CONFIG_SLAB?
> > > Or any other ideas how to make it less expensive?
> > >
> > > > What's the reason to remove this from charge_slab_page()?
> > >
> > > Because at charge_slab_page() we don't know if we'll ever need
> > > page->obj_cgroups. Some caches might have only few or even zero
> > > accounted objects.
> > >
> >
> > If slab_pre_alloc_hook() returns a non-NULL objcg then we definitely
> > need page->obj_cgroups.  The charge_slab_page() happens between
> > slab_pre_alloc_hook() & slab_post_alloc_hook(), so, we should be able
> > to tell if page->obj_cgroups is needed.
>
> Yes, but the opposite is not always true: we can reuse the existing page
> without allocated page->obj_cgroups. In this case charge_slab_page() is
> not involved at all.
>

Hmm yeah, you are right. I missed that.

>
> Or do you mean that we can minimize the amount of required synchronization
> by allocating some obj_cgroups vectors from charge_slab_page()?

One optimization would be to always pre-allocate page->obj_cgroups for
kmem_caches with SLAB_ACCOUNT.
