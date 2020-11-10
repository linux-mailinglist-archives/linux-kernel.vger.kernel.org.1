Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57332ACB06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgKJCZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:25:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7621 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbgKJCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:25:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CVWtX0PM7zLsPg;
        Tue, 10 Nov 2020 10:25:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 10:25:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <stefan@agner.ch>, <alison.wang@nxp.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/fsl-dcu: remove redundant platform_get_irq error message
Date:   Tue, 10 Nov 2020 10:26:19 +0800
Message-ID: <1604975179-15309-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dev_err() after platform_get_irq() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 7528e8a..476b196 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -259,7 +259,6 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
 	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return fsl_dev->irq;
 	}
 
-- 
2.7.4

