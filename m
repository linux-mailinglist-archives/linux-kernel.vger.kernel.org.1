Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C272F0E71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbhAKIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbhAKIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:44:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11736C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:44:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p12so7379944pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iXjMOX8XKg1YVQt+aRV4SPtrFnvj7IJcMj0QikARtus=;
        b=BrYaPgTnbRvGoBu115PuzWaR/I1yPBL+QGG/d/E6JhiBD4NwNGjavu3Cjq+vHAUFwK
         hvVDmI9BvVWsHSZ7KKoQc6dyiumQLE9oz9idsVwWiTeNysPtyDLOJ/P3U1lfZd7IV5Fs
         Sp1+T4gc66lYTTnOy04zwK/lPlTkg9C2IuoaDqnhd/Zdeea3P3aolJZNNxDKWFWpXmot
         WBci1gNp56z8eX1FBVkZRXuBzRlJzq7UhatLmMnrcBQV2I7p7eS5qNtHIgyd6iV1k98m
         6Xy2bI+x/IY+9deZBXwh9dsHtBNtuubIBsTWorGC3UkXb+oQWUYeJsv93DWPF+rGgiFc
         jIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iXjMOX8XKg1YVQt+aRV4SPtrFnvj7IJcMj0QikARtus=;
        b=AOPpcmzOBjv5XbTPuS1TGPzqXUKHNW0+8bZiovqrVdFbv/TzDM8j05LsQNCpAmvroB
         q6JXIswjbWNLytxYUvKdF+lLYBhWHF6SHCHANRfTvp/oNV6+gM4Ly2cPk5pFtDtwYlWB
         Syb5ZzPyXnggf3dft1FQfY08MJw1X+ie2HpE/wFc2oGvahgAs3gQLGfAvOdbF6/qsEXj
         F+Cu3lwll4nqX9Xfuaa0F5gqhJmkqEcOgK2o8/tzcxZ5LaPLdNO+iI/4JK4K0ZAzKxx8
         ZkuSrt5pOI7Kw67eNDGkiQl3qwxIvyGxg4jUNgqzK0UGJBLB6QoP7IUBczwB27XJV4++
         M3HQ==
X-Gm-Message-State: AOAM5306Idqc9H7HqqYizJlgMT7zv5/57HF76EOczlbeG8WjgI9WWP91
        Pn3P/WYPAuFWiQImJMJN4y7H0A==
X-Google-Smtp-Source: ABdhPJzBc5o9Z92bmdiLxpdOqk/0H5l3HK/IMszpMjABrWLz/xuwcRJ1pKegyaa2zeIkg6t36dn8xA==
X-Received: by 2002:a17:902:b18c:b029:da:fc41:baf8 with SMTP id s12-20020a170902b18cb02900dafc41baf8mr15464165plr.58.1610354647601;
        Mon, 11 Jan 2021 00:44:07 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id n1sm17845401pfu.28.2021.01.11.00.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:44:07 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:44:02 +0800
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
Subject: Re: [PATCH v2 07/11] perf c2c: Refactor node display macro
Message-ID: <20210111084402.GH3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-8-leo.yan@linaro.org>
 <CAM9d7cj4z6KxYLS1Envcsir9wBJgHujXq3-86PEGk-7zAbyvsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj4z6KxYLS1Envcsir9wBJgHujXq3-86PEGk-7zAbyvsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:47:49PM +0900, Namhyung Kim wrote:
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The macro DISPLAY_HITM() is used to calculate HITM percentage introduced
> > by every node and it's shown for the node info.
> >
> > This patch refactors the macro, it is renamed it as DISPLAY_METRICS().
> > And the parameters is changed for passing the metric's statistic value
> > and the sum value, this is flexsible for later's extension, e.g. it's
> > easier to be used for metrics which combines multiple fields from
> > structure c2c_stats.
> 
> Same as the previous one.

Will do, thanks.

> Thanks,
> Namhyung
> 
> 
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index f11c3c84bb2b..50018bfb1089 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -1324,23 +1324,26 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
> >                         ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
> >                         advance_hpp(hpp, ret);
> >
> > -               #define DISPLAY_HITM(__h)                                               \
> > -                       if (c2c_he->stats.__h> 0) {                                     \
> > +               #define DISPLAY_METRICS(val, sum)                                       \
> > +               {                                                                       \
> > +                       if ((sum) > 0) {                                                \
> >                                 ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",        \
> > -                                               percent(stats->__h, c2c_he->stats.__h));\
> > +                                               percent((val), (sum)));                 \
> >                         } else {                                                        \
> >                                 ret = scnprintf(hpp->buf, hpp->size, "%6s ", "n/a");    \
> > -                       }
> > +                       }                                                               \
> > +               }
> >
> >                         switch (c2c.display) {
> >                         case DISPLAY_RMT:
> > -                               DISPLAY_HITM(rmt_hitm);
> > +                               DISPLAY_METRICS(stats->rmt_hitm, c2c_he->stats.rmt_hitm);
> >                                 break;
> >                         case DISPLAY_LCL:
> > -                               DISPLAY_HITM(lcl_hitm);
> > +                               DISPLAY_METRICS(stats->lcl_hitm, c2c_he->stats.lcl_hitm);
> >                                 break;
> >                         case DISPLAY_TOT:
> > -                               DISPLAY_HITM(tot_hitm);
> > +                               DISPLAY_METRICS(stats->tot_hitm, c2c_he->stats.tot_hitm);
> > +                               break;
> >                         default:
> >                                 break;
> >                         }
> > --
> > 2.17.1
> >
