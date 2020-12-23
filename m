Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA85F2E1D21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgLWONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:13:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9639 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgLWONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:13:32 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FWk6JmZz15gmW;
        Wed, 23 Dec 2020 22:12:02 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:12:37 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] dlm: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:13:13 +0800
Message-ID: <20201223141313.669-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/dlm/lockspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 624617c12250..2b3c32f2d29d 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -26,7 +26,7 @@
 #include "ast.h"
 
 static int			ls_count;
-static struct mutex		ls_lock;
+static DEFINE_MUTEX(ls_lock);
 static struct list_head		lslist;
 static spinlock_t		lslist_lock;
 static struct task_struct *	scand_task;
@@ -231,7 +231,6 @@ static const struct kset_uevent_ops dlm_uevent_ops = {
 int __init dlm_lockspace_init(void)
 {
 	ls_count = 0;
-	mutex_init(&ls_lock);
 	INIT_LIST_HEAD(&lslist);
 	spin_lock_init(&lslist_lock);
 
-- 
2.22.0

