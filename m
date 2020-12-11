Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0596E2D6E56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405080AbgLKDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392043AbgLKDIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:08:13 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:07:33 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id s85so4063232vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G97lzUF4PHYueXv8dGIsV02xWvxfYbGAiwNKsPfVFy4=;
        b=XV/Zs3nXRa6DgC/a1FNCZ9rtqs03Qk5x+lrVeWGOpOb1CL4l7Aj0wrjBMXnq4Fnn3J
         i+cZEMB5BFwFcFzjt8+4SUYVKs0f1+RtbefK3L1Rg4NTTiGRSHwvQkDJmltCVUEt1QQM
         3yl89BA6TL68XE1G/Hy1y6fhze27aNN15IV0dGu+wyFunNqcI/eQbTIwxZvkKZ88ZH5D
         GhOk4kLHFwI9HWbckeHjbbW/bL3z1O4WRRwgr1oNAsKvgCTDkJjZL74mhOu7BgSeLDYW
         Mo9qkHVrJ3hlu0+jxBTBYRYsl6NxF1Dbyhl5KoGYAtnT2Y2oiXLi6FhFfsyyDeNFJeFR
         8ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G97lzUF4PHYueXv8dGIsV02xWvxfYbGAiwNKsPfVFy4=;
        b=k3cTvXlsB5xj4vP8UmpFqXKJD2ZUn1qSWOkOUZU4KftjF6LUGmH+MsuXgk2NSPaPy+
         GfnskWqEry7IMWis9PzwkagtWu8y8+aoSdvWt0yICJuHnJzGMm5wVDzuRwkzwaYKrOeS
         LY58Q/l/DnyF9VmjYjcSU7SieVnr5hvs+hbF9osy18GKNUi/hqjsI+yCo5II8pFco0/V
         TF0BUY3TTkST8TdYZzd28C+q8TwrBXzB6helm/NXbTrc8vsxbozDkW/iAuHWWlvSWm0I
         Z5SQdwhS+UtOgv6sEo06/7pGzLUoQOj1IME6hvzeb07fsC6ycYNBsCqBwMeDxFj+rU+u
         vndQ==
X-Gm-Message-State: AOAM532Q3sTbCgML5OaTwjfM2KeGH6/3cD/PqhXSpTLAs4D39d9sv11f
        XOYoD0UnuqYDxyUVMD/4szWK/7YazdTFoLv8P50=
X-Google-Smtp-Source: ABdhPJyqzaPf7PCliGToiGe8xIe/JM+NzmbmpzvAA6DxWN4+8ppMWQlbqOiHdQRhgwaeFfa6mOR28Zw2OsgilrLoKnI=
X-Received: by 2002:a67:fc4:: with SMTP id 187mr5585042vsp.55.1607656052512;
 Thu, 10 Dec 2020 19:07:32 -0800 (PST)
MIME-Version: 1.0
References: <1607508541-9345-1-git-send-email-yejune.deng@gmail.com>
 <20201209103719.GV3021@hirez.programming.kicks-ass.net> <20201209110405.GA5601@C02TD0UTHF1T.local>
In-Reply-To: <20201209110405.GA5601@C02TD0UTHF1T.local>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Fri, 11 Dec 2020 11:07:18 +0800
Message-ID: <CABWKuGWHpMkfbQQ5v_6y=vnO0joMJhaEvZvnd3AjUtLzuXiXaA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Replace 1 with true
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can my submission be accepted ? Do I need to do something, or wait for news?

On Wed, Dec 9, 2020 at 7:11 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Dec 09, 2020 at 11:37:19AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 09, 2020 at 06:09:01PM +0800, Yejune Deng wrote:
> > > In task_css_check(), the third parameter 'true' looks more readable.
> > >
> > > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> > > ---
> > >  kernel/events/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index d2f3ca7..0700022 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7265,7 +7265,7 @@ void perf_prepare_sample(struct perf_event_header *header,
> > >             struct cgroup *cgrp;
> > >
> > >             /* protected by RCU */
> > > -           cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
> > > +           cgrp = task_css_check(current, perf_event_cgrp_id, true)->cgroup;
> >
> > it looks like 3 wasted bytes to me
>
> I disagree; I think it'd make sense to do this for consistency, given all the
> other callers pass true/false (including in the header where this is defined):
>
> | [mark@lakrids:~/src/linux]% git grep task_css_check
> | include/linux/cgroup.h: * task_css_check - obtain css for (task, subsys) w/ extra access conds
> | include/linux/cgroup.h:#define task_css_check(task, subsys_id, __c)                             \
> | include/linux/cgroup.h: * See task_css_check().
> | include/linux/cgroup.h: return task_css_check(task, subsys_id, false);
> | include/linux/cgroup.h: return task_css_check(task, subsys_id, true) ==
> | include/linux/perf_event.h:     return container_of(task_css_check(task, perf_event_cgrp_id,
> | kernel/cgroup/pids.c: * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
> | kernel/cgroup/pids.c:           css = task_css_check(current, pids_cgrp_id, true);
> | kernel/cgroup/pids.c:           css = task_css_check(current, pids_cgrp_id, true);
> | kernel/events/core.c:           cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
> | kernel/sched/core.c:     * which is pointless here. Thus, we pass "true" to task_css_check()
> | kernel/sched/core.c:    tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
> | net/core/netclassid_cgroup.c:   return css_cls_state(task_css_check(p, net_cls_cgrp_id,
>
> ... but it'd be helpful if this could be cc'd to LKML
> (linux-kernel@vger.kernel.org), rather than just the maintainers off-list.
>
> ... or we could waste more than 3 bytes arguing. ;)
>
> Thanks,
> Mark.
