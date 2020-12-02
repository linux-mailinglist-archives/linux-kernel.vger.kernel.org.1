Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3532CC037
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLBO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbgLBO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:59:46 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220BDC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:59:06 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b12so1123667pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxSjm0C0NDnoL/IIQUuyyVYhh2eEiAQbNE93rX86LYI=;
        b=vf14kW9xFVfvlhi7cxHDY1TfyzCLQFFlxSWSLtDtQq21FIqmn02N5trKWTrbMWawew
         nOinpppX932gtotkEoQZehYpDIOnaTP+AzlfI7ZAKDnYBsEW1fl/sluC7B/+YMEaSstz
         7w737umIU8NP63VPOfXUGqSctTQfaUenppFcY6h4Qxqr8bpQVrlRYmbIl+ftPf5Ru7AK
         BB3dVQJdRWsR/ryATnSc8QXyovJQ8IVh+BWZiRCdZ0y1xGKxcaJ/x3bE7pkOniFt5kIw
         ZYdu4xkCOdK/ERL5lO6BjXDoz66hXuurCfl3E6DrEz+87H2IFlI1MumROkkwlPEuVNd3
         qGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxSjm0C0NDnoL/IIQUuyyVYhh2eEiAQbNE93rX86LYI=;
        b=nP5RpFvteNg3NpjCNPPfO/udm0FrGwYwf8G2o4wd36fW95dOUGL6nGZxAYhRTdHdLq
         1+douzkCynOQCZpzu/ER/g7Uy5n6bPuJU54jEdTO11C+t612/fA2x3g8GN4VPobiWaMk
         eY4+rkbuR6y6uDWlTXxkZo2WUC6uk+Z28//myeSPWXPlNlFhU1g9llomwyK0rtq3oNax
         et9w2pYoey/OyTu+oxouUQhbbXesQbXKpvdQeQ4uexaL75IfKUTQG3LszCmQKbGvFO7z
         cQa2zi4MR4i8sBDrqtyzYdTkA6kMNi4t2VB/oTuPwH2y1uoBLO4l4n91Tv0e8Wtygefh
         Krjg==
X-Gm-Message-State: AOAM530Qu+py7JCnGufGkrgxep2k3bS+svkdXLHm53tWQzzriZte+VZe
        B3LGfoh5i8hdwt24Yh15jEc=
X-Google-Smtp-Source: ABdhPJzGEO9yrFsha9fbs6byBMkVoAH876bUsIFihNS4WBRN6i+Sx/IJfIbdExRnx5LkS3bHHRkp/Q==
X-Received: by 2002:a17:90a:9f8e:: with SMTP id o14mr241919pjp.89.1606921145604;
        Wed, 02 Dec 2020 06:59:05 -0800 (PST)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fee1:602f])
        by smtp.gmail.com with ESMTPSA id j11sm146826pfe.26.2020.12.02.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:59:04 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernfs: remove mutex in kernfs_dop_revalidate
Date:   Wed,  2 Dec 2020 22:58:37 +0800
Message-Id: <20201202145837.48040-3-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202145837.48040-1-foxhlchen@gmail.com>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a big mutex in kernfs_dop_revalidate which slows down the
concurrent performance of kernfs.

Since kernfs_dop_revalidate only does some checks, the lock is
largely unnecessary. Also, according to kernel filesystem locking
document:
https://www.kernel.org/doc/html/latest/filesystems/locking.html
locking is not in the protocal for d_revalidate operation.

This patch remove this mutex from
kernfs_dop_revalidate, so kernfs_dop_revalidate
can run concurrently.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/kernfs/dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..c2267c93f546 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_mutex);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -557,10 +556,9 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/* Always perform fresh lookup for negatives */
 	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
+		goto out_bad;
 
 	kn = kernfs_dentry_node(dentry);
-	mutex_lock(&kernfs_mutex);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -579,11 +577,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	mutex_unlock(&kernfs_mutex);
 	return 1;
 out_bad:
-	mutex_unlock(&kernfs_mutex);
-out_bad_unlocked:
 	return 0;
 }
 
@@ -650,6 +645,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->mode = mode;
 	kn->flags = flags;
 
+	rwlock_init(&kn->iattr_rwlock);
+
 	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
 		struct iattr iattr = {
 			.ia_valid = ATTR_UID | ATTR_GID,
-- 
2.29.2

