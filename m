Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EA1C85EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEGJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 05:39:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:39:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 489F142A0A6C250BACBC;
        Thu,  7 May 2020 17:39:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:39:32 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: rt5677: Use devm_snd_soc_register_component()
Date:   Thu, 7 May 2020 09:43:35 +0000
Message-ID: <20200507094335.14302-1-weiyongjun1@huawei.com>
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

Using devm_snd_soc_register_component() can make the code
shorter and cleaner.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt5677-spi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 3f40d2751833..7bfade8b3d6e 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -605,20 +605,15 @@ static int rt5677_spi_probe(struct spi_device *spi)
 
 	g_spi = spi;
 
-	ret = snd_soc_register_component(&spi->dev, &rt5677_spi_dai_component,
-					 &rt5677_spi_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+					      &rt5677_spi_dai_component,
+					      &rt5677_spi_dai, 1);
 	if (ret < 0)
 		dev_err(&spi->dev, "Failed to register component.\n");
 
 	return ret;
 }
 
-static int rt5677_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_component(&spi->dev);
-	return 0;
-}
-
 static const struct acpi_device_id rt5677_spi_acpi_id[] = {
 	{ "RT5677AA", 0 },
 	{ }
@@ -631,7 +626,6 @@ static struct spi_driver rt5677_spi_driver = {
 		.acpi_match_table = ACPI_PTR(rt5677_spi_acpi_id),
 	},
 	.probe = rt5677_spi_probe,
-	.remove = rt5677_spi_remove,
 };
 module_spi_driver(rt5677_spi_driver);
 





