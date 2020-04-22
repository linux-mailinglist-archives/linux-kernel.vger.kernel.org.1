Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC1B37FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDVGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 02:52:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2865 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVGwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:52:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA34F1F8295A51C6F2A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:52:43 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 14:52:36 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <mikulas@artax.karlin.mff.cuni.cz>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] fs:hpfs:remove unneeded semicolon in buffer.c
Date:   Wed, 22 Apr 2020 14:51:53 +0800
Message-ID: <1587538313-409999-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
fs/hpfs/buffer.c:56:2-3: Unneeded semicolon

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/hpfs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/buffer.c b/fs/hpfs/buffer.c
index e285d6b..d392468 100644
--- a/fs/hpfs/buffer.c
+++ b/fs/hpfs/buffer.c
@@ -53,7 +53,7 @@ void hpfs_prefetch_sectors(struct super_block *s, unsigned secno, int n)
 			return;
 		}
 		brelse(bh);
-	};
+	}
 
 	blk_start_plug(&plug);
 	while (n > 0) {
-- 
1.8.3.1

