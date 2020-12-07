Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797C92D0BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgLGIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLGIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:44:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B27C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:43:49 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c79so9131347pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUrY6PA5YZSoMpiO4ZcFeaOOCMSIy5vWzW/UBZ3r8Lk=;
        b=YkeUkCzfavBjthDz3VRnW/5DQtFsXeHyzurairm4rS14AFY+FmimRjb74NgSRsaEff
         JsHdPXkWA0CbXS/d2SzqN1+WjCBd84juiI82tKt75WIBirqlWICHEL2jPcAcnm4VqYJS
         +DVIrMLZSMXlwrwZ65qR8dz/6fC/tw6tpd8MuiW3zLFVx/5R3R6qOLaA09XZVRZhvzRd
         S1tW3Yue78UjJTenu9hh1meRYV9R4i7pwvClglxzYr2uqOAP/NjJ1gM9Z/dl0ifQiWKz
         Kfm4IRdOJJ8RBrwlohXE3uhZ1hcMRU7gtaxInOVbIH9haNa+r0bqxF1WxyTQOwFTlV7C
         2cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUrY6PA5YZSoMpiO4ZcFeaOOCMSIy5vWzW/UBZ3r8Lk=;
        b=ADi/AvUmNtKChEpBJoZ/S8r7Mq4xXrrlbdrTbQw0dUnPJHUk0tpkzM9FRwEFyu43hZ
         e6WzLXvElvKoArBmHe66fFif9x/jarp41BgTb7X0a1NoUZNlNG+5C8hmwi7bNM3X3hgG
         bN31VzVokPklin49+YRTx0IzDztKlGgppi0g1HyNmtG9ogFyT4XJMSF0k9NPmauIXpsC
         T6qRst99fpn+y+IVNt+Rlme60nyYtHPGh09oy74JbYh4nOKQqSdDoNgsSshQL+ZMQcpQ
         RgP5Xh0cJO12wfQGySLUNQRfOs9IU/ZBlH1asYbRGnBOVymUdTakDAzUDoWMWtAM97on
         eKwA==
X-Gm-Message-State: AOAM53291Dam7CzGKFphgPTplSeY/sNw80IBb4R3oy0GlOAPWyQQEmjB
        rTWLMkpvDIvA7V/KWe7meniibykIrMeIpqYA
X-Google-Smtp-Source: ABdhPJzZftDwqpvGvqMVCjhLBxEESAksVuJ6odEjtLAI+TzfRf+ptlf4Rc0uqbDijR7LaOqj6KSo0Q==
X-Received: by 2002:a63:f308:: with SMTP id l8mr17880756pgh.68.1607330629508;
        Mon, 07 Dec 2020 00:43:49 -0800 (PST)
Received: from localhost.localdomain (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id z9sm9949833pji.48.2020.12.07.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:43:48 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] kernfs: replace the mutex in kernfs_iop_permission with a rwlock
Date:   Mon,  7 Dec 2020 08:43:33 +0000
Message-Id: <20201207084333.179132-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A big global mutex in kernfs_iop_permission will significanly drag
system performance when processes concurrently open files
on kernfs in Big machines(with >= 16 cpu cores).

This patch replace the big mutex with a global rwsem lock.
So that kernfs_iop_permission can perform concurrently.

In a 96-core AMD EPYC ROME server, I can observe 50% boost on
a open+read+close cycle when I call open+read+close one thread per
core concurrently 1000 times after applying the patch.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/kernfs/inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..ea65da176cfa 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -14,9 +14,12 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/security.h>
+#include <linux/rwsem.h>
 
 #include "kernfs-internal.h"
 
+static DECLARE_RWSEM(kernfs_iattr_rwsem);
+
 static const struct address_space_operations kernfs_aops = {
 	.readpage	= simple_readpage,
 	.write_begin	= simple_write_begin,
@@ -106,9 +109,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_iattr_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_iattr_rwsem);
 	return ret;
 }
 
@@ -121,7 +124,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_iattr_rwsem);
 	error = setattr_prepare(dentry, iattr);
 	if (error)
 		goto out;
@@ -134,7 +137,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_iattr_rwsem);
 	return error;
 }
 
@@ -189,9 +192,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_iattr_rwsem);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +284,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_iattr_rwsem);
 
 	return generic_permission(inode, mask);
 }
-- 
2.29.2



Differences from V1:

* Use rwsem instead of rwlock so we can	sleep when kernfs_iattrs calls
  GFP_KERNEL type memory allocation.

* Use a	global lock instead of a per-node lock to reduce memory
  consumption.


It's still slow, a open+read+close cycle spends ~260us compared to ~3us of single
thread one. After applying this, the mutex in kernfs_dop_revalidate becomes the top time-consuming
operation on concurrent open+read+close. However That's harder to solve than this one
and it's near the merge window and holiday season, I don't want to add up work load to
you guys during that time so I decided to turn in this separately. Hopefully, I can bring in
kernfs_dop_revalidate patch after holiday.

And hope this patch can help.


thanks,
fox
