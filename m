Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD392741C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIVMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:07:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FA7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 05:07:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so12236696pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5w6SYj6vWVMvIwwfbbKQJ7hkdAAvG6nTX7Ove35nPyQ=;
        b=CtryYgyTS+ASsBVG1pv29mIdumxIuR/lxW9K3GOAsKANseouwbzROqgz1VNXu+CW3t
         nt/zHTOJgQput8qHHYKRuV2cJvFHOUroiBo6qCJs+fArbqb7I2Ev5T4rjl5CbBpQQptv
         aHkUx+JL72eRIN7f5JrYkiJ0rED3VhAvO6SW2/pXhSxF0MTDxs+oecBXoSXLhObr27/A
         eHdnqnguq6NZvvhLCfvSRj0LPoGS3Q0kwEq24FoOJAE8FhDbUYOqe7WTEMS+FbhdQx1E
         YXjjmpLzZ5wgHeuoONwsWJ3XiIlq1YzyHVptyRNn8hd6S/rHkXSMMZxHESXjSg3k5EC9
         JpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5w6SYj6vWVMvIwwfbbKQJ7hkdAAvG6nTX7Ove35nPyQ=;
        b=HkBNZevggrj1ZF1Fqof/4Dk5beea1IoGJhowK5criRzDiOKTPPzo42+MBYW6UNulFr
         Y2gv6Fnqml3TPsXw4dAqvnIYTz7+DBMGl0TaCcHZM8zjowGsk0bkEDaZhs9QUymDAimV
         AX62KATDeRTYezNH9bpI5YA7MPm6Piwo2RJZEqdpzq/3ZeDhDRhWL55NfRXd+fJ+6Jda
         R/xwKWYLSinedMcBrEoEAc61kEdYsZD3Ukv/QFB+bJAhyocBTiGfwcdAcmFGIXPefqdh
         199mJI9elPEyiPhODLxxDjZmf/Vi9O7TsFUEnZU2O/F5AwZvqSk0jB86l8P0a4rLDxVE
         Iy7w==
X-Gm-Message-State: AOAM530ZPFDlAM5yXQ5BpTM7wVUqbVM5ckhw8wtlTn+Foy6LXKBPnfwG
        qk3NId1U0arB5Y8h6q1PbQTfVw==
X-Google-Smtp-Source: ABdhPJx6T7KnM9MqwtLugPvi3nz330TRm2l5rZXYyEZSHIBJb69POrkDVr82YgEQjWsuN69viztsnw==
X-Received: by 2002:a63:5848:: with SMTP id i8mr3276774pgm.269.1600776465341;
        Tue, 22 Sep 2020 05:07:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z4sm14884008pfr.197.2020.09.22.05.07.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Sep 2020 05:07:44 -0700 (PDT)
Date:   Tue, 22 Sep 2020 20:07:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Message-ID: <20200922120732.GB15124@leoy-ThinkPad-X240s>
References: <20200914115311.2201-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> This patch set is to refactor TSC implementation and move TSC code from
> x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> alse move the TSC testing from x86 folder to tests so can work as a
> common testing.
> 
> So far, for x86 it needs to support cap_user_time_zero and for Arm64
> it needs to support cap_user_time_short.  For architecture specific
> code, every arch only needs to implement its own rdtsc() to read out
> timer's counter.
> 
> This patch set has been rebased on the perf/core branch with latest
> commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> metric events") and tested on Arm64 DB410c.

Could you pick up this patch set?  Thanks!

Leo

>   $ perf test list
>     [...]
>     68: Convert perf time to TSC
>     [...]
> 
>   $ perf test 68 -v
>     68: Convert perf time to TSC
>     --- start ---
>     test child forked, pid 10961
>     mmap size 528384B
>     1st event perf time 35715036563417 tsc 686221770989
>     rdtsc          time 35715036649719 tsc 686221772647
>     2nd event perf time 35715036660448 tsc 686221772852
>     test child finished with 0
>     ---- end ----
>     Convert perf time to TSC: Ok
> 
> Changes from v3:
> * Added comments for Arm64's rdtsc() for short counter (PeterZ);
> * Rebased on latest acme/perf/core branch.
> 
> Changes from v2:
> * Refactored patch set to move TSC common code to util/tsc.c (Wei/Al);
> * Moved TSC testing to perf/tests (Wei);
> * Dropped Arm SPE timestamp patch so can have clear purpose and easier
>   reviewing; will send Arm SPE timestamp as separate patch.
> 
> 
> Leo Yan (6):
>   perf tsc: Move out common functions from x86
>   perf tsc: Add rdtsc() for Arm64
>   perf tsc: Calculate timestamp with cap_user_time_short
>   perf tsc: Support cap_user_time_short for event TIME_CONV
>   perf tests tsc: Make tsc testing as a common testing
>   perf tests tsc: Add checking helper is_supported()
> 
>  tools/lib/perf/include/perf/event.h           |  4 +
>  tools/perf/arch/arm64/util/Build              |  1 +
>  tools/perf/arch/arm64/util/tsc.c              | 21 +++++
>  tools/perf/arch/x86/include/arch-tests.h      |  1 -
>  tools/perf/arch/x86/tests/Build               |  1 -
>  tools/perf/arch/x86/tests/arch-tests.c        |  4 -
>  tools/perf/arch/x86/util/tsc.c                | 73 +----------------
>  tools/perf/tests/Build                        |  1 +
>  tools/perf/tests/builtin-test.c               |  5 ++
>  .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 13 +++
>  tools/perf/tests/tests.h                      |  2 +
>  tools/perf/util/jitdump.c                     | 14 ++--
>  tools/perf/util/synthetic-events.c            |  8 --
>  tools/perf/util/tsc.c                         | 81 +++++++++++++++++++
>  tools/perf/util/tsc.h                         |  5 ++
>  15 files changed, 143 insertions(+), 91 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/tsc.c
>  rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (93%)
> 
> -- 
> 2.17.1
> 
