Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766229DB45
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgJ1WsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbgJ1Wr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:47:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w11so347949pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1cQOz6xe20uUsRkiyAuJXh3GxeGLZykdgg7FMJb+9TM=;
        b=ntnVw4zWPTSF52CfSWIdiqgEPO4CfxGZ21R82hCOg03zVqyRyFeEKdVTSJzffVd38J
         kVwbwfRz3Q0kzb+9YLMZWcZLV7nxrFTQNomneeaWtckMrwU1qIBKgzTz6rvfGee4e88u
         liB2uR5zLpgl6RGDJEGlLZVI5VeNr/QiwgqlHtPQZOJnH+2gsYaYvf0Mb5t/aLOGsPlp
         vFZvPF8qK3teef8a+A2x1jwFDKTZiKufP2yl9Ba1oKCxWFUUAT5J6tjBwQcjYmUABH40
         aAuBTPJgzP9BGUVuurvbNmJelWeXxahqSclq0PmKdW1SugPDCDWak4v5iExHv8YGpAKf
         7ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1cQOz6xe20uUsRkiyAuJXh3GxeGLZykdgg7FMJb+9TM=;
        b=Fceph9glkZmc9NEI6nk1sy7PKIQKq/tPtBiO5JfrKVqT1UWufcxZedAm5rUeZ5g4uI
         RbHMGm1CtdRVOA/P8q8YGD5MNejhoO9dtVix743or/XkaBsqw4ceILgzc93+vtTU9w/x
         1zrmYJDlwII69WdX1jfTNF0XwwXd4xhqbBntj9NHrl6Mb4UNhRd/6D9DzQwLx5tXJioF
         OTWR6CapLuurrgYQZbPzKM7sfoY7IQV2LFSUqMF6T2PbzwfCvuxANXHGIwAeqA5MFzZr
         GNsrvKqhhmkmqhasJuYoM29XjwfcHq3um7SBwq+wnaFEJb10OhCO8AgEOGGT7WLF90oZ
         XPWQ==
X-Gm-Message-State: AOAM530q7K8CVLY0rO8665+d5MMUFI9wFqPmGMIl2L/hurgl3QrtF+Yp
        87oFCYkyobEM6lQq35SbOZ2inKOS8pcUhm9t
X-Google-Smtp-Source: ABdhPJzSSQLsObq9R6Qna2EWklpUp7kMkjkQsi/Stm0Xg/CGBjSQq8PXNnA/hGApdSSBbqZLrbrCBw==
X-Received: by 2002:aa7:85c3:0:b029:156:78e8:1455 with SMTP id z3-20020aa785c30000b029015678e81455mr5261262pfn.68.1603867104520;
        Tue, 27 Oct 2020 23:38:24 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id f4sm4451655pfc.63.2020.10.27.23.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:23 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/9] perf mem/c2c: Support AUX trace
Date:   Wed, 28 Oct 2020 14:38:04 +0800
Message-Id: <20201028063813.8562-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set v2 [1] mixed the patches for support perf mem/c2c AUX
trace and for enabling Arm SPE's memory event.  To make easier
reviewing, this patch set extracts the changes for perf mem/c2c AUX
trace.

Patches 01, 02, 03 extend to support more flexible memory event name
and introduce a new event type 'ldst' (besides the existed types 'load'
and 'store').

Patch 04 is a minor refactoring to initailize memory event for recording
but not for reporting.

Patches 05, 06 are to support AUX trace for "perf mem" and "perf c2c"
tools.

Patch 07 enabled SPE memory events for Arm64 arch; patch 08 fixes the
memory event name issue on PowerPC.

Patch 09 is to update documentation to reflect the latest changes.

This patch set has been applied clearly on the perf/core branch with the
latest commit 7cf726a59435 ("Merge tag 'linux-kselftest-kunit-5.10-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest").

This patch set has been verified on x86 and Arm64.

On x86, below commands have been tested:

  # perf c2c record -e ldlat-loads  -- ~/false_sharing.exe 2
  # perf c2c record -e ldlat-stores  -- ~/false_sharing.exe 2
  # perf mem record -t load -- ~/false_sharing.exe 2
  # perf mem record -t store -- ~/false_sharing.exe 2
  # perf mem record -t ldst -- ~/false_sharing.exe 2
      `-> report failure due the type 'ldst' is not supported on x86
  # perf mem record -e ldlat-loads  -- ~/false_sharing.exe 2
  # perf mem record -e ldlat-stores  -- ~/false_sharing.exe 2

On Arm64, below commands have been tested:

  # perf c2c record -e spe-load  -- ~/false_sharing.exe 2
  # perf c2c record -e spe-store  -- ~/false_sharing.exe 2
  # perf c2c record -e spe-ldst  -- ~/false_sharing.exe 2
  # perf mem record -t load -- ~/false_sharing.exe 2
  # perf mem record -t store -- ~/false_sharing.exe 2
  # perf mem record -t ldst -- ~/false_sharing.exe 2
  # perf mem record -e spe-load  -- ~/false_sharing.exe 2
  # perf mem record -e spe-store  -- ~/false_sharing.exe 2
  # perf mem record -e spe-ldst  -- ~/false_sharing.exe 2

[1] https://lore.kernel.org/patchwork/cover/1298085/


Leo Yan (9):
  perf mem: Search event name with more flexible path
  perf mem: Introduce weak function perf_mem_events__ptr()
  perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
  perf mem: Only initialize memory event for recording
  perf mem: Support AUX trace
  perf c2c: Support AUX trace
  perf mem: Support Arm SPE events
  perf mem: Return NULL for event 'ldst' on PowerPC
  perf mem: Document event type 'ldst'

Changes from v2:
* Patch 02 went back to use loops with PERF_MEM_EVENTS__MAX (Jiri);
* Patch 06 for "perf c2c" AUX trace is supported;
* Patch 08 for fixing memory event name on PowerPC.


Changes from v1:
* Refined patch 02 to use perf_mem_events__ptr() to return event pointer
  and check if pointer is NULL, and remove the condition checking for
  PERF_MEM_EVENTS__MAX; (James Clark)
* Added new itrace option 'M' for memory events;
* Added patch 14 to update documentation.


 tools/perf/Documentation/perf-mem.txt     |  6 ++-
 tools/perf/arch/arm64/util/Build          |  2 +-
 tools/perf/arch/arm64/util/mem-events.c   | 37 +++++++++++++++++
 tools/perf/arch/powerpc/util/mem-events.c |  6 ++-
 tools/perf/builtin-c2c.c                  | 22 +++++++---
 tools/perf/builtin-mem.c                  | 49 ++++++++++++++++-------
 tools/perf/util/mem-events.c              | 45 ++++++++++++++++-----
 tools/perf/util/mem-events.h              |  3 +-
 8 files changed, 133 insertions(+), 37 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

-- 
2.17.1

