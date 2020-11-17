Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE92B6C13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgKQRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKQRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:43:06 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745BBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:43:06 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so31205587lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OcK8vS7qwP+2MUiwggUAsGSyQgPJ6vX74pEaK+mCpA=;
        b=EfimNTvREFiRdOY2ieeDuVAPDlSiosLb27iyWW6BIJAubZtFMDUVVV+gCCDiPICtKs
         ItTcqtEzY+1iI9DPKSjq2dlThhD6Ug3CKvs/Ajrc3U9K6BKjNnwPrTggEQxL6diILEd+
         CzuWZMRCS++XV6cDo2OGzUPEArL6039UquYvpSLbemqAYZ+tETi02G9JlWmnPDQEVu/q
         QG5Rn3MNQpGHmjpPC56EDLlDs2loMHOppVpVN5/n5mjW9PSkdrw2dAEYP8/qFw65AD+L
         xgA5n+NwZ8+hj/UlTVYTOjtdwIF+PtZZy7BdBoZsLpHS+UUDc2SKhNOdS67nJwrHHzAc
         zhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OcK8vS7qwP+2MUiwggUAsGSyQgPJ6vX74pEaK+mCpA=;
        b=fkWeXILF2qIdu77YM/sENuQ7t/08vTIc8uAwjzo/rZdbjtRq+9Jqn30PeZdTu4vyH9
         umJhql3Rn7JwRlw/waOlpQF66rHc3PsBfLP25mYoqKSHHDam1Yhd2svg9SPBqz/eLeLe
         1vE2RSiFGVwVVBwQN7tB0C6h8r0yF4frsRN045eUyuEmdQycDmDeuy1GQnLAgRIqyLzQ
         mang6bX+JDGWnLtN9xtUkGpHSG0Ag/aOrttYY7mlGsVzsOPBQGnIHTx5dQP6lUdJRv4I
         w/1sdd7lRjCUxmyP6NOySlEyuj7DuXyFkiIdfksbmlxHXQ62c2url2N59IagL0mJV1SK
         u54w==
X-Gm-Message-State: AOAM533uCKWtwmn4MRnuQjB/o67awSEHzNUmPk/SzxXS+boi2CX7OVYb
        fQPPELMwTmlo+HuB0TPTyJzyRS7N2LoBRLs1+ep6iA==
X-Google-Smtp-Source: ABdhPJxcad+TUU7WOPJC9TQcbIdDavzSM9nTnUW8s0epJhwrmsMVdl0Df6mTIo+ZUlYJFp8YDhhALLMeRKwxtRWPXUE=
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr1997878lfm.449.1605634984523;
 Tue, 17 Nov 2020 09:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20201110195753.530157-1-guro@fb.com> <20201110195753.530157-2-guro@fb.com>
 <20201112162303.GB873621@cmpxchg.org> <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 Nov 2020 09:42:53 -0800
Message-ID: <CALvZod7gMyasoXgaGJ9hKJO98Cick07gdLabKLqrrPXyXonCrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 4:19 PM Roman Gushchin <guro@fb.com> wrote:
>
[snip]
>
> From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 16 Sep 2020 15:43:48 -0700
> Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
>  caches with SLAB_ACCOUNT
>
> In general it's unknown in advance if a slab page will contain
> accounted objects or not. In order to avoid memory waste, an
> obj_cgroup vector is allocated dynamically when a need to account
> of a new object arises. Such approach is memory efficient, but
> requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> because an allocation can race with a different allocation on another
> cpu.
>
> But in some common cases it's known for sure that a slab page will
> contain accounted objects: if the page belongs to a slab cache with a
> SLAB_ACCOUNT flag set. It includes such popular objects like
> vm_area_struct, anon_vma, task_struct, etc.
>
> In such cases we can pre-allocate the objcgs vector and simple assign
> it to the page without any atomic operations, because at this early
> stage the page is not visible to anyone else.
>
> v2: inline set_page_objcgs() and add some comments, by Johannes
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
[snip]
>
>  static __always_inline void account_slab_page(struct page *page, int order,
> -                                             struct kmem_cache *s)
> +                                             struct kmem_cache *s,
> +                                             gfp_t gfp)
>  {
> +       if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
> +               memcg_alloc_page_obj_cgroups(page, s, gfp, true);
> +

I was wondering why not add (gfp & __GFP_ACCOUNT) check as well but it
seems like for that some additional plumbing is required.

Anyways:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
