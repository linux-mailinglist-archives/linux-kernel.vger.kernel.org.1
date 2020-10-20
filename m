Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276C72940EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395003AbgJTQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394991AbgJTQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:55:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61586C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:55:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d24so2773690ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buGW0O0c+InVLuoUUk4CrqPPjYxIlROTH5UiCLGLQrA=;
        b=EyVIFhUR+vfjItI8v3zK8T9hgH1qJLGNMdDt9Sagc57TYoW3GYcuL2ArDX8hRTtv3W
         d336nsW8UK7UCgl8Ysrd+yQW1zn4nYjB6feBlVbYJ66KuTKhwZLozyq0HzQEuG5i6APj
         WMr6T5fW4l0vwUu52R38Y4mwQGUithzZDB8GDBuD5jxi+ntd1LWktkBxsKbrgaMVKE/y
         hOqvyNkNQOL/OfuJ5dnsw3Xh05LqPtjLxW4W+M5YVVxVurJ6zLQNOfxu1JqNawa4SYDY
         +zlPzhp3cjslOGTbW+uvbUIr8IUTqmQQIYzzAeOqb5eonAKy4AI5JEP8lJvdzbgnJ0bY
         th2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buGW0O0c+InVLuoUUk4CrqPPjYxIlROTH5UiCLGLQrA=;
        b=tyb+CSpfji5ew5KYcqyO4BHgxysw2XeMS0M1dsi2iRvTGu5GNWINae8GnHIo/GSRh3
         xGpjEj77B+XI2x7gkDGRIQfUG1+MA2xJ+LBOOOmXsi+q/xAjd7o9XtEisjznwGaWLdtx
         i6B7+WU+V5cgUsJMafGP94yKpEX++3QJHgY7Azt0SWDM3Dna08zliU7KTCA82KJOvbXn
         RwgJ6Z+9lVOd+8FZK5jQtXGHC2sA7cfpUfDgC+deWWt2zzhcyYj2eNivoEXkSUPIq9Ik
         LvMV1eK2gCW5E/kktk13MJYsC4wX+umXd8A4dGb/CDHNLvG4+2e1gbvyVgtOlVLHIu+D
         QN7g==
X-Gm-Message-State: AOAM5319iri86zzeYoDWJibVk9G8BuJLMu6pk1dq+bkDHUwlKlLidENF
        su7Ew9RDAyOqnuTEyF7eQMUr1Jn9qwhnYfUfb26rGg==
X-Google-Smtp-Source: ABdhPJwFABKkDYQUVhWxC8A5aUlf2eaKKjOkQxmcJkfbzgyahjid0WWNFsVS8Oxbv0WWn+/jNA7xVdk7wg9Fh52vTkg=
X-Received: by 2002:a05:651c:1af:: with SMTP id c15mr1668396ljn.446.1603212949514;
 Tue, 20 Oct 2020 09:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201014190749.24607-1-rpalethorpe@suse.com> <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org> <20201016171502.GA102311@blackbook> <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Oct 2020 09:55:38 -0700
Message-ID: <CALvZod66ETQR2rKhZQfEZwdovuF0AaVTZ1g1JNjkLgLGgMKY8g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
To:     Roman Gushchin <guro@fb.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 3:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Oct 16, 2020 at 07:15:02PM +0200, Michal Koutny wrote:
> > On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > The central try_charge() function charges recursively all the way up
> > > to and including the root.
> > Except for use_hiearchy=0 (which is the case here as Richard
> > wrote). The reparenting is hence somewhat incompatible with
> > new_parent.use_hiearchy=0 :-/
> >
> > > We should clean this up one way or another: either charge the root or
> > > don't, but do it consistently.
> > I agree this'd be good to unify. One upside of excluding root memcg from
> > charging is that users are spared from the charging overhead when memcg
> > tree is not created.  (Actually, I thought that was the reason for this
> > exception.)
>
> Yeah, I'm completely on the same page. Moving a process to the root memory
> cgroup is currently a good way to estimate the memory cgroup overhead.
>
> How about the patch below, which consistently avoids charging the root
> memory cgroup? It seems like it doesn't add too many checks.
>
> Thanks!
>
> --
>
> From f50ea74d8f118b9121da3754acdde630ddc060a7 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Mon, 19 Oct 2020 14:37:35 -0700
> Subject: [PATCH RFC] mm: memcontrol: do not charge the root memory cgroup
>
> Currently the root memory cgroup is never charged directly, but
> if an ancestor cgroup is charged, the charge is propagated up to the
> root memory cgroup. The root memory cgroup doesn't show the charge
> to a user, neither it does allow to set any limits/protections.
> So the information about the current charge is completely useless.
>
> Avoiding to charge the root memory cgroup allows to:
> 1) simplify the model and the code, so, hopefully, fewer bugs will
>    be introduced in the future;
> 2) avoid unnecessary atomic operations, which are used to (un)charge
>    corresponding root page counters.
>
> In the default hierarchy case or if use_hiearchy == true, it's very
> straightforward: when the page counters tree is traversed to the root,
> the root page counter (the one with parent == NULL), should be
> skipped. To avoid multiple identical checks over the page counters
> code, for_each_nonroot_ancestor() macro is introduced.
>
> To handle the use_hierarchy == false case without adding custom
> checks, let's make page counters of all non-root memory cgroup
> direct ascendants of the corresponding root memory cgroup's page
> counters. In this case for_each_nonroot_ancestor() will work correctly
> as well.
>
> Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> However, it's not based on page counters (refer to mem_cgroup_usage()).
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

This patch is only doing the page counter part of the cleanup (i.e. to
not update root's page counters when descendent's page counter is
updated) but not the stats part.

For the user memory, we do update the stats for the root memcg and do
set page->mem_cgroup = root_mem_cgroup. However this is not done for
the kmem/obj. I thought this is what Johannes was asking for the
cleanup.
