Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043CD2566E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgH2Kv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 06:51:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:17379 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgH2Ku5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:50:57 -0400
IronPort-SDR: N1UI92Ntt9KKG1BNiCn80opCVaHK505w+UQEME9qTgRqTIlxbH9k2QLerooDY6uW9SDBqsFefE
 AyhSPQRcgvZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174838396"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="174838396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:50:53 -0700
IronPort-SDR: T4tnsmhQlfI2GBRnhCSyWQx0tF2AtAbCS4p9uM8UQUS/NuWxUFInOUSceh3zzPeq057Ak7XKe+
 /KEQ5KlXfzQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="313853142"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2020 03:50:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf tools: Enable AUX area tracing snapshots using a FIFO
Date:   Sat, 29 Aug 2020 13:50:09 +0300
Message-Id: <20200829105015.10800-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches to enable AUX area tracing snapshots using a FIFO.
Presently SIGUSR2 can be used but the advantage of the FIFO is that access
is governed by access to the FIFO.  Refer to the example in patch 5.

The first 4 patches are preparation, including patch 4 which enhances the
--control option to accept file names.

Patch 5 adds snapshot control command.

The final patch updates Intel PT documentation.


Adrian Hunter (6):
      perf tools: Consolidate --control option parsing into one function
      perf tools: Handle read errors from ctl_fd
      perf tools: Use AsciiDoc formatting for --control option documentation
      perf tools: Add FIFO file names as alternative options to --control
      perf record: Add 'snapshot' control command
      perf intel-pt: Document snapshot control command

 tools/perf/Documentation/perf-intel-pt.txt | 23 ++++++-
 tools/perf/Documentation/perf-record.txt   | 56 ++++++++---------
 tools/perf/Documentation/perf-stat.txt     | 48 ++++++++-------
 tools/perf/builtin-record.c                | 74 +++++++++++++----------
 tools/perf/builtin-stat.c                  | 35 +++++------
 tools/perf/util/evlist.c                   | 96 +++++++++++++++++++++++++++---
 tools/perf/util/evlist.h                   |  6 +-
 tools/perf/util/record.h                   |  1 +
 tools/perf/util/stat.h                     |  1 +
 9 files changed, 227 insertions(+), 113 deletions(-)


Regards
Adrian
