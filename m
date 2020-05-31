Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425531E975B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEaLwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 07:52:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgEaLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:52:14 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jfMVe-0006jt-NC; Sun, 31 May 2020 11:52:10 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 1/4] seccomp: rename "usage" to "refs" and document
Date:   Sun, 31 May 2020 13:50:28 +0200
Message-Id: <20200531115031.391515-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming the lifetime counter of a seccomp filter "usage" suggests a
little too strongly that its about tasks that are using this filter
while it also tracks other references such as the user notifier or
ptrace. This also updates the documentation to note this fact.

We'll be introducing an actual usage counter in a follow-up patch.

Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matt Denton <mpdenton@google.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Jann Horn <jannh@google.com>
Cc: Chris Palmer <palmer@google.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Robert Sesek <rsesek@google.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch introduced
---
 kernel/seccomp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..0ba2d6d0800f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -106,10 +106,11 @@ struct notification {
 /**
  * struct seccomp_filter - container for seccomp BPF programs
  *
- * @usage: reference count to manage the object lifetime.
- *         get/put helpers should be used when accessing an instance
- *         outside of a lifetime-guarded section.  In general, this
- *         is only needed for handling filters shared across tasks.
+ * @refs: Reference count to manage the object lifetime.
+ *	  A filter's reference count is incremented for each directly
+ *	  attached task, once for the dependent filter, and if
+ *	  requested for the user notifier. When @refs reaches zero,
+ *	  the filter can be freed.
  * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
@@ -124,10 +125,10 @@ struct notification {
  * how namespaces work.
  *
  * seccomp_filter objects should never be modified after being attached
- * to a task_struct (other than @usage).
+ * to a task_struct (other than @refs).
  */
 struct seccomp_filter {
-	refcount_t usage;
+	refcount_t refs;
 	bool log;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
@@ -461,7 +462,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 		return ERR_PTR(ret);
 	}
 
-	refcount_set(&sfilter->usage, 1);
+	refcount_set(&sfilter->refs, 1);
 
 	return sfilter;
 }
@@ -554,7 +555,7 @@ static long seccomp_attach_filter(unsigned int flags,
 
 static void __get_seccomp_filter(struct seccomp_filter *filter)
 {
-	refcount_inc(&filter->usage);
+	refcount_inc(&filter->refs);
 }
 
 /* get_seccomp_filter - increments the reference count of the filter on @tsk */
@@ -577,7 +578,7 @@ static inline void seccomp_filter_free(struct seccomp_filter *filter)
 static void __put_seccomp_filter(struct seccomp_filter *orig)
 {
 	/* Clean up single-reference branches iteratively. */
-	while (orig && refcount_dec_and_test(&orig->usage)) {
+	while (orig && refcount_dec_and_test(&orig->refs)) {
 		struct seccomp_filter *freeme = orig;
 		orig = orig->prev;
 		seccomp_filter_free(freeme);

base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
-- 
2.26.2

