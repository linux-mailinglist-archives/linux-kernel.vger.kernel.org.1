Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CC2C42E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgKYPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbgKYPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:30:20 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:19 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so2694717ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeZYpN6ceKaX6TfXbLKbNUGfPhPG7kooiv8AQejhsJc=;
        b=WhZUTC9YUIpB9RDGNZahAcAiuaU/CI786AWFeNIHLbPBoula2nT2RK6gxq+nfadkvL
         pFSQJPfM/4O3e3tKuWy/F9N7WdoRF7LefVP72CYJyIKtGcsLF4sfLwhFyxpyaTZhekXY
         MXqXcL81CXOzVPL7JEXOGBeWNCp5wBkHsnJHltA+/2maDrr7wLAx2vVnxQDthFdGR7+Y
         yRGt/yn+rOIx3A5YSdCQcKQxbSxvAa2ESV5ensOS+NvmH9Ugdj7inz+skWD88KmFqu6J
         squmRbQRngpm+1VF0HT29MGioKrdZIqV7NzUEYdHGTDfXPVp/ZJfZLL/8ak+cqMBKjKS
         8ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeZYpN6ceKaX6TfXbLKbNUGfPhPG7kooiv8AQejhsJc=;
        b=sjxJv0oPfPzYRs8WwOOjuBjoKRG6WTmOZyx8lUMOoV3jsBphEzSL16c7FMGJm7TLvv
         taluuLrHlJlzvdfVjWBzHj15sVhgmHb+I3LEU8Q1Lz4pwpKBDNpjGzdtTHpANhLsgoRO
         J812oAm9+PDYsSDHnbprY81f37EEXWLC83Gy5fYZBEtE6Gpj4fduLY5w+BnXndsMT3Up
         pJiJDto7xipEDNct+E1AFSLE2ExKVnqHN+7YMqeVte+KSRxaeZrXPH92gCf9JUTYOiA0
         oPWVkjSFBS4sVO/6oEaOzMiu03IFkyQFYdQZOaSz7WLlICWer3+pHbW2N2H3P79cqkS3
         VSYQ==
X-Gm-Message-State: AOAM531Z02/mJqPpliJqOOODLB5FZ3uqY4W4DuolrjRYHqwzP1J7+jRI
        iED8niGwb/0lD+Hxx9b01J3FrohegeWdZivPtzRVmQ==
X-Google-Smtp-Source: ABdhPJyCnvynWTodcwSYTNdjI7u8KaDsboYP5Z/mWviR481Shbyl8sfXiINAWblDR2UGCQGwq2zitVZfNFgmYGIwaOM=
X-Received: by 2002:a2e:b16a:: with SMTP id a10mr1650615ljm.446.1606318217780;
 Wed, 25 Nov 2020 07:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-6-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-6-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:30:06 -0800
Message-ID: <CALvZod5DGLtegPdDjj72WOO1RmR1MV_8DE+NEakg1PYGurHNUQ@mail.gmail.com>
Subject: Re: [PATCH v22 05/18] mm/idle_page_tracking: Make PG_(idle|young) reusable
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

On Tue, Oct 20, 2020 at 2:04 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> PG_idle and PG_young allows the two PTE Accessed bit users,
> IDLE_PAGE_TRACKING and the reclaim logic concurrently work while don't
> interfere each other.  That is, when they need to clear the Accessed
> bit, they set PG_young

Only PG_young bit

> and PG_idle to represent the previous state of
> the bit, respectively.  And when they need to read the bit, if the bit
> is cleared, they further read the PG_young

Again only PG_young bit.

PG_idle bit is only read (and set) by the page idle tracking code and
it can be cleared by others (reclaim or file access).

> and PG_idle, respectively, to
> know whether the other has cleared the bit meanwhile or not.
>
> We could add another page flag and extend the mechanism to use the flag
> if we need to add another concurrent PTE Accessed bit user subsystem.
> However, it would be only waste the space.  Instead, if the new
> subsystem is mutually exclusive with IDLE_PAGE_TRACKING, it could simply
> reuse the PG_idle flag.  However, it's impossible because the flags are
> dependent on IDLE_PAGE_TRACKING.
>
> To allow such reuse of the flags, this commit separates the PG_young and
> PG_idle flag logic from IDLE_PAGE_TRACKING and introduces new kernel
> config, 'PAGE_IDLE_FLAG'.  Hence, if !IDLE_PAGE_TRACKING and
> IDLE_PAGE_FLAG, a new subsystem would be able to reuse PG_idle.
>
> In the next commit, DAMON's reference implementation of the virtual
> memory address space monitoring primitives will use it.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  include/linux/page-flags.h     |  4 ++--
>  include/linux/page_ext.h       |  2 +-
>  include/linux/page_idle.h      |  6 +++---
>  include/trace/events/mmflags.h |  2 +-
>  mm/Kconfig                     |  8 ++++++++
>  mm/page_ext.c                  | 12 +++++++++++-
>  mm/page_idle.c                 | 10 ----------
>  7 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..7736d290bb61 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -132,7 +132,7 @@ enum pageflags {
>  #ifdef CONFIG_MEMORY_FAILURE
>         PG_hwpoison,            /* hardware poisoned page. Don't touch */
>  #endif
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
>         PG_young,
>         PG_idle,
>  #endif
> @@ -432,7 +432,7 @@ static inline bool set_hwpoison_free_buddy_page(struct page *page)
>  #define __PG_HWPOISON 0
>  #endif
>
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
>  TESTPAGEFLAG(Young, young, PF_ANY)
>  SETPAGEFLAG(Young, young, PF_ANY)
>  TESTCLEARFLAG(Young, young, PF_ANY)
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index cfce186f0c4e..c9cbc9756011 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -19,7 +19,7 @@ struct page_ext_operations {
>  enum page_ext_flags {
>         PAGE_EXT_OWNER,
>         PAGE_EXT_OWNER_ALLOCATED,
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>         PAGE_EXT_YOUNG,
>         PAGE_EXT_IDLE,
>  #endif
> diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> index 1e894d34bdce..d8a6aecf99cb 100644
> --- a/include/linux/page_idle.h
> +++ b/include/linux/page_idle.h
> @@ -6,7 +6,7 @@
>  #include <linux/page-flags.h>
>  #include <linux/page_ext.h>
>
> -#ifdef CONFIG_IDLE_PAGE_TRACKING
> +#ifdef CONFIG_PAGE_IDLE_FLAG
>
>  #ifdef CONFIG_64BIT
>  static inline bool page_is_young(struct page *page)
> @@ -106,7 +106,7 @@ static inline void clear_page_idle(struct page *page)
>  }
>  #endif /* CONFIG_64BIT */
>
> -#else /* !CONFIG_IDLE_PAGE_TRACKING */
> +#else /* !CONFIG_PAGE_IDLE_FLAG */
>
>  static inline bool page_is_young(struct page *page)
>  {
> @@ -135,6 +135,6 @@ static inline void clear_page_idle(struct page *page)
>  {
>  }
>
> -#endif /* CONFIG_IDLE_PAGE_TRACKING */
> +#endif /* CONFIG_PAGE_IDLE_FLAG */
>
>  #endif /* _LINUX_MM_PAGE_IDLE_H */
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 5fb752034386..4d182c32071b 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -73,7 +73,7 @@
>  #define IF_HAVE_PG_HWPOISON(flag,string)
>  #endif
>
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
>  #define IF_HAVE_PG_IDLE(flag,string) ,{1UL << flag, string}
>  #else
>  #define IF_HAVE_PG_IDLE(flag,string)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 19fe2251c87a..044317ef9143 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -761,10 +761,18 @@ config DEFERRED_STRUCT_PAGE_INIT
>           lifetime of the system until these kthreads finish the
>           initialisation.
>
> +config PAGE_IDLE_FLAG
> +       bool "Add PG_idle and PG_young flags"
> +       help
> +         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> +         Accessed bit writers can set the state of the bit in the flags to let
> +         other PTE Accessed bit readers don't disturbed.
> +
>  config IDLE_PAGE_TRACKING
>         bool "Enable idle page tracking"
>         depends on SYSFS && MMU
>         select PAGE_EXTENSION if !64BIT
> +       select PAGE_IDLE_FLAG
>         help
>           This feature allows to estimate the amount of user pages that have
>           not been touched during a given period of time. This information can
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index a3616f7a0e9e..f9a6ff65ac0a 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -58,11 +58,21 @@
>   * can utilize this callback to initialize the state of it correctly.
>   */
>

Is there a need to move the following code in this patch?


> +#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
> +static bool need_page_idle(void)
> +{
> +       return true;
> +}
> +struct page_ext_operations page_idle_ops = {
> +       .need = need_page_idle,
> +};
> +#endif
> +
>  static struct page_ext_operations *page_ext_ops[] = {
>  #ifdef CONFIG_PAGE_OWNER
>         &page_owner_ops,
>  #endif
> -#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>         &page_idle_ops,
>  #endif
>  };
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index 057c61df12db..144fb4ed961d 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -211,16 +211,6 @@ static const struct attribute_group page_idle_attr_group = {
>         .name = "page_idle",
>  };
>
> -#ifndef CONFIG_64BIT
> -static bool need_page_idle(void)
> -{
> -       return true;
> -}
> -struct page_ext_operations page_idle_ops = {
> -       .need = need_page_idle,
> -};
> -#endif
> -
>  static int __init page_idle_init(void)
>  {
>         int err;
> --
> 2.17.1
>

Overall this patch looks good to me.
