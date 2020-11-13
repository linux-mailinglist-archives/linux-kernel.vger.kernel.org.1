Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95C2B1698
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgKMHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:40:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7534 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:40:28 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXVk70vR9zhl5h;
        Fri, 13 Nov 2020 15:40:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 15:40:24 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/tilcdc: Remove unnecessary THIS_MODULE
Date:   Fri, 13 Nov 2020 15:40:53 +0800
Message-ID: <1605253253-22179-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in platform_driver_register(),
so remove it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 00efc30..4235780 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -399,7 +399,6 @@ static struct platform_driver panel_driver = {
 	.probe = panel_probe,
 	.remove = panel_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tilcdc-panel",
 		.of_match_table = panel_of_match,
 	},
-- 
2.7.4

