Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C592D4147
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgLILnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:43:33 -0500
Received: from smtp.h3c.com ([60.191.123.56]:10864 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbgLILnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:43:33 -0500
X-Greylist: delayed 6974 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 06:43:31 EST
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0B99lFhD000426
        for <linux-kernel@vger.kernel.org>; Wed, 9 Dec 2020 17:47:15 +0800 (GMT-8)
        (envelope-from zhang.yanjunA@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam01-ex.h3c.com with ESMTP id 0B99jcoI096985;
        Wed, 9 Dec 2020 17:45:38 +0800 (GMT-8)
        (envelope-from zhang.yanjunA@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 17:45:41 +0800
From:   Yanjun Zhang <zhang.yanjuna@h3c.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <viro@zeniv.linux.org.uk>, <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Yanjun Zhang <zhang.yanjuna@h3c.com>
Subject: [PATCH] devpts: update the function comments about pty driver
Date:   Wed, 9 Dec 2020 17:34:05 +0800
Message-ID: <20201209093405.28482-1-zhang.yanjuna@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0B99jcoI096985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the function comments to match the code modified by 
commit 8ead9dd54716 ("devpts: more pty driver interface cleanups")

Signed-off-by: Yanjun Zhang <zhang.yanjuna@h3c.com>
---
 drivers/tty/pty.c    |  2 ++
 drivers/tty/tty_io.c |  1 +
 fs/devpts/inode.c    | 15 +++++++--------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 23368cec7..0facf8855 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -699,6 +699,7 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
 /**
  *	ptm_unix98_lookup	-	find a pty master
  *	@driver: ptm driver
+ *	@file: file pointer to tty
  *	@idx: tty index
  *
  *	Look up a pty master device. Called under the tty_mutex for now.
@@ -715,6 +716,7 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 /**
  *	pts_unix98_lookup	-	find a pty slave
  *	@driver: pts driver
+ *	@file: file pointer to tty
  *	@idx: tty index
  *
  *	Look up a pty master device. Called under the tty_mutex for now.
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 56ade99ef..274186c86 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1145,6 +1145,7 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 /**
  *	tty_driver_lookup_tty() - find an existing tty, if any
  *	@driver: the driver for the tty
+ *	@file: file pointer to tty
  *	@idx:	 the minor number
  *
  *	Return the tty, if found. If not found, return NULL or ERR_PTR() if the
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d..2248f99d1 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -551,13 +551,12 @@ void devpts_kill_index(struct pts_fs_info *fsi, int idx)
 }
 
 /**
- * devpts_pty_new -- create a new inode in /dev/pts/
- * @ptmx_inode: inode of the master
- * @device: major+minor of the node to be created
+ * devpts_pty_new -- create a new dentry in /dev/pts/
+ * @fsi: devpts filesystem private info, sb->s_fs_info
  * @index: used as a name of the node
  * @priv: what's given back by devpts_get_priv
  *
- * The created inode is returned. Remove it from /dev/pts/ by devpts_pty_kill.
+ * The created dentry is returned. Remove it from /dev/pts/ by devpts_pty_kill.
  */
 struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 {
@@ -598,9 +597,9 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 
 /**
  * devpts_get_priv -- get private data for a slave
- * @pts_inode: inode of the slave
+ * @dentry: dentry of the slave
  *
- * Returns whatever was passed as priv in devpts_pty_new for a given inode.
+ * Returns whatever was passed as priv in devpts_pty_new for a given dentry.
  */
 void *devpts_get_priv(struct dentry *dentry)
 {
@@ -610,8 +609,8 @@ void *devpts_get_priv(struct dentry *dentry)
 }
 
 /**
- * devpts_pty_kill -- remove inode form /dev/pts/
- * @inode: inode of the slave to be removed
+ * devpts_pty_kill -- remove dentry form /dev/pts/
+ * @dentry: dentry of the slave to be removed
  *
  * This is an inverse operation of devpts_pty_new.
  */
-- 
2.17.1

