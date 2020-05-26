Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418ED1C8076
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 05:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEGDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 23:21:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbgEGDVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:21:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F3E26763DC8128E49C9;
        Thu,  7 May 2020 11:19:54 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 11:19:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: SOF: Intel: Mark cht_debugfs as __maybe_unused
Date:   Thu, 7 May 2020 11:19:11 +0800
Message-ID: <20200507031911.38644-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:

sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
 static const struct snd_sof_debugfs_map cht_debugfs[] = {
                                         ^~~~~~~~~~~
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/intel/byt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index f872bb1f2682..1c75e4220e9d 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -82,7 +82,7 @@ static const struct snd_sof_debugfs_map byt_debugfs[] = {
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
-static const struct snd_sof_debugfs_map cht_debugfs[] = {
+static const struct snd_sof_debugfs_map __maybe_unused cht_debugfs[] = {
 	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
-- 
2.17.1


