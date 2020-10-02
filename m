Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB4281D14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:47:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFEC0613E4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 13:47:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so3170334wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXKKFOeSYPG8al9cOaypQaHiMKPA9xxy17Dd4BLJwvc=;
        b=A+1P4SoTB5U034QG0+WmgfcBxp3U+9PRSZ4IhqevphFs61HqRbCJpodggEf2oyNcwe
         nKsqKkz45QhOTuJHkVnHwUfGyhEvIWJGe+3e5sm1JmMEq3413vQyblzchNBI6/IlNWYf
         NHUXuTRp1W3982IMCnOwSPMzpKWPxIN49Bm2uoG2FHacvx7NnRYSJQrrrc9vtRvnI0ha
         GyAtvSxeVmeQHlhSIMMdFoNBOYgz1S65Iq4nxYfoOeYdky7XN3teDdhWacbWFzf7sx94
         w9OVi4MIOnIXEuefoxj4VIyvaLQ7VzWeI1Nojd7f6TvgoBnWkr6u099aHcuvKGurNLbj
         28Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXKKFOeSYPG8al9cOaypQaHiMKPA9xxy17Dd4BLJwvc=;
        b=ECs6DLmtOLYz89AUE9zHRXY0Ie3pT6ZC8gf27EuEjI///yoru26htvyjBG67/NDqVC
         j14YxSC98kDE5PMEwGFmZ4thU/pYrUe1DKQz4Dx1aOVayNgOzG1AMYYDgOznUgMEkt+d
         QpP8ZLNum6Uabxl/bvYNkjUvUsX1oTw4kSkE/1cxabsRQu0eUE4XJLdRhCYTLd8uiskP
         X3ed2gtQ9/jKZwP3CJH6j/1ZUjTTArtlEYfwjmNo34F7khTt68Ipf1syJkRxQ1kN/ZnZ
         Z7sp5zpOTM5uvbIP5k/j4IdUcnlt0yWNWdQOEaaZfzbM+N9bK/mY3/K+FcR1Ybv0bbNV
         IP6g==
X-Gm-Message-State: AOAM53309XkRML9Q7r4dSpplt7tyjcTeZQTVQBZM3JRPMKlReSBJ8sYq
        6/tLgi8dNR/8+RLwcjruAJDgiPLR19FJNxDv0QsSCQ==
X-Google-Smtp-Source: ABdhPJwf2MahFXb5roCcSXJw39ZF+8aTZAyovTdB7iZgRUUyATSygYlDICmS5UdszlFwdG4hfktZg+aSXxL6iEJknu8=
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr5271207wrp.271.1601671623743;
 Fri, 02 Oct 2020 13:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com> <20200507140819.126960-24-irogers@google.com>
 <e3c4f253-e1ed-32f6-c252-e8657968fc42@huawei.com>
In-Reply-To: <e3c4f253-e1ed-32f6-c252-e8657968fc42@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 2 Oct 2020 13:46:52 -0700
Message-ID: <CAP-5=fXkYQ0ktt5DZYW=PPzgRN4_DeM08_def4Qn-6BPRvKW-A@mail.gmail.com>
Subject: Re: Issue of metrics for multiple uncore PMUs (was Re: [RFC PATCH v2
 23/23] perf metricgroup: remove duped metric group events)
To:     John Garry <john.garry@huawei.com>
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 5:00 AM John Garry <john.garry@huawei.com> wrote:
>
> On 07/05/2020 15:08, Ian Rogers wrote:
>
> Hi Ian,
>
> I was wondering if you ever tested commit 2440689d62e9 ("perf
> metricgroup: Remove duped metric group events") for when we have a
> metric which aliases multiple instances of the same uncore PMU in the
> system?

Sorry for this, I hadn't tested such a metric and wasn't aware of how
the aliasing worked. I sent a fix for this issue here:
https://lore.kernel.org/lkml/20200917201807.4090224-1-irogers@google.com/
Could you see if this addresses the issue for you? I don't see the
change in Arnaldo's trees yet.

Thanks,
Ian

> I have been rebasing some of my arm64 perf work to v5.9-rc7, and find an
> issue where find_evsel_group() fails for the uncore metrics under the
> condition mentioned above.
>
> Unfortunately I don't have an x86 machine to which this test applies.
> However, as an experiment, I added a test metric to my broadwell JSON:
>
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 8cdc7c13dc2a..fc6d9adf996a 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> @@ -348,5 +348,11 @@
>          "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
>          "MetricGroup": "Power",
>          "MetricName": "C7_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "test metric",
> +        "MetricExpr": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE *
> UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
> +        "MetricGroup": "Test",
> +        "MetricName": "test_metric_inc"
>      }
> ]
>
>
> And get this:
>
> john@localhost:~/linux/tools/perf> sudo ./perf stat -v -M
> test_metric_inc sleep 1
> Using CPUID GenuineIntel-6-3D-4
> metric expr unc_cbo_xsnp_response.miss_xcore *
> unc_cbo_xsnp_response.miss_eviction for test_metric_inc
> found event unc_cbo_xsnp_response.miss_eviction
> found event unc_cbo_xsnp_response.miss_xcore
> adding
> {unc_cbo_xsnp_response.miss_eviction,unc_cbo_xsnp_response.miss_xcore}:W
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_1/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_0/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_1/umask=0x41,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_0/umask=0x41,event=0x22/
> Cannot resolve test_metric_inc: unc_cbo_xsnp_response.miss_xcore *
> unc_cbo_xsnp_response.miss_eviction
> task-clock: 688876 688876 688876
> context-switches: 2 688876 688876
> cpu-migrations: 0 688876 688876
> page-faults: 69 688876 688876
> cycles: 2101719 695690 695690
> instructions: 1180534 695690 695690
> branches: 249450 695690 695690
> branch-misses: 10815 695690 695690
>
> Performance counter stats for 'sleep 1':
>
>               0.69 msec task-clock                #    0.001 CPUs
> utilized
>                  2      context-switches          #    0.003 M/sec
>
>                  0      cpu-migrations            #    0.000 K/sec
>
>                 69      page-faults               #    0.100 M/sec
>
>          2,101,719      cycles                    #    3.051 GHz
>
>          1,180,534      instructions              #    0.56  insn per
> cycle
>            249,450      branches                  #  362.112 M/sec
>
>             10,815      branch-misses             #    4.34% of all
> branches
>
>        1.001177693 seconds time elapsed
>
>        0.001149000 seconds user
>        0.000000000 seconds sys
>
>
> john@localhost:~/linux/tools/perf>
>
>
> Any idea what is going wrong here, before I have to dive in? The issue
> seems to be this named commit.
>
> Thanks,
> John
>
> > A metric group contains multiple metrics. These metrics may use the same
> > events. If metrics use separate events then it leads to more
> > multiplexing and overall metric counts fail to sum to 100%.
> > Modify how metrics are associated with events so that if the events in
> > an earlier group satisfy the current metric, the same events are used.
> > A record of used events is kept and at the end of processing unnecessary
> > events are eliminated.
> >
> > Before:
