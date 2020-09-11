Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D472666E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIKRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIKRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:34:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA60C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:34:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so13071070ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvxJxAVSuTWGuM+h5vWmwMjDvCcq+fuIG/RpHMBhiPs=;
        b=DjdeNCFutxyY9lDGpo4tFW8pqf/M17W5kAPM89h9TqBR2uaWfihqpGCbaNPKZxfls0
         0bABOX684WC5YsfIb7zyUlk3EgTVWeMu3njWTFl+WEbWPQVJ3cU58u/pkwR9Gp1C59zD
         jveob89SONHFkOfFty0NocCD96mB6m00PYLWCZaUffQPzuBBdur9dQfNzEOMI5ehv5fS
         BN5yLT2kL3BeNomfCFI2YhKezzPerCgL9j30JnCkVzZVLd0YG+7anh+qQkw1wAHsXm/s
         E7SR8zscAhTP17zi3NQA/JdSzDV2AgwMDFtVTIMBH6kZFp8fHGHyQI+80Bnj3osHYa6P
         T8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvxJxAVSuTWGuM+h5vWmwMjDvCcq+fuIG/RpHMBhiPs=;
        b=rLmeC7ngTv6QbYe5Ml+4FMsveBHCAJFiEEJ8rl6H8V9yC5OaKu3G+zGVlFk18+MjBX
         HbV7+ix3Azvld0RalHig0ci/LeGbbundm9vE3hyJVIDADq9Gb6M9ktEaK8/KznBqtZrG
         9SDh5+DhqCjq709gTKrB/Z7i/2D3gOHQmKpjj9rQVxt6Iq0mgud++HAHu8YFRCueUSzL
         NB2iYw9U6Wzzn7G8EJXvZfLjZaGWtNpxSR8RfDmChFBSnY078MXuIvBR8ATHckTws4t1
         uVuY8HsJC2ifrlcs1RQB97ywB2NoijJqNvp6ePz1tTSDaH57CEMEpnCHcFOXHcy+yuCP
         3Oww==
X-Gm-Message-State: AOAM531qlMmEBX/6utO76z8vPdaaSEdwrdg4DdQ2ZXBe+qxaDeyxMN+j
        FsCKr2fa/d3VlukNWWltlOYpT0gIB+jCaYWK1E58sw==
X-Google-Smtp-Source: ABdhPJwUszV8INh0bBpEkUCldZXG88nIVbGF+zdvu4Zrl3qQPVV4Bf3d9LVe5G6/zxlTKBpnc7U+2GaJDYZAtwkztZM=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr1115333ljc.192.1599845688649;
 Fri, 11 Sep 2020 10:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202659.1378404-1-guro@fb.com>
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 10:34:36 -0700
Message-ID: <CALvZod4-kiW6ZsL0EUuomrxxJqhYzmbsY7phqBs2WcT_A6Q-Lg@mail.gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: allow mapping accounted kernel pages to userspace
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> Currently a non-slab kernel page which has been charged to a memory
> cgroup can't be mapped to userspace. The underlying reason is simple:
> PageKmemcg flag is defined as a page type (like buddy, offline, etc),
> so it takes a bit from a page->mapped counter. Pages with a type set
> can't be mapped to userspace.
>
> But in general the kmemcg flag has nothing to do with mapping to
> userspace. It only means that the page has been accounted by the page
> allocator, so it has to be properly uncharged on release.
>
> Some bpf maps are mapping the vmalloc-based memory to userspace, and
> their memory can't be accounted because of this implementation detail.
>
> This patchset removes this limitation by moving the PageKmemcg flag
> into one of the free bits of the page->mem_cgroup pointer. Also it
> formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
> using new helpers, adds several checks and removes a couple of obsolete
> functions. As the result the code became more robust with fewer
> open-coded bits tricks.
>
> The first patch in the series is a bugfix, which I already sent separately.
> Including it in rfc to make the whole series compile.
>
>

This would be a really beneficial feature. I tried to fix the similar
issue for kvm_vcpu_mmap [1] but using the actual page flag bit but
your solution would be non controversial.

I think this might also help the accounting of TCP zerocopy receive
mmapped memory. The memory is charged in skbs but once it is mmapped,
the skbs get uncharged and we can have a very large amount of
uncharged memory.

I will take a look at the series.
