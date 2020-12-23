Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810382E2295
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgLWWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgLWWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:50:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2FC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:50:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so888349lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUg/8XfBmtURDT5lBCWnW6DL77gquz8BfclV7WZ4WGw=;
        b=WXc/1DGf132PTO1txk0qMQlA5PG0JderjXg2RMviXDYMgUBTpn0MqJXVQrstbdvo6U
         sKm9x+TNynXiw6fdwNIhfb9WiW73WTA5/GgwZ63RKCfipWjrnCp/3sDrRiqtyLXe/pu/
         RrMmKQzJmh06iQw8BhyxXv85Zh3l9UA6Ma1uzb62jIYj+VBrUW+UR+spV0IMA2cM7gvX
         1WU4XzoMmfXN4HmmtrpXX/FjhnZfG0j4BuNb3k6ZhbP0/BDUHTMikjqdM0hs5QPto24B
         dHsBaQcvbYHG/SiToDbByT99rbRC3ga3AiXz2NEi+G5EjGn0LhHJ/kt3qh7dBINn1oiZ
         LLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUg/8XfBmtURDT5lBCWnW6DL77gquz8BfclV7WZ4WGw=;
        b=daAKICqobHoFKnDxiX70OkOuWZHo3fqodVJta2HYnI4QIOUck8R0MkMAiUqR6mcYNf
         6vrVbvXKq2wvuab/NxfZQBtHXzHac2Xxr/QeKU4NyYeEZIlxy7BhljJg32n03YamJDDW
         41xDFoEB8hg70j68VTVLCm6usagnADHemxDHZNbQwcba7CRSKWMFKsqnVLFcdZ2D7mqX
         WzAh0P5xzcsKhOPoC0BtWnHxzNQf6BgFc1n30miy7OwD0kNTsYTjaxoya/7aSZP+Xp8i
         jPWpH1/B36mL7dzQJrySs+gepCcPJwY2UscJ/qA/+FJqWMVjrxgI0eSTymP2LYNyOimb
         5Ppw==
X-Gm-Message-State: AOAM533ctFOQLXTkpsygbIIKRW0Eg20u8t2o9tnGbRD2jTflB7UFsYMA
        7Tq4qTVyE+vi9fbvb5yMPvQ1o0g2E2AwypV+vPchFw==
X-Google-Smtp-Source: ABdhPJz1fu+GYJ9Q4hXNi4+W2DXO1kx8E49h4Uw1p0aYX/QxgzzQ1t8pfpNBN4cRz69zRb7/MqIYJBvXh6tuLD6HBDE=
X-Received: by 2002:a2e:9cc3:: with SMTP id g3mr13689242ljj.0.1608763808708;
 Wed, 23 Dec 2020 14:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CALvZod5C_Pt_BAVBW7QRYLnfv9=9Qs0K5=kXqyyM=2dg6EqVXw@mail.gmail.com>
 <20201223163317.25979-1-sjpark@amazon.com>
In-Reply-To: <20201223163317.25979-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 14:49:57 -0800
Message-ID: <CALvZod6HjfHg-LGM82mnj5keCL8gXykmvR_aatfi2B=F0hqgbw@mail.gmail.com>
Subject: Re: [PATCH v23 01/15] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
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

On Wed, Dec 23, 2020 at 8:34 AM SeongJae Park <sjpark@amazon.com> wrote:
[snip]
> > Overall the patch looks good to me. Two concerns I have are if we
> > should damon_callback here or with the real user and the regions part
> > of primitive abstraction. For the first one, I don't have any strong
> > opinion but for the second one I do.
>
> I'd like to keep 'damon_callback' part here, to let API users know how the
> monitoring result will be available to them.
>
> For the 'regions' part, I will rename relevant things as below in the next
> version, to reduce any confusion.
>
> init_target_regions() -> init()
> update_target_regions() -> update()
> regions_update_interval -> update_interval
> last_regions_update -> last_update
>
> >
> > More specifically the question is if sampling and adaptive region
> > adjustment are general enough to be part of core monitoring context?
> > Can you give an example of a different primitive/use-case where these
> > would be beneficial.
>
> I think all adress spaces having some spatial locality and monitoring requests
> that need to have upper-bound overhead and best-effort accuracy could get
> benefit from it.  The primitives targetting 'virtual address spaces' and the
> 'physical address space' clearly showed the benefit.

I am still not much convinced on the 'physical address space' use-case
or the way you are presenting it. Anyways I think we start with what
you have and if in future there is a use-case where regions adjustment
does not make sense, we can change it then.
