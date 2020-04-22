Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406011B3897
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDVHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:12:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgDVHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:12:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3316C335695113F4E212;
        Wed, 22 Apr 2020 15:12:52 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:12:44 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] fs:ocfs2:remove unneeded variable 'o2dlm_flags'
Date:   Wed, 22 Apr 2020 15:12:01 +0800
Message-ID: <1587539521-461177-1-git-send-email-wubo40@huawei.com>
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
fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags". 
Return "0" on line 84

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ocfs2/stack_o2cb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index dbf8b57..2da9633 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
 	}
 static int flags_to_o2dlm(u32 flags)
 {
-	int o2dlm_flags = 0;
-
 	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
 	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
 	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
@@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
 	/* map_flag() should have cleared every flag passed in */
 	BUG_ON(flags != 0);
 
-	return o2dlm_flags;
+	return 0;
 }
 #undef map_flag
 
-- 
1.8.3.1

