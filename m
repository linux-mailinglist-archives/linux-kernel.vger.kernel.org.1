Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF92789DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgIYNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:45:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45170 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgIYNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:45:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id x14so3629066wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlhR3B1xTrFJPN7Yr45TLDcNvoWGlkYDRnyFJmu7snU=;
        b=FGUMSa4TdWu9DxstvjiaD50mwiA1BQsfBA+I3zXt+gZECukzdXpFDYCUrivQh/ygOd
         wt/jV1Ndfj1+En0+R1+WUE2WZkXGmqr52VcqOicsf+9Dyxpfm6ucTxPPSLVlmIa2o1sT
         EnKEhrZd8lU4H131xGHS6yK4XD5MVPL9geortpGLjmAGiWVxZnvCLxS00djImjYaCp4b
         s4V3TXeedKG3lwaFysLffjVnkH6qW2BmI3kv0khSxajhm7GpF/lcKEjQdTUXQBJuoNIl
         D2V26cDf0G2CfHko6goPxBAnqn3BFaRWrtWZntdpmoY0MvtUEXSk6+W/4D1giBucnSe1
         eZlA==
X-Gm-Message-State: AOAM530uh+dUPOuP9z/w+FSRpoMwXdKb5bSgV2MnoNChv8OomFGs9Xqs
        1/VegbAbQPK9Xmvvy6/Y6iX7M3FaramVi0yy2pc=
X-Google-Smtp-Source: ABdhPJyBN/va2EdeB5OsIq/sfsn5RsbVsveEfASKFe3flCATXtrdZgun9ebgeD0yMuKB1E/2zjvKHBnKG7WP4lwXGlE=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr4437142wrp.332.1601041505066;
 Fri, 25 Sep 2020 06:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200924124455.336326-1-namhyung@kernel.org> <20200924124455.336326-4-namhyung@kernel.org>
 <20200925132636.GB3273770@krava>
In-Reply-To: <20200925132636.GB3273770@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Sep 2020 22:44:53 +0900
Message-ID: <CAM9d7cgHBe6-SfCc3RTfLmrvaKr1hSprmJPd2BFnQtMUu_6TFw@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand cgroups
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 09:44:53PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> >
> > +     if (metric_events) {
> > +             orig_metric_events = *metric_events;
> > +             rblist__init(metric_events);
> > +     } else {
> > +             rblist__init(&orig_metric_events);
> > +     }
> > +
> >       for (;;) {
> >               p = strchr(str, ',');
> >               e = p ? p : eos;
> > @@ -255,6 +267,14 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >               cgroup__put(cgrp);
> >               nr_cgroups++;
> >
> > +             if (metric_events) {
> > +                     perf_stat__collect_metric_expr(tmp_list);
> > +                     if (metricgroup__copy_metric_events(tmp_list, cgrp,
> > +                                                         metric_events,
> > +                                                         &orig_metric_events) < 0)
> > +                             break;
> > +             }
>
> looks good, do you plan to actualy add support for record?

No actually, I still think perf record should use --all-cgroups.

> my ack from last version stays

Thanks!  But I didn't see your ack for this patch set.
(I've only seen it for the perf inject patchset..)

Thanks
Namhyung
