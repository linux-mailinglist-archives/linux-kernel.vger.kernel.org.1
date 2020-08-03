Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0A23A2A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHCKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 06:16:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:37816 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:35 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVr-0002Nw-Oz; Mon, 03 Aug 2020 13:16:11 +0300
Subject: [PATCH 4/8] pid: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:32 +0300
Message-ID: <159644979226.604812.7512601754841882036.stgit@localhost.localdomain>
In-Reply-To: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pid namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/pid_namespace.h |    4 +---
 kernel/pid.c                  |    2 +-
 kernel/pid_namespace.c        |   13 +++----------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 5a5cb45ac57e..7c7e627503d2 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -8,7 +8,6 @@
 #include <linux/workqueue.h>
 #include <linux/threads.h>
 #include <linux/nsproxy.h>
-#include <linux/kref.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 
@@ -18,7 +17,6 @@
 struct fs_pin;
 
 struct pid_namespace {
-	struct kref kref;
 	struct idr idr;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
@@ -43,7 +41,7 @@ extern struct pid_namespace init_pid_ns;
 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
 	if (ns != &init_pid_ns)
-		kref_get(&ns->kref);
+		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index de9d29c41d77..3b9e67736ef4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -72,7 +72,7 @@ int pid_max_max = PID_MAX_LIMIT;
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
-	.kref = KREF_INIT(2),
+	.ns.count = REFCOUNT_INIT(2),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0e5ac162c3a8..d02dc1696edf 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -102,7 +102,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 		goto out_free_idr;
 	ns->ns.ops = &pidns_operations;
 
-	kref_init(&ns->kref);
+	refcount_set(&ns->ns.count, 1);
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);
@@ -148,22 +148,15 @@ struct pid_namespace *copy_pid_ns(unsigned long flags,
 	return create_pid_namespace(user_ns, old_ns);
 }
 
-static void free_pid_ns(struct kref *kref)
-{
-	struct pid_namespace *ns;
-
-	ns = container_of(kref, struct pid_namespace, kref);
-	destroy_pid_namespace(ns);
-}
-
 void put_pid_ns(struct pid_namespace *ns)
 {
 	struct pid_namespace *parent;
 
 	while (ns != &init_pid_ns) {
 		parent = ns->parent;
-		if (!kref_put(&ns->kref, free_pid_ns))
+		if (!refcount_dec_and_test(&ns->ns.count))
 			break;
+		destroy_pid_namespace(ns);
 		ns = parent;
 	}
 }


