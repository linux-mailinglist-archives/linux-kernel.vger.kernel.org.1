Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C546F2F08D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbhAJRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:43:27 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:38132 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbhAJRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:43:27 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-103-122-167.net.upcbroadband.cz [89.103.122.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id AADA620A1F;
        Sun, 10 Jan 2021 17:34:53 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH v2 8/8] Move RLIMIT_NPROC check to the place where we increment the counter
Date:   Sun, 10 Jan 2021 18:33:47 +0100
Message-Id: <54b0cf752c2c275a164aa980e2d8e4e464797ca1.1610299858.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610299857.git.gladkov.alexey@gmail.com>
References: <cover.1610299857.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sun, 10 Jan 2021 17:34:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling set_user(), we always have to call commit_creds() to apply
new credentials upon the current task. There is no need to separate
limit check and counter incrementing.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 kernel/cred.c | 22 +++++++++++++++++-----
 kernel/sys.c  | 13 -------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 89a945571533..770447b4f4de 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -488,14 +488,26 @@ int commit_creds(struct cred *new)
 	if (!gid_eq(new->fsgid, old->fsgid))
 		key_fsgid_changed(new);
 
-	/* do it
-	 * RLIMIT_NPROC limits on user->processes have already been checked
-	 * in set_user().
-	 */
 	alter_cred_subscribers(new, 2);
 	if (new->user != old->user || new->user_ns != old->user_ns) {
+		bool overlimit;
+
 		set_cred_ucounts(new, new->user_ns, new->euid);
-		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
+
+		overlimit = inc_rlimit_ucounts_and_test(new->ucounts, UCOUNT_RLIMIT_NPROC,
+				1, rlimit(RLIMIT_NPROC));
+
+		/*
+		 * We don't fail in case of NPROC limit excess here because too many
+		 * poorly written programs don't check set*uid() return code, assuming
+		 * it never fails if called by root.  We may still enforce NPROC limit
+		 * for programs doing set*uid()+execve() by harmlessly deferring the
+		 * failure to the execve() stage.
+		 */
+		if (overlimit && new->user != INIT_USER)
+			current->flags |= PF_NPROC_EXCEEDED;
+		else
+			current->flags &= ~PF_NPROC_EXCEEDED;
 	}
 	rcu_assign_pointer(task->real_cred, new);
 	rcu_assign_pointer(task->cred, new);
diff --git a/kernel/sys.c b/kernel/sys.c
index c2734ab9474e..180c4e06064f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -467,19 +467,6 @@ static int set_user(struct cred *new)
 	if (!new_user)
 		return -EAGAIN;
 
-	/*
-	 * We don't fail in case of NPROC limit excess here because too many
-	 * poorly written programs don't check set*uid() return code, assuming
-	 * it never fails if called by root.  We may still enforce NPROC limit
-	 * for programs doing set*uid()+execve() by harmlessly deferring the
-	 * failure to the execve() stage.
-	 */
-	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
-			new_user != INIT_USER)
-		current->flags |= PF_NPROC_EXCEEDED;
-	else
-		current->flags &= ~PF_NPROC_EXCEEDED;
-
 	free_uid(new->user);
 	new->user = new_user;
 	return 0;
-- 
2.29.2

