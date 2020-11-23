Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AFB2C0180
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgKWIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:35:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgKWIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:35:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CfgSD3CS8zhg5t;
        Mon, 23 Nov 2020 16:34:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Nov 2020 16:34:52 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/nouveau/fb/gp102-: use flexible-array member instead of zero-length array
Date:   Mon, 23 Nov 2020 16:35:15 +0800
Message-ID: <1606120515-45702-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the coccicheck:
drivers/gpu/drm/nouveau/include/nvfw/hs.h:26:5-9: WARNING use
flexible-array member instead.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
index 64d0d32..b53bbc4 100644
--- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
+++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
@@ -23,7 +23,7 @@ struct nvfw_hs_load_header {
 	u32 data_dma_base;
 	u32 data_size;
 	u32 num_apps;
-	u32 apps[0];
+	u32 apps[];
 };
 
 const struct nvfw_hs_load_header *
-- 
2.7.4

