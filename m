Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA9295D27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896964AbgJVLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:06:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503186AbgJVLGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:06:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02A04AA43DBB1F5FECE4;
        Thu, 22 Oct 2020 19:06:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 22 Oct 2020 19:05:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <irogers@google.com>, <yao.jin@linux.intel.com>,
        <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 0/2] perf PMU events test: Add scenario for arch std events
Date:   Thu, 22 Oct 2020 19:02:25 +0800
Message-ID: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
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

Differences to v1:
- Revert to original logic in jevents.c error path

John Garry (2):
  perf jevents: Tidy error handling
  perf jevents: Add test for arch std events

 .../pmu-events/arch/test/arch-std-events.json |  8 ++
 .../pmu-events/arch/test/test_cpu/cache.json  |  5 ++
 tools/perf/pmu-events/jevents.c               | 87 +++++++++----------
 tools/perf/tests/pmu-events.c                 | 14 +++
 4 files changed, 66 insertions(+), 48 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json

-- 
2.26.2

