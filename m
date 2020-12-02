Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E32CC036
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgLBO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgLBO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:59:44 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750EC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:59:04 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so1274339plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G4sCzg9feiGKCRZF2M8EYklEFXuMpffsPhjXjlGSQQ=;
        b=FQUBtODa7eP4ejGOu6/ZsvTuztMXm50XP4vLgoV2LmsomyV6kqT/IA9/ZvjE8GU2a7
         YIlP5dOC7kK1HZmNG3ksRmbVvCMmxNtC6gkZ4vGWfO0U4Xpk6K9ma7hAIoVYw7Mv9cYI
         zHzpIvJr6HZyhkR9ZkBBRee1b57h1gm92gAKDVVc5xAXKptqW3KYVmUayLTewGpEeAJU
         2M6QAnocUT/1fhGpRnj6Y7la5iiZDePTKdLZx/QHLMALctfhe709FagNuCLXS4rLd1Gx
         9RYS78mI/pzVy54IrX54rsEtxinf5wKWe9+t/4KJE9zubWMDTgKe6fMuta8P77/0U53i
         ai7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G4sCzg9feiGKCRZF2M8EYklEFXuMpffsPhjXjlGSQQ=;
        b=LqPnbf929Btwog7tXgjkrIHNjoXu+XpIjtSLbw6cVEvAzN/QmBb2I38pfe879AR0MM
         3+B3f1aXW+/rd9Vq1+S2BDKANsw9LaLrip1sujfvaWwLBxu44XWDa/SdeAuG8keIfBhZ
         gk8vJqhqCc3r7XzFTXw3LFoWvmBmChOV5aVXhhHmCnCZY4hSy/X0TjMZ2a5dpwPKbg6l
         LnHN4z4+2kLexKGYWmBh1xyPcgIoxaNSgP0Yxe1hXRZw5PjpZN9rZsk+8C8YiE3HigIe
         7cE5g45H2aCLP+ldlGlPLrn6Veq84dOxl/XB6lO0BCckxsD8qo8tM1HEVkQ0CE5V7fS4
         F3JQ==
X-Gm-Message-State: AOAM530erissJpm/cYhvPMoAkFe6igvpl3p1ZLxyP1WcLKWoX7ZHucR/
        FTYgkTEwsviJTohkFMm9k8Y=
X-Google-Smtp-Source: ABdhPJxYtTDznyv/INjFA+wDDxMs5Em0CoJWXvQYVG7GqkYcZbOov5fpZLt4AfRaMKL38Z+ZGakK6w==
X-Received: by 2002:a17:902:6b4a:b029:d8:d13d:14f with SMTP id g10-20020a1709026b4ab02900d8d13d014fmr2946758plt.24.1606921144246;
        Wed, 02 Dec 2020 06:59:04 -0800 (PST)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fee1:602f])
        by smtp.gmail.com with ESMTPSA id j11sm146826pfe.26.2020.12.02.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:59:03 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernfs: replace the mutex in kernfs_iop_permission with a rwlock
Date:   Wed,  2 Dec 2020 22:58:36 +0800
Message-Id: <20201202145837.48040-2-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202145837.48040-1-foxhlchen@gmail.com>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A big global mutex in kernfs_iop_permission will significanly drag
system performance when processes concurrently open files
on kernfs in Big machines(with >= 16 cpu cores).

This patch replace the big mutex with a rwlock specifically for
protecting kernfs_node->iattribute. So that kernfs_iop_permission
can perform concurrently.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/kernfs/inode.c      | 16 ++++++++--------
 include/linux/kernfs.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..c8c2ea669e6d 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -106,9 +106,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	write_lock(&kn->iattr_rwlock);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	write_unlock(&kn->iattr_rwlock);
 	return ret;
 }
 
@@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	write_lock(&kn->iattr_rwlock);
 	error = setattr_prepare(dentry, iattr);
 	if (error)
 		goto out;
@@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	write_unlock(&kn->iattr_rwlock);
 	return error;
 }
 
@@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	read_lock(&kn->iattr_rwlock);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	read_unlock(&kn->iattr_rwlock);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	read_lock(&kn->iattr_rwlock);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	read_unlock(&kn->iattr_rwlock);
 
 	return generic_permission(inode, mask);
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..545cdb39b34b 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -156,6 +156,7 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+	rwlock_t		iattr_rwlock;
 };
 
 /*
-- 
2.29.2

