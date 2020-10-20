Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205DD2940D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394947AbgJTQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbgJTQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:53:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBAC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:53:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k21so1543849wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuRT7WGR1yf4Aih4FHNjLkjxaooHkzjoLX1S4xPnefg=;
        b=mmvravx6qr3s6YNO0bOJBLaNuMkIWgh8AZesjBAF7OanfvyAXphZdX9fDDvJRMh8D2
         a775bhb12Qw5PiRIaHWGLCzzrg55qw/vXgfWJ2D6SzzBdpuieZdJruQcE67HfldFeiIJ
         vheS5ml4/PVyzkRxwGuTBaUxJ+6rNtDzpLXpSS7m5qq3Sn7+PWN792n5sLq0GAQnFgsj
         PdHNc5mkjF7tNc2vaf1g3EvYV06nJKq6XpZsAXxUloQzSRJJ4YM2gVVMhxUI/NoWfjhx
         zSfulpK1KtFtMm+0NaaEyY6Q4BskHl+FghFmn/CZMT10rHj0n73nb1c6MwPazKmo1ELY
         okhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuRT7WGR1yf4Aih4FHNjLkjxaooHkzjoLX1S4xPnefg=;
        b=V8jTIokjIo8OgWxjbACOw9mMBdxvvDg5uCnZfCmPQH7Y1bTgYnvoG9ieQyWMgwUYEM
         R2i8IaBxZ8p3ftqS8y9kk3SVY8j39in58FGbWZiwJuZAWG1EMKurawCfiLRLjfOwPYho
         z0aIhA03gmkvQkIo/oD1IJmfP5mhh9gdnq4Re4TzSug7PaBVxGeRyYWprpac/5A92F1s
         GMTqb3l265OGSqY8nyiW3VF3vu3ZZAl//Jh6wOAs5cT2BJnQeMCAyn93BuDXhySSCexp
         YXgsxMamk0NhCKQnw3y4417WrRW8zYvIWC68tLjXH01qY8DAxcEoC5EmJ4UCOWPZuZ4x
         kndw==
X-Gm-Message-State: AOAM532VZiCO/5mM4sudkkx4wnDehwuwBPlNNijPBiMGo+TFOhJ5BGjV
        9O6lLRgMuZYCkhQZvOrzai8nazl0pa3bpd8wFUHzww==
X-Google-Smtp-Source: ABdhPJxZsiN4tl8k9ebwN6emgXLUOi7E9ipWQDZThzgrgCPrYYPOWGtXlW1kmVtr28RYPDnbF2TdmDYLw8cNbN6fHwE=
X-Received: by 2002:a1c:9cd8:: with SMTP id f207mr3811262wme.76.1603212833883;
 Tue, 20 Oct 2020 09:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian> <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com> <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
 <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com>
In-Reply-To: <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 20 Oct 2020 09:53:41 -0700
Message-ID: <CAP-5=fUU7Smr7ij8bQTd0Gn6RimXppjSFUBYkLRROb8vbvMJXA@mail.gmail.com>
Subject: Re: [perf metricgroup] fcc9c5243c: perf-sanity-tests.Parse_and_process_metrics.fail
To:     kajoljain <kjain@linux.ibm.com>
Cc:     John Garry <john.garry@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linuxarm@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        zhangshaokun@hisilicon.com, James Clark <james.clark@arm.com>,
        linux-imx@nxp.com, 0day robot <lkp@intel.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 1:56 AM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 10/19/20 9:50 PM, Ian Rogers wrote:
> > On Mon, Oct 19, 2020 at 2:51 AM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 19/10/2020 00:30, Ian Rogers wrote:
> >>> On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >>>>
> >>>> Greeting,
> >>>>
> >>>> FYI, we noticed the following commit (built with gcc-9):
> >>>>
> >>>> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when covering multiple PMUs")
> >>>> url: https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049
> >>>>
> >>>>
> >>>> in testcase: perf-sanity-tests
> >>>> version: perf-x86_64-c85fb28b6f99-1_20201008
> >>>> with following parameters:
> >>>>
> >>>>          perf_compiler: gcc
> >>>>          ucode: 0xdc
> >>>>
> >>>>
> >>>>
> >>>> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> >>>>
> >>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>>
> >>> I believe this is a Skylake and there is a known bug in the Skylake
> >>> metric DRAM_Parallel_Reads as described here:
> >>> https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
> >>> Fixing the bug needs more knowledge than what is available in manuals.
> >>> Hopefully Intel can take a look.
> >>>
> >>> Thanks,
> >>> Ian
> >>
> >> So this named patch ("perf metricgroup: Hack a fix for aliases...") is
> >> breaking test #67 on my machine also, which is a broadwell.
> >
> > Thanks for taking a look John. If you want help you can send the
> > output of "perf test 67 -vvv" to me. It is possible Broadwell has
> > similar glitches in the json to Skylake. I tested the original test on
> > server parts as I can access them as cloud machines.
> >
> >> I will have a look, but I was hoping that Ian would have a proper fix
> >> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
> >> which now looks to be merged.
> >
> > I still have these changes to look at in my inbox but I'm assuming
> > they're good :-) Sorry for not getting to them, but it's good they are
> > merged.
>
> Hi Ian,
>    Checked in upstream kernel with your fix patch, in powerpc also test case 67 is passing.
> But I am getting issue in test 10 for powerpc
>
> [command]# ./perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>
> Was debugging it, issue is with commit e1c92a7fbbc5 perf tests: Add another metric parsing test.
>
> So, there we are passing different runtime parameter value in "expr__find_other and expr__parse"
> in function `metric_parse_fake`. I believe we need to send same value.
> I will send fix patch for the same.
>
> Thanks,
> Kajol Jain

Thanks, the fake support was done by Jiri. I do try to test on Power
8. The awesome thing, aside from the testing nit fixes, is that the
metrics will actually work once the test is passing :-). They may of
course report junk.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> Thanks!
> >>
> >>>
> >>>>
> >>>>
> >>>> If you fix the issue, kindly add following tag
> >>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>>>
> >>>>
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 67
> >>>> 67: Parse and process metrics                             : FAILED!
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 68
> >>>> 68: x86 rdpmc                                             : Ok
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 69
> >>>> 69: Convert perf time to TSC                              : Ok
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 70
> >>>> 70: DWARF unwind                                          : Ok
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 71
> >>>> 71: x86 instruction decoder - new instructions            : Ok
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 72
> >>>> 72: Intel PT packet decoder                               : Ok
> >>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 73
> >>>> 73: x86 bp modify                                         : Ok
> >>>> 2020-10-16 19:31:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 74
> >>>> 74: probe libc's inet_pton & backtrace it with ping       : Ok
> >>>> 2020-10-16 19:31:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 75
> >>>> 75: Zstd perf.data compression/decompression              : Ok
> >>>>
> >>>>
> >>>>
> >>>> To reproduce:
> >>>>
> >>>>          git clone https://github.com/intel/lkp-tests.git
> >>>>          cd lkp-tests
> >>>>          bin/lkp install job.yaml  # job file is attached in this email
> >>>>          bin/lkp run     job.yaml
> >>>>
> >>>>
> >>>>
> >>>> Thanks,
> >>>> Rong Chen
> >>>>
> >>> .
> >>>
> >>
