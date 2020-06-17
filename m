Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B71FC978
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 05:06:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgFQJGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:06:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 37CBF2B58B95CE9F9500;
        Wed, 17 Jun 2020 17:06:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 17:06:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linuxarm@huawei.com>, <irogers@google.com>, <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] perf: Improve list for arm64
Date:   Wed, 17 Jun 2020 17:01:52 +0800
Message-ID: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This couple of patches provides:
- aliases for arm64 CPU core events in perf list, like x86
- ensures that CPU core events are not sparsely listed

Differences to v1:
- Add ack from Namhyung Kim (thanks)
- use more concise logic in patch 2/2 and also add comment

John Garry (2):
  perf pmu: List kernel supplied event aliases for arm64
  perf pmu: Improve CPU core PMU HW event list ordering

 tools/perf/util/pmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.26.2

