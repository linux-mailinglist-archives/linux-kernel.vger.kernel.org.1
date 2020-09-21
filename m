Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5587F271A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIUFsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:48:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIUFsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:48:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so11341389wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD5o7cKUggobLLp2qHvg4ywZrOLFSirT2Fpdeoar1xo=;
        b=DtO1rzTl7NlSuqTqVrDTdj+q2MaHPp1cU87GDpyAmSCtzNJe6dLNxRMcCgf71dIwq8
         TS5KnSStKVW+71isXGIaD3CyBVkMRXYitwAH7gtCN56/YRcPwsQ1+Vr2Ok0U1Rd7/WxC
         4oGSI4MOj/dXomEc4fkdinlh/+RRhH+6lKijNN5e0x0Hvade9yGfNJyyo5FCFO0MPUwF
         /urEh9Au0n4B8nDcJzao3vWwTAQPZbBP33WSfKRYZmhe8iWxGcFxeH4tEPLhLED00jhf
         TnqVyRlyRN+G+iPY8VXYGw/pH/j3LoXuEopbALuduyQJn6iP782CjHogEPF8aWSVdgEE
         44SQ==
X-Gm-Message-State: AOAM531m/HNkrbHp/XMAOtfvzOLTi+y+AEIeir3pKiO/3Dnph5gi6kZv
        AWmugXnKnzgY33Vss3s5AA2fiKvCgW4O94URUZY=
X-Google-Smtp-Source: ABdhPJwhn9JmYUoa7BoF9DOQaeY2wW76B1zNQ43pZdVGU695foGsMdyVs4X2NGUgN8eaXUtMMkknAhd9c0tSRiEN42w=
X-Received: by 2002:adf:a418:: with SMTP id d24mr42724014wra.80.1600667328952;
 Sun, 20 Sep 2020 22:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200916063129.1061487-1-namhyung@kernel.org> <20200916063129.1061487-4-namhyung@kernel.org>
 <20200918134535.GC2626435@krava>
In-Reply-To: <20200918134535.GC2626435@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Sep 2020 14:48:38 +0900
Message-ID: <CAM9d7cg1zLi+NE-8QJ0hfigi33s3ts2_2onRLtYosG2CgsF=Fw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf tools: Copy metric events properly when expand cgroups
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:45 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 16, 2020 at 03:31:28PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +                                     free(new_expr);
> > +                                     return -ENOMEM;
> > +                             }
> > +
> > +                             memcpy(new_expr->metric_refs, old_expr->metric_refs,
> > +                                    nr * alloc_size);
> > +                     } else {
> > +                             new_expr->metric_refs = NULL;
> > +                     }
> > +
> > +                     /* calculate number of metric_events */
> > +                     for (nr = 0; old_expr->metric_events[nr]; nr++)
> > +                             continue;
> > +                     alloc_size = sizeof(*new_expr->metric_events);
> > +                     new_expr->metric_events = calloc(nr + 1, alloc_size);
> > +                     if (!new_expr->metric_events) {
> > +                             free(new_expr->metric_refs);
> > +                             free(new_expr);
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +                     /* copy evsel in the same position */
> > +                     for (idx = 0; idx < nr; idx++) {
> > +                             evsel = old_expr->metric_events[idx];
> > +                             evsel = evlist__get_evsel(evlist, evsel->idx);
>
> this probably won't happen, but evlist__get_evsel can return NULL

Hmm.. yeah, it should not happen.  Anyway I'll check the result.

Thanks
Namhyung

>
> > +                             new_expr->metric_events[idx] = evsel;
> > +                     }
> > +
> > +                     list_add(&new_expr->nd, &new_me->head);
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> SNIP
>
