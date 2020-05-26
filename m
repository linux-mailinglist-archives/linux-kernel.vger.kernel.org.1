Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9880F1B9F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgD0JLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 05:11:41 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:49535 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgD0JLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:11:41 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65ea6a1ba977-78abc; Mon, 27 Apr 2020 17:11:22 +0800 (CST)
X-RM-TRANSID: 2ee65ea6a1ba977-78abc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5ea6a1b738b-77aae;
        Mon, 27 Apr 2020 17:11:22 +0800 (CST)
X-RM-TRANSID: 2eea5ea6a1b738b-77aae
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: hisilicon: Use IS_ERR() instead of IS_ERR_OR_NULL()
Date:   Mon, 27 Apr 2020 17:11:45 +0800
Message-Id: <20200427091145.4268-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function hi6210_i2s_probe(), devm_clk_get() doesn't return NULL.
Thus use IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index ab3b76d29..f14ce0253 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -570,12 +570,12 @@ static int hi6210_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->sysctrl);
 
 	i2s->clk[CLK_DACODEC] = devm_clk_get(&pdev->dev, "dacodec");
-	if (IS_ERR_OR_NULL(i2s->clk[CLK_DACODEC]))
+	if (IS_ERR(i2s->clk[CLK_DACODEC]))
 		return PTR_ERR(i2s->clk[CLK_DACODEC]);
 	i2s->clocks++;
 
 	i2s->clk[CLK_I2S_BASE] = devm_clk_get(&pdev->dev, "i2s-base");
-	if (IS_ERR_OR_NULL(i2s->clk[CLK_I2S_BASE]))
+	if (IS_ERR(i2s->clk[CLK_I2S_BASE]))
 		return PTR_ERR(i2s->clk[CLK_I2S_BASE]);
 	i2s->clocks++;
 
-- 
2.20.1.windows.1



