Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB02A7E66
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgKEMQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:16:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6746 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:16:28 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CRjDL542NzkfFR;
        Thu,  5 Nov 2020 20:16:18 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Nov 2020 20:16:13 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jiaxin.yu@mediatek.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next v2] ASoC: mediatek: mt8192: Make some symbols static
Date:   Thu, 5 Nov 2020 20:28:07 +0800
Message-ID: <1604579287-25251-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

./mt8192-dai-i2s.c:2040:5: warning: symbol 'mt8192_dai_i2s_get_share' was not declared. Should it be static?
./mt8192-dai-i2s.c:2060:5: warning: symbol 'mt8192_dai_i2s_set_priv' was not declared. Should it be static?
./mt8192-afe-gpio.c:15:16: warning: symbol 'aud_pinctrl' was not declared. Should it be static?
./mt8192-afe-pcm.c:70:5: warning: symbol 'mt8192_get_memif_pbuf_size' was not declared. Should it be static?
./mt8192-afe-pcm.c:2137:39: warning: symbol 'mt8192_afe_component' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c | 2 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c  | 4 ++--
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
index ea00088..4208820 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
@@ -12,7 +12,7 @@
 #include "mt8192-afe-common.h"
 #include "mt8192-afe-gpio.h"
 
-struct pinctrl *aud_pinctrl;
+static struct pinctrl *aud_pinctrl;
 
 enum mt8192_afe_gpio {
 	MT8192_AFE_GPIO_DAT_MISO_OFF,
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 4a4729f..e7fec2d 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -67,7 +67,7 @@ static int mt8192_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 	return mt8192_general_rate_transform(afe->dev, rate);
 }
 
-int mt8192_get_memif_pbuf_size(struct snd_pcm_substream *substream)
+static int mt8192_get_memif_pbuf_size(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -2134,7 +2134,7 @@ static int mt8192_afe_component_probe(struct snd_soc_component *component)
 	return mtk_afe_add_sub_dai_control(component);
 }
 
-const struct snd_soc_component_driver mt8192_afe_component = {
+static const struct snd_soc_component_driver mt8192_afe_component = {
 	.name = AFE_PCM_NAME,
 	.probe = mt8192_afe_component_probe,
 	.pointer = mtk_afe_pcm_pointer,
diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-i2s.c b/sound/soc/mediatek/mt8192/mt8192-dai-i2s.c
index 53c560e..5b29340 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-i2s.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-i2s.c
@@ -2037,7 +2037,7 @@ static const struct mtk_afe_i2s_priv mt8192_i2s_priv[DAI_I2S_NUM] = {
 	},
 };
 
-int mt8192_dai_i2s_get_share(struct mtk_base_afe *afe)
+static int mt8192_dai_i2s_get_share(struct mtk_base_afe *afe)
 {
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 	const struct device_node *of_node = afe->dev->of_node;
@@ -2057,7 +2057,7 @@ int mt8192_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt8192_dai_i2s_set_priv(struct mtk_base_afe *afe)
+static int mt8192_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	int i;
 	int ret;
-- 
2.6.2

