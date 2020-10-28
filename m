Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02529D5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgJ1WKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:10:10 -0400
Received: from foss.arm.com ([217.140.110.172]:39038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgJ1WKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9C61763;
        Wed, 28 Oct 2020 15:10:04 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A6223F73C;
        Wed, 28 Oct 2020 15:10:03 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 03/26] coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
Date:   Wed, 28 Oct 2020 22:09:22 +0000
Message-Id: <20201028220945.3826358-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ETMv4.2, TRCIDR3.NUMPROCS has been extended to a 5bit field
by encoding the top 2 bits[4:3] in TRCIDR3.[13:12], which were RES0.
Fix the driver to compute the field correctly for ETMv4.2+

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index af0ab2f44865..cbbe755d1d16 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -724,8 +724,13 @@ static void etm4_init_arch_data(void *info)
 	else
 		drvdata->sysstall = false;
 
-	/* NUMPROC, bits[30:28] the number of PEs available for tracing */
-	drvdata->nr_pe = BMVAL(etmidr3, 28, 30);
+	/*
+	 * NUMPROC - the number of PEs available for tracing, 5bits
+	 *         = TRCIDR3.bits[13:12]bits[30:28]
+	 *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
+	 *  bits[3:0] = TRCIDR3.bits[30:28]
+	 */
+	drvdata->nr_pe = (BMVAL(etmidr3, 12, 13) << 3) | BMVAL(etmidr3, 28, 30);
 
 	/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
 	if (BMVAL(etmidr3, 31, 31))
-- 
2.24.1

