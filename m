Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95DA2EB9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbhAFGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbhAFGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:06:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF421C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 22:05:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so4025718lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 22:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIJaOqbryClxfevroW/ia7XSphbowTWiua0Lkb9FHkA=;
        b=ZOcX4aGlTjVymjlFOaOvgg1un/DRzDU7SmBaYNTrnVhtpPEDGnU033l+QWfwDB0ZvC
         iVAJSvmWjESVp/0zenZR0N5ZakfQU2iGXQidJ+J8OQmYHj/KPma0juWZMsOjByvwQKos
         luI7FW2S6c+xfhLXldHZUvRSKqZ+hTCGxrXNNVzZg9/ZL5uR2dtR04DlkKOQ44+rbzS6
         QDHyz7/w3poV7RefdJFg8KImtLcgV/nuffLhc4PUOYnUfCcLOJzS7eBCA/RETIm0vrM4
         ctg9FurwupAapeGDslO1GGYY1x72+liakoMZefdELNiBFeMW9Ga5gnaztrDZjGyiSm6j
         FECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIJaOqbryClxfevroW/ia7XSphbowTWiua0Lkb9FHkA=;
        b=UCJSn+BV7jI/QbzXpInvRP2B/0B/y6ryLJvP+9OTwzwvQXZIJMh4EF7ZHxcwzh8s/D
         vHumUyCQ2tI7DEAaQUySV7zuxTEHqsSeZiaax7kamJOUHPhikSpHtjAkW7rz2s43yefE
         vdQ8xK+OhcxcjGgXxT0YI8yQZQZsFUAbUoD2ulxZDsIfYigC+S8kVI39B6QDSFA8b9os
         X5Gt/4X4Xa9Ijbs53b1BhayoDUx3SAZXdCRBBfe6Go1kjga+sRUhht6TEonnsxG5ASSY
         G3pDp1sEtwQQXBeR8ZU6Xi0Ay/QssL18LTpfWyvaWHbyA6bVWKAmi7YkTA302kV4wKK3
         QkGw==
X-Gm-Message-State: AOAM530oERdX58MUVSYu9pjnjM4aIl3NS/YR7/r1zlICjVtElilA1JmI
        fbPGLCXh+7M8vrkALd6bFafkelgt0wXp7vkR2aw9sooLCLQ8vA==
X-Google-Smtp-Source: ABdhPJzIyXxfjs3/KFS6JaC9/bOWQdFBqOzAqT+WUjEFzFby45K7RLUK8h8kZqk0W0n/DGJd7UWu2ioehB8yt55Volo=
X-Received: by 2002:a2e:9cc3:: with SMTP id g3mr1519821ljj.0.1609913131155;
 Tue, 05 Jan 2021 22:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20210106042239.2860107-1-guro@fb.com>
In-Reply-To: <20210106042239.2860107-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Jan 2021 22:05:20 -0800
Message-ID: <CALvZod6CyDvSe0aGXt=eLfREF4Gte76oVfy+-egR99iUqNVMJA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Imran Khan <imran.f.khan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 8:22 PM Roman Gushchin <guro@fb.com> wrote:
>
> Imran Khan reported a regression in hackbench results caused by the
> commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages"). The regression is noticeable in the case of
> a consequent allocation of several relatively large slab objects,
> e.g. skb's. As soon as the amount of stocked bytes exceeds PAGE_SIZE,
> drain_obj_stock() and __memcg_kmem_uncharge() are called, and it leads
> to a number of atomic operations in page_counter_uncharge().
>
> The corresponding call graph is below (provided by Imran Khan):
>   |__alloc_skb
>   |    |
>   |    |__kmalloc_reserve.isra.61
>   |    |    |
>   |    |    |__kmalloc_node_track_caller
>   |    |    |    |
>   |    |    |    |slab_pre_alloc_hook.constprop.88
>   |    |    |     obj_cgroup_charge
>   |    |    |    |    |
>   |    |    |    |    |__memcg_kmem_charge
>   |    |    |    |    |    |
>   |    |    |    |    |    |page_counter_try_charge
>   |    |    |    |    |
>   |    |    |    |    |refill_obj_stock
>   |    |    |    |    |    |
>   |    |    |    |    |    |drain_obj_stock.isra.68
>   |    |    |    |    |    |    |
>   |    |    |    |    |    |    |__memcg_kmem_uncharge
>   |    |    |    |    |    |    |    |
>   |    |    |    |    |    |    |    |page_counter_uncharge
>   |    |    |    |    |    |    |    |    |
>   |    |    |    |    |    |    |    |    |page_counter_cancel
>   |    |    |    |
>   |    |    |    |
>   |    |    |    |__slab_alloc
>   |    |    |    |    |
>   |    |    |    |    |___slab_alloc
>   |    |    |    |    |
>   |    |    |    |slab_post_alloc_hook
>
> Instead of directly uncharging the accounted kernel memory, it's
> possible to refill the generic page-sized per-cpu stock instead.
> It's a much faster operation, especially on a default hierarchy.
> As a bonus, __memcg_kmem_uncharge_page() will also get faster,
> so the freeing of page-sized kernel allocations (e.g. large kmallocs)
> will become faster.
>
> A similar change has been done earlier for the socket memory by
> the commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for
> socket memory uncharging").
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Imran Khan <imran.f.khan@oracle.com>

I remember seeing this somewhere
https://lore.kernel.org/linux-mm/20190423154405.259178-1-shakeelb@google.com/

Reviewed-by: Shakeel Butt <shakeelb@google.com>
