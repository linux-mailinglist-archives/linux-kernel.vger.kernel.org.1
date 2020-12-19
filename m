Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07552DEEE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgLSMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:50:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9540 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgLSMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:50:04 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CylsN006Bzhtyl;
        Sat, 19 Dec 2020 20:48:39 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.20) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 19 Dec 2020 20:49:13 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <wangfangpeng1@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubi: remove dead code in validate_vid_hdr()
Date:   Sat, 19 Dec 2020 20:49:10 +0800
Message-ID: <1608382150-102703-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data_size is already checked against zero when vol_type matches
UBI_VID_STATIC. Remove the following dead code.

Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>
---
 drivers/mtd/ubi/io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 2f3312c..8a7306c 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -913,12 +913,7 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
 				ubi_err(ubi, "bad data_size");
 				goto bad;
 			}
-		} else if (lnum == used_ebs - 1) {
-			if (data_size == 0) {
-				ubi_err(ubi, "bad data_size at last LEB");
-				goto bad;
-			}
-		} else {
+		} else if (lnum > used_ebs - 1) {
 			ubi_err(ubi, "too high lnum");
 			goto bad;
 		}
-- 
1.8.5.6

