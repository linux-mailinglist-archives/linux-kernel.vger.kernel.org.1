Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEA2800BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgJAOBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:40 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38801 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbgJAOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:34 -0400
Received: by mail-oo1-f67.google.com with SMTP id r10so1495345oor.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPPit0voQ5iZSd9YAtw226cZcfg7JS5J3IK/RTi0Ep0=;
        b=lkUg/IOmIpzlebYW7/STffzmlqK2NKVRmtuYgekPYA1+aT/wQbjLPmrskCZkOX0DF1
         fzSg/Hzlz/zpCd5yBiDXb2SV0J9WUh1vJOIn03IjQb3a9d9cloAphN32NC45ORCbRaGX
         TE/rNgIT8rTo3LzVwhm6rM30NBvyCT93T2GGkyhHtg8026G4prAR6dFhJXQGGCiFWP62
         gDE8xdT1Ov857XKYW7QEn+Yg9z2lWD/9WUhXiHTgQe/PA40KXRHiCGK59T0mk6/7R1lU
         5Z95Xkz1MIoH+NGXa3LAMl8xm6rMbY26ipr+++AJ7z88xXBkXbuyiGe0FOYARoZn/GMg
         7mow==
X-Gm-Message-State: AOAM533/VIWOk2jMe3WNjBgtTdkurMxF3D7QHUKpKm0MaUandmeyQCTQ
        TSluFDZ3T3APah+onNcj/A==
X-Google-Smtp-Source: ABdhPJydih/aHjZHfjgbKwgMy0lYj0D+YWruwhwC4nk7d63ZkCCJeNY48AJ80aqtxuvzpQ8OUVjoAA==
X-Received: by 2002:a4a:1a44:: with SMTP id 65mr5900885oof.30.1601560892873;
        Thu, 01 Oct 2020 07:01:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 9/9] Documentation: arm64: Document PMU counters access from userspace
Date:   Thu,  1 Oct 2020 09:01:16 -0500
Message-Id: <20201001140116.651970-10-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add a documentation file to describe the access to the pmu hardware
counters from userspace

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/index.rst                 |  1 +
 .../arm64/perf_counter_user_access.rst        | 56 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index d9665d83c53a..c712a08e7627 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -15,6 +15,7 @@ ARM64 Architecture
     legacy_instructions
     memory
     perf
+    perf_counter_user_access
     pointer-authentication
     silicon-errata
     sve
diff --git a/Documentation/arm64/perf_counter_user_access.rst b/Documentation/arm64/perf_counter_user_access.rst
new file mode 100644
index 000000000000..e49e141f10cc
--- /dev/null
+++ b/Documentation/arm64/perf_counter_user_access.rst
@@ -0,0 +1,56 @@
+=============================================
+Access to PMU hardware counter from userspace
+=============================================
+
+Overview
+--------
+The perf userspace tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 pmuv3 which makes sure that the access to the pmu
+registers is enabled and that the userspace has access to the relevant
+information in order to use them.
+
+In order to have access to the hardware counter it is necessary to open the event
+using the perf tool interface: the sys_perf_event_open syscall returns a fd which
+can subsequently be used with the mmap syscall in order to retrieve a page of
+memory containing information about the event.
+The PMU driver uses this page to expose to the user the hardware counter's
+index and other necessary data. Using this index enables the user to access the
+PMU registers using the `mrs` instruction.
+
+The userspace access is supported in libperf using the perf_evsel__mmap()
+and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
+an example.
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
+
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About chained events
+--------------------
+Chained events are not supported in userspace. If a 64-bit counter is requested,
+userspace access will only be enabled if the underlying counter is 64-bit.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
-- 
2.25.1

