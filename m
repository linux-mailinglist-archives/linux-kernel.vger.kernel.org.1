Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B9293790
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392402AbgJTJGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:06:19 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55547 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392386AbgJTJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184777; x=1634720777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0qgIN6PF8Vlxz+c85tX82vt0ceuyz9cGcJXK98L27/c=;
  b=s/STfepzh66xjWxbDOSW9jP2kwtVQzq5z0hpMhsIp1y8WQ46jqHcYELw
   EpuT/d0g2/uHcDvcmKIFEHphb/Skg+qaMGw0TZ9Yyob1uDFvrh9f4Xs4E
   Zjj4hwdniZWe19g3XIvXR4CHdEYT9bRzM1Ajr8ZxqXmdpJlCD8Chv8PrU
   w=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="86290213"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Oct 2020 09:06:16 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 1CFC2222DF9;
        Tue, 20 Oct 2020 09:06:14 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:05:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v22 13/18] mm/damon/dbgfs: Support multiple contexts
Date:   Tue, 20 Oct 2020 10:59:35 +0200
Message-ID: <20201020085940.13875-14-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020085940.13875-1-sjpark@amazon.com>
References: <20201020085940.13875-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

In some use cases, users would want to run multiple monitoring context.
For example, if a user wants a high precision monitoring and dedicating
multiple CPUs for the job is ok, because DAMON creates one monitoring
thread per one context, the user can split the monitoring target regions
into multiple small regions and create one context for each region.  Or,
someone might want to simultaneously monitor different address spaces,
e.g., both virtual address space and physical address space.

The DAMON's API allows such usage, but 'damon-dbgfs' does not.
Therefore, only kernel space DAMON users can do multiple contexts
monitoring.

This commit allows the user space DAMON users to use multiple contexts
monitoring by introducing two new 'damon-dbgfs' debugfs files,
'mk_context' and 'rm_context'.  Users can create a new monitoring
context by writing the desired name of the new context to 'mk_context'.
Then, a new directory with the name and having the files for setting of
the context ('attrs', 'target_ids' and 'record') will be created under
the debugfs directory.  Writing the name of the context to remove to
'rm_context' will remove the related context and directory.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 211 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 94ed2eca2510..2c9e9e05adca 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -434,7 +434,7 @@ static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 	const char * const file_names[] = {"attrs", "record", "target_ids",
 		"kdamond_pid"};
 	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&target_ids_fops}, &kdamond_pid_fops;
+		&target_ids_fops, &kdamond_pid_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
@@ -506,6 +506,13 @@ static void dbgfs_write_record_header(struct damon_ctx *ctx)
 	dbgfs_write_rbuf(ctx, &recfmt_ver, sizeof(recfmt_ver));
 }
 
+static void dbgfs_free_recorder(struct dbgfs_recorder *recorder)
+{
+	kfree(recorder->rbuf);
+	kfree(recorder->rfile_path);
+	kfree(recorder);
+}
+
 static unsigned int nr_damon_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
@@ -599,6 +606,195 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	return ctx;
 }
 
+static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
+{
+	dbgfs_free_recorder(ctx->callback.private);
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Make a context of @name and create a debugfs directory for it.
+ *
+ * This function should be called while holding damon_dbgfs_lock.
+ *
+ * Returns 0 on success, negative error code otherwise.
+ */
+static int dbgfs_mk_context(char *name)
+{
+	struct dentry *root, **new_dirs, *new_dir;
+	struct damon_ctx **new_ctxs, *new_ctx;
+	int err;
+
+	if (damon_nr_running_ctxs())
+		return -EBUSY;
+
+	new_ctxs = krealloc(dbgfs_ctxs, sizeof(*dbgfs_ctxs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_ctxs)
+		return -ENOMEM;
+
+	new_dirs = krealloc(dbgfs_dirs, sizeof(*dbgfs_dirs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_dirs) {
+		kfree(new_ctxs);
+		return -ENOMEM;
+	}
+
+	dbgfs_ctxs = new_ctxs;
+	dbgfs_dirs = new_dirs;
+
+	root = dbgfs_dirs[0];
+	if (!root)
+		return -ENOENT;
+
+	new_dir = debugfs_create_dir(name, root);
+	if (IS_ERR(new_dir))
+		return PTR_ERR(new_dir);
+	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
+
+	new_ctx = dbgfs_new_ctx();
+	if (!new_ctx) {
+		debugfs_remove(new_dir);
+		dbgfs_dirs[dbgfs_nr_ctxs] = NULL;
+		return -ENOMEM;
+	}
+	dbgfs_ctxs[dbgfs_nr_ctxs] = new_ctx;
+
+	err = dbgfs_fill_ctx_dir(dbgfs_dirs[dbgfs_nr_ctxs],
+			dbgfs_ctxs[dbgfs_nr_ctxs]);
+	if (err)
+		return err;
+
+	dbgfs_nr_ctxs++;
+	return 0;
+}
+
+static ssize_t dbgfs_mk_context_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	char *ctx_name;
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+	ctx_name = kmalloc(count + 1, GFP_KERNEL);
+	if (!ctx_name) {
+		kfree(kbuf);
+		return -ENOMEM;
+	}
+
+	/* Trim white space */
+	if (sscanf(kbuf, "%s", ctx_name) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&damon_dbgfs_lock);
+	err = dbgfs_mk_context(ctx_name);
+	if (err)
+		ret = err;
+	mutex_unlock(&damon_dbgfs_lock);
+
+out:
+	kfree(kbuf);
+	kfree(ctx_name);
+	return ret;
+}
+
+/*
+ * Remove a context of @name and its debugfs directory.
+ *
+ * This function should be called while holding damon_dbgfs_lock.
+ *
+ * Return 0 on success, negative error code otherwise.
+ */
+static int dbgfs_rm_context(char *name)
+{
+	struct dentry *root, *dir, **new_dirs;
+	struct damon_ctx **new_ctxs;
+	int i, j;
+
+	if (damon_nr_running_ctxs())
+		return -EBUSY;
+
+	root = dbgfs_dirs[0];
+	if (!root)
+		return -ENOENT;
+
+	dir = debugfs_lookup(name, root);
+	if (!dir)
+		return -ENOENT;
+
+	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
+			GFP_KERNEL);
+	if (!new_dirs)
+		return -ENOMEM;
+
+	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
+			GFP_KERNEL);
+	if (!new_ctxs) {
+		kfree(new_dirs);
+		return -ENOMEM;
+	}
+
+	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
+		if (dbgfs_dirs[i] == dir) {
+			debugfs_remove(dbgfs_dirs[i]);
+			dbgfs_destroy_ctx(dbgfs_ctxs[i]);
+			continue;
+		}
+		new_dirs[j] = dbgfs_dirs[i];
+		new_ctxs[j++] = dbgfs_ctxs[i];
+	}
+
+	kfree(dbgfs_dirs);
+	kfree(dbgfs_ctxs);
+
+	dbgfs_dirs = new_dirs;
+	dbgfs_ctxs = new_ctxs;
+	dbgfs_nr_ctxs--;
+
+	return 0;
+}
+
+static ssize_t dbgfs_rm_context_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t ret = count;
+	int err;
+	char *ctx_name;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+	ctx_name = kmalloc(count + 1, GFP_KERNEL);
+	if (!ctx_name) {
+		kfree(kbuf);
+		return -ENOMEM;
+	}
+
+	/* Trim white space */
+	if (sscanf(kbuf, "%s", ctx_name) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&damon_dbgfs_lock);
+	err = dbgfs_rm_context(ctx_name);
+	if (err)
+		ret = err;
+	mutex_unlock(&damon_dbgfs_lock);
+
+out:
+	kfree(kbuf);
+	kfree(ctx_name);
+	return ret;
+}
+
 static ssize_t dbgfs_monitor_on_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -655,6 +851,16 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static const struct file_operations mk_contexts_fops = {
+	.owner = THIS_MODULE,
+	.write = dbgfs_mk_context_write,
+};
+
+static const struct file_operations rm_contexts_fops = {
+	.owner = THIS_MODULE,
+	.write = dbgfs_rm_context_write,
+};
+
 static const struct file_operations monitor_on_fops = {
 	.owner = THIS_MODULE,
 	.read = dbgfs_monitor_on_read,
@@ -664,8 +870,10 @@ static const struct file_operations monitor_on_fops = {
 static int __init __damon_dbgfs_init(void)
 {
 	struct dentry *dbgfs_root;
-	const char * const file_names[] = {"monitor_on"};
-	const struct file_operations *fops[] = {&monitor_on_fops};
+	const char * const file_names[] = {"mk_contexts", "rm_contexts",
+		"monitor_on"};
+	const struct file_operations *fops[] = {&mk_contexts_fops,
+		&rm_contexts_fops, &monitor_on_fops};
 	int i;
 
 	dbgfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

