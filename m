Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64922A5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgGWDNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 23:13:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728902AbgGWDNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:13:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0FEC2F2316F860034BF;
        Thu, 23 Jul 2020 11:13:45 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:13:42 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <jdike@addtoit.com>, <richard@nod.at>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] um: Remove redundant NULL check
Date:   Thu, 23 Jul 2020 11:15:16 +0800
Message-ID: <1595474116-3305-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./arch/um/drivers/vector_user.c:403:2-7: WARNING: NULL check before some freeing functions is not needed.

Fixes: bc8f8e4e6e7a ("um: Add a generic "fd" vector transport")
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26..e836d49 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -399,8 +399,7 @@ static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
 fd_cleanup:
 	if (fd >= 0)
 		os_close_file(fd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }
 
-- 
2.7.4

