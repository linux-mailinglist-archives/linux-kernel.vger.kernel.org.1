Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0382F0E66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbhAKInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbhAKInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:43:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:42:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 11so10523219pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1sj7p9OJF3CD1ndaejSw+BXsDdf3eGYPwhmU3XLwIFk=;
        b=lUfi4eSGGn6xM/WGWPO74Bb5dDwhb8WL3inL02bcZi9gal3b9W+Fpd8//A7vYFmOGs
         6ooIidEFfX/ylFx/Ay/IC15iDBzIipLVeTCF1Wbk3bHmG/hqNqDtqlPsmcD5NTYXjYG8
         pZ5+4JZwODXmJ4heNwfHWqBi+WuGpMqIWJjm50NX5qlDUmLvl3DQvVx56pi4kd1o69dD
         xsbHuQDiuhZetdWu0UaNHhUKSqDuD2ULa/BQwkERcghn8aUGR4mNWGO7uYzpesZHisD7
         dnVcIP7wLQbFeB+wSpEGgYMCQQKNL34DIkqSYhTMPwvyPI59rdvDelNpU+jVLfYyMcp1
         f66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sj7p9OJF3CD1ndaejSw+BXsDdf3eGYPwhmU3XLwIFk=;
        b=OfegQq6JwBjOAhmCfju5DIjoRnSjEt1dsyOwdsxXr4wBIl3biMb6rXocB5iX/4it2U
         3ORJ+o8UKZqGKcjaXs2jWJhh6YuDRhPxmku+o8Jo0qtUk+/4NT8Dh2bNNnnLtnSEztzp
         JxW1xehgGz+oTrWlZcr3xCq7co2I0IzwdJfoU97qwnnE0j6uZhYL9tdJh5jD5jrcONei
         28bVpqTnaGOiFa/67Kxzao+spz6yj9uT3C8qfW7AGRn244gL0JCWrPS8kOmoB++HABbo
         tUHP2Rzi13eTSGaRxGRO9a7Xl9wjsa6Jy2je2Q1u3Vzjt5xLa53F3ICBIBH/Cjr+MvmC
         n9VA==
X-Gm-Message-State: AOAM5337NweVzz52GVRaQn7hAfa4F1DAi0YFSEqIwLqxJ/4GthLxEfVw
        0m4D2HOcZiiuOoeR8sr2fbQEmw==
X-Google-Smtp-Source: ABdhPJx5Pv8kMewkdQS40gpu0U/OUvPVhcwQqeUNw/2qQqOyQfPD5JxAoeYGi4o2TaLfqKBWc9+bSg==
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr18839043pgb.421.1610354551152;
        Mon, 11 Jan 2021 00:42:31 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id y1sm18798225pff.17.2021.01.11.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:42:30 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:42:25 +0800
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
Subject: Re: [PATCH v2 04/11] perf c2c: Rename for shared cache line stats
Message-ID: <20210111084225.GF3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-5-leo.yan@linaro.org>
 <CAM9d7cjnHpZ2G5rBnCZonhfeGOS9vB1nrLLvhet_XG=f7O5ysQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjnHpZ2G5rBnCZonhfeGOS9vB1nrLLvhet_XG=f7O5ysQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:44:34PM +0900, Namhyung Kim wrote:
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > For shared cache line statistics, it relies on HITM.  We can use more
> > general naming rather than only binding to HITM, so replace "hitm_stats"
> > with "shared_clines_stats" in structure perf_c2c, and rename function
> > resort_hitm_cb() to resort_shared_cl_cb().
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 27745340c14a..580c4ead68db 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -97,8 +97,8 @@ struct perf_c2c {
> >         bool                     symbol_full;
> >         bool                     stitch_lbr;
> >
> > -       /* HITM shared clines stats */
> > -       struct c2c_stats        hitm_stats;
> > +       /* Shared clines stats */
> 
> Please change it to "Shared cache line stats".

Will do.  Thanks!

> Thanks,
> Namhyung
> 
> 
> > +       struct c2c_stats        shared_clines_stats;
> >         int                     shared_clines;
> >
> >         int                      display;
