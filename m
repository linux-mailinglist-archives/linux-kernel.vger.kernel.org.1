Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBF23A2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHCKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 06:16:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:37954 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:57 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XWE-0002OV-It; Mon, 03 Aug 2020 13:16:34 +0300
Subject: [PATCH 7/8] cgroup: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:50 +0300
Message-ID: <159644980994.604812.383801057081594972.stgit@localhost.localdomain>
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

Convert cgroup namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/cgroup.h    |    5 ++---
 kernel/cgroup/cgroup.c    |    2 +-
 kernel/cgroup/namespace.c |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 618838c48313..451c2d26a5db 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -854,7 +854,6 @@ static inline void cgroup_sk_free(struct sock_cgroup_data *skcd) {}
 #endif	/* CONFIG_CGROUP_DATA */
 
 struct cgroup_namespace {
-	refcount_t		count;
 	struct ns_common	ns;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
@@ -889,12 +888,12 @@ copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
 static inline void get_cgroup_ns(struct cgroup_namespace *ns)
 {
 	if (ns)
-		refcount_inc(&ns->count);
+		refcount_inc(&ns->ns.count);
 }
 
 static inline void put_cgroup_ns(struct cgroup_namespace *ns)
 {
-	if (ns && refcount_dec_and_test(&ns->count))
+	if (ns && refcount_dec_and_test(&ns->ns.count))
 		free_cgroup_ns(ns);
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..22e466926853 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -199,7 +199,7 @@ static u16 have_canfork_callback __read_mostly;
 
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
-	.count		= REFCOUNT_INIT(2),
+	.ns.count	= REFCOUNT_INIT(2),
 	.user_ns	= &init_user_ns,
 	.ns.ops		= &cgroupns_operations,
 	.ns.inum	= PROC_CGROUP_INIT_INO,
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 812a61afd538..f5e8828c109c 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -32,7 +32,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 		kfree(new_ns);
 		return ERR_PTR(ret);
 	}
-	refcount_set(&new_ns->count, 1);
+	refcount_set(&new_ns->ns.count, 1);
 	new_ns->ns.ops = &cgroupns_operations;
 	return new_ns;
 }


