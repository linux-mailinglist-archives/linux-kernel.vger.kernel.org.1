Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635A292B62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgJSQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgJSQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:20:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:20:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so430372wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NquwAUtO1k5i5bPjA/6Py77lhQ8QXVvkcQCgWKnQuCs=;
        b=og8ramQf9sUtFVbzkR2N1L5JVY7fl5vqFumGCX37IuFrwBZohlHS3fcDuQnKKbhvjg
         YQ9vlyvZM2nvKNMmOXEFGTlCnErnK7KOQtO04/z5TEiF4HLnTcrq/faQk+3dOSiJhzp5
         nq3Au8CWIfrbgBtVYnnMFi47NZ8mr/ADK/7kqD44xyhLYqGvLD8fLgmFAH+lneXwAF9c
         ZV67QHyNwggh1+rhvJm/mYkOP6ZsQyx2b6ZrTpPI9xlmVt4hx4wOSPPutt+bXBH0dxY8
         6UxvRt7DPAn9AucLUUHJVHilwnd6nx2wNbzhZImGn6UyXB92E6hKZ/kqEwEvHiBe2age
         cvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NquwAUtO1k5i5bPjA/6Py77lhQ8QXVvkcQCgWKnQuCs=;
        b=VtfQNnE5NnGG2K8FWYdXqH9tC3pTjKgSuV1+TwCWurB6/Qp9Axk1lx/xCQAQmN/nuB
         kCC9iDCWRyVsn07XS/KpZp9yJ2LuB+kxjacoI+18OgAHLevAZEiuPQOk22kQF8P0y4cd
         HHDjG9nbWU1UDqWcX2/jAh4ZOkldfznIqGOFye+1RSHUfvzRQ0bONK/tILaCY4J7zbQH
         bICULCcU6OiwcRQsQweGUxtIQNMmn+H/OVL4dF84wFDMAyIInlCj/+Q69VFPAuaU/64o
         Kojr0OAXNgm2jqQlX9D8f7/mImYBU+6U1jlC6HufD3dyCk+fu0cM2mhVEQC9LQ3alyU+
         vIPw==
X-Gm-Message-State: AOAM533E9g2x1WRi7WjuDgyXuT155OI/KDGcoUcqGfrL/2Vs3sBhRLbY
        s10BXyF7AiWI6QcaXzlnaHNOpLbahEhwbwmmDItlqg==
X-Google-Smtp-Source: ABdhPJyFKRjTbf4Img22qvtoTOSEtWeI2Ns9xaDrFoggwFXR+1sUqnPcPhvQs+5FSwcEWBxD64/1RhjDNRiotLBTXzQ=
X-Received: by 2002:adf:b19c:: with SMTP id q28mr327822wra.119.1603124453120;
 Mon, 19 Oct 2020 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian> <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
In-Reply-To: <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 19 Oct 2020 09:20:41 -0700
Message-ID: <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
Subject: Re: [perf metricgroup] fcc9c5243c: perf-sanity-tests.Parse_and_process_metrics.fail
To:     John Garry <john.garry@huawei.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
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

On Mon, Oct 19, 2020 at 2:51 AM John Garry <john.garry@huawei.com> wrote:
>
> On 19/10/2020 00:30, Ian Rogers wrote:
> > On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >>
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-9):
> >>
> >> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when covering multiple PMUs")
> >> url: https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049
> >>
> >>
> >> in testcase: perf-sanity-tests
> >> version: perf-x86_64-c85fb28b6f99-1_20201008
> >> with following parameters:
> >>
> >>          perf_compiler: gcc
> >>          ucode: 0xdc
> >>
> >>
> >>
> >> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> > I believe this is a Skylake and there is a known bug in the Skylake
> > metric DRAM_Parallel_Reads as described here:
> > https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
> > Fixing the bug needs more knowledge than what is available in manuals.
> > Hopefully Intel can take a look.
> >
> > Thanks,
> > Ian
>
> So this named patch ("perf metricgroup: Hack a fix for aliases...") is
> breaking test #67 on my machine also, which is a broadwell.

Thanks for taking a look John. If you want help you can send the
output of "perf test 67 -vvv" to me. It is possible Broadwell has
similar glitches in the json to Skylake. I tested the original test on
server parts as I can access them as cloud machines.

> I will have a look, but I was hoping that Ian would have a proper fix
> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
> which now looks to be merged.

I still have these changes to look at in my inbox but I'm assuming
they're good :-) Sorry for not getting to them, but it's good they are
merged.

Thanks,
Ian

> Thanks!
>
> >
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>
> >>
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 67
> >> 67: Parse and process metrics                             : FAILED!
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 68
> >> 68: x86 rdpmc                                             : Ok
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 69
> >> 69: Convert perf time to TSC                              : Ok
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 70
> >> 70: DWARF unwind                                          : Ok
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 71
> >> 71: x86 instruction decoder - new instructions            : Ok
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 72
> >> 72: Intel PT packet decoder                               : Ok
> >> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 73
> >> 73: x86 bp modify                                         : Ok
> >> 2020-10-16 19:31:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 74
> >> 74: probe libc's inet_pton & backtrace it with ping       : Ok
> >> 2020-10-16 19:31:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 75
> >> 75: Zstd perf.data compression/decompression              : Ok
> >>
> >>
> >>
> >> To reproduce:
> >>
> >>          git clone https://github.com/intel/lkp-tests.git
> >>          cd lkp-tests
> >>          bin/lkp install job.yaml  # job file is attached in this email
> >>          bin/lkp run     job.yaml
> >>
> >>
> >>
> >> Thanks,
> >> Rong Chen
> >>
> > .
> >
>
