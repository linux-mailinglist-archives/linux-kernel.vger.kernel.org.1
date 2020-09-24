Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EC27750C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgIXPSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgIXPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:18:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89728C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v14so1764225pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=puw58mDs8KzYb2rLs0SANRcfJwykyGIPKXhMCo03gvU=;
        b=cVIv22lTt70QR0O6XcDVVYQRuOORtKO/CJbIB9bsSXhQU5IoHKUYu986Evx72lqADA
         qLrsWMpV3Yn+OxR+MZcFlPhAzTrMbPilrKLEH8SGMwJ9kT83XJM9q934KeplNwhVMSk1
         jDMgoK94oCHm5cb6IIkiHRaECnMOfJka0tL7ooXA/QOPwwIIF/k9rRkX0h6HCg8BN9qs
         s2LUOAgHXRfFCRZ4zz91pIHyJc/qvUld6vQSaj+EFmIS8THrQr36ihVP91XGvW9CHekL
         R1xXKQIsIVqDGstm88N2/zFo30bnTGVmXvUP8IDDOmhUZxbNBxXts6cGcCyYNvb6H0CT
         eS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=puw58mDs8KzYb2rLs0SANRcfJwykyGIPKXhMCo03gvU=;
        b=K9n3VP7RErFs2p/ZZdzvIGKzZ9qyHsHGSDumOpdsxx7DhLCAJampgkU77LZQ35KTh2
         AHYhQITVjYe8Y8IixJG1LQxc4Ki6Fh3JmcAMfFARjrA0zdeGu3YAQo1abC9g9SErhsx5
         t5KSaztO7Dbhc5TlOuk4fPwAgQLgMfZubcwHiPkypK//aJmSlNy7pLAios0L/hc+4z9p
         akTDa5XGMky+w408rpWtuuhSF06K2Z0aY6aS+8UNTD6kb4mYuy+UcGZVbQKLCw4Fkkjy
         KmmFuTxmCAEdep44RX4BjaaukwKGVEjuEmg8R1tbPBZvDENFC5JSttafoq6cnA66fWba
         qdHA==
X-Gm-Message-State: AOAM533rm4d+rL6ng6BnkXZcRwiTZFVsPDyo0TrQFIfiAvM12Gn4+hJ6
        O0UeDAyuVSC1NZ5uXFUMMGzxYA==
X-Google-Smtp-Source: ABdhPJzdnyxX+PGoJnnu504x77gaG4Tnxa2ifKzAZAmRnBJu44XK7tu1rxeIaZk81MPH0WRCQ1kBrw==
X-Received: by 2002:a17:90a:ba06:: with SMTP id s6mr4567290pjr.13.1600960713900;
        Thu, 24 Sep 2020 08:18:33 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r4sm2619996pjf.4.2020.09.24.08.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 08:18:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephane Eranian <eranian@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/2] perf: Make tsc testing as a common testing case
Date:   Thu, 24 Sep 2020 23:18:13 +0800
Message-Id: <20200924151815.22930-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to follow up the building failure which was found by
Arnaldo:

    CC       /tmp/build/perf/tests/llvm-src-prologue.o
    CC       /tmp/build/perf/tests/llvm-src-relocation.o
    tests/perf-time-to-tsc.c:24:10: fatal error: arch-tests.h: No such
    file or directory
    24 | #include "arch-tests.h"
       |          ^~~~~~~~~~~~~~
    compilation terminated.

Patch 01 has removed the header "arch-tests.h" from the testing code, so
that this can fix the reported building failure.

These two patches have been tested on x86_64 and Arm64.  Though I don't
test them on archs MIPS, PowerPC, etc, I tried to search every header so
ensure included headers are supported for all archs.

These two patches have been rebased on the perf/core branch with its
latest commit 69f48c7040d3 ("perf script: Add min, max to
futex-contention output, in addition to avg").


Leo Yan (2):
  perf tests tsc: Make tsc testing as a common testing
  perf tests tsc: Add checking helper is_supported()

 tools/perf/arch/x86/include/arch-tests.h      |  1 -
 tools/perf/arch/x86/tests/Build               |  1 -
 tools/perf/arch/x86/tests/arch-tests.c        |  4 ----
 tools/perf/tests/Build                        |  1 +
 tools/perf/tests/builtin-test.c               |  5 +++++
 .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 19 +++++++++++++++----
 tools/perf/tests/tests.h                      |  2 ++
 7 files changed, 23 insertions(+), 10 deletions(-)
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (92%)

-- 
2.17.1

