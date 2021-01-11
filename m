Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949A2F0D82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbhAKHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbhAKHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:50:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73018C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:49:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x18so9071155pln.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+nni9oQp6TXIN3NBlopyF2kozA4BwOGypW/XxSOsul0=;
        b=OGQT4DZmodAAu+WeebJ1d9sh77G0ZYseLznIdw5SEDiRwNzIYul2ylSo9lh9zjLp+n
         XpxNDsDw9fobsMWyZXHCYjP8gJ7bbNz3d2YQh/Bg133nDe+1M3fmX5XgJPuXCDW2y4qT
         5RhnebECJ6cJcNG+G7AKrxn4xKj20ihYokNyhRwcBMCWwKK38uUfT3uSlpykUEEodikT
         VLq1eH3XdHK0QLgZkB6ArFIfwfUr2LTK4cgTmBVj9MHRtYTqiNqK4GbOxajP9qPP8QLi
         GWnJEqURVwkfTQ/9XnIXm8zVuz9dDAkkV4UBEygJ55G9K16y2EnfMRZqJdeB2hiKFg90
         42VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nni9oQp6TXIN3NBlopyF2kozA4BwOGypW/XxSOsul0=;
        b=R95mcdw2CFj7KzXfk/TV7/f6GnpPtCRWqpeL0qTMrU5O4Zq5higQV0iAl+nDM1O76L
         S8ISj2za3bAlJ9rDNdpMTZ0r3iNnR2HebCp7Wzh0ZB8ygNvMF2bhSB9x+koWBj4lUb9N
         xoQOjuiHg8D/DN0WvOANXZPNK/V/vnizeF4/o5/ThODiuozAWC1/v5ciJijznZkh++HE
         qnP/GfoFclxh5aRGWO2OG7FD/ZxZzPTyKHogSVJloc15g6jVdZPFcmfKa9lzVMLHaymt
         QHc22AoCrfjjv7t+W0fKPb/XcGHEasqLraqdSARWGHxJAXtI9M9byVf8ffuGLmnvhK02
         DTcg==
X-Gm-Message-State: AOAM532/+IAOfBJt+MvyeZQEhesWtM6PuCvT4qocozQoizagUBPzNKbS
        2R8gn2BIQcOzFfQVJtbZS5RFBw==
X-Google-Smtp-Source: ABdhPJx64kS1PgEJYDJeDKf/oerz0JMNe6zWMK9Dfh5sV1ZVL5mEcS2ps59ClEs/AemeJhOK34J13A==
X-Received: by 2002:a17:902:be02:b029:da:c6c9:c9db with SMTP id r2-20020a170902be02b02900dac6c9c9dbmr18156696pls.69.1610351390857;
        Sun, 10 Jan 2021 23:49:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id g2sm9154180pjd.18.2021.01.10.23.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 23:49:50 -0800 (PST)
Date:   Mon, 11 Jan 2021 15:49:45 +0800
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
Subject: Re: [PATCH v2 01/11] perf c2c: Add dimensions for total load hit
Message-ID: <20210111074945.GC3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-2-leo.yan@linaro.org>
 <CAM9d7cjMHcz_hunqKLtuKCK2BaX7NzXfE1tWCiSTxEEHz8_Jbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjMHcz_hunqKLtuKCK2BaX7NzXfE1tWCiSTxEEHz8_Jbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Wed, Jan 06, 2021 at 04:38:01PM +0900, Namhyung Kim wrote:
> Hi,
> 
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Arm SPE trace data doesn't support HITM, but we still want to explore
> > "perf c2c" tool to analyze cache false sharing.  If without HITM tag,
> > the tool cannot give out accurate result for cache false sharing, a
> > candidate solution is to sort the total load operations and connect with
> > the threads info, e.g. if multiple threads hit the same cache line for
> > many times, this can give out the hint that it's likely to cause cache
> > false sharing issue.
> >
> > Unlike having HITM tag, the proposed solution is not accurate and might
> > introduce false positive reporting, but it's a pragmatic approach for
> > detecting false sharing if memory event doesn't support HITM.
> >
> > To sort with the cache line hit, this patch adds dimensions for total
> > load hit and the associated percentage calculation.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 112 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index c5babeaa3b38..3d5a2dc8b4fd 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -615,6 +615,47 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> >         return tot_hitm_left - tot_hitm_right;
> >  }
> >
> > +#define TOT_LD_HIT(stats)              \
> > +       ((stats)->ld_fbhit +            \
> > +        (stats)->ld_l1hit +            \
> > +        (stats)->ld_l2hit +            \
> > +        (stats)->ld_llchit +           \
> > +        (stats)->lcl_hitm +            \
> > +        (stats)->rmt_hitm +            \
> > +        (stats)->rmt_hit)
> 
> It doesn't need to be a macro, why not use a static inline function?

Yes, will change to use static inline function.

As explained with Jiri, this patch series is mainly for Arm SPE, but
so far we have a known issue for store operation, thus the store
operation cannot be shown properly in the single cache view of perf
c2c tool.  For this reason, I will firstly send the refactoring patches
in next version, but your comments for patches 01, 02, 03, 10, 11 will
be addressed if later upstream them.

Thanks a lot for review,
Leo
