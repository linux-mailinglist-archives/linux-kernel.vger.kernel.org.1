Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73526760D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIKWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIKWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:41:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:41:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so13705065ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naSKnnliw5Mpgkr2F3L5QROMJpfjAY9uHH+kOIOM738=;
        b=H1dQIbWKaMmL+aZc7U2mstufXvwtiANpXmTZnMm92/rw2KJWyLz/QU83Bt4N+zqKKa
         sm6W1Vm1HGStoH5YocmrMJPTFOTwLtdgXallj0p/IV+V5ichue/yRoZxEDobDnlyYotz
         g+OI9rxfJtVW1bP9RX+ZfomLlXUdA58+Q8IhjI4mo/pP7YsBJBpnyLsLNk1Xg9iGRECh
         cMGsbTGXWu+0vtGpwBtRG+eK3HbgrtCp8GxFvdtcmYFoEIC7FxeZ9lx1+Z9dLfQHW6nv
         0TB+JZO/cExgP/lnq+hAiYivGXu9Na077PEDjZuOfif3yjrXPVgz9L1BMxI04BWBYWvP
         ZBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naSKnnliw5Mpgkr2F3L5QROMJpfjAY9uHH+kOIOM738=;
        b=ReYo0r+ABlCO/IDEC/B94VIuargt0yrIHnawkCPq2VgyQ+ZQ6VW4wvMMe2qaOP74GV
         FhKihkiIbzH1YM3GTIKpnkTqYOHJrNbljBBSRcynofAD84WJqn/1NwYcTJ8u3Cm/lJRQ
         9zHSmsNaDCUWitwPnvNm/64DUMAQhsfk6dMv+OttKVZU4fH6k1rZ1hszklJL8tHXf/2O
         4bc2yeyP4Tshc4mN43sly9d0m2QzVcNw7F3sKS/bX+VjKsw1sgR6nWqDr4UalTl7Jn8I
         PHqzBfRYSjF2G5TBg8uEeNfmWuZxK8dUfqhB7vzYoBhVhIfY0g9inWgzFXZBtjAxgPqz
         Ai5w==
X-Gm-Message-State: AOAM533r/y7lT3tKcTfEORwC3Ks4ar57Qcg+h/DXIWZvuS90Ie2n/Mvm
        hHX03O8DlZ1g670w2EwmFO2bYZLUuG44ezXDAfQaOg==
X-Google-Smtp-Source: ABdhPJxixpRuERtNUdFVdh1FadJSasbxEi9YKCOjBuG1pUZrm0Kydbw0hEXHgdqwha99ZluySJyDdfc8rGsqDTUY8cE=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr1459032ljz.58.1599864100989;
 Fri, 11 Sep 2020 15:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200910022435.2773735-1-guro@fb.com> <20200910224309.GB1307870@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200910224309.GB1307870@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 15:41:30 -0700
Message-ID: <CALvZod7RxjcyhscGmJzcAw9_LU0ruQRU0bJc8dYD5Ne07END_w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg/slab: fix racy access to page->mem_cgroup in mem_cgroup_from_obj()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:43 PM Roman Gushchin <guro@fb.com> wrote:
>
> Forgot to cc stable@, an updated version is below.
>
> Thanks!
>
> --
>
> From fe61af45ae570b143ca783ba4d013a0a2b923a15 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 9 Sep 2020 12:19:37 -0700
> Subject: [PATCH] mm: memcg/slab: fix racy access to page->mem_cgroup in
>  mem_cgroup_from_obj()
>
> mem_cgroup_from_obj() checks the lowest bit of the page->mem_cgroup
> pointer to determine if the page has an attached obj_cgroup vector
> instead of a regular memcg pointer. If it's not set, it simple returns
> the page->mem_cgroup value as a struct mem_cgroup pointer.
>
> The commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") changed the moment when this bit
> is set: if previously it was set on the allocation of the slab page,
> now it can be set well after, when the first accounted object is
> allocated on this page.
>
> It opened a race: if page->mem_cgroup is set concurrently after the
> first page_has_obj_cgroups(page) check, a pointer to the obj_cgroups
> array can be returned as a memory cgroup pointer.
>
> A simple check for page->mem_cgroup pointer for NULL before the
> page_has_obj_cgroups() check fixes the race. Indeed, if the pointer
> is not NULL, it's either a simple mem_cgroup pointer or a pointer
> to obj_cgroup vector. The pointer can be asynchronously changed
> from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
> from a valid memcg pointer to objcg vector or back.
>
> If the object passed to mem_cgroup_from_obj() is a slab object
> and page->mem_cgroup is NULL, it means that the object is not
> accounted, so the function must return NULL.
>
> I've discovered the race looking at the code, so far I haven't seen it
> in the wild.
>
> Fixes: 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: stable@vger.kernel.org

I think this patch is good to have as it will make
mem_cgroup_from_obj() more future proof.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
