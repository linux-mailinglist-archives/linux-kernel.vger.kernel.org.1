Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE192E8F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 03:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhADCK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 21:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbhADCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:10:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB9C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 18:09:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t8so15432404pfg.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 18:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6iTKtqyriWsZAxKsvL2Y6RhQK5K9bt6sJVY3XzQqa4=;
        b=tBPVkrRisV0lX83ZYxntXAoxU7o2BtzEZh6vV0j4YeIbt6Si6lIiv9/G7K2df44AbF
         IBfQE40Gbzw4PlS4Znuwj8PdWfstU1v6DLGI7jnDstPbFfdwN7vpSLAanGrnwp9d/HOA
         QfrQ7ifOA7lVzJ0STwZfoNOu0Ae9C2GUZuuCAkgEDR02AovaCkcLlooHeMggOyLGr8AM
         VZVFs5KXw4UnIzdlx4p2JdMti0DDqm4vFo4sOsZ/YXGEeDs5H8qmWFApPJcsNEDhoHPX
         OZXYlcxS6wc+g26Gf8gbSB2kvybk2BikWJOHIe+QIS6nMxNXI/ldtkoqZZX78lVNMCPo
         wQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6iTKtqyriWsZAxKsvL2Y6RhQK5K9bt6sJVY3XzQqa4=;
        b=eIP72KKvlcXe5zqGbwoa0J2+p7s5Cmly22utsenygI4/tAmr1ct6ObNCKKPR29reRj
         bpfzf7jpRji1ZHF6ht154CHXhNEwfnnTFQ8byPgElbKrWjv1GTrEWJUVTGAZv6MTF+XR
         u6+sJmaWrXiy3f8wVQLZTsDz3OIj7/zFKcW/fqbpRqQwXdYfINHLjRPEy9mBom++iCe3
         9UriYDg/UBsABJuQqUeQjkV82ghujCVu3X2fWanLq2Ikw61u7aGH0WDbBV9ZoKvkwrgO
         KpRW+BZPDzE9z/zZLa/Z+eYOvWb4piZNt6PaUy79oZ+AQhDRI2rwlD3znnGZSkIaZdSR
         g+DA==
X-Gm-Message-State: AOAM533W9WVk2UIga+GGewtiAfQvbSR4F9tc0WcDk1Pt+d3t7jNklUAg
        r2RXCX7sB90qB5rSOOOEIRDH89clnlR7wasj
X-Google-Smtp-Source: ABdhPJwEkemHM7IzHlpd+qvgIiTGSjqlMBFb3lNMUSbhB+CU9Mt2llsUl7xQuIhgBXcsOu75Y7kYVA==
X-Received: by 2002:aa7:8a99:0:b029:1a6:c8b8:1414 with SMTP id a25-20020aa78a990000b02901a6c8b81414mr63014513pfc.66.1609726184396;
        Sun, 03 Jan 2021 18:09:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id h17sm53052071pfc.119.2021.01.03.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 18:09:43 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:09:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf c2c: Sort cacheline with all loads
Message-ID: <20210104020930.GA4897@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20210103225219.GA850408@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103225219.GA850408@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 11:52:19PM +0100, Jiri Olsa wrote:
> On Sun, Dec 13, 2020 at 01:38:39PM +0000, Leo Yan wrote:
> > This patch set is to sort cache line for all load operations which hit
> > any cache levels.  For single cache line view, it shows the load
> > references for loads with cache hits and with cache misses respectively.
> > 
> > This series is a following for the old patch set "perf c2c: Sort
> > cacheline with LLC load" [1], in the old patch set it tries to sort
> > cache line with the load operations in last level cache (LLC), after
> > testing we found the trace data doesn't contain LLC events if the
> > platform isn't a NUMA system.  For this reason, this series refines the
> > implementation to sort on all cache levels hits of load operations; it's
> > reasonable for us to review the load and store opreations, if detects
> > any cache line is accessed by multi-threads, this hints that the cache
> > line is possible for false sharing.
> > 
> > This patch set is clearly applied on perf/core branch with the latest
> > commit db0ea13cc741 ("perf evlist: Use the right prefix for 'struct
> > evlist' record methods").  And the changes has been tested on x86 and
> > Arm64, the testing result is shown as below.
> 
> SNIP
> 
> > 
> > 
> >   [...]
> > 
> > Changes from v1:
> > * Changed from sorting on LLC to sorting on all loads with cache hits;
> > * Added patches 06/11, 07/11 for refactoring macros;
> > * Added patch 08/11 for refactoring node header, so can display "%loads"
> >   rather than "%hitms" in the header;
> > * Added patch 09/11 to add local pointers for pointing to output metrics
> >   string and sort string (Juri);
> > * Added warning in percent_hitm() for the display "all", which should
> >   never happen (Juri).
> > 
> > [1] https://lore.kernel.org/patchwork/cover/1321514/
> > 
> > 
> > Leo Yan (11):
> >   perf c2c: Add dimensions for total load hit
> >   perf c2c: Add dimensions for load hit
> >   perf c2c: Add dimensions for load miss
> >   perf c2c: Rename for shared cache line stats
> >   perf c2c: Refactor hist entry validation
> >   perf c2c: Refactor display filter macro
> >   perf c2c: Refactor node display macro
> >   perf c2c: Refactor node header
> >   perf c2c: Add local variables for output metrics
> >   perf c2c: Sort on all cache hit for load operations
> >   perf c2c: Update documentation for display option 'all'
> > 
> >  tools/perf/Documentation/perf-c2c.txt |  21 +-
> >  tools/perf/builtin-c2c.c              | 548 ++++++++++++++++++++++----
> >  2 files changed, 487 insertions(+), 82 deletions(-)
> 
> Joe might want to test it first, but it looks all good to me:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks for the review, Jiri.

Note, after testing with Arm SPE, we found the store operations don't
contain the information for L1 cache hit or miss, this leads to there
have no statistics for "st_l1hit" and "st_l1miss"; finally the single
cache line view only can show the load samples and fails to show store
opreations due to the empty statistics for "st_l1hit" and "st_l1miss".

This is related the hardware issue, after some discussion internally,
so far cannot find a easy way to set memory flag for L1 cache hit or
miss for store operations (more specific, set flags PERF_MEM_LVL_HIT or
PERF_MEM_LVL_MISS for store's L1 cache accessing).

Given it is uncertain for this issue, please hold on for this patch
series and I will resend if have any conclusion.

And really sorry I notify this too late.

Thanks,
Leo
