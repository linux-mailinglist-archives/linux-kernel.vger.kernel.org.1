Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389432E26DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 13:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgLXM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 07:29:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgLXM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 07:29:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1q9P58Jrz15gbj;
        Thu, 24 Dec 2020 20:28:09 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 20:28:46 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <ccaulfie@redhat.com>, <teigland@redhat.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] dlm: debug_fs: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 20:29:21 +0800
Message-ID: <20201224122921.29343-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init()

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/dlm/debug_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index d6bbccb0ed15..7a6fa8ac6f50 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -20,7 +20,7 @@
 
 #define DLM_DEBUG_BUF_LEN 4096
 static char debug_buf[DLM_DEBUG_BUF_LEN];
-static struct mutex debug_buf_lock;
+static DEFINE_MUTEX(debug_buf_lock);
 
 static struct dentry *dlm_root;
 
@@ -794,7 +794,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 void __init dlm_register_debugfs(void)
 {
-	mutex_init(&debug_buf_lock);
 	dlm_root = debugfs_create_dir("dlm", NULL);
 }
 
-- 
2.22.0

