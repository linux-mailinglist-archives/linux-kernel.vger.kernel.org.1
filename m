Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E82F0E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAKIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:44:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C44C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:43:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w1so7927472pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vNbjTzB0klxSHJ3pIVIcpT/ZpZqNRV8Ioc0fsYUqPWI=;
        b=Er1iP7WFJqIKCsjj3qxTy9sHmJDCC5/s9WfsMIRvKUwSI09g9VuhtX2BI7g/JNTDmD
         VLrxd+1RMTUAPGUlDZvzDtICSFWsuvLXqgxbORm0sFhW9a1pfRH/GFt+OsvwRUa6s4E1
         CsjB/dPoXziikTcpkmkBq35P1xH0xkHWZeKmkfyioLZTe4WhaSLSAmZZR6cPro8eqmHO
         DuwoX7AZpmtKhJsAm/e3TS9z3ApM/MHM3I6HqkF/tnwEysVoBTUtxWJQKc7YLmW5h6rz
         4MCMENQldfjxtV4ioae+AIsVF2LgMWGROkuTNsXu5GR4suY0R7eTTdSKPZiJmS7ru+LF
         wvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vNbjTzB0klxSHJ3pIVIcpT/ZpZqNRV8Ioc0fsYUqPWI=;
        b=qhVJ3TnLnatytG0ygP+lz41KU2IRU8sAvEEAnBLmgF+cJXgSpR+/wLlFRSEw18UbOq
         5WHOfyYatpBTmtTv9iAdGcocZKHcSIsrA/wmM5lINv0gAiVKqSf84dTCz++J6kMJ9QVY
         DR2qQoKprbuvovRUQ5B8xE0JMOOCo02fgazdXMtcinB/Pb660CTSLQuyYwElnsuKWZue
         fCt9EvPrto3xYRsF4p9Y/R8tvHtVJIm3yfRZnc0lKd8OdCm/wXasQk93JMIu62QH4P03
         WF4OO2IaNFzLwV8NxfQqe41aJpKLXExglsdsCFrHD1BOFfILOiXK2DFT6Z2iKZKd+2Wx
         OGzQ==
X-Gm-Message-State: AOAM530jgcLDWzwMEHHgVT52MKnvZEBEGnEMh/zZJ0KjLCcLVY9ZxP3t
        JogppnMf1aelw+z9iNxi3pmUPA==
X-Google-Smtp-Source: ABdhPJyGjuFk+TNbYNqKjJP0Kl7TIPVSeN1lotPcEwcBn1n7rTCxur52nDWE0t+e6yAf7B2n2/zxGA==
X-Received: by 2002:a17:90a:ff03:: with SMTP id ce3mr16590970pjb.44.1610354613283;
        Mon, 11 Jan 2021 00:43:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id b22sm17981071pfo.163.2021.01.11.00.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:43:32 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:43:28 +0800
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
Subject: Re: [PATCH v2 06/11] perf c2c: Refactor display filter macro
Message-ID: <20210111084328.GG3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-7-leo.yan@linaro.org>
 <CAM9d7cgg07RCthbLohwDiw4yvTdzR9ZZfRpZ5PgEg24EQiz_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgg07RCthbLohwDiw4yvTdzR9ZZfRpZ5PgEg24EQiz_Ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:47:00PM +0900, Namhyung Kim wrote:
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
> > macro FILTER_HITM is to filter out the cache line entries if its
> > overhead is less than 1%.
> >
> > This patch is to refactor macro FILTER_HITM.  It uses more gernal name
> > FILTER_DISPLAY to replace the old name; and refines its parameter,
> > rather than passing field name for the data structure, it changes to
> > pass the cache line's statistic value and the sum value, this is more
> > flexsible, e.g. if consider to extend for sorting on all load hits
> > which combines multiple fields from structure c2c_stats.
> 
> As it doesn't use field names anymore, I think it's better to change it to
> a static function.

Agreed.  Will do.

Thanks,
Leo

> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 5cd30c083d6c..f11c3c84bb2b 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2151,24 +2151,27 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
> >
> >         c2c_he = container_of(he, struct c2c_hist_entry, he);
> >
> > -#define FILTER_HITM(__h)                                               \
> > -       if (stats->__h) {                                               \
> > -               ld_dist = ((double)c2c_he->stats.__h / stats->__h);     \
> > +#define FILTER_DISPLAY(val, sum)                                       \
> > +{                                                                      \
> > +       if ((sum)) {                                                    \
> > +               ld_dist = ((double)(val) / (sum));                      \
> >                 if (ld_dist < DISPLAY_LINE_LIMIT)                       \
> >                         he->filtered = HIST_FILTER__C2C;                \
> >         } else {                                                        \
> >                 he->filtered = HIST_FILTER__C2C;                        \
> > -       }
> > +       }                                                               \
> > +}
> >
> >         switch (c2c.display) {
> >         case DISPLAY_LCL:
> > -               FILTER_HITM(lcl_hitm);
> > +               FILTER_DISPLAY(c2c_he->stats.lcl_hitm, stats->lcl_hitm);
> >                 break;
> >         case DISPLAY_RMT:
> > -               FILTER_HITM(rmt_hitm);
> > +               FILTER_DISPLAY(c2c_he->stats.rmt_hitm, stats->rmt_hitm);
> >                 break;
> >         case DISPLAY_TOT:
> > -               FILTER_HITM(tot_hitm);
> > +               FILTER_DISPLAY(c2c_he->stats.tot_hitm, stats->tot_hitm);
> > +               break;
> >         default:
> >                 break;
> >         }
> > --
> > 2.17.1
> >
