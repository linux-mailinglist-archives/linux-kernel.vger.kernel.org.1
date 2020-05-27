Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC41E35FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgE0C5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:57:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbgE0C5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:57:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6ABE37498ABE6535058E;
        Wed, 27 May 2020 10:57:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 10:57:25 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: mmp-sspa: Fix return value check in asoc_mmp_sspa_probe()
Date:   Wed, 27 May 2020 03:02:10 +0000
Message-ID: <20200527030210.124393-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/pxa/mmp-sspa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 3e37ab625f8d..4255851c71c1 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -493,13 +493,13 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		sspa->rx_base = devm_ioremap(&pdev->dev, res->start, 0x30);
-		if (IS_ERR(sspa->rx_base))
-			return PTR_ERR(sspa->rx_base);
+		if (!sspa->rx_base)
+			return -ENOMEM;
 
 		sspa->tx_base = devm_ioremap(&pdev->dev,
 					     res->start + 0x80, 0x30);
-		if (IS_ERR(sspa->tx_base))
-			return PTR_ERR(sspa->tx_base);
+		if (!sspa->tx_base)
+			return -ENOMEM;
 
 		sspa->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(sspa->clk))





