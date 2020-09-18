Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2826F939
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:26:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIRJ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:26:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8483CA90DB7D34974FE6;
        Fri, 18 Sep 2020 17:26:26 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 17:26:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <patrik.r.jakobsson@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu: gma500: Remove set but not used variable
Date:   Fri, 18 Sep 2020 17:27:08 +0800
Message-ID: <20200918092708.21570-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/gma500/mmu.c: In function psb_mmu_insert_pfn_sequence:
drivers/gpu/drm/gma500/mmu.c:660:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c: In function get_clock:
drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c:69:11: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c: In function get_data:
drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c:83:11: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

these variable is never used, so remove it or check it's return value.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/gma500/mmu.c               | 2 +-
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 505044c9a673..6ce842d05a44 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -690,7 +690,7 @@ int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd, uint32_t start_pfn,
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
 
-	return 0;
+	return ret;
 }
 
 int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
index baaf8212e01d..4d660868d76f 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
@@ -66,12 +66,12 @@
 static int get_clock(void *data)
 {
 	struct psb_intel_i2c_chan *chan = data;
-	u32 val, tmp;
+	u32 val;
 
 	val = LPC_READ_REG(chan, RGIO);
 	val |= GPIO_CLOCK;
 	LPC_WRITE_REG(chan, RGIO, val);
-	tmp = LPC_READ_REG(chan, RGLVL);
+	LPC_READ_REG(chan, RGLVL);
 	val = (LPC_READ_REG(chan, RGLVL) & GPIO_CLOCK) ? 1 : 0;
 
 	return val;
@@ -80,12 +80,12 @@ static int get_clock(void *data)
 static int get_data(void *data)
 {
 	struct psb_intel_i2c_chan *chan = data;
-	u32 val, tmp;
+	u32 val;
 
 	val = LPC_READ_REG(chan, RGIO);
 	val |= GPIO_DATA;
 	LPC_WRITE_REG(chan, RGIO, val);
-	tmp = LPC_READ_REG(chan, RGLVL);
+	LPC_READ_REG(chan, RGLVL);
 	val = (LPC_READ_REG(chan, RGLVL) & GPIO_DATA) ? 1 : 0;
 
 	return val;
-- 
2.17.1

