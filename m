Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6609819C0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbgDBMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:02:15 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:51844 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgDBMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:02:15 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e85d439609-5e6d1; Thu, 02 Apr 2020 20:02:03 +0800 (CST)
X-RM-TRANSID: 2eeb5e85d439609-5e6d1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e85d439357-4c8f6;
        Thu, 02 Apr 2020 20:02:03 +0800 (CST)
X-RM-TRANSID: 2ee65e85d439357-4c8f6
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] perf:arm_spe:Avoid duplicate printouts
Date:   Thu,  2 Apr 2020 20:03:30 +0800
Message-Id: <20200402120330.19468-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because platform_get_irq() has dev_err(),so this place
should be removed.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/perf/arm_spe_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4e4984a55..dd561880d 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1133,10 +1133,8 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 	struct platform_device *pdev = spe_pmu->pdev;
 	int irq = platform_get_irq(pdev, 0);
 
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ (%d)\n", irq);
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	if (!irq_is_percpu(irq)) {
 		dev_err(&pdev->dev, "expected PPI but got SPI (%d)\n", irq);
-- 
2.20.1.windows.1



