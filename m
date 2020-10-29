Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC429F085
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgJ2PwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgJ2PwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:52:16 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:52:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i6so3972679lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKj2b5AWCjhkAnY/6wcR30bVFmlXN2BZgELxg/l/4Qc=;
        b=ughZoPhz2Dl8WA8zbaZkOQUKXOfM6TdfudncnPkaH2w2VErcLZjrLnKsTYj9mJlE/U
         QyScXP5T9cnoE2IK6W+7gVNn+ZvWHcM22Y9ZUEwMyjzAfcNCZFNjFf9oXkbajJ8nqXJu
         bEyM3S50OwxEjqUUeuuznmQ1bCZuQpI1VW1kLSjYLsGB2o6JB1JVzY+BTtt2yaZMjXn3
         YeZGcpo0qJzULk/nv1dnq5K8II6rmbN/8Xd0AJUP3d5A1Tf6EnQCpMo89CtdLZaPhvIx
         4fESoUlvLp+JGBeT4hJZyH0SRxSf01ifp27P8Efe/SZDUwGaK+/Dos8pOuvl1MJ2KpFH
         bVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKj2b5AWCjhkAnY/6wcR30bVFmlXN2BZgELxg/l/4Qc=;
        b=UgIUiKshtJbQhCcsrc5KhD8SdVlKUaYFyeN4yICCohkI0zCtyO2qTHgeLqrf0A2c7c
         X1nZHcPUIjAkpofOPSEO8jaAkhPFL2br5++OK4sLjb/BOp0qU9Skg7iI8XkceNF/9M75
         DcLbQx4YHOdvysGwUo00pvxizEfS06CZA4tnNrl9iQC7TDj4/gUPFh3BC4XijO8l9Kbb
         auGMNde0L3FGG6XR006KsOarhQtVj/eLRFrPixSxuVvb6T0NBYDJ3SamZOFKYccHHVNH
         iBYhfpclkrvXU9KkfXwEoZtxJSGjogx2ADGrTmEnRVZRrgH5ZfUpruPSTcKgIyoJOVEp
         XTZg==
X-Gm-Message-State: AOAM530EwMI6HW6jZZhVXiUnegxuQXl3N7jxZ34SW4ukChvm8sRExfgY
        TaP1d7MTmD3hOfhEBK0h3TeieHCEF4oEuDCoV3cdQg==
X-Google-Smtp-Source: ABdhPJw179Hs1WHKGbS1Wgn/thlA4WzmGkNhOsQywU69U7h93k8AVJNAwLgf8IFpAc1FdNmF5BFAi6HVO/s4D/JTPx4=
X-Received: by 2002:a19:2355:: with SMTP id j82mr1728129lfj.385.1603986734575;
 Thu, 29 Oct 2020 08:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com> <20201028035013.99711-2-songmuchun@bytedance.com>
In-Reply-To: <20201028035013.99711-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 08:52:03 -0700
Message-ID: <CALvZod6uh7hV+_0FTpJehQtvw-f_UmYXNbiiu_YM_Egq4w-TUw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix use after free in obj_cgroup_charge
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

On Tue, Oct 27, 2020 at 8:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The rcu_read_lock/unlock only can guarantee that the memcg will
> not be freed, but it cannot guarantee the success of css_get to
> memcg.
>
> If the whole process of a cgroup offlining is completed between
> reading a objcg->memcg pointer and bumping the css reference on
> another CPU, and there are exactly 0 external references to this
> memory cgroup (how we get to the obj_cgroup_charge() then?),
> css_get() can change the ref counter from 0 back to 1.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
