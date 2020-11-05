Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4052A82EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgKEQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:01:51 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B227C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:01:51 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f21so991029plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dd3dZUGk52m1PzHmB9JCt0RYfkWYgfXRYAB3u3yjNc=;
        b=EmPG/oH4Tkkqi1KyDMqC3L49bMVwzFsZHlUSt88Cat+RqutdkMzjHl+/yB4P/Em2VZ
         qK6KQysFWlzqG77VX7vskgupDft/9tVqj1l3yUWRjVXC4YCIRPXATMRWi66tr2DP8LS/
         tP2JJfMufXtSD6dhij+iu6Xnro4uD0jVY0a2dfFi5F4wW6DHfAWXMMsoeGAWwTCna0rF
         BkRUwhypTs12IGkdEdEhA0yiUi/ulalziUI7q/ZiqvVFf86PYuCINVHN7243tixj8t8g
         cS0SunI/Qmm2HGQbJ/KIeNqPfRxHL2aX3D9XFALW+H4/po5M5D4oJOqpBKKzG9s5tGzx
         raag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dd3dZUGk52m1PzHmB9JCt0RYfkWYgfXRYAB3u3yjNc=;
        b=f3GxVNEP3Tf9yr7/CesTqxT5+hnYO5Rh/87HRMNONQ9IJnlseexjIMs1XRUJfUC4+0
         PxdnoIFtO9EAqxVBJqoJHXOlBzEqawWWQ15X/a/O0ettBjMtE4XN8M4ZwQCGvnqAmf7C
         6kJXwQYaqukaqdRxkgpJXlbsctNxIAndMoEYy/Zlu8X9BKupHl/geFvPVmoUPLcSvX3s
         yxqq7Ad8FSbw7uSXma25Tteupn/66MOGaZDwZcM4FCYuVeY+eDSK9CucNoEWxODyDp1Q
         /VGsjwUjWp4ygrzFkhyPtAJ7QzmrOGr7UeJOsxJy6JmzmNAlFZykFvgV0Y90/jadLXVx
         jDHw==
X-Gm-Message-State: AOAM53049hBU6cj1rz7rs6HlNNqKTlmJdh3VPGeCRZGcXCSGPqlpkNgL
        0svz+zBD4evR6bPEFk23xMervRbG4RiT3QK7w5NiBQ==
X-Google-Smtp-Source: ABdhPJyGWsDb2U5zWmfBMAyXzraRvFA3S733P2djRrIVQYJ02fr92cwUAKpohVXZzTSBuwZ6rBRiqN9EFuU/c3P7XY4=
X-Received: by 2002:a17:902:aa86:b029:d6:99d8:3fff with SMTP id
 d6-20020a170902aa86b02900d699d83fffmr2922157plr.34.1604592110844; Thu, 05 Nov
 2020 08:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20201104125558.49472-1-songmuchun@bytedance.com> <20201105155028.GD744831@cmpxchg.org>
In-Reply-To: <20201105155028.GD744831@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 6 Nov 2020 00:01:12 +0800
Message-ID: <CAMZfGtVAf6aZQs+1mh_KDx53DtpavYb_KpTbhoZL0kfpsCeXsA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup polling thread
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:52 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 04, 2020 at 08:55:58PM +0800, Muchun Song wrote:
> > When wen poll the memory.swap.events, we can miss being waked up when the
> > swap event occurs. Because we didn't notify.
> >
> > Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Good catch!
>
> > ---
> >  include/linux/memcontrol.h | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0f4dd7829fb2..2456cb737329 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1071,15 +1071,29 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
> >       rcu_read_unlock();
> >  }
> >
> > +static inline bool is_swap_memory_event(enum memcg_memory_event event)
> > +{
> > +     return event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> > +            event == MEMCG_SWAP_FAIL;
> > +}
>
> Please inline this, it's not really worth the indirection.
>
> >  static inline void memcg_memory_event(struct mem_cgroup *memcg,
> >                                     enum memcg_memory_event event)
> >  {
> > +     bool swap_event = is_swap_memory_event(event);
> > +     struct cgroup_file *cfile;
> > +
> >       atomic_long_inc(&memcg->memory_events_local[event]);
> > -     cgroup_file_notify(&memcg->events_local_file);
> > +     if (swap_event) {
> > +             cfile = &memcg->swap_events_file;
> > +     } else {
> > +             cfile = &memcg->events_file;
> > +             cgroup_file_notify(&memcg->events_local_file);
> > +     }
> >
> >       do {
> >               atomic_long_inc(&memcg->memory_events[event]);
> > -             cgroup_file_notify(&memcg->events_file);
> > +             cgroup_file_notify(cfile);
>
> This loop is a walk up the hierarchy and memcg keeps changing, so you
> cannot cache cfile up front.
>
>                 if (swap_event)
>                         cgroup_file_notify(&memcg->swap_events_file);
>                 else
>                         cgroup_file_notify(&memcg->events_file);

Oh, Yeah, Thanks for reminding me.

-- 
Yours,
Muchun
