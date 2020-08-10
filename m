Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DD24063D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHJM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:57:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgHJM5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:57:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB8E1FF15D6C8BBB2C41;
        Mon, 10 Aug 2020 20:57:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 20:57:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <miaoqinglang@huawei.com>
Subject: [PATCH] drm/vgem: add missing platform_device_unregister() in vgem_init()
Date:   Mon, 10 Aug 2020 20:59:42 +0800
Message-ID: <20200810125942.186637-1-miaoqinglang@huawei.com>
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

When vgem_init() get into out_put, the unregister call of
vgem_device->platform is missing. So add it before return.

Fixes: 363de9e7d4f6 "drm/vgem: Use drmm_add_final_kfree"
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index a775feda1..313339bbf 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -471,8 +471,8 @@ static int __init vgem_init(void)
 
 out_put:
 	drm_dev_put(&vgem_device->drm);
+	platform_device_unregister(vgem_device->platform);
 	return ret;
-
 out_unregister:
 	platform_device_unregister(vgem_device->platform);
 out_free:
-- 
2.25.1

