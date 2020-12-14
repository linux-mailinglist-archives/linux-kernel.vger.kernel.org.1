Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BB2D98F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439530AbgLNNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:35:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9443 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391265AbgLNNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:34:28 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cvj550WKSzht2Q;
        Mon, 14 Dec 2020 21:33:13 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:33:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fbdev: imsttfb: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:34:06 +0800
Message-ID: <20201214133406.3676-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/fbdev/imsttfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 3ac053b88495..6794770873f5 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -994,7 +994,7 @@ imsttfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	bgc |= (bgc << 8);
 	bgc |= (bgc << 16);
 
-	Bpp = info->var.bits_per_pixel >> 3,
+	Bpp = info->var.bits_per_pixel >> 3;
 	line_pitch = info->fix.line_length;
 
 	dy = rect->dy * line_pitch;
-- 
2.22.0

