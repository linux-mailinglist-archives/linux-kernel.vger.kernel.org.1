Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45726266A59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:52:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35625 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIKVvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:46 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so12666319ioa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPPit0voQ5iZSd9YAtw226cZcfg7JS5J3IK/RTi0Ep0=;
        b=DVRG88UgpEIw/PGAuv7lzIQhnzSnDlE4iXzxFm94KR6pyMl7V6tP8N5e5YNDEclZSA
         zHA/eTasz/EMS4wqY7AGoi/MPQuzzJb/8hz9+cqCRYlpmuuW4ogDLkTarySbLsEItv7T
         EMPf/6eeU1jr0jOdi40NH4+nANq8wiXZM79WNN6PiIkygxWvJWl7FiLB7omAjGXnJEhF
         4erlCU/kbTBOkaroVH9UWc4ERcR3mTLXAIcEzp6VHEO19QHYd/1NcgT07QTxlXy3A0i5
         ndEqTstBNbroyaHzZohtG9A2We4nhQqYHF7h3hFWCD98RdqaNf5xznaz64TtGAg9zqac
         O3ew==
X-Gm-Message-State: AOAM5303xlsDfRB1BQrOlUs3wKpDby3VvVEx0XxN+LhLcNIxGIGRS80O
        F8L94ClErdiKPmzSs58RWg==
X-Google-Smtp-Source: ABdhPJwXsUOdBoxG1hqbkTvcWRCS/9/3qi9AIdeT/TMf/FXFFXd3jcCl4evlYyv+FoXvTFxkkQtSpQ==
X-Received: by 2002:a6b:b48c:: with SMTP id d134mr3385351iof.115.1599861094893;
        Fri, 11 Sep 2020 14:51:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 10/10] Documentation: arm64: Document PMU counters access from userspace
Date:   Fri, 11 Sep 2020 15:51:18 -0600
Message-Id: <20200911215118.2887710-11-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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

