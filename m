Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883311C33B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEDHfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 03:35:52 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4380 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgEDHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:35:52 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25eafc5bf247-fd6c3; Mon, 04 May 2020 15:35:28 +0800 (CST)
X-RM-TRANSID: 2ee25eafc5bf247-fd6c3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.182.180])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75eafc5bddce-073a0;
        Mon, 04 May 2020 15:35:28 +0800 (CST)
X-RM-TRANSID: 2ee75eafc5bddce-073a0
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: qcom: Remove the unnecessary cast
Date:   Mon,  4 May 2020 15:35:58 +0800
Message-Id: <20200504073558.2340-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not necessary to specify 'void const __force *' casting
for 'drvdata->lpaif'.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/lpass-cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 885c1f2e7..4242f45ee 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -443,10 +443,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	drvdata->lpaif = devm_platform_ioremap_resource_byname(pdev, 
 						"lpass-lpaif")
-	if (IS_ERR((void const __force *)drvdata->lpaif)) {
+	if (IS_ERR(drvdata->lpaif)) {
 		dev_err(&pdev->dev, "error mapping reg resource: %ld\n",
-				PTR_ERR((void const __force *)drvdata->lpaif));
-		return PTR_ERR((void const __force *)drvdata->lpaif);
+				PTR_ERR(drvdata->lpaif));
+		return PTR_ERR(drvdata->lpaif);
 	}
 
 	lpass_cpu_regmap_config.max_register = LPAIF_WRDMAPER_REG(variant,
-- 
2.20.1.windows.1



