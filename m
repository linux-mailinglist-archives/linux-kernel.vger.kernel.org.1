Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF82CCFF8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgLCHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbgLCHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:02:34 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAAC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:01:48 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id es6so488840qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWQ9GYyKSHe1JGWbs3Y1m+BNCxpwEs1X4TY/MrUFeCQ=;
        b=AEJpqtMIVwb3X42BIB1/HJea4LLwUtS4HnA8BXFrGROZJqrBKSVEr1cu5IISBqSkrl
         P98xhyU/PWqUV10Y5FY1mzeyyJdt6dobJE2ldbkGkLNV+QXqPM0jBM9w92+NcNT515uJ
         teDyKYcrYvdP3I/iODLw/3Uu+lQrvOmKH0tMfac7aGhcyZzlWzPfWWhayrRW+XZMxdUO
         06kjm5KwxhHT3smLiB7izlolZjYqnhnGxX1tX0KOrnggY5TOSAj/fb6aXkuBkNS1fLok
         UETNSmvzdRygD1N+AwMvCPLwrz1/VvP/8YHeOCdUaeErlYgDkDl1IJxN3Arh6yPWj6F2
         XRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWQ9GYyKSHe1JGWbs3Y1m+BNCxpwEs1X4TY/MrUFeCQ=;
        b=mkNjr3eh6buh9xnWJ2y1AqUqenLhMr+SoVsZGKx47YuUuw7XsX1hwCGpOhPGTdzGVO
         DFQ1ltY5C4M7/gkdzTUHAbnuZBcvwyJAGlJCu5KfrKE5KVtAn8WmWDKeD7W4X3oGq4Ma
         ljOOQ7KUFkjS7wzdMDo2BgzoCDfrK8JcC1vbT6n/kgjuB9WTONY9xIUWDL/FOWfJoO9x
         cQa6/qthd/27S9EKHX9motWfok/+dqCzfzS07qtfjHNgyuO5K4JNMfafbw6OMiL+oi2s
         5ZGjJnhtApZKdyPkchOznnO6pxhvBkoADcYfXZUw5Z9czzT4r9QP5H16EL32VNg751Yw
         s0WA==
X-Gm-Message-State: AOAM533eoAYkcCFQdct29BmjwoShmtR9gLU7f3aSvxiE9UsMCXgW2s0W
        wBaLPiRQ2A8Xso8gWiksqoZ51/bbVTHYsODD3o2QdA==
X-Google-Smtp-Source: ABdhPJz2rjhZqdGJa/6Mjj6mEetaVwe2kA0PLG5+48mAyehB6IZhfKIsje0X6UAhmPuKT58JOTMrZ+YDq5tQhz8LcqI=
X-Received: by 2002:ad4:5bad:: with SMTP id 13mr1695026qvq.23.1606978906682;
 Wed, 02 Dec 2020 23:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20201203022148.29754-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20201203022148.29754-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Dec 2020 08:01:35 +0100
Message-ID: <CACT4Y+aQ19fUhDZMeLQeVzdECQhje6CpnH4SVmMQtS_cTPq0zg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] kasan: add workqueue stack for generic KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:21 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Syzbot reports many UAF issues for workqueue, see [1].
> In some of these access/allocation happened in process_one_work(),
> we see the free stack is useless in KASAN report, it doesn't help
> programmers to solve UAF for workqueue issue.
>
> This patchset improves KASAN reports by making them to have workqueue
> queueing stack. It is useful for programmers to solve use-after-free
> or double-free memory issue.
>
> Generic KASAN also records the last two workqueue stacks and prints
> them in KASAN report. It is only suitable for generic KASAN.
>
> [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> [2]https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Walter Wu (4):
> workqueue: kasan: record workqueue stack
> kasan: print workqueue stack
> lib/test_kasan.c: add workqueue test case
> kasan: update documentation for generic kasan
>
> ---
> Changes since v4:
> - Not found timer use case, so that remove timer patch
> - remove a mention of call_rcu() from the kasan_record_aux_stack()
>   Thanks for Dmitry and Alexander suggestion.
>
> Changes since v3:
> - testcases have merge conflict, so that need to
>   be rebased onto the KASAN-KUNIT.
>
> Changes since v2:
> - modify kasan document to be readable,
>   Thanks for Marco suggestion.
>
> Changes since v1:
> - Thanks for Marco and Thomas suggestion.
> - Remove unnecessary code and fix commit log
> - reuse kasan_record_aux_stack() and aux_stack
>   to record timer and workqueue stack.
> - change the aux stack title for common name.
>
> ---
> Documentation/dev-tools/kasan.rst |  5 +++--
> kernel/workqueue.c                |  3 +++
> lib/test_kasan_module.c           | 29 +++++++++++++++++++++++++++++
> mm/kasan/generic.c                |  4 +---
> mm/kasan/report.c                 |  4 ++--
> 5 files changed, 38 insertions(+), 7 deletions(-)


Hi Walter,

Thanks for the update.
The series still looks good to me. I see patches already have my
Reviewed-by, so I will not resend them.
