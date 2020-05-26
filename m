Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F01BD4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD2GeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 02:34:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgD2GeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:34:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F08776129585477CC03;
        Wed, 29 Apr 2020 14:34:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 14:34:12 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH RESEND] perf tools: Fix function name in comment
Date:   Wed, 29 Apr 2020 14:33:12 +0800
Message-ID: <1588141992-48382-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_cpuid_str() is used in tools/perf/arch/xxx/util/header.c,
fix the name in comment.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 tools/perf/pmu-events/pmu-events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 53e76d5d5b37..c8f306b572f4 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -26,7 +26,7 @@ struct pmu_event {
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
  * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
  *
  * The  cpuid can contain any character other than the comma.
  */
-- 
2.7.4

