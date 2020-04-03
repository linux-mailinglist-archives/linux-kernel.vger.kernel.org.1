Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B219D218
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbgDCIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 04:24:00 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3379 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390512AbgDCIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:24:00 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e86f25fc1b-72d91; Fri, 03 Apr 2020 16:22:55 +0800 (CST)
X-RM-TRANSID: 2ee25e86f25fc1b-72d91
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e86f25cd60-3dabc;
        Fri, 03 Apr 2020 16:22:55 +0800 (CST)
X-RM-TRANSID: 2eea5e86f25cd60-3dabc
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jun.nie@linaro.org, shawnguo@kernel.org, linux@armlinux.org.uk
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]ARM:zx:Delete duplicate dev_err message in zx296702_pd_probe()
Date:   Fri,  3 Apr 2020 16:24:23 +0800
Message-Id: <20200403082423.8800-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this place,devm_ioremap_resource() has already contains error
message, so delete the duplicate dev_err message.

Changes from v1:
 - the title has changed, because the description is not very detailed
   and the formate is wrong. So I find an other wording more appropriate.

As suggested by Markus Elfring:
   This is another attempt for the previous update suggestion, v1 can be
   found here: https://lore.kernel.org/patchwork/patch/1203764/

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index 7a08bf9dd..ac44ea8e6 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	}
 
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcubase)) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
+	if (IS_ERR(pcubase))
 		return -EIO;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
 		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
-- 
2.20.1.windows.1



