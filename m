Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0526D061
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgIQBIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:08:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190F7C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:58:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so241320lfy.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THgsmZel/sKOebF10Auhnk+taxqXdrSC0+xZqau7VF4=;
        b=KuTE6vzx0dc9gxBPYVDqvGihkQy86qBNSpF9iWH3bpHZQBO/8ZNC4wFTesS9P/sVtT
         mpnuTZd3FYkvfJxE6oXTj2lH4EXNiqq4x/VC+x0ltW5fmn3UXX11HEFyOkvvTXNN2ICe
         nqkl+wblbZuENmgZawiYU8QA9Bl0UQvR0RpivQf9lQYpOlbC7nQ7YwYinVAssJYSdlMj
         /wgBMatjl/W7O4PQlw5t+oAVTaoPdBR8y/KetjX05bcfQG89wFb+sUqIeq7J5b8AxpDu
         pClEHJnOwkl/IiIc9a09QB1ftyJ67CpelUwYk8vilo+yI0FpJBhNBQtMdTQQGdSAzdt1
         0bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THgsmZel/sKOebF10Auhnk+taxqXdrSC0+xZqau7VF4=;
        b=UTm5eo5Z8lC0FnHiPlin2+J5rESlN5sRLG6LJ2De4CbRCCSjlupiFow9IEhVsWFcJi
         ZXRY2SMJQ5Dzim7TyxC7FhisGXkrVOxKYV9aYE+1QB2i51n2uWB4LYG8g56PpKMePFhT
         W+qS7/2s04u9ypukYPhn1GQVII08yIAUnqqqw3Bj8N9SxiyXWM0iKQKD5JMVwOr8EsGM
         PelW/4agDHFwJqi9BV73/bgWcZ1UuuYBQNynQaAByuZVJiu28Osv+kVRlRHMFy9oQ6wJ
         8JYcfAAbM+PVsQGpQ08/dLXbdA8R0VIMwEf5jZdohLyuLNmJg4bZaQAhg3L39L5zL3DS
         0qNQ==
X-Gm-Message-State: AOAM533ep0sTE+eA4owSNG6PyPmE8/hswYLcDK8KMId9x8Js1Ff5zf+5
        zuG/yTsHnuMbJdLG9+X3eY3xF1lgFIkW7q5qX+3eug==
X-Google-Smtp-Source: ABdhPJy9ZgWR2JEMmVN5ksKa/DjG5EnajS2k2G+HkTTMu4MwAXO/ACdKOGMmqq1DGZ4EEtelKVbgznT1b8Pa3/Yoais=
X-Received: by 2002:a19:604e:: with SMTP id p14mr8024244lfk.385.1600304318184;
 Wed, 16 Sep 2020 17:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202659.1378404-1-guro@fb.com> <20200910202659.1378404-3-guro@fb.com>
In-Reply-To: <20200910202659.1378404-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Sep 2020 17:58:27 -0700
Message-ID: <CALvZod6sBt0B0WisAZKhaD3SqEWGwkUTzOCUO=jGmR9KLjJZWw@mail.gmail.com>
Subject: Re: [PATCH rfc 2/5] mm: memcontrol: use helpers to access page's
 memcg data
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
> Currently there are many open-coded reads and writes of the page->mem_cgroup
> pointer, as well as a couple of read helpers, which are barely used.
>
> It creates an obstacle on a way to reuse some bits of the pointer
> for storing additional bits of information. In fact, we already do
> this for slab pages, where the last bit indicates that a pointer has
> an attached vector of objcg pointers instead of a regular memcg
> pointer.
>
> This commits introduces 4 new helper functions and converts all
> raw accesses to page->mem_cgroup to calls of these helpers:
>   struct mem_cgroup *page_mem_cgroup(struct page *page);
>   struct mem_cgroup *page_mem_cgroup_check(struct page *page);
>   void set_page_mem_cgroup(struct page *page, struct mem_cgroup *memcg);
>   void clear_page_mem_cgroup(struct page *page);
>
> page_mem_cgroup_check() is intended to be used in cases when the page
> can be a slab page and have a memcg pointer pointing at objcg vector.
> It does check the lowest bit, and if set, returns NULL.
> page_mem_cgroup() contains a VM_BUG_ON_PAGE() check for the page not
> being a slab page. So do set_page_mem_cgroup() and clear_page_mem_cgroup().
>
> To make sure nobody uses a direct access, struct page's
> mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> Only new helpers and a couple of slab-accounting related functions
> access this field directly.
>
> page_memcg() and page_memcg_rcu() helpers defined in mm.h are removed.
> New page_mem_cgroup() is a direct analog of page_memcg(), while
> page_memcg_rcu() has a single call site in a small rcu-read-lock
> section, so it's just not worth it to have a separate helper. So
> it's replaced with page_mem_cgroup() too.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

You need to update a couple of comments in kernel/fork.c, mm/slab.h,
mm/workingset.c, fs/buffer.c, fs/iomap/buffered-io.c.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
