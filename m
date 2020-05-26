Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3A1CBBF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgEIAl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 20:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgEIAl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:41:28 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 17:41:27 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o198so1845699ybg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apt6PtlX6aCenSSTB3xM+2wfl3pUWi+4h8MqzP3M6e8=;
        b=BCOtYKeHkJn1rMdkWGn8DLQyW/XIssArSPBRpqsIdRePmOcVhYhV7A7kBYytr7wBTV
         gjCPDuvKfioGwh3LP1ABMq8WtUgMqFZ/lK4LtjOmm206oksXmKGRTJPeD+hr6TjpeBw5
         NRn0LhZ1DKqw1ryR/u8kY3VdmD5oPvPQ8l+YNAM7xdDU3vyc0ihsX74ASYtRtO3lp4rh
         d8iT/6guSGnrYgE8C2qNz3cBOciN5SPlQV50d0UWY4o5WJ/DCS7HnZRR1p4BhdrcM5Cu
         DBPcaCsQCGniJa8djxiVUQhK/9BlioqAEwamblDF1bfQ9Ap21IAyU7hAYTdbG4vCsY4O
         ZbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apt6PtlX6aCenSSTB3xM+2wfl3pUWi+4h8MqzP3M6e8=;
        b=s39VEZHe/5js/ocEuATK2kDWZ+Ckbsyn5lhQo1Uijgdd+vhRbB4ubq/C7fK/HTIJ59
         PDRTZJJNRLofTEmGAP2avw/LGjGrJYi1L4Ngl2vj8h7NbcD0aItVYJL6mQNbQROcePu7
         tLmHV4cTiF9AjGU/1N7QGe2hF4HK4OGVoURyLPjJCnUfDxmukrlFDK/iXoyFeCg8Zy0G
         /rM1v52mhXQwG4j9+Iw9PqWp/wclbbx+uJkLdWojJyCOtjayMWVzKzeoa9nLsxsAHyad
         TUgyohQ82qQZ02LEtBTxk4OFQxxSt5+TBVyRyY8stvF1ihEuNSKSeKqxLN9pfldBZtyY
         bKeg==
X-Gm-Message-State: AGi0PuZKNN7QY/KQ60sA5+7Pn2KPzb0tsjH4CPIbT+hibQqIkWE58S/R
        a+6p2hO5En5kN8hTpAM8tpF5hXkbJfjbqcXGD40z2g==
X-Google-Smtp-Source: APiQypI98dvYPae1t1/9C5x+HbnaKufpUwiqItw27bjaCb8Vy0Kc2F+ZoR5YTGNY2wGWQ5ZwzUEcQDdxchTTyY2UUAs=
X-Received: by 2002:a25:d688:: with SMTP id n130mr8769766ybg.324.1588984886878;
 Fri, 08 May 2020 17:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com> <20200508053629.210324-7-irogers@google.com>
 <20200509003936.GH3538@tassilo.jf.intel.com>
In-Reply-To: <20200509003936.GH3538@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 May 2020 17:41:15 -0700
Message-ID: <CAP-5=fWr57Z6LP8XcNSBanNfuYPntMjJeNHoXUG6FRusP2KwcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/14] perf evsel: fix 2 memory leaks
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:39 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Thu, May 07, 2020 at 10:36:21PM -0700, Ian Rogers wrote:
> > If allocated, perf_pkg_mask and metric_events need freeing.
>
> All these patches at the beginning look like straight forward
> bug fixes and are really independent of the new features.

Thanks, for context I added them after v1 to make it easier to apply
the patches.

Ian

> For them
>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 28683b0eb738..05bb46baad6a 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1263,6 +1263,8 @@ void evsel__exit(struct evsel *evsel)
> >       zfree(&evsel->group_name);
> >       zfree(&evsel->name);
> >       zfree(&evsel->pmu_name);
> > +     zfree(&evsel->per_pkg_mask);
> > +     zfree(&evsel->metric_events);
> >       perf_evsel__object.fini(evsel);
> >  }
> >
> > --
> > 2.26.2.645.ge9eca65c58-goog
> >
