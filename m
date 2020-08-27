Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C612545DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgH0N1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 09:27:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbgH0NTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:19:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C3F82C315B0D3867DA47;
        Thu, 27 Aug 2020 21:00:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 21:00:46 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <b.zolnierkie@samsung.com>, <yanaijie@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] video: fbdev: remove set but not used 'ulCoreClock'
Date:   Thu, 27 Aug 2020 21:00:28 +0800
Message-ID: <20200827130028.428893-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
‘SetCoreClockPLL’:
drivers/video/fbdev/kyro/STG4000InitDevice.c:247:6: warning: variable
‘ulCoreClock’ set but not used [-Wunused-but-set-variable] // yanaijie
fixed
  247 |  u32 ulCoreClock;
      |      ^~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index 1d3f2080aa6f..edaeec2d9590 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -244,7 +244,6 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
 {
 	u32 F, R, P;
 	u16 core_pll = 0, sub;
-	u32 ulCoreClock;
 	u32 tmp;
 	u32 ulChipSpeed;
 
@@ -282,7 +281,7 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
 	if (ulChipSpeed == 0)
 		return -EINVAL;
 
-	ulCoreClock = ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
+	ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
 
 	core_pll |= ((P) | ((F - 2) << 2) | ((R - 2) << 11));
 
-- 
2.25.4

