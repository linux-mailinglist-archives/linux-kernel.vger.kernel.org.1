Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B92F0E60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbhAKImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbhAKImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:42:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C16C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:41:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w2so2650483pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFx8wmURstpDQyDwNwIE6Nf4AUHKPJbuOybjktkqX50=;
        b=JcVZTnsrnT03qDRonFmbCUgziXt4ZgCY0V3kgcXtdNSwhbcrHVapVFXAsL0p5/w7ZR
         0cx/bfAHhKLkV43XjmMq+7Z+4WA8SQtTIMJO21nEVvCn8CnoweKrThxjmiCHj0/LUGJr
         DHgRjjnXXVlEfGa3b7+zQNBa+mJhRtsUg50jDNhr+ylSqGIMpPP+4y6tAQODfLlq/XHB
         BfUjVADfCzeor4QzL3v1lvG7YM6b+W/33fzc2kPQyQpMY/NhIXHY1UGfNhpHeZFuIvUz
         1zwViIOrChDNa6hznT4MDzhxTz6GKM5y5fgw2ljlOIOQWJnkXjc0f9/MWE/VkGNx97QH
         hWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFx8wmURstpDQyDwNwIE6Nf4AUHKPJbuOybjktkqX50=;
        b=hr0uZbbpNwAKhkgYmd/hs8rtlRahIKQtIEO7FPk5pOx5Eh4jkGnwNd4qgkJ7zLmaT9
         Bkcztf7kfAQYriHO8qCInnHKTjxJ9TwfmFhXBAfkaI5qvl+ZD5kzXCqEPjfJ8yxqs5cm
         p08vmbg/TcIs0QE0bZulnh6f50bN/2E/gcyaVuwsnDRaq36SGu3OIXkSy8SmPqw1J3Qn
         NXiK/sseZxwtc3RIuGqFq1WJX+2fugQolX+ML9BWV671kx7F42vDdVev35OXQp2+kALS
         3iN/aMjTvbsu5LLz3thDJLleX/rpjUXuZ1nYopJCMGezuVAhn16snZmkMNIwQ0MZ6y3y
         AJqA==
X-Gm-Message-State: AOAM533FMNI6kJnmMKFxW4BT+1iwKcuRWCVMKR6eEdGoshUwgYki/xu0
        aS0OIi6IMag6SRMJbv7oUAWfgQ==
X-Google-Smtp-Source: ABdhPJzSH6yYUJtHu0RLiNsBybGqy6yE0S01/pmwBsLhfGIvQWGTf3/T5TM0jbPlkUSdbCa8xdXysg==
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr18563898pgb.226.1610354504193;
        Mon, 11 Jan 2021 00:41:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id e10sm19419956pgu.42.2021.01.11.00.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:41:43 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:41:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/11] perf c2c: Add dimensions for load miss
Message-ID: <20210111084138.GE3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-4-leo.yan@linaro.org>
 <CAM9d7cjOkSZRZz6JJW-eCD0Dx5E6rGzfmvU3deQyEr2RLUgzGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjOkSZRZz6JJW-eCD0Dx5E6rGzfmvU3deQyEr2RLUgzGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:42:59PM +0900, Namhyung Kim wrote:
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Add dimensions for load miss and its percentage calculation, which is to
> > be displayed in the single cache line output.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 107 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 00014e3d81fa..27745340c14a 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -624,6 +624,10 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> >          (stats)->rmt_hitm +            \
> >          (stats)->rmt_hit)
> >
> > +#define TOT_LD_MISS(stats)             \
> > +       ((stats)->lcl_dram +            \
> > +        (stats)->rmt_dram)
> > +
> 
> Is this true always?  I'm not sure if there's a case where stores can go to DRAM
> directly.. maybe like a kind of uncached accesses.

Firstly, from my understanding, the uncached accesses are not accounted
in the "load miss" metrics.  You could see there have other two metrics
"stats->st_uncache" and "stats->ld_uncache" which present the store
uncached and load uncached respectively.

Furthermore, based on the function total_records(), it uses below
formula to account the total load accesses:

        lclmiss  = stats->lcl_dram +
                   stats->rmt_dram +
                   stats->rmt_hitm +
                   stats->rmt_hit;

        ldcnt    = lclmiss +
                   stats->ld_fbhit +
                   stats->ld_l1hit +
                   stats->ld_l2hit +
                   stats->ld_llchit +
                   stats->lcl_hitm;

So this patch series classifies these metrics into two numbers: load hit
and load miss; load hit is considered as hit at any cache levels
(L1, L2, LLC and even remote cache), the load miss is accounted with the
rest metrics (lcl_dram + rmt_dram).

> Also it can be a static function..

Yeah, will fix.

Thanks,
Leo
