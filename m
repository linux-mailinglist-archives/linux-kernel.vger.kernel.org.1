Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F465273933
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgIVDT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:19:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:30245 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgIVDT6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:19:58 -0400
IronPort-SDR: 6xxrMqM4+N/XBUt8NoFpHVSFUAFdbtxcAmS/aOrG5aC11Ep3pufZZF3QLgtdNPz8k3AAzJUJnG
 yTELRjPHN+dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="140004282"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="140004282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 20:19:58 -0700
IronPort-SDR: v+cd3UwZcKZ6ghthSO4PxO4pLPty/cQIRsZ7i/pCO6rplltAdUcjqKM47JwLXXx5rl/uAtpVgV
 05ScoovC7Zww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="412516877"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2020 20:19:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/2] perf: Update CascadelakeX and SkylakeX events list
Date:   Tue, 22 Sep 2020 11:19:16 +0800
Message-Id: <20200922031918.3723-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates CascadelakeX events to v1.08 and
updates SkylakeX events to v1.21.

The events have been tested on CascadelakeX and SkylakeX
servers with latest perf/core branch.

The first version was posted a few months ago and now just
resend the patchset with minor update.

 v2:
   - Change 'MB/sec' to 'MB' in UNC_M_PMM_BANDWIDTH.

Jin Yao (2):
  perf vendor events: Update CascadelakeX events to v1.08
  perf vendor events: Update SkylakeX events to v1.21

 .../arch/x86/cascadelakex/cache.json          |   28 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  153 +-
 .../arch/x86/cascadelakex/frontend.json       |   34 +
 .../arch/x86/cascadelakex/memory.json         |  704 ++---
 .../arch/x86/cascadelakex/other.json          | 1100 ++++----
 .../arch/x86/cascadelakex/pipeline.json       |   10 -
 .../arch/x86/cascadelakex/uncore-memory.json  |   12 +-
 .../arch/x86/cascadelakex/uncore-other.json   |   21 +
 .../pmu-events/arch/x86/skylakex/cache.json   | 2348 +++++++++--------
 .../arch/x86/skylakex/floating-point.json     |   96 +-
 .../arch/x86/skylakex/frontend.json           |  656 ++---
 .../pmu-events/arch/x86/skylakex/memory.json  | 1977 +++++++-------
 .../pmu-events/arch/x86/skylakex/other.json   |  172 +-
 .../arch/x86/skylakex/pipeline.json           | 1206 +++++----
 .../arch/x86/skylakex/skx-metrics.json        |  141 +-
 .../arch/x86/skylakex/uncore-memory.json      |   26 +-
 .../arch/x86/skylakex/uncore-other.json       |  730 ++++-
 .../arch/x86/skylakex/virtual-memory.json     |  358 +--
 18 files changed, 5204 insertions(+), 4568 deletions(-)

-- 
2.17.1

