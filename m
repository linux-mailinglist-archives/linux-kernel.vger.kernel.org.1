Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B154F275E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIWRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIWRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:05:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A8C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:05:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z17so645946lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4dEeErX3fsJf6YfVdhDLGuUkUQWGltXcsACjrY/uUI=;
        b=m+5t6/WReDb3eJGSXP+SUuLUwfRUdODd/gkzMeTwF+vQXEDdtXpZ8z0pgCktidjkqk
         dex5yOo+KZyYZt/RngNJ03vEPmDiKY3E6Rs4mxpYyUot6d8Pb2RWyI1hI3bhHzEwjIXC
         FbODuVFocd5UQvROdQS52y2Q5RL+//IYAHs9u9nL2lxRY/vSWnKlPmCaC8N4iirqRmrP
         1RPzrLASW/3/fZQQEHL3ngFIxi/nWH0rIyY+RwDL7FZDsrQs8f1zsXwnhT2eoVSBZjL+
         6b8hFmiVlFaDmmzvZerKvOJ8l/WtRB1yCuow/q7JzeskhwQo2zn64WHaob2SmO5I0GdU
         NI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4dEeErX3fsJf6YfVdhDLGuUkUQWGltXcsACjrY/uUI=;
        b=N+BBErYORa+vL39ct0nvHQi4pUFLxhPv+g8D2UQ8N/ViZZpKUnGu+tPv3z6rxII8vP
         yhSyA/ZVxgQqY7CPOWuWla/0glmN9r7LbG/sBP2UJyoHofi1ZCftdzTz99d2ebmnD51X
         eiE6YhgTYLGAxTijk1mZGuwSoVUiiew4a2vDN4iIO07/AdPyaLhOvu21pbNYoGaZrLno
         KWtonI//n0zXfa9VqYyv00mSHf3rUQRbigX2bz9hyoG6d+HloFiyXfGSA/YDrPPj4Kni
         uAYVIl33QemGG9IPjEeOanOeYV7EpOGHaNun1SHYu59sQFVR3MYI7/LBvtPSCi+Cx+GK
         9aWQ==
X-Gm-Message-State: AOAM5310ZTEamhU/WyQF8azg/8t0asEsW+4U+KPm23nGJ2mue1nXXE8h
        /YqME6BZT3K1hU3I9Y/TiWepJH4dbhYfU/gTUjeBwg==
X-Google-Smtp-Source: ABdhPJxyVSTU6OwDrnwBr27zTvXQW3Cc+Jmn5hKL9YGv53XywBc2KXEux75LUE51dxjMmNkE1Wk1wlrvd7lleGb/XqQ=
X-Received: by 2002:a05:6512:304a:: with SMTP id b10mr229017lfb.475.1600880708833;
 Wed, 23 Sep 2020 10:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200817105137.19296-1-sjpark@amazon.com>
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Sep 2020 10:04:57 -0700
Message-ID: <CALvZod7nA+_hupDrtp-G886XrgmBVf7izs5VH+1mEj6SNnyWJw@mail.gmail.com>
Subject: Re: [PATCH v20 00/15] Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        "Du, Fan" <fan.du@intel.com>, foersleo@amazon.de,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>, mark.rutland@arm.com,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Changes from Previous Version
> =============================
>
> - Place 'CREATE_TRACE_POINTS' after '#include' statements (Steven Rostedt)
> - Support large record file (Alkaid)
> - Place 'put_pid()' of virtual monitoring targets in 'cleanup' callback
> - Avoid conflict between concurrent DAMON users
> - Update evaluation result document
>
> Introduction
> ============
>
> DAMON is a data access monitoring framework subsystem for the Linux kernel.
> The core mechanisms of DAMON called 'region based sampling' and 'adaptive
> regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
> patchset for the detail) make it
>
>  - accurate (The monitored information is useful for DRAM level memory
>    management. It might not appropriate for Cache-level accuracy, though.),
>  - light-weight (The monitoring overhead is low enough to be applied online
>    while making no impact on the performance of the target workloads.), and
>  - scalable (the upper-bound of the instrumentation overhead is controllable
>    regardless of the size of target workloads.).
>
> Using this framework, therefore, the kernel's core memory management mechanisms
> such as reclamation and THP can be optimized for better memory management.  The
> experimental memory management optimization works that incurring high
> instrumentation overhead will be able to have another try.  In user space,
> meanwhile, users who have some special workloads will be able to write
> personalized tools or applications for deeper understanding and specialized
> optimizations of their systems.
>
> Evaluations
> ===========
>
> We evaluated DAMON's overhead, monitoring quality and usefulness using 25
> realistic workloads on my QEMU/KVM based virtual machine running a kernel that
> v20 DAMON patchset is applied.
>
> DAMON is lightweight.  It increases system memory usage by 0.12% and slows
> target workloads down by 1.39%.
>
> DAMON is accurate and useful for memory management optimizations.  An
> experimental DAMON-based operation scheme for THP, 'ethp', removes 88.16% of
> THP memory overheads while preserving 88.73% of THP speedup.  Another
> experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
> reduces 91.34% of residential sets and 25.59% of system memory footprint while
> incurring only 1.58% runtime overhead in the best case (parsec3/freqmine).
>
> NOTE that the experimentail THP optimization and proactive reclamation are not
> for production but just only for proof of concepts.
>
> Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
> a document for DAMON" patch in this patchset for detailed evaluation setup and
> results.
>
> [1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html
>


Hi SeongJae,

Sorry for the late response. I will start looking at this series in
more detail in the next couple of weeks. I have a couple of high level
comments for now.

1) Please explain in the cover letter why someone should prefer to use
DAMON instead of Page Idle Tracking.

2) Also add what features Page Idle Tracking provides which the first
version of DAMON does not provide (like page level tracking, physical
or unmapped memory tracking e.t.c) and tell if you plan to add such
features to DAMON in future. Basically giving reasons to not block the
current version of DAMON until it is feature-rich.

3) I think in the first mergeable version of DAMON, I would prefer to
have support to control (create/delete/account) the DAMON context. You
already have a RFC series on it. I would like to have that series part
of this one.

I will go through individual patches to provide more detailed
feedback, so, you don't need to post the next version until then.

thanks,
Shakeel
