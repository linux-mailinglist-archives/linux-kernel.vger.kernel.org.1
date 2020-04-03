Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0939919CF12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgDCETO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 00:19:14 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3378 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDCETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:19:14 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e86b92a542-6c6b2; Fri, 03 Apr 2020 12:18:52 +0800 (CST)
X-RM-TRANSID: 2ee25e86b92a542-6c6b2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e86b92ae84-15666;
        Fri, 03 Apr 2020 12:18:52 +0800 (CST)
X-RM-TRANSID: 2ee15e86b92ae84-15666
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] mfd:asic3:Delete redundant variable definition
Date:   Fri,  3 Apr 2020 12:20:20 +0800
Message-Id: <20200403042020.17452-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, 'ret' is always assigned, even if 'pdata->leds'
don't carry out,it has already been assigned a value in the above
code, including '0',so it's redundant.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mfd/asic3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index a6bd2134c..cee7454b3 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -924,7 +924,6 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 			goto out;
 	}
 
-	ret = 0;
 	if (pdata->leds) {
 		int i;
 
-- 
2.20.1.windows.1



