Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2171F240643
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHJM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:57:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgHJM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:57:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CAFBC721ED4FE0FEC50;
        Mon, 10 Aug 2020 20:57:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 20:57:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <miaoqinglang@huawei.com>
Subject: [PATCH] drm/vkms: add missing platform_device_unregister() in vkms_init()
Date:   Mon, 10 Aug 2020 21:00:11 +0800
Message-ID: <20200810130011.187691-1-miaoqinglang@huawei.com>
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

When vkms_init() get into out_put, the unregister call of
vkms_device->platform is missing. So add it before return.

Fixes: c27f0cc4d43a "drm/vkms: enable cursor by default"
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 57a8a397d..83dd5567d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -190,8 +190,8 @@ static int __init vkms_init(void)
 
 out_put:
 	drm_dev_put(&vkms_device->drm);
+	platform_device_unregister(vkms_device->platform);
 	return ret;
-
 out_unregister:
 	platform_device_unregister(vkms_device->platform);
 out_free:
-- 
2.25.1

