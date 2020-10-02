Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9876281707
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgJBPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:48:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbgJBPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:48:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kONHt-0000L3-6C; Fri, 02 Oct 2020 15:48:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf: arm-cmn: fix less than zero check on unsigned dtc->irq
Date:   Fri,  2 Oct 2020 16:48:00 +0100
Message-Id: <20201002154800.92607-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the failure check on dtc->irq is always false because
dtc->irq is an unsigned int. Fix this by using a temporary signed
int for the less than zero error check.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/perf/arm-cmn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index a76ff594f3ca..21819af163f3 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1246,11 +1246,13 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 {
 	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
 	struct arm_cmn_node *xp;
+	int irq;
 
 	dtc->base = dn->pmu_base - CMN_PMU_OFFSET;
-	dtc->irq = platform_get_irq(to_platform_device(cmn->dev), idx);
-	if (dtc->irq < 0)
-		return dtc->irq;
+	irq = platform_get_irq(to_platform_device(cmn->dev), idx);
+	if (irq < 0)
+		return irq;
+	dtc->irq = irq;
 
 	writel_relaxed(0, dtc->base + CMN_DT_PMCR);
 	writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
-- 
2.27.0

