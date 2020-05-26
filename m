Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F621D882E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgERTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:24:46 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C249C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:24:46 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v26so6333974vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uiCxZtkzkGr7WZ+iPgFdPescQSjCrMQZRNNCDufNnc=;
        b=MRxltl0J8aVtgfT0JM0hwghme8n9ii5KsiIHtdLqdtuS9rEt+rotP0c1XrlD+P19BC
         ImL2dWayDJwm7R5aOFG0KUgv1InTk/WuJfjulJ3iPKJ3TXZmIfPIm+u7x5HSxKRq4VEK
         DiqyqEYGbmHIxaZ4qMEteC8edmu/XROFw/xzWo21AGsIHPA42X5NEVDkctwW4PJcfGfx
         Gkadxk18b3LT/xd0B1vTYfI/JxV1cBkPXxob0QjB5TBaABWX1UnbTpUiJnFoyW0aOPxA
         NxalsdLqJYtVMwX5WCws2p15mC9an6P0fMlTs8e9wHP/lbYeOaOgvJqP7Ck4t2V1oVon
         cxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uiCxZtkzkGr7WZ+iPgFdPescQSjCrMQZRNNCDufNnc=;
        b=QIU/V5HEwO3HhbbifalrlNrQEyrfCzGo2F0QJyI5azXM2dXIMFruMrmAhu9wObr8P/
         RA/8L0H+yaAecR6CPuQPO9L8dYCMPr4HQ9L22XB2SEI5Tk7/1vDq5HMrbXw0DaRe3E2g
         LAeQeYBHsIupD5NL9prK5p1p7fRPYfloR7YbR7kNUHdkj/pdEHfguAif00AC8+umIkgG
         UExFeHDmtFnZXX1n4e1jTT4vrDZP5TatfCmpLNi6wqctti/8zgIlOnveV/LJFFq/7W+s
         Y/tC0OVexSBKn90DXX3R/Sl3/MxapwyjvRrFH6yK7d2z2S/lJaXqCWYoBZvTAH6Xnz3k
         WAMg==
X-Gm-Message-State: AOAM530Ys/DdMAN56po4nsnyPxCx/+glCHbAbW9yuSiRFLoVYBupWZQv
        Z+KRGMunU51mscgx5CoIARPD1L8WSlP2jx7JcF4azA==
X-Google-Smtp-Source: ABdhPJxVu2fS5s4IiGMyAvrir4jnYnkIGQ58i79JVocolUPFTtPQKzk3xisdDZdfn+yqG22dcEB1yhz14Cay7MsEwoE=
X-Received: by 2002:a67:ef43:: with SMTP id k3mr4860940vsr.213.1589829885173;
 Mon, 18 May 2020 12:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200518191242.GA27634@oc3272150783.ibm.com> <20200518192051.GE11620@krava>
In-Reply-To: <20200518192051.GE11620@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 18 May 2020 12:24:34 -0700
Message-ID: <CABPqkBQc-T_wJpxOQXS8O7kM=81-XJZ7L0uT5C-HDANqTeEy8A@mail.gmail.com>
Subject: Re: metric expressions including metrics?
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Paul A. Clarke" <pc@us.ibm.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:21 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, May 18, 2020 at 02:12:42PM -0500, Paul A. Clarke wrote:
> > I'm curious how hard it would be to define metrics using other metrics,
> > in the metrics definition files.
> >
> > Currently, to my understanding, every metric definition must be an
> > expresssion based solely on arithmetic combinations of hardware events.
> >
> > Some metrics are hierarchical in nature such that a higher-level metric
> > can be defined as an arithmetic expression of two other metrics, e.g.
> >
> > cache_miss_cycles_per_instruction =
> >   data_cache_miss_cycles_per_instruction +
> >   instruction_cache_miss_cycles_per_instruction
> >
> > This would need to be defined something like:
> > dcache_miss_cpi = "dcache_miss_cycles / instructions"
> > icache_miss_cpi = "icache_miss_cycles / instructions"
> > cache_miss_cpi = "(dcache_miss_cycles + icache_miss_cycles) / instructions"
> >
> > Could the latter definition be simplified to:
> > cache_miss_cpi = "dcache_miss_cpi + icache_miss_cpi"
> >
> > With multi-level caches and NUMA hierarchies, some of these higher-level
> > metrics can involve a lot of hardware events.
> >
> > Given the recent activity in this area, I'm curious if this has been
> > considered and already on a wish/to-do list, or found onerous.
>
> hi,
> actually we were discussing this with Ian and Stephane and I plan on
> checking on that.. should be doable, I'll keep you in the loop
>
Yes, this is needed to minimize the number of events needed to compute
metrics groups.
Then across all metrics groups, event duplicates must be eliminated
whenever possible, except when explicit event grouping is required.

>
> jirk
>
> a
>
> >
> > Regards,
> > Paul Clarke
> >
>
