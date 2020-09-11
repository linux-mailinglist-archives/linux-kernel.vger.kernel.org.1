Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3247E2666E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIKRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgIKRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:35:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:35:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so6663224lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jrn7SJSGlKD5VxquHcwDgprw1jbNsWS3A5hw4CEPJvM=;
        b=wKyGChFb44M8QCveA4+Uomcymc+kqf8TEAEsTjSJJ7JyjXouyLUUbXI3ZWzkvhsRPQ
         cGzrt/hWlGJW1eTwbdWRxZQnaCVKBiESN2/TCufCGlNBO0diX8nBWihCQxw6jxEx9jQ9
         BBLpyjSZJr28RurcFYXWM+XlrVffTu6Eit9mW5c905YOSPlfsOCZ5sI9E3jXcCCnNREr
         BSIUUuU8N8UN6VttmpnuNTlfb8/+ovRRbi3VBGbJax4XNAJmSz8MqZrYZE42K7q8eml0
         8zNUgUvCd9hkRWk/lP38Ki9/thlFBA8M/+SyLdTtyIBjlrLxHwAbOqNG5kezFNGlIJrK
         jl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jrn7SJSGlKD5VxquHcwDgprw1jbNsWS3A5hw4CEPJvM=;
        b=gWA5Sxlp/rCTMXehxhKvO9jG8KS+3/tpkkYXQDBpHEzFsHro+3gWgpQrk2eoncNnji
         VOFcLByThaQwvkvJyaCL6b42YsHzh4RJM+An7t8pc9xoskkShqbv74ANkuWhPd355wNA
         ppxjoKXrlrJQYgEhE35wZ2IE/QBbik0MkxfEh9lavtXrxDewLqkKF3o2p+agivpa89vI
         yAJwpGmFA1uzIj1ne0F7jWNMhJ5R9BVrb8Al6+OdSVVDh/tRxeujV7jWrFUXLkY7Ph6m
         hqJ0jWrvi+Npoo2SwR/zDn48yUIWivFutrEwMw8cGCOZhPHmP7CSei7WTjxrRSDvOFlZ
         xzTA==
X-Gm-Message-State: AOAM530YXTTfriqwntot+bDRXg5Ek0YvqvAE+8K3zXd7auN/1uKtTIHB
        NUlzbJND81fkbGxOtm49+ryOVpCzIUuqiQ25vG/z8g==
X-Google-Smtp-Source: ABdhPJx5uqToMAB63iP/Dxy859vfI04E9uchFQJ7I5VmwohiwH2mfq+TWqIu7Z2Yne1HuAI4jd/Hgc1Iwjzf9Y4pHuU=
X-Received: by 2002:a19:604e:: with SMTP id p14mr589322lfk.385.1599845708798;
 Fri, 11 Sep 2020 10:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202659.1378404-1-guro@fb.com> <CALvZod4-kiW6ZsL0EUuomrxxJqhYzmbsY7phqBs2WcT_A6Q-Lg@mail.gmail.com>
In-Reply-To: <CALvZod4-kiW6ZsL0EUuomrxxJqhYzmbsY7phqBs2WcT_A6Q-Lg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 10:34:57 -0700
Message-ID: <CALvZod6BWYo7fy4f23e7CnkoAxrjwx8QNFPXZ43pHnzcKBWgRw@mail.gmail.com>
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

On Fri, Sep 11, 2020 at 10:34 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Sep 10, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Currently a non-slab kernel page which has been charged to a memory
> > cgroup can't be mapped to userspace. The underlying reason is simple:
> > PageKmemcg flag is defined as a page type (like buddy, offline, etc),
> > so it takes a bit from a page->mapped counter. Pages with a type set
> > can't be mapped to userspace.
> >
> > But in general the kmemcg flag has nothing to do with mapping to
> > userspace. It only means that the page has been accounted by the page
> > allocator, so it has to be properly uncharged on release.
> >
> > Some bpf maps are mapping the vmalloc-based memory to userspace, and
> > their memory can't be accounted because of this implementation detail.
> >
> > This patchset removes this limitation by moving the PageKmemcg flag
> > into one of the free bits of the page->mem_cgroup pointer. Also it
> > formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
> > using new helpers, adds several checks and removes a couple of obsolete
> > functions. As the result the code became more robust with fewer
> > open-coded bits tricks.
> >
> > The first patch in the series is a bugfix, which I already sent separately.
> > Including it in rfc to make the whole series compile.
> >
> >
>
> This would be a really beneficial feature. I tried to fix the similar
> issue for kvm_vcpu_mmap [1] but using the actual page flag bit but
> your solution would be non controversial.
>
> I think this might also help the accounting of TCP zerocopy receive
> mmapped memory. The memory is charged in skbs but once it is mmapped,
> the skbs get uncharged and we can have a very large amount of
> uncharged memory.
>
> I will take a look at the series.

[1] https://lore.kernel.org/kvm/20190329012836.47013-1-shakeelb@google.com/
