Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F7272512
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgIUNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:13:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbgIUNKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0BC876B41EEAC0FC220;
        Mon, 21 Sep 2020 21:10:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:59 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/tidss: simplify the return expression of tidss_pm_runtime_resume()
Date:   Mon, 21 Sep 2020 21:10:23 +0800
Message-ID: <20200921131023.91694-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/tidss/tidss_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 9179ea18f..96568695a 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -60,15 +60,10 @@ static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)
 static int __maybe_unused tidss_pm_runtime_resume(struct device *dev)
 {
 	struct tidss_device *tidss = dev_get_drvdata(dev);
-	int r;
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	r = dispc_runtime_resume(tidss->dispc);
-	if (r)
-		return r;
-
-	return 0;
+	return dispc_runtime_resume(tidss->dispc);
 }
 
 static int __maybe_unused tidss_suspend(struct device *dev)
-- 
2.23.0

