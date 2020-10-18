Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5364329209C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 01:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgJRXav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 19:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 19:30:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF03FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 16:30:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so9401588wre.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CROyUg6GgaZFedw8ypc2M4b9ksHcjSzt1NtmVyezkkM=;
        b=hdJdqcz491E0wjaAQ8HROMr7IYtlXWgFSjMOiTJe2vezFbxI0AfZBDnhzYEVgKC9t/
         BFX/Beg8VcVkNNQzMq9P5GUoX5jQaJppwtDaJM7U9ZR2Rv1wVmPyHZvEWx34XjEpujGn
         lCB2Mjrk/cDJqSaJgac7DuOdiyIM5/JrppVOfWFfo26O61/65laBVqSz9ZrXxhOagtDZ
         bnBJtZjRCNHbgH6oV0tSJpCLvkwS2qj7eNnAV3vz05GsMVSGHlXVNPjXsvC/4TAD2iAs
         rdrqqq6llypObfdj1MAmZuVNV328s28z4SyP6+822yI+S6HCkQlHtDGXDLR6OnKMekqe
         nu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CROyUg6GgaZFedw8ypc2M4b9ksHcjSzt1NtmVyezkkM=;
        b=gk6wvz8vNVG9T5Xn67zi+pMyGcUH3Kb0G3/lhK9eIQ1bZY2cTsVNrCzIyD5Od/4RA3
         G5my0QCmg9W66b4ISb7ZoRpA3SF9dXHsxOlyetzi3C0YOXUS6Kw5xfLm9zgv+9A4zqqK
         v9PAlKFRkgzuMUjBRtIUBTfYMEC7jeLFddWilgpzAx03wcgHCujjRc+jTsjO4U7V0JAw
         7YafCndP87/4LC5ezLwIgnhCT25rMdzJbUkVteAl9xRe32fwtiBSWFk9Ab89UmaD7NMO
         Dt6aajD+Z5rZfpONZcP8gy4Poa5Wsh6F7fR+4b1KPlcE6dcPGSxqPOm6tj7fcVMGzHTj
         dy/A==
X-Gm-Message-State: AOAM5329YyqM9m2tfSMn4ex93bE8akZHUkS8SwIvr7oo7if45U2ufYYr
        04P54sEDFFqcOt3AqeMngHbhTAGNN87kweiJKJX9Kg==
X-Google-Smtp-Source: ABdhPJytQD1ddYohjhSbGuRJRLLuAaZiFF16+ZSgJkxwO9A2n2P4vKk8EhFVEkb2U4SuSMAxuqrnJOHe34pJAiMH9fw=
X-Received: by 2002:adf:b641:: with SMTP id i1mr16132508wre.376.1603063849142;
 Sun, 18 Oct 2020 16:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com> <20201018085031.GK11647@shao2-debian>
In-Reply-To: <20201018085031.GK11647@shao2-debian>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 18 Oct 2020 16:30:37 -0700
Message-ID: <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
Subject: Re: [perf metricgroup] fcc9c5243c: perf-sanity-tests.Parse_and_process_metrics.fail
To:     kernel test robot <rong.a.chen@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
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

On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when covering multiple PMUs")
> url: https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049
>
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-c85fb28b6f99-1_20201008
> with following parameters:
>
>         perf_compiler: gcc
>         ucode: 0xdc
>
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

I believe this is a Skylake and there is a known bug in the Skylake
metric DRAM_Parallel_Reads as described here:
https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
Fixing the bug needs more knowledge than what is available in manuals.
Hopefully Intel can take a look.

Thanks,
Ian

>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 67
> 67: Parse and process metrics                             : FAILED!
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 68
> 68: x86 rdpmc                                             : Ok
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 69
> 69: Convert perf time to TSC                              : Ok
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 70
> 70: DWARF unwind                                          : Ok
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 71
> 71: x86 instruction decoder - new instructions            : Ok
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 72
> 72: Intel PT packet decoder                               : Ok
> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 73
> 73: x86 bp modify                                         : Ok
> 2020-10-16 19:31:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 74
> 74: probe libc's inet_pton & backtrace it with ping       : Ok
> 2020-10-16 19:31:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 75
> 75: Zstd perf.data compression/decompression              : Ok
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Rong Chen
>
