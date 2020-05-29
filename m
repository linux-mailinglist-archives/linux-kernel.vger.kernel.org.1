Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53F1E7734
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgE2HlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:41:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40738 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgE2HlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id v2so878313pfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gyi+SSBMYaz8TR5pIeizC0x+opRDWqonQ2PbJtJFBcU=;
        b=KG7rTz2BiLaYCPoyuQw4Y1EMmPJcbXAZAIjnWo3iPGcl8gA55Y4WE2x5iJQ9duOMi3
         s6YSMwAVWItTTv8jISVFiAsUNnBUExibNzJ7pgf9yeh5hHueaf6cbM25tX2nV93KFpFr
         AWeTZ6AkSGtxX0CMtveuZSdw/U5qGO5U/coWIdtmafZXzwiCdc5LAuEwD3byQ3as66Xj
         ttvAk2pCGvYzvSGjkwGWXBpYxRtcSzBemCY1CwAjKSwzAPWyeUOqSuMMel+7blYVttEg
         r25R34F0oxLwyXgrLUdtdmcGB+kOD7RsO/i4ykHM82fliCODNivy8AhaKaWs9Dh7qT5e
         25fQ==
X-Gm-Message-State: AOAM531Tq5MZYF8XLRFlqmsDGekicIIh8bBFD7TxshzwMY5pWikYZYVH
        J2AKGeBNcFyiRNNh34PY+Vo=
X-Google-Smtp-Source: ABdhPJx56643L02wDwth5rceoeGJdrDM09GlBME9Pg+5yDtZkMeY7H83kJ7EluZRQYSUUOaPNTyILA==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr7400994pfp.265.1590738079523;
        Fri, 29 May 2020 00:41:19 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s63sm7735409pjj.16.2020.05.29.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3A3042349; Fri, 29 May 2020 07:41:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/13] inotify: simplify sysctl declaration with register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:03 +0000
Message-Id: <20200529074108.16928-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

move inotify_user sysctl to inotify_user.c and use the new
register_sysctl_subdir() helper.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/notify/inotify/inotify_user.c | 11 ++++++++++-
 include/linux/inotify.h          |  3 ---
 kernel/sysctl.c                  | 11 -----------
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index f88bbcc9efeb..64859fbf8463 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -46,7 +46,7 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 #include <linux/sysctl.h>
 
-struct ctl_table inotify_table[] = {
+static struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
 		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
@@ -73,6 +73,14 @@ struct ctl_table inotify_table[] = {
 	},
 	{ }
 };
+
+static void __init inotify_sysctls_init(void)
+{
+	register_sysctl_subdir("fs", "inotify", inotify_table);
+}
+
+#else
+#define inotify_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
 static inline __u32 inotify_arg_to_mask(u32 arg)
@@ -826,6 +834,7 @@ static int __init inotify_user_setup(void)
 	inotify_max_queued_events = 16384;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
+	inotify_sysctls_init();
 
 	return 0;
 }
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 6a24905f6e1e..8d20caa1b268 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -7,11 +7,8 @@
 #ifndef _LINUX_INOTIFY_H
 #define _LINUX_INOTIFY_H
 
-#include <linux/sysctl.h>
 #include <uapi/linux/inotify.h>
 
-extern struct ctl_table inotify_table[]; /* for sysctl */
-
 #define ALL_INOTIFY_BITS (IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
 			  IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
 			  IN_MOVED_TO | IN_CREATE | IN_DELETE | \
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 04ff032f2863..30c2d521502a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -123,10 +123,6 @@ static const int maxolduid = 65535;
 static int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
-#ifdef CONFIG_INOTIFY_USER
-#include <linux/inotify.h>
-#endif
-
 #ifdef CONFIG_PROC_SYSCTL
 
 /**
@@ -3012,13 +3008,6 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_INOTIFY_USER
-	{
-		.procname	= "inotify",
-		.mode		= 0555,
-		.child		= inotify_table,
-	},
-#endif	
 #ifdef CONFIG_EPOLL
 	{
 		.procname	= "epoll",
-- 
2.26.2

