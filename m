Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702292C91C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgK3W6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgK3W6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26ADC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:57:35 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so25295156ejm.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPiFGQkiqWAFPJXQUHUTo1ORgX89o0bCN92vawl5snc=;
        b=KgRqSq+mb9FeUCYdNxy5lVl/TeDwcTk3FhwJ04jq285EVz2Qrm56pUpjxUUcl0JlG4
         CoH8pcNtTuSGqyF3oELr/YGrlWhw9WbyxstlzH0jtLC86akm5F3/ni8pfQaehPgcfoiZ
         PPazu2lIKQbNgn6v6gqY+jsCJCHsmC6YL63W2FKz9gFWcDMyfL+MsNT1O3um3pLlO9Sh
         HR2JAcX7kimDAyyYSn7pgVlEHzSQ5QOTiBQljDm2W3qTzkfPn4Rdog+b0xW/VhGK5DLV
         pMKnzA0Mj6wVzkiOkEhfbCJX5MVQbBb/vz612jFpTIzpiXYLd9s05ff8MOPRIwiWKm5g
         W4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPiFGQkiqWAFPJXQUHUTo1ORgX89o0bCN92vawl5snc=;
        b=ExspSkfESR8PtIWMMz0oE/gB/H4Q2G5JBwa5OHCRHhbEquiLxGFGePIHgC8JjnRxT1
         RLG4yNDzzBWfEEl+dwAfY7jZBMko8Ftf4V2WV8Nbr2MJhFz9Viuy1kYzc8Ij9BPnR8qL
         GAo/r/ytRtXzoqOrdh5W8AVxJtlmA414DnRQByi5UZqY9I0KNBRph2r/BD1vkm6tyVAj
         kROGuk+suLsvqhgsG/fywJ+pbao4A+hA52tJQC/RYJ11qgDPA8XVpdrAq1ZZ0K5pIUKB
         r2g2wuYoqQnJ4iZqMc7wDCtU9MU4oWhGhTGQKro/QmhzvcX4nflkB9dOKj7Ohbk1ZmGq
         j+mw==
X-Gm-Message-State: AOAM530rQ957ijjccXxEc9PHloN5gWxVk2ECA0pXFN92Q8VNaYptcSIo
        1EVdRwVg7S6wdNOM6KCCj/z4z82lUnhfSHJM5mM=
X-Google-Smtp-Source: ABdhPJyWHDxtxgVzsyEmdHRSHw5yyUKB4fq2DqJ7mDYsDO9Aj5qtpcI56NKuYH3RYmkkGXJ8dyZ7JDU9ssNrPdNWtCE=
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr81171ejb.238.1606777054774;
 Mon, 30 Nov 2020 14:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20201130184514.551950-1-shy828301@gmail.com> <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com> <20201130225255.GF840171@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201130225255.GF840171@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Nov 2020 14:57:23 -0800
Message-ID: <CAHbLzkoK+oFmmpmK7D7vc7fs__fdos+Ckuuj6CBVoP0Yb90YCw@mail.gmail.com>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
To:     Roman Gushchin <guro@fb.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 2:53 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Nov 30, 2020 at 12:57:47PM -0800, Yang Shi wrote:
> > On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> > > > When investigating a slab cache bloat problem, significant amount of
> > > > negative dentry cache was seen, but confusingly they neither got shrunk
> > > > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > > > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > > > but tracing result shows they were even not scanned at all.  The further
> > > > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > > > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > > > to reboot the hosts to get the memory back.
> > > >
> > > > I didn't manage to come up with a reproducer in test environment, and the
> > > > problem can't be reproduced after rebooting.  But it seems there is race
> > > > between shrinker map bit clear and reparenting by code inspection.  The
> > > > hypothesis is elaborated as below.
> > > >
> > > > The memcg hierarchy on our production environment looks like:
> > > >                 root
> > > >                /    \
> > > >           system   user
> > > >
> > > > The main workloads are running under user slice's children, and it creates
> > > > and removes memcg frequently.  So reparenting happens very often under user
> > > > slice, but no task is under user slice directly.
> > > >
> > > > So with the frequent reparenting and tight memory pressure, the below
> > > > hypothetical race condition may happen:
> > > >
> > > >     CPU A                            CPU B                         CPU C
> > > > reparent
> > > >     dst->nr_items == 0
> > > >                                  shrinker:
> > > >                                      total_objects == 0
> > > >     add src->nr_items to dst
> > > >     set_bit
> > > >                                      retrun SHRINK_EMPTY
> > > >                                      clear_bit
> > > >                                                                   list_lru_del()
> > > > reparent again
> > > >     dst->nr_items may go negative
> > > >     due to current list_lru_del()
> > > >     on CPU C
> > > >                                  The second run of shrinker:
> > > >                                      read nr_items without any
> > > >                                      synchronization, so it may
> > > >                                      see intermediate negative
> > > >                                      nr_items then total_objects
> > > >                                      may return 0 conincidently
> > > >
> > > >                                      keep the bit cleared
> > > >     dst->nr_items != 0
> > > >     skip set_bit
> > > >     add scr->nr_item to dst
>
> Btw, I think I have a simpler explanation:
>
> A (0 objects)
> |
> B (N objects)
>
> Let's say the reparenting races with the deletion of a single slab object.
> list_lru_del() can see parent's lru list and substract 1 from nr_items == 0,
> setting A's nr_items to -1 (the item is actually still in B's list).
>
> memcg_drain_list_lru_node() will check !dst->nr_items && src->nr_items
> !-1 && N => 0 and not set the bit. But now we have (N-1) objects in A's list
> and the shrinker bit not set.

Yes, this is the exact race I elaborated in the commit log.

>
> My proposed fix should resolve it. Alternatively, we maybe can check if
> dst->nr_items <= 0 and only then set the bit, but it seems to be an unnecessary
> optimization.

Yes, I think "src->nr_items != 0" is good enough.

>
> Thanks!
