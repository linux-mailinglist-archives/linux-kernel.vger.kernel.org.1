Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8401BE050
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgD2OK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:10:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbgD2OK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:10:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF597D0A7553792897A7;
        Wed, 29 Apr 2020 22:10:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 22:10:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <b.zolnierkie@samsung.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] video: fbdev: valkyriefb.c: fix warning comparing pointer to 0
Date:   Wed, 29 Apr 2020 22:09:42 +0800
Message-ID: <20200429140942.8137-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
0, suggest !E
drivers/video/fbdev/valkyriefb.c:334:12-13: WARNING comparing pointer to
0
drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
0

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/valkyriefb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 4d20c4603e5a..8425afe37d7c 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -331,7 +331,7 @@ int __init valkyriefb_init(void)
 		struct resource r;
 
 		dp = of_find_node_by_name(NULL, "valkyrie");
-		if (dp == 0)
+		if (!dp)
 			return 0;
 
 		if (of_address_to_resource(dp, 0, &r)) {
@@ -345,7 +345,7 @@ int __init valkyriefb_init(void)
 #endif /* ppc (!CONFIG_MAC) */
 
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (p == 0)
+	if (!p)
 		return -ENOMEM;
 
 	/* Map in frame buffer and registers */
-- 
2.21.1

