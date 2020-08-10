Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5824063C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHJM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:57:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgHJM5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:57:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0586456B329F9446570C;
        Mon, 10 Aug 2020 20:57:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 20:56:56 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <miaoqinglang@huawei.com>
Subject: [PATCH] drm/v3d: convert to use module_platform_driver
Date:   Mon, 10 Aug 2020 20:59:31 +0800
Message-ID: <20200810125931.186456-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of boilerplate code by using module_platform_driver macro
for v3d_drm.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 82a7dfdd1..9f7c26193 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -358,18 +358,7 @@ static struct platform_driver v3d_platform_driver = {
 	},
 };
 
-static int __init v3d_drm_register(void)
-{
-	return platform_driver_register(&v3d_platform_driver);
-}
-
-static void __exit v3d_drm_unregister(void)
-{
-	platform_driver_unregister(&v3d_platform_driver);
-}
-
-module_init(v3d_drm_register);
-module_exit(v3d_drm_unregister);
+module_platform_driver(v3d_platform_driver);
 
 MODULE_ALIAS("platform:v3d-drm");
 MODULE_DESCRIPTION("Broadcom V3D DRM Driver");
-- 
2.25.1

