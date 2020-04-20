Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB41B0065
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 06:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDTECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 00:02:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgDTECH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:02:07 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C4EBEF88FFFFD299326;
        Mon, 20 Apr 2020 12:02:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 12:01:52 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ASoC: wcd934x: remove unnecessary comparisons to bool
Date:   Mon, 20 Apr 2020 12:28:33 +0800
Message-ID: <20200420042833.19116-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

sound/soc/codecs/wcd934x.c:3881:8-17: WARNING: Comparison of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index a514eb32e3e6..531b8b79e55f 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3878,7 +3878,7 @@ static u32 wcd934x_get_dmic_sample_rate(struct snd_soc_component *comp,
 	u16 adc_mux_ctl_reg, tx_fs_reg;
 	u32 dmic_fs;
 
-	while (dec_found == 0 && adc_mux_index < WCD934X_MAX_VALID_ADC_MUX) {
+	while (!dec_found && adc_mux_index < WCD934X_MAX_VALID_ADC_MUX) {
 		if (adc_mux_index < 4) {
 			adc_mux_ctl_reg = WCD934X_CDC_TX_INP_MUX_ADC_MUX0_CFG0 +
 						(adc_mux_index * 2);
-- 
2.21.1

