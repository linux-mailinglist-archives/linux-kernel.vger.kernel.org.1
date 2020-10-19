Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8851292AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgJSPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:42:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730226AbgJSPmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:42:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C669A1B0EDC1014330AE;
        Mon, 19 Oct 2020 23:42:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 23:42:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <irogers@google.com>, <yao.jin@linux.intel.com>,
        <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] perf PMU events test: Add scenario for arch std events
Date:   Mon, 19 Oct 2020 23:38:26 +0800
Message-ID: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The small series covers the following:
- Tidy error handling in jevents a bit
- Expands on PMU events test to cover jevents arch std events support

John Garry (2):
  perf jevents: Tidy error handling
  perf jevents: Add test for arch std events

 .../pmu-events/arch/test/arch-std-events.json |  8 ++
 .../pmu-events/arch/test/test_cpu/cache.json  |  5 ++
 tools/perf/pmu-events/jevents.c               | 85 ++++++++-----------
 tools/perf/tests/pmu-events.c                 | 14 +++
 4 files changed, 64 insertions(+), 48 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json

-- 
2.26.2

