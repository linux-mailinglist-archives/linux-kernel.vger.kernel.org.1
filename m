Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB60E1B38AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:17:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVHRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:17:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1755546874DFF5CDF436;
        Wed, 22 Apr 2020 15:17:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:17:17 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <clemens@ladisch.de>, <perex@perex.cz>, <tiwai@suse.com>,
        <tglx@linutronix.de>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ALSA: oxygen: use true,false for bool variables
Date:   Wed, 22 Apr 2020 15:16:46 +0800
Message-ID: <20200422071646.48436-1-yanaijie@huawei.com>
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

sound/pci/oxygen/xonar_pcm179x.c:463:1-17: WARNING: Assignment of 0/1 to
bool variable
sound/pci/oxygen/xonar_pcm179x.c:505:1-17: WARNING: Assignment of 0/1 to
bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/pci/oxygen/xonar_pcm179x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index 6a0520c4fb5a..cf801a235df9 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -460,7 +460,7 @@ static void xonar_st_init(struct oxygen *chip)
 
 	data->generic.anti_pop_delay = 100;
 	data->h6 = chip->model.dac_channels_mixer > 2;
-	data->has_cs2000 = 1;
+	data->has_cs2000 = true;
 	data->cs2000_regs[CS2000_FUN_CFG_1] = CS2000_REF_CLK_DIV_1;
 	data->broken_i2c = true;
 
@@ -502,7 +502,7 @@ static void xonar_xense_init(struct oxygen *chip)
 	xonar_init_ext_power(chip);
 
 	data->generic.anti_pop_delay = 100;
-	data->has_cs2000 = 1;
+	data->has_cs2000 = true;
 	data->cs2000_regs[CS2000_FUN_CFG_1] = CS2000_REF_CLK_DIV_1;
 
 	oxygen_write16(chip, OXYGEN_I2S_A_FORMAT,
-- 
2.21.1

