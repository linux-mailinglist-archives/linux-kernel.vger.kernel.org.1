Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F2283945
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgJEPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgJEPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:12:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:12:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so7755202ljk.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n64bhRgrjZAPSE8hsmRtosmZgZ8BUi0pu4orUKxbfAg=;
        b=cHbqkx0BD2VCXxfABFzpqdGK8hvPOhCb/mbFGOsaBjKnCrOCvr4cuLcLn8JBnVDjbf
         cYIoyGuTvTbtBa91/sgycFfOOpd2aIl+NDV8d9DVVRwT9+74+0tZZ/HsL1sJUE+WdKIT
         wRcsM6eYUT+sd5uKSndcFnpWMJRLj2Jrqay4Pi3Ok9Mp6zkApOlIx6zSWGr/ijV0Skxu
         ac8x923bg4lvb8Sw78VbcxUCHky6BwzdmH9uwFJmdaCMNLQN/EDZ8A8nd3EvakZczu6M
         4cU4rr91XXXoVwyOzaMwKPwET7AJmZNS836YIwCuRKaqp9XawTBOObxet5qHZB6ADIRS
         yIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n64bhRgrjZAPSE8hsmRtosmZgZ8BUi0pu4orUKxbfAg=;
        b=qCzvJuqsiIAwpiYUwppiQK9D2lHleC+zdBxdCEbSRQIPoJ3lu0lOUtOVL46Jgm1YZu
         Szy2yj067QW7JO5U1P9JytPWMlZ9vKgWP1J85a8UYAGwuVruU2oDIPKv1JV3esC2EOzi
         rwC9TdjFaf2vpzvTtc0jcmqf2CGWo2styqgmm32KbAP8khUpsn0I1xxt45JIYui6D5BW
         wrZ0wCIM1sF1+W5Yx3WDIfJwdTmsIn//m78FNTDY6KlE/0ub8SP3ezBf82vxgMF3zVF+
         0/mQlFFvRysUrLzcuSG35DlLqCwsNa8zHSs2kLExCs4h1VxvIFiQXSU40XYIpU3z0dPZ
         lHJQ==
X-Gm-Message-State: AOAM530lOXU3qcf62zA59KuivSLTW6IOitVVZTRGc1HN7Bx692y1uODH
        yH9LbgfpVA+ovTxRWvrhtgK/pABsUgLaI4OmnY5h5w==
X-Google-Smtp-Source: ABdhPJz/pOyqr1nPnX4VZ7lKlz5EuT0V+qwRAWQ5ANxOt9H7EbMYkGGP+WrilTlpEJPMRuGthuWoiGNZ3apj654jNDM=
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr59327ljj.77.1601910756874;
 Mon, 05 Oct 2020 08:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201002172559.4000748-1-guro@fb.com> <20201002172559.4000748-2-guro@fb.com>
In-Reply-To: <20201002172559.4000748-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Oct 2020 08:12:25 -0700
Message-ID: <CALvZod7EeQmg8h-5s1Jp+wYwvN+bEV407T9YaOLnW4WuvPM0Bg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: memcontrol: use helpers to read page's memcg data
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
>
> Currently there are many open-coded reads of the page->mem_cgroup
> pointer, as well as a couple of read helpers, which are barely used.
>
> It creates an obstacle on a way to reuse some bits of the pointer
> for storing additional bits of information. In fact, we already do
> this for slab pages, where the last bit indicates that a pointer has
> an attached vector of objcg pointers instead of a regular memcg
> pointer.
>
> This commits uses 2 existing helpers and introduces a new helper to
> converts all read sides to calls of these helpers:
>   struct mem_cgroup *page_memcg(struct page *page);
>   struct mem_cgroup *page_memcg_rcu(struct page *page);
>   struct mem_cgroup *page_memcg_check(struct page *page);
>
> page_memcg_check() is intended to be used in cases when the page
> can be a slab page and have a memcg pointer pointing at objcg vector.
> It does check the lowest bit, and if set, returns NULL.
> page_memcg() contains a VM_BUG_ON_PAGE() check for the page not
> being a slab page.
>
> To make sure nobody uses a direct access, struct page's
> mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
