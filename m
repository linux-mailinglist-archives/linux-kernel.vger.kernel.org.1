Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0202010F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405079AbgFSPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 11:36:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405067AbgFSPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:36:26 -0400
Received: from ip-109-41-0-196.web.vodafone.de ([109.41.0.196] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jmJ44-0000bE-6M; Fri, 19 Jun 2020 15:36:24 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/3] timens: add timens_commit() helper
Date:   Fri, 19 Jun 2020 17:35:58 +0200
Message-Id: <20200619153559.724863-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619153559.724863-1-christian.brauner@ubuntu.com>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the calls to timens_set_vvar_page() and vdso_join_timens() in
timens_on_fork() and timens_install() in a new timens_commit() helper.
We'll use this helper in a follow-up patch in nsproxy too.

Cc: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/time/namespace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e5af6fe87af8..aa7b90aac2a7 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -280,6 +280,12 @@ static void timens_put(struct ns_common *ns)
 	put_time_ns(to_time_ns(ns));
 }
 
+static void timens_commit(struct task_struct *tsk, struct time_namespace *ns)
+{
+	timens_set_vvar_page(tsk, ns);
+	vdso_join_timens(tsk, ns);
+}
+
 static int timens_install(struct nsset *nsset, struct ns_common *new)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
@@ -292,9 +298,8 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	timens_set_vvar_page(current, ns);
 
-	vdso_join_timens(current, ns);
+	timens_commit(current, ns);
 
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -315,14 +320,12 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
-	timens_set_vvar_page(tsk, ns);
-
-	vdso_join_timens(tsk, ns);
-
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
 
+	timens_commit(tsk, ns);
+
 	return 0;
 }
 
-- 
2.27.0

