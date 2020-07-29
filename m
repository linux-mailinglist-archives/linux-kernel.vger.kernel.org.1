Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA00231B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgG2Icp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 04:32:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8849 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgG2Ico (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:32:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01CD633EA6E208CE3739;
        Wed, 29 Jul 2020 16:32:43 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 16:32:37 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/powerplay: Remove unneeded cast from memory allocation
Date:   Wed, 29 Jul 2020 16:34:01 +0800
Message-ID: <1596011641-9136-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove casting the values returned by memory allocation function.

Coccinelle emits WARNING:

./drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c:893:37-46: WARNING: casting value returned by memory allocation function to (PPTable_t *) is useless.

Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
index 7a7f15d..f56a3cb 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
@@ -890,7 +890,7 @@ static int init_powerplay_table_information(
 				power_saving_clock_count);
 	}
 
-	pptable_information->smc_pptable = (PPTable_t *)kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-- 
2.7.4

