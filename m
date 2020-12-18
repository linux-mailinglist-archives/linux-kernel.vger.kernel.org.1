Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0382DEB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLRWMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLRWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:12:21 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D9C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 14:11:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w4so2504513pgc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 14:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ck3u6765XFN6FEFO3ZLOomPeqc28tVcEC8hXVCjWIsU=;
        b=D3qUkt/XxACOSQfBp6GvcJgUu44+k4VDlZtcicB6IZpzGs192mj4Z0wlh5YHSNDo1I
         lv4mSoLCfIjgNqY1jPV0rXIT0oA9GrkYVxgAmLRhaiAzi/NU2ZT3h6vPOUgwzJYYQzVx
         JBUYbt8fe1XAAVJMWMK5pLAaz/WEl/dlRGD0n/VHCb/FIK9K6jRsHmvrgXrd2LsxVCT1
         56C06pDtgj+NAPoulNO89lItMaLVROzlfzeu3QqcdoKO8E2ctU3Sw3Sm8HEtKW1le0Zg
         U+K1ZYjqMa56rkjBKxCR0eQIic0vZmwzgsWj7dBdrywFptMMxZUQUlotqRop3ePi8/hT
         UKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ck3u6765XFN6FEFO3ZLOomPeqc28tVcEC8hXVCjWIsU=;
        b=rYp2WprWUEr4pDmqXycUD9+IfBqItMtiHT+XdrhAyfSoTFMXsG83jUhT9gW7fhI3fI
         ie99e13XDUw3o4e8KA23XkyjV4/KmscAZIs5pfPqLSmsLvTk1/vKr5BkGRlW2N5Qsyk5
         zdloOWDD/sQhN/uxWyfLvNMkGpdqf5kq6V+X/zl6yj2XpktsxgYUVc93aoFO5P6il+og
         MbX6j49wyItMIWBKPNFaTb2hQSo518knQvrTe8xII9F7H7Vh0q1LuAmcJfkMHRybepDP
         Lv6iEQRJZLZpTWjHNUT9dlsebN62R+j79Mr5Lp7KGODdv6FlkGqjeaBEiShoNbO/+HT7
         MCDQ==
X-Gm-Message-State: AOAM530vtUSVFa66sMaN4Iqx/bMpLPJ/QE+VIqnIBFI93O0y0l1ynTpL
        GkgUP9L9OZGEMdvSk+L0ClsSvfM3wl03WA==
X-Google-Smtp-Source: ABdhPJxcawrmjBI4cERswBp9ZQTcRZEHQ6XSM4I6r7NG/a793QUW6RV6LjbfqEK/+361A+gQA6Ay7ei1KZxbzA==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a17:90a:3e05:: with SMTP id j5mr6215501pjc.91.1608329500851;
 Fri, 18 Dec 2020 14:11:40 -0800 (PST)
Date:   Fri, 18 Dec 2020 14:11:29 -0800
Message-Id: <20201218221129.851003-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] inotify, memcg: account inotify instances to kmemcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the fs sysctl inotify/max_user_instances is used to limit the
number of inotify instances on the system. For systems running multiple
workloads, the per-user namespace sysctl max_inotify_instances can be
used to further partition inotify instances. However there is no easy
way to set a sensible system level max limit on inotify instances and
further partition it between the workloads. It is much easier to charge
the underlying resource (i.e. memory) behind the inotify instances to
the memcg of the workload and let their memory limits limit the number
of inotify instances they can create.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/notify/group.c                | 14 ++++++++++++--
 fs/notify/inotify/inotify_user.c |  5 +++--
 include/linux/fsnotify_backend.h |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/notify/group.c b/fs/notify/group.c
index a4a4b1c64d32..fab3cfdb4d9e 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -114,11 +114,12 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
  */
-struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+struct fsnotify_group *fsnotify_alloc_group_gfp(const struct fsnotify_ops *ops,
+						gfp_t gfp)
 {
 	struct fsnotify_group *group;
 
-	group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
+	group = kzalloc(sizeof(struct fsnotify_group), gfp);
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
@@ -139,6 +140,15 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(fsnotify_alloc_group_gfp);
+
+/*
+ * Create a new fsnotify_group and hold a reference for the group returned.
+ */
+struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+{
+	return fsnotify_alloc_group_gfp(ops, GFP_KERNEL);
+}
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 int fsnotify_fasync(int fd, struct file *file, int on)
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 59c177011a0f..7cb528c6154c 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -632,11 +632,12 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct fsnotify_group *group;
 	struct inotify_event_info *oevent;
 
-	group = fsnotify_alloc_group(&inotify_fsnotify_ops);
+	group = fsnotify_alloc_group_gfp(&inotify_fsnotify_ops,
+					 GFP_KERNEL_ACCOUNT);
 	if (IS_ERR(group))
 		return group;
 
-	oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
+	oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!oevent)) {
 		fsnotify_destroy_group(group);
 		return ERR_PTR(-ENOMEM);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a2e42d3cd87c..a0138267f547 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -470,6 +470,8 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 
 /* create a new group */
 extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
+extern struct fsnotify_group *fsnotify_alloc_group_gfp(const struct fsnotify_ops *ops,
+						       gfp_t gfp);
 /* get reference to a group */
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
-- 
2.29.2.684.gfbc64c5ab5-goog

