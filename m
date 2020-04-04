Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7F19E1BE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDDAAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 20:00:24 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:63113 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgDDAAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:08 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vH460RsJzZ1;
        Sat,  4 Apr 2020 02:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585958406; bh=bsuHw8Ua60Zcsxk1TaxSYtB0ZG8LffLBdTMIriUnQtU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=qqv8Kbke4XES/OprUqpvcBcKa+2kWVztnOkChuBCY+GzgApBs9guztJRZRILkulxK
         4KTBtS8fLoak0BVk9HoQUqkHnOUJcdTOORummtngH57DFwKS8t4+ruf3AkhL4cItHL
         6i4fbMsLX1emHaMjgbMTOckkCu3Pk1YEI2PNcB7afAUGle12Sc/cd3Uzf/PyhLaT94
         5tVNihITgYobI5tLXgAHpgtgtxG9fnIY6IX+imLFeklhKLMNDCzT57kOkDHQgZQ0pU
         jwY5oJoq/l1DvkKQWv+gX8EkHQOBJXZGU0mcjzFiT9JN4voqL9d182RWwoXcuQ7EHc
         HtjA9kOnkZu6w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 02:00:05 +0200
Message-Id: <ee26f5ed9760a22fcda93531c6c53a0e112e5509.1585958250.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/5] usb: chipidea: usb2: make clock optional
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow clock to be missing from DT (assume it's enabled then).

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index bf300a234e64..9086514840ed 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -64,13 +64,14 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clk = devm_clk_get(dev, NULL);
-	if (!IS_ERR(priv->clk)) {
-		ret = clk_prepare_enable(priv->clk);
-		if (ret) {
-			dev_err(dev, "failed to enable the clock: %d\n", ret);
-			return ret;
-		}
+	priv->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable the clock: %d\n", ret);
+		return ret;
 	}
 
 	ci_pdata->name = dev_name(dev);
@@ -94,8 +95,7 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 	return 0;
 
 clk_err:
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
-- 
2.20.1

