Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E462C42E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgKYP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgKYP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:29:42 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:29:24 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d20so3649807lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13PkHEsv5Gfsa10yo6xM+865e/X5/3hhggzHTqOXsfY=;
        b=EtFwDakdU9esaLPfWzzJWQtYC0O8QZ1aEjSYd6jyGyNFsHJbU3dKUmYx/8clc5nygX
         Kg9cV5BthVrMiwyp4ET9GXGQCSU6jr00bTNUXQelW1NTF92XFBTITcCQ2vKtBk2hlbW0
         KFCXPk81RL0a6N6E7YzOef0MyTqMww45RtMIX4nu2KfuzH4/RMa93iWSnzzsuHhVtNYI
         1sHg6kX7myPLW4vH8t/EMJaLxl+APqJIm//p6N8TOrsTOeIorJxwFOeDShhnZFTLFhG5
         duyLIOrAX7uOWCNDMTPoB49Q67kC8++gGKTMbP+k4uDFOPSRdm0XIIEOg0K87bT+1AoV
         VUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13PkHEsv5Gfsa10yo6xM+865e/X5/3hhggzHTqOXsfY=;
        b=C4QthdI3WI875sMhpM0NuANpI9Sqc5OoEfoeHZP8SGrGhbogECQaZJjB3pe6kaKzTy
         jKiYYlAzRBoBXg0/k71IA5ARGNJFG6PfuIDLO1ZDEVKJ5jlgNHHBwLJi36Ddh4SvCVKU
         /mwWwvOCrlqcNaS3927jfFf00bqDtslIovkdS0Mhj+mdRIvEvUzTaYpBBJibno8MIsF3
         TLlFh4D9trvmGuNiHgHmgNA3grB+8ImpxIULWFK1UXCYhc42YMScLAG0CwITNOJ8TCXz
         sEU2Ho312KrGuWch6jU09GdeDUVhx07FrrL0SO9QJTsxK5dpwKqEB2gf35TaS8dqUcwx
         T64g==
X-Gm-Message-State: AOAM532F2Ocq5nEilve0vF+fQfES59v/SO7O7dAL5OQzWR8g686/kQi+
        CmsN75bTaHHFujE+yMgJXMZrOQ+WPp8dlr9lYCrkkg==
X-Google-Smtp-Source: ABdhPJwzuLmEK1UhNY2f2Yzr1gYWBmJ4e3SlnShveEx8r1IdEbiY7y110FD2IyZZ2Nz8RyetMJzXwtu34FltaqP3zKM=
X-Received: by 2002:ac2:43cc:: with SMTP id u12mr504816lfl.54.1606318162152;
 Wed, 25 Nov 2020 07:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-2-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-2-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:29:10 -0800
Message-ID: <CALvZod5rALTNRzK2w-y7AJMxFfBV9upJECPvCjhF=iFcDFt-5g@mail.gmail.com>
Subject: Re: [PATCH v22 01/18] mm: Introduce Data Access MONitor (DAMON)
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
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
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

On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> DAMON is a data access monitoring framework for the Linux kernel.  The
> core mechanisms of DAMON make it
>
>  - accurate (the monitoring output is useful enough for DRAM level
>    performance-centric memory management; It might be inappropriate for
>    CPU Cache levels, though),
>  - light-weight (the monitoring overhead is normally low enough to be
>    applied online), and
>  - scalable (the upper-bound of the overhead is in constant range
>    regardless of the size of target workloads).
>
> Using this framework, hence, we can easily write efficient kernel space
> data access monitoring applications.  For example, the kernel's memory
> management mechanisms can make advanced decisions using this.
> Experimental data access aware optimization works that incurring high
> access monitoring overhead could implemented again on top of this.
>
> Due to its simple and flexible interface, providing user space interface
> would be also easy.  Then, user space users who have some special
> workloads can write personalized applications for better understanding
> and optimizations of their workloads and systems.
>
> That said, this commit is implementing only basic data structures and
> simple manipulation functions of the structures.  The core mechanisms of
> DAMON will be implemented by following commits.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Varad Gautam <vrd@amazon.de>

I don't see any benefit of this patch on its own. Some of this should
be part of the main damon context patch. I would suggest to separate
the core (damon context) from the target related structs (target,
region, addr range).

Also I would prefer the code be added with the actual usage otherwise
it is hard to review.

> ---
[snip]
> +unsigned int damon_nr_regions(struct damon_target *t)
> +{
> +       struct damon_region *r;
> +       unsigned int nr_regions = 0;
> +
> +       damon_for_each_region(r, t)
> +               nr_regions++;
> +
> +       return nr_regions;
> +}

Why not keep a count instead of traversing to get the size?
