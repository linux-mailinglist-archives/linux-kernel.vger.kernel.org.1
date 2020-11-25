Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC362C42E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKYPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgKYPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:30:10 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83AC061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:10 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l11so3728459lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xw/d2aL2V6OyUJc5Lb0yrMaOLnYVpYV2bdYYQamMGc0=;
        b=MWBqsMqBpkegZ9cm2AN+6GNJuM1/HaLoNDyLLanpmYnqeimJPKC1ygemMiRZ+FIvlW
         2+O9wuEMUWF+vXohOu7PIPKFptm+XHU7s56V0TsEtZTFkdQlyRVRMaILU1SMzjjp4vMw
         O0SZkmY07leSN/rrz8ESoI4G3C4knpSXh5Ajuk/xR4XQYHB7Nz9edn/z6kVqMfBYoqzL
         8dmV3+XX89bWjeTzYPKkx4+wlvgqV29zgEwrajjaXj3imTkgEQZc4pT9m45rF0lc/rAd
         JTCcJPX8MBhqi+UN4PerFekbtDSenwDkQAriCwze8+FI5ZWtZ4TGqF3VcjQ9A9MhycrV
         4EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw/d2aL2V6OyUJc5Lb0yrMaOLnYVpYV2bdYYQamMGc0=;
        b=UMKDm4Tpto0SNwc0c50zz8vsjt5tGXwGdxbbg3IO61pOdSCa8O50W2pM9r8raWu1WE
         UWTFxue/U87ptq0Xu6Ov004BwlYpa4N5rK6Np5B6phOEDFadm5psQAsUB1WGNKPbi2yj
         dIgtBbvO6vhEfhdNvuk7kIVYc0EqRFJXHFHaI1v9thNxxsjWYqM5KaQNW66msQtBUIng
         ip7wH5cn3IFp9Yh+l4xzRJa9F7BI4kC37GkpvvWgo+mpYybDEgbWIZNyca4MKYR+QaF5
         7oXf/Ofq18IXTOldOFrbyJBYzUHDmnCFCf0Uqo7QIW/kT9Zd2bvXnWS8V3bXAEzNNkBW
         Xotg==
X-Gm-Message-State: AOAM531LSanNQWYNhYBDyjHhDumRdbyLa65ykBFwXqLK8xmV6onLOQAD
        b29xf2fugRg7qNmJteZxH7Rq/nZijsbLeuOWAXVjkA==
X-Google-Smtp-Source: ABdhPJymDgfWal1UzxfIM98lP5IZ5DYTmO9CqloamXZNu690XNw4o8xkul77pSc7vicKazCnSS2LhP1gDXV9tmzWi4s=
X-Received: by 2002:a05:6512:6c9:: with SMTP id u9mr1529475lff.475.1606318208341;
 Wed, 25 Nov 2020 07:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-5-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-5-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:29:57 -0800
Message-ID: <CALvZod6iLkNyePTMn9=DOgbD5Q7Yqc_WrQrNqOQ3e-2+FtJZsg@mail.gmail.com>
Subject: Re: [PATCH v22 04/18] mm/damon: Track dynamic monitoring target
 regions update
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

On Tue, Oct 20, 2020 at 2:02 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> The monitoring target address range can be dynamically changed.  For
> example, virtual memory could be dynamically mapped and unmapped.
> Physical memory could be hot-plugged.
>
> As the changes could be quite frequent in some cases,

Which cases? Usually address space changes are very infrequent for
performance reasons.

> DAMON checks the
> dynamic memory mapping changes and applies it to the abstracted target
> area only for each of a user-specified time interval, ``regions update
> interval``.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
[snip]
>   * Check whether current monitoring should be stopped
>   *
> @@ -612,6 +625,11 @@ static int kdamond_fn(void *data)
>                         kdamond_reset_aggregated(ctx);
>                         kdamond_split_regions(ctx);
>                 }
> +
> +               if (kdamond_need_update_regions(ctx)) {
> +                       kdamond_call_prmt(ctx, update_target_regions);

The implementation of update_target_regions callback should be part of
this patch.


> +                       sz_limit = damon_region_sz_limit(ctx);
> +               }
>         }
>         damon_for_each_target(t, ctx) {
>                 damon_for_each_region_safe(r, next, t)
> --
> 2.17.1
>
