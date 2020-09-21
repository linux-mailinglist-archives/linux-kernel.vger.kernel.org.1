Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821A2724C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgIUNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:11:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727475AbgIUNLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:11:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 901E5C13B1E580BF3F98;
        Mon, 21 Sep 2020 21:10:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:47 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] vga_switcheroo: simplify the return expression of vga_switcheroo_runtime_resume
Date:   Mon, 21 Sep 2020 21:11:10 +0800
Message-ID: <20200921131110.93365-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/vga/vga_switcheroo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 087304b1a..1401fd52f 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -1034,17 +1034,12 @@ static int vga_switcheroo_runtime_suspend(struct device *dev)
 static int vga_switcheroo_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
 
 	mutex_lock(&vgasr_mutex);
 	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
 	mutex_unlock(&vgasr_mutex);
 	pci_wakeup_bus(pdev->bus);
-	ret = dev->bus->pm->runtime_resume(dev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return dev->bus->pm->runtime_resume(dev);
 }
 
 /**
-- 
2.23.0

