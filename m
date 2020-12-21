Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06072DF9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgLUIhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DAC061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:36:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t6so5260204plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/J4r2jGoaG5BGLzjFfVKnbpll1qTVhD/RP5ng3rJ9v0=;
        b=vxXX2I7cnQUEnZohK2/v2PSOuvKk9rP6apmZgKTnMsOve/4JW3j46o9DLEyn44jAj+
         31BiJ0gSs1fW6iaJeoLzpQjoSwlLY7KNtjN3cpr/pof9jxpl3twe/5TbXQ5r1A2vr4zs
         5JW1gijVTi5lUusnkfu7Fafdt5k4iba7SdU/65ZmrEB2NeUKxroZWXn53aKvpFQBFyEr
         4+/fRdL3G3R3zAaljT17om3kCuudQ+b1ns8thykF0XYWfGJduYES/kvdAplNwvxqdTo4
         mySFbCHFBVpoMXmuRpxAIGkMS1QNxxcJmeWRyQk+jWhCPQ6dqJdsa6wNb0OQK7ORn8BP
         +c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/J4r2jGoaG5BGLzjFfVKnbpll1qTVhD/RP5ng3rJ9v0=;
        b=XkqapoQw1UCEfEnCyApK8BOWFZj16H0gH/nITy/+wHGio2r41w0+h1VB7mdv5aY9sX
         ymiN6Z2tLGLWfKXRryDaOe4vXc225wScNjNXUWSOUwqjtekp/uj3FWmbBrLVaUmxJt/1
         COQl00FkmidZV9piAmqim/9DqH42fojMGHMWZVw0S9c3WJH6mqqZ/y8fTWVxJNEaxjCs
         VxHwtwXRcxPy9vWssAudZRGE3DDlUYAnRPlxx+u+T7Q4K46GRWEwPnBLPX/HUE18VpcK
         PgbbJ85tLQRAjgRaOxOMGOTZK14moit8k6oM4D0I70GN92UqeJ5dA2encuhjx3LOr7fR
         o/QQ==
X-Gm-Message-State: AOAM5310BXlhusbu9QwBt4wediOe6cmsYsrINCwHXAs1n5YX3FDqN05p
        KvRIy2y0qws/5PQNUtZiLFpafw==
X-Google-Smtp-Source: ABdhPJy1jhojG9Fkh8iPuAlsfoS5GayiRjrgVYb2YkANKIm0Ci97lygip8vsB1AcSnxNlFMS3D0rkw==
X-Received: by 2002:a17:902:8a88:b029:dc:f3:6db2 with SMTP id p8-20020a1709028a88b02900dc00f36db2mr10354015plo.2.1608539816716;
        Mon, 21 Dec 2020 00:36:56 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id f193sm16607909pfa.81.2020.12.21.00.36.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:36:56 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/7] perf arm-spe: Enable timestamp
Date:   Mon, 21 Dec 2020 16:35:50 +0800
Message-Id: <20201221083557.27642-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, the timestamp is important for AUX trace; it's mainly used
to correlate between perf events and AUX trace, allows to generate
events with time ordered manner.  There have several good examples of
enabling timestamp for AUX trace (like Intel-pt, Intel-bts, etc).

Since the conversion between TSC and kernel timestamp has been supported
on Arm64, TSC is a naming convention from x86, but perf now has reused
it to support Arm arch timer counter.

This patch set is to enable timestamp for Arm SPE trace.  It reads out
TSC parameters from mmap page and stores into auxtrace info structure;
the TSC parameters are used for conversion between timer counter and
kernel time and which is applied for Arm SPE samples.

This patch set can be clearly applied on perf/core branch with the
latest commit 2e7f545096f9 ("perf mem: Factor out a function to generate
sort order").  And it was tested on Hisilicon D06 platform.

After:

  # perf script -F comm,time,cpu,pid,dso,ip,sym

              perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event_exec ([kernel.kallsyms])
              perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event_exec ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680367:  ffffbd12539b03ec __arch_clear_user ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])


Leo Yan (7):
  perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
  perf arm-spe: Store TSC parameters in auxtrace info
  perf arm-spe: Dump TSC parameters
  perf arm-spe: Convert event kernel time to counter value
  perf arm-spe: Assign kernel time to synthesized event
  perf arm-spe: Bail out if the trace is later than perf event
  perf arm-spe: Don't wait for PERF_RECORD_EXIT event

 tools/perf/arch/arm64/util/arm-spe.c | 23 ++++++++++
 tools/perf/util/arm-spe.c            | 67 +++++++++++++++++++++++-----
 tools/perf/util/arm-spe.h            |  7 ++-
 3 files changed, 85 insertions(+), 12 deletions(-)

-- 
2.17.1

