Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E92E0AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgLVNb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:31:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9236 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgLVNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:31:25 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D0cdS3dhXzkv1G;
        Tue, 22 Dec 2020 21:29:48 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:30:34 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu/drm/radeon: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 21:31:00 +0800
Message-ID: <20201222133100.19470-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 390a9621604a..a3aea5329712 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -219,7 +219,7 @@ int r600_fmt_get_nblocksx(u32 format, u32 w)
 	if (bw == 0)
 		return 0;
 
-	return (w + bw - 1) / bw;
+	return DIV_ROUND_UP(w, bw);
 }
 
 int r600_fmt_get_nblocksy(u32 format, u32 h)
@@ -233,7 +233,7 @@ int r600_fmt_get_nblocksy(u32 format, u32 h)
 	if (bh == 0)
 		return 0;
 
-	return (h + bh - 1) / bh;
+	return DIV_ROUND_UP(h, bh);
 }
 
 struct array_mode_checker {
-- 
2.22.0

