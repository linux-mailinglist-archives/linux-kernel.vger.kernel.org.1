Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF2251923
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHYNDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:03:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgHYNCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:02:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AEB24C7A2EAAA29B03A7;
        Tue, 25 Aug 2020 21:02:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 21:02:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>,
        <shengjiu.wang@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>, <xobs@kosagi.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH V2] ASoC: fsl: imx-es8328: add missing put_device() call in imx_es8328_probe()
Date:   Tue, 25 Aug 2020 21:02:24 +0800
Message-ID: <20200825130224.1488694-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, imx_es8328_probe() doesn't have
a corresponding put_device(). Thus add a jump target to fix the exception
handling for this function implementation.

Fixes: 7e7292dba215 ("ASoC: fsl: add imx-es8328 machine driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes from V1:
 - remove the first patch in patch series

 sound/soc/fsl/imx-es8328.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 15a27a2cd0ca..fad1eb6253d5 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -145,13 +145,13 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
 	if (!comp) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	data->dev = dev;
@@ -182,12 +182,12 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret) {
 		dev_err(dev, "Unable to parse card name\n");
-		goto fail;
+		goto put_device;
 	}
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret) {
 		dev_err(dev, "Unable to parse routing: %d\n", ret);
-		goto fail;
+		goto put_device;
 	}
 	data->card.num_links = 1;
 	data->card.owner = THIS_MODULE;
@@ -196,10 +196,12 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&data->card);
 	if (ret) {
 		dev_err(dev, "Unable to register: %d\n", ret);
-		goto fail;
+		goto put_device;
 	}
 
 	platform_set_drvdata(pdev, data);
+put_device:
+	put_device(&ssi_pdev->dev);
 fail:
 	of_node_put(ssi_np);
 	of_node_put(codec_np);
-- 
2.25.4

