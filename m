Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D21BF0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD3HEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 03:04:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgD3HEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:04:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75443E6259D20B6A35F4;
        Thu, 30 Apr 2020 15:04:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 15:04:13 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/vboxvideo: Fix a NULL vs IS_ERR() check in vbox_hw_init()
Date:   Thu, 30 Apr 2020 07:05:23 +0000
Message-ID: <20200430070523.185584-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_gen_pool_create() function returns ERR_PTR() on error, it
doesn't return NULL so this check doesn't work.

Fixes: 4cc9b565454b ("drm/vboxvideo: Use devm_gen_pool_create")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index d68d9bad7674..c5ea880d17b2 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -123,8 +123,8 @@ int vbox_hw_init(struct vbox_private *vbox)
 	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
 	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
 						"vboxvideo-accel");
-	if (!vbox->guest_pool)
-		return -ENOMEM;
+	if (IS_ERR(vbox->guest_pool))
+		return PTR_ERR(vbox->guest_pool);
 
 	ret = gen_pool_add_virt(vbox->guest_pool,
 				(unsigned long)vbox->guest_heap,



