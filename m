Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7C24565B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgHPHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 03:14:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbgHPHOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:14:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2DC612D125E6899B1B39;
        Sun, 16 Aug 2020 15:14:04 +0800 (CST)
Received: from ubuntu.huawei.com (100.120.247.70) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sun, 16 Aug 2020 15:13:53 +0800
From:   Liang Wang <wangliang101@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>
Subject: [PATCH] sound/isa:fix spelling mistakes in the comments
Date:   Sun, 16 Aug 2020 15:13:09 +0800
Message-ID: <20200816071309.121461-1-wangliang101@huawei.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.120.247.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistakes in the comments:
	initailise ==> initialise
	tranfer ==> transfer
	Initialse ==> Initialise

Signed-off-by: Liang Wang <wangliang101@huawei.com>
---
 sound/isa/sscape.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 5363d88cc4b9..2e5a5c5279e8 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -308,7 +308,7 @@ static inline int verify_mpu401(const struct snd_mpu401 *mpu)
 }
 
 /*
- * This is apparently the standard way to initailise an MPU-401
+ * This is apparently the standard way to initialise an MPU-401
  */
 static inline void initialise_mpu401(const struct snd_mpu401 *mpu)
 {
@@ -339,7 +339,7 @@ static void soundscape_free(struct snd_card *c)
 }
 
 /*
- * Tell the SoundScape to begin a DMA tranfer using the given channel.
+ * Tell the SoundScape to begin a DMA transfer using the given channel.
  * All locking issues are left to the caller.
  */
 static void sscape_start_dma_unsafe(unsigned io_base, enum GA_REG reg)
@@ -803,7 +803,7 @@ static int mpu401_open(struct snd_mpu401 *mpu)
 }
 
 /*
- * Initialse an MPU-401 subdevice for MIDI support on the SoundScape.
+ * Initialise an MPU-401 subdevice for MIDI support on the SoundScape.
  */
 static int create_mpu401(struct snd_card *card, int devnum,
 			 unsigned long port, int irq)
-- 
2.27.0

