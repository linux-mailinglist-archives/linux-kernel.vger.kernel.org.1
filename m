Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4828BD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbgJLQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389068AbgJLQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:10:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AFC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:10:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so24006910ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lWC5vs2YU8MKyR/XOhmZF8z3qyKs4NOsSz5ADhGN8ik=;
        b=X86r1p2mWY6wno9RjRPL9lw26uOmm2xYXc20lhhXbcaBv4kdBVRWzA6g70DBByNR31
         GR4j3G05jB04whWnFq4M3YXyrHhMaUMe+QgnvfZkw2qVjKHG68K3l0l2hQhLWMtAxHWT
         t9IoForQrZ6/2DIT9VcUp6nIQC9wMSip7TICcNVlN9eBa8fuH+G7K+zCT/wOqYS13mMg
         JbVC0Isd4pQzK5EQNzin6RvcjWqJpIOCrDZHaLMr9J5GcEoHq+OO/jQzSg7uVs04XnHi
         VL1o/wJS/C/PVJfqBnx0R/pjuCF4vwMCn9MHWSsefdKEbZ792X28XfO1JcDSy9QAZ94C
         KHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=lWC5vs2YU8MKyR/XOhmZF8z3qyKs4NOsSz5ADhGN8ik=;
        b=jI1SoBe0NXcwbOhsmPOzk+lRq+L2Ac+S9xnc03+HEmK6jkAypxxgTOMWdnbCNIgHlu
         XOcnJhmfEaekDRebtT53zmBLAJRU4j/deHgrc+uQv707j5YzarM4UWTTzl/zfFh7rjhM
         TyKsQdMaIM3Rea7IoCI9U98Bb4y8Lfp4yw4GjoS+OUPtQuXDEuajzjgnwEuYt8hEzJ08
         cvTAGyMRj70MIBS3W8U/zJPZeCCAaRBvP2dhEsVbwU5wwwwJijzI0ftpEvLQKl6Oclc7
         km+dBtCCLB/iNAeZDU1ez/JXCkWo4p/pfPkIVSK9OZTaH5me8fNZogXXqw6GqmAvi5Ie
         l65w==
X-Gm-Message-State: AOAM532SYM0NWCYz+4I52zsYPibSeiEaKXEy/SaquJSyWL1E3ljiHE3U
        O5KjaoIogtPp+ScgbTlMbOo=
X-Google-Smtp-Source: ABdhPJyVj29d71vzV1+eKvNxZGs3oBCtAh98h5EeSEnfMdOyniqtJ8eJRBpwHmdDzBPSqzGxLeJahA==
X-Received: by 2002:a17:906:8248:: with SMTP id f8mr29471052ejx.292.1602519052174;
        Mon, 12 Oct 2020 09:10:52 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id d7sm3884711edu.46.2020.10.12.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:10:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 18:10:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [GIT PULL] performance events updates for v5.10
Message-ID: <20201012161049.GA3624146@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-10-12

   # HEAD: f91072ed1b7283b13ca57fcfbece5a3b92726143 perf/core: Fix race in the perf_mmap_close() function

These are the performance events changes for v5.10:

x86 Intel updates:

 - Add Jasper Lake support

 - Add support for TopDown metrics on Ice Lake

 - Fix Ice Lake & Tiger Lake uncore support, add Snow Ridge support

 - Add a PCI sub driver to support uncore PMUs where the PCI resources
   have been claimed already - extending the range of supported systems.

x86 AMD updates:

 - Restore 'perf stat -a' behaviour to program the uncore PMU
   to count all CPU threads.

 - Fix setting the proper count when sampling Large Increment
   per Cycle events / 'paired' events.

 - Fix IBS Fetch sampling on F17h and some other IBS fine tuning,
   greatly reducing the number of interrupts when large sample
   periods are specified.

 - Extends Family 17h RAPL support to also work on compatible
   F19h machines.

Core code updates:

 - Fix race in perf_mmap_close()

 - Add PERF_EV_CAP_SIBLING, to denote that sibling events should be
   closed if the leader is removed.

 - Smaller fixes and updates.

 Thanks,

	Ingo

------------------>
Alexander Antonov (1):
      perf/x86/intel/uncore: Fix for iio mapping on Skylake Server

Colin Ian King (1):
      x86/events/amd/iommu: Fix sizeof mismatch

Jarkko Sakkinen (1):
      kprobes: Use module_name() macro

Jiri Olsa (1):
      perf/core: Fix race in the perf_mmap_close() function

Kan Liang (28):
      perf/x86: Use event_base_rdpmc for the RDPMC userspace support
      perf/x86/intel: Name the global status bit in NMI handler
      perf/x86/intel: Introduce the fourth fixed counter
      perf/x86/intel: Move BTS index to 47
      perf/x86/intel: Fix the name of perf METRICS
      perf/x86/intel: Use switch in intel_pmu_disable/enable_event
      perf/core: Add a new PERF_EV_CAP_SIBLING event capability
      perf/x86/intel: Generic support for hardware TopDown metrics
      perf/x86: Add a macro for RDPMC offset of fixed counters
      perf/x86/intel: Support TopDown metrics on Ice Lake
      perf/x86/intel: Support per-thread RDPMC TopDown metrics
      perf/x86/intel/ds: Fix x86_pmu_stop warning for large PEBS
      perf/core: Pull pmu::sched_task() into perf_event_context_sched_in()
      perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()
      perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
      perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
      perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
      perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
      perf/x86/intel/uncore: Generic support for the PCI sub driver
      perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge
      perf/x86/intel/uncore: Split the Ice Lake and Tiger Lake MSR uncore support
      perf/x86/intel/uncore: Update Ice Lake uncore units
      perf/x86/intel/uncore: Reduce the number of CBOX counters
      perf/x86/intel: Add Jasper Lake support
      perf/x86/msr: Add Jasper Lake support
      perf/x86/intel/uncore: Fix the scale of the IMC free-running events
      perf/x86/intel: Fix Ice Lake event constraint table
      perf/x86/intel: Check perf metrics feature for each CPU

Kim Phillips (11):
      perf/amd/uncore: Set all slices and threads to restore perf stat -a behaviour
      perf/x86/amd: Fix sampling Large Increment per Cycle events
      perf/x86/amd/ibs: Don't include randomized bits in get_ibs_op_count()
      perf/x86/amd/ibs: Fix raw sample data accumulation
      perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter
      perf/x86/rapl: Add AMD Fam19h RAPL support
      arch/x86/amd/ibs: Fix re-arming IBS Fetch
      perf/amd/uncore: Prepare to scale for more attributes that vary per family
      perf/amd/uncore: Allow F17h user threadmask and slicemask specification
      perf/amd/uncore: Allow F19h user coreid, threadmask, and sliceid specification
      perf/amd/uncore: Inform the user how many counters each uncore PMU has

Peter Zijlstra (2):
      perf/x86: Fix n_pair for cancelled txn
      perf/x86: Fix n_metric for cancelled txn


 arch/x86/events/amd/ibs.c            |  93 ++++++---
 arch/x86/events/amd/iommu.c          |   2 +-
 arch/x86/events/amd/uncore.c         | 186 ++++++++++--------
 arch/x86/events/core.c               |  91 +++++++--
 arch/x86/events/intel/core.c         | 364 +++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c           |  32 +--
 arch/x86/events/intel/uncore.c       | 275 ++++++++++++++++++++------
 arch/x86/events/intel/uncore.h       |   2 +
 arch/x86/events/intel/uncore_snb.c   |  45 ++++-
 arch/x86/events/intel/uncore_snbep.c |  72 ++++++-
 arch/x86/events/msr.c                |   1 +
 arch/x86/events/perf_event.h         |  54 +++++-
 arch/x86/events/rapl.c               |   1 +
 arch/x86/include/asm/msr-index.h     |   4 +
 arch/x86/include/asm/perf_event.h    |  98 ++++++++--
 include/linux/perf_event.h           |  34 ++--
 kernel/events/core.c                 | 121 +++++++-----
 kernel/trace/trace_kprobe.c          |   7 +-
 18 files changed, 1182 insertions(+), 300 deletions(-)
