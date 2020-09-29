Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77627D417
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgI2RCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgI2RCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:02:55 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90CE8208B8;
        Tue, 29 Sep 2020 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601398974;
        bh=6sxhzxES43pi5ZwcvSOYXKElL659FR/ANkscAcTnenk=;
        h=Date:From:To:Cc:Subject:From;
        b=JY3aizJ4AVhdJISbRasOcjhkl0CUKga5HepsCPOpYl9A+Q+NLp+GukB0pW7hS1OnY
         F3+59//DDyK5akylc/L9ZCSZiy4syj7G5YYTC+CcsNRbgxewISYpMkI+ILzBWCBPen
         2lofEMRESoC4s+HJ5dgLx+sVTteLXS1v9SOEoO9k=
Date:   Tue, 29 Sep 2020 12:08:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH][next] perf: arm-cmn: Fix unsigned comparison to less than
 zero
Message-ID: <20200929170835.GA15956@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unsigned comparison to less than zero by assigning the returned
value of function platform_get_irq() to a new integer variable _ret_
and then make the comparison. In case the returned value is greater
than or equal to zero, assign it to dtc->irq.

Addresses-Coverity-ID: 1497488 ("Unsigned compared against 0")
Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/perf/arm-cmn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e824b5b83ea2..383b67042677 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1246,11 +1246,13 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 {
 	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
 	struct arm_cmn_node *xp;
+	int ret;
 
 	dtc->base = dn->pmu_base - CMN_PMU_OFFSET;
-	dtc->irq = platform_get_irq(to_platform_device(cmn->dev), idx);
-	if (dtc->irq < 0)
-		return dtc->irq;
+	ret = platform_get_irq(to_platform_device(cmn->dev), idx);
+	if (ret < 0)
+		return ret;
+	dtc->irq = ret;
 
 	writel_relaxed(0, dtc->base + CMN_DT_PMCR);
 	writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
-- 
2.27.0

