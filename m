Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916192B6A50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKQQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:32:03 -0500
Received: from m12-13.163.com ([220.181.12.13]:33119 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbgKQQcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=2wc+1
        4ynyBPMiY80AQ9rvbu5MPFWr0KvJuRIyUlPey8=; b=BS80uZHRXsRMHqF+ZvzHV
        Ju73tpz+Ow0XAV3ui5sW64tYC6MDhTgvrSCPACzCq9Q56Trke4wlqU8IXca2EIjZ
        CTcKPyd2Ayd75OKB8vK50e2FqpiASOYsiu9IiKUWAqURonshW0VNmmz2c2OlDPs7
        Qpj2dRbOFDdB3ZiP9ji6Ik=
Received: from localhost (unknown [101.86.213.141])
        by smtp9 (Coremail) with SMTP id DcCowACHhQL39rNfOeHQRA--.4171S2;
        Wed, 18 Nov 2020 00:14:47 +0800 (CST)
Date:   Wed, 18 Nov 2020 00:14:47 +0800
From:   Hui Su <sh_def@163.com>
To:     tglx@linutronix.de, christian.brauner@ubuntu.com, serge@hallyn.com,
        avagin@openvz.org, 0x7f454c46@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] namespace: make timens_on_fork() return nothing
Message-ID: <20201117161447.GA44938@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowACHhQL39rNfOeHQRA--.4171S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4fGw4DXw4kJFy7GF43GFg_yoW5Zr1fpF
        4Sy3srA3y7t34jg3W8Xr4DZ34akwnYg3WUG34ku3ySya1Igr1UCFnrA3WY9r45trs2grZ3
        XFW8tws8tr1DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRKFAJUUUUU=
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJhjfX1v2fByKKwAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timens_on_fork() always return 0, and maybe not
need to judge the return value in copy_namespaces().

So make timens_on_fork() return nothing and do not
judge its return val in copy_namespaces().

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/time_namespace.h | 6 +++---
 kernel/nsproxy.c               | 7 +------
 kernel/time/namespace.c        | 6 ++----
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..74a88ce0cd3c 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -45,7 +45,7 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct kref *kref);
-int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
 
 static inline void put_time_ns(struct time_namespace *ns)
@@ -122,10 +122,10 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 	return old_ns;
 }
 
-static inline int timens_on_fork(struct nsproxy *nsproxy,
+static inline void timens_on_fork(struct nsproxy *nsproxy,
 				 struct task_struct *tsk)
 {
-	return 0;
+	return;
 }
 
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 12dd41b39a7f..e2e6c5dc433f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -153,7 +153,6 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
-	int ret;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
@@ -180,11 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
-	ret = timens_on_fork(new_ns, tsk);
-	if (ret) {
-		free_nsproxy(new_ns);
-		return ret;
-	}
+	timens_on_fork(new_ns, tsk);
 
 	tsk->nsproxy = new_ns;
 	return 0;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index afc65e6be33e..e0f9509b17c3 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -308,22 +308,20 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 	return 0;
 }
 
-int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
-		return 0;
+		return;
 
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
 
 	timens_commit(tsk, ns);
-
-	return 0;
 }
 
 static struct user_namespace *timens_owner(struct ns_common *ns)
-- 
2.29.0


