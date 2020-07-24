Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFD322BF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGXH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 03:27:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgGXH1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:27:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B5C0123194B570F3C2F;
        Fri, 24 Jul 2020 15:27:03 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 15:26:54 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>
Subject: [PATCH] perf: arm-spe: Fix check error when synthesizing events
Date:   Fri, 24 Jul 2020 15:26:28 +0800
Message-ID: <20200724072628.35904-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm_spe_read_record(), when we are processing an events packet,
'decoder->packet.index' is the length of payload, which has been
transformed in payloadlen(). So correct the check of 'idx'.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 302a14d0aca9..93e063f22be5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -182,15 +182,15 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_TLB_ACCESS))
 				decoder->record.type |= ARM_SPE_TLB_ACCESS;
 
-			if ((idx == 1 || idx == 2 || idx == 3) &&
+			if ((idx == 2 || idx == 4 || idx == 8) &&
 			    (payload & BIT(EV_LLC_MISS)))
 				decoder->record.type |= ARM_SPE_LLC_MISS;
 
-			if ((idx == 1 || idx == 2 || idx == 3) &&
+			if ((idx == 2 || idx == 4 || idx == 8) &&
 			    (payload & BIT(EV_LLC_ACCESS)))
 				decoder->record.type |= ARM_SPE_LLC_ACCESS;
 
-			if ((idx == 1 || idx == 2 || idx == 3) &&
+			if ((idx == 2 || idx == 4 || idx == 8) &&
 			    (payload & BIT(EV_REMOTE_ACCESS)))
 				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
 
-- 
2.17.1

