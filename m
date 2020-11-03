Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBF2A4AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCQFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:05:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FBC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:05:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 205so5549932wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqSD886pRn9GuG+FXqn7iraliGXgYSXWwNSlYmxVEk8=;
        b=EX3Sqh4KFhtEvDyOjhwvl1dc8DCATfD/wkooWf+O3PeTwedgRPTke4qa5lJ+8h4H8Y
         321y8uW44FqcUdkDG1VRyLAEOmLCL5dIdXHhrzyHT72AGf0L4PRk2/s+F1scOx3JApBc
         815Zh2cL0NpaTlE9uqlliLeCJyfxU2xyj8lyRmN6v5eS2FC39eSe6DciEi78T3PQHTns
         PdICGYEZibrBaz3q5cFpV+rORFAQXp8FI0Ge2d671RWjHr9+Jblr99yML82EbFcKEMkW
         W+p1A3ppTNzjGR5KGLiOifhE5l9Xw4IUXLnxczZ2inEfeD9l/ybqfLCwtUXumyEI4TRc
         ZQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqSD886pRn9GuG+FXqn7iraliGXgYSXWwNSlYmxVEk8=;
        b=qvHVY0/IyGCmTv0yMyob9OSffC9FF12uuokAoKCi7Mj6rZtaWsa6UNcj6fjtkpD0cf
         C8gviIV7F8paTMVvt8+2G1rHd8lTmt8iC0VWqQfl2GWPrgxQUY9bAJUyOUMBo31oWRLv
         SsLFRiCMDPQ/Jt56bQ4v96RoHuI30iZOfCSAxnUSs8mdZw0z4SGN5OMXRmiAsyH4ukc7
         NRSKnK0SIP6SKGyn1OxSS86EB8rJLXoymGMlE3ZePS6K/K/TlG1Y136CyXS/cjCIX2/6
         PwmLpeFjtssa3nCm6xzu5tc6WQGoIbPBosKiRCJNifyulaIF2ixxsMM3r965ysXMy7mW
         v2vg==
X-Gm-Message-State: AOAM533QwVyvQ7d28je1kxokw7QIjnG2VtE3I2g0YuiFFQ5eG0cMREIh
        BgIiloSeOksMvgMnLA+ECsV/sMqjkxqPvyJjD9KY9Q==
X-Google-Smtp-Source: ABdhPJxg35lFIp8jrsUt8/dPqzopzEBTu+LGLIuqLYyiIIe6z13GXcI2pasNyd0BLcST9+VToOeOIl48TyhuQ0ARGKo=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr485797wms.77.1604419551039;
 Tue, 03 Nov 2020 08:05:51 -0800 (PST)
MIME-Version: 1.0
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian> <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com> <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
 <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com> <CAP-5=fUU7Smr7ij8bQTd0Gn6RimXppjSFUBYkLRROb8vbvMJXA@mail.gmail.com>
 <935893a3-297d-c6ed-524b-e50e5d5a0d54@huawei.com>
In-Reply-To: <935893a3-297d-c6ed-524b-e50e5d5a0d54@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 Nov 2020 08:05:38 -0800
Message-ID: <CAP-5=fUz+r+jSAKecnTmAi2r6XT7+YmB=8f73sFTuVDptL5Owg@mail.gmail.com>
Subject: Re: [perf metricgroup] fcc9c5243c: perf-sanity-tests.Parse_and_process_metrics.fail
To:     John Garry <john.garry@huawei.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
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

On Tue, Nov 3, 2020 at 6:43 AM John Garry <john.garry@huawei.com> wrote:
>
> On 20/10/2020 17:53, Ian Rogers wrote:
> >>> Thanks for taking a look John. If you want help you can send the
> >>> output of "perf test 67 -vvv" to me. It is possible Broadwell has
> >>> similar glitches in the json to Skylake. I tested the original test on
> >>> server parts as I can access them as cloud machines.
> >>>
> >>>> I will have a look, but I was hoping that Ian would have a proper fix
> >>>> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
> >>>> which now looks to be merged.
> >>> I still have these changes to look at in my inbox but I'm assuming
> >>> they're good:-)  Sorry for not getting to them, but it's good they are
> >>> merged.
> >> Hi Ian,
> >>     Checked in upstream kernel with your fix patch, in powerpc also test case 67 is passing.
> >> But I am getting issue in test 10 for powerpc
> >>
> >> [command]# ./perf test 10
> >> 10: PMU events                                                      :
> >> 10.1: PMU event table sanity                                        : Ok
> >> 10.2: PMU event map aliases                                         : Ok
> >> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> >> 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
> >>
> >> Was debugging it, issue is with commit e1c92a7fbbc5 perf tests: Add another metric parsing test.
> >>
> >> So, there we are passing different runtime parameter value in "expr__find_other and expr__parse"
> >> in function `metric_parse_fake`. I believe we need to send same value.
> >> I will send fix patch for the same.
>
> Just wondering, was a patch ever submitted for this? Something still
> broken? I can't see any recent relevant changes to tests/pmu-events.c

The test itself shouldn't have changed, but the json files parsed by
jevents and turned into C code that the test exercises should have
changed. Jin Yao has sent two patch sets fixing a metric issue on SKL
(Skylake non-server) that should hopefully fix the issue there - I'll
check the status on these. Are you testing on Skylake?

Thanks,
Ian

> Thanks,
> John
