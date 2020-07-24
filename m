Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAC22BBA2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 03:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXBlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 21:41:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbgGXBlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:41:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27A1FF71B18AD2511C2E;
        Fri, 24 Jul 2020 09:41:34 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 09:41:27 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <regkh@linuxfoundation.org>, <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yuyufen@huawei.com>
Subject: [PATCH] kernfs: use common interface kernfs_lockdep() to check lockdep
Date:   Thu, 23 Jul 2020 21:42:18 -0400
Message-ID: <20200724014218.1083874-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the common interface to check lockdep instead of reading
the flags directly. This patch will not change any existing functionality.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/kernfs/dir.c        | 9 ---------
 fs/kernfs/file.c       | 2 +-
 fs/sysfs/file.c        | 2 +-
 include/linux/kernfs.h | 9 +++++++++
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..2caa12d8f498 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -30,15 +30,6 @@ static bool kernfs_active(struct kernfs_node *kn)
 	return atomic_read(&kn->active) >= 0;
 }
 
-static bool kernfs_lockdep(struct kernfs_node *kn)
-{
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	return kn->flags & KERNFS_LOCKDEP;
-#else
-	return false;
-#endif
-}
-
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
 	if (!kn)
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 06b342d8462b..24d3d75c9d1c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -62,7 +62,7 @@ static struct kernfs_open_file *kernfs_of(struct file *file)
  */
 static const struct kernfs_ops *kernfs_ops(struct kernfs_node *kn)
 {
-	if (kn->flags & KERNFS_LOCKDEP)
+	if (kernfs_lockdep(kn))
 		lockdep_assert_held(kn);
 	return kn->attr.ops;
 }
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..31645f03478d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -26,7 +26,7 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 {
 	struct kobject *kobj = kn->parent->priv;
 
-	if (kn->flags & KERNFS_LOCKDEP)
+	if (kernfs_lockdep(kn))
 		lockdep_assert_held(kn);
 	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..2ead0a1a3ee5 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -600,4 +600,13 @@ static inline int kernfs_rename(struct kernfs_node *kn,
 	return kernfs_rename_ns(kn, new_parent, new_name, NULL);
 }
 
+static inline bool kernfs_lockdep(struct kernfs_node *kn)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	return kn->flags & KERNFS_LOCKDEP;
+#else
+	return false;
+#endif
+}
+
 #endif	/* __LINUX_KERNFS_H */
-- 
2.25.4

