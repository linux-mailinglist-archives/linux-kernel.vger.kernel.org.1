Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4C7271AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:37:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbgIUGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:37:43 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34CCCA880779C5AAB829;
        Mon, 21 Sep 2020 14:37:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 14:37:36 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <christian.brauner@ubuntu.com>, <serge@hallyn.com>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] userns: Remove redundant assignment to variable ret
Date:   Mon, 21 Sep 2020 14:37:54 +0800
Message-ID: <20200921063754.179899-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit d2f007dbe7e4 ("userns: also map extents in the reverse map
to kernel IDs"), the assignment to ret is redundant. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 kernel/user_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..0157ae92e447 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -968,7 +968,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
 		goto out;
 
-	ret = -EPERM;
 	/* Map the lower ids from the parent user namespace to the
 	 * kernel global id space.
 	 */
-- 
2.17.1

