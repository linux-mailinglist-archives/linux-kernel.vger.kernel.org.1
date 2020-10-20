Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE163293789
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbgJTJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:05:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55268 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389440AbgJTJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184736; x=1634720736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XdUhU/uieMloV+LtEQ7UZfIH1e/xiUeXXXPJkp3izOM=;
  b=Ayaabe80dh7pvDNqRsNM6Ds+RDJdFaq8mgNIv3rVFYkBL/BiUHIptiav
   SNYLF8n5skzUBTsmhpw03YThawy0KpkWuiXt3nyEdwo3B2lb7BAaTbnXx
   qn2KoHy1n6DPZfJI5hDX7S4IRKvk/uq3L66OTvrCH6f6auiZbOe0ymcXt
   I=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="86290015"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Oct 2020 09:05:35 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id F1207A1CCC;
        Tue, 20 Oct 2020 09:05:31 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:05:09 +0000
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
Subject: [PATCH v22 11/18] mm/damon/dbgfs: Implement recording feature
Date:   Tue, 20 Oct 2020 10:59:33 +0200
Message-ID: <20201020085940.13875-12-sjpark@amazon.com>
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

The user space users can control DAMON via and get the monitoring
results using the 'damon_aggregated' tracepoint event.  However, dealing
with the tracepoint might be complex for some simple use cases.  This
commit therefore implements 'recording' feature in 'damon-dbgfs'.  The
feature can be used via 'record' file in the '<debugfs>/damon/'
directory.

The file allows users to record monitored access patterns in a regular
binary file.  The recorded results are first written in an in-memory
buffer and flushed to a file in batch.  Users can get and set the size
of the buffer and the path to the result file by reading from and
writing to the ``record`` file.  For example, below commands set the
buffer to be 4 KiB and the result to be saved in ``/damon.data``. ::

    # cd <debugfs>/damon
    # echo "4096 /damon.data" > record
    # cat record
    4096 /damon.data

The recording can be disabled by setting the buffer size zero.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 253 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 6316d4cae2a4..5aac85de23d2 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -15,6 +15,17 @@
 #include <linux/page_idle.h>
 #include <linux/slab.h>
 
+#define MIN_RECORD_BUFFER_LEN	1024
+#define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
+#define MAX_RFILE_PATH_LEN	256
+
+struct dbgfs_recorder {
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+};
+
 static struct damon_ctx **dbgfs_ctxs;
 static int dbgfs_nr_ctxs = 1;
 static int dbgfs_nr_terminated_ctxs;
@@ -99,6 +110,116 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 	return ret;
 }
 
+static ssize_t dbgfs_record_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	struct dbgfs_recorder *rec = ctx->callback.private;
+	char record_buf[20 + MAX_RFILE_PATH_LEN];
+	int ret;
+
+	mutex_lock(&ctx->kdamond_lock);
+	ret = scnprintf(record_buf, ARRAY_SIZE(record_buf), "%u %s\n",
+			rec->rbuf_len, rec->rfile_path);
+	mutex_unlock(&ctx->kdamond_lock);
+	return simple_read_from_buffer(buf, count, ppos, record_buf, ret);
+}
+
+/*
+ * dbgfs_set_recording() - Set attributes for the recording.
+ * @ctx:	target kdamond context
+ * @rbuf_len:	length of the result buffer
+ * @rfile_path:	path to the monitor result files
+ *
+ * Setting 'rbuf_len' 0 disables recording.
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int dbgfs_set_recording(struct damon_ctx *ctx,
+			unsigned int rbuf_len, char *rfile_path)
+{
+	struct dbgfs_recorder *recorder;
+	size_t rfile_path_len;
+
+	if (rbuf_len && (rbuf_len > MAX_RECORD_BUFFER_LEN ||
+			rbuf_len < MIN_RECORD_BUFFER_LEN)) {
+		pr_err("result buffer size (%u) is out of [%d,%d]\n",
+				rbuf_len, MIN_RECORD_BUFFER_LEN,
+				MAX_RECORD_BUFFER_LEN);
+		return -EINVAL;
+	}
+	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
+	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
+		pr_err("too long (>%d) result file path %s\n",
+				MAX_RFILE_PATH_LEN, rfile_path);
+		return -EINVAL;
+	}
+
+	recorder = ctx->callback.private;
+	if (!recorder) {
+		recorder = kzalloc(sizeof(*recorder), GFP_KERNEL);
+		if (!recorder)
+			return -ENOMEM;
+		ctx->callback.private = recorder;
+	}
+
+	recorder->rbuf_len = rbuf_len;
+	kfree(recorder->rbuf);
+	recorder->rbuf = NULL;
+	kfree(recorder->rfile_path);
+	recorder->rfile_path = NULL;
+
+	if (rbuf_len) {
+		recorder->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
+		if (!recorder->rbuf)
+			return -ENOMEM;
+	}
+	recorder->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
+	if (!recorder->rfile_path)
+		return -ENOMEM;
+	strncpy(recorder->rfile_path, rfile_path, rfile_path_len + 1);
+
+	return 0;
+}
+
+static ssize_t dbgfs_record_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	unsigned int rbuf_len;
+	char rfile_path[MAX_RFILE_PATH_LEN];
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	if (sscanf(kbuf, "%u %s",
+				&rbuf_len, rfile_path) != 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = dbgfs_set_recording(ctx, rbuf_len, rfile_path);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
 #define targetid_is_pid(ctx)	\
 	(ctx->primitive.target_valid == damon_va_target_valid)
 
@@ -262,6 +383,13 @@ static const struct file_operations attrs_fops = {
 	.write = dbgfs_attrs_write,
 };
 
+static const struct file_operations record_fops = {
+	.owner = THIS_MODULE,
+	.open = damon_dbgfs_open,
+	.read = dbgfs_record_read,
+	.write = dbgfs_record_write,
+};
+
 static const struct file_operations target_ids_fops = {
 	.owner = THIS_MODULE,
 	.open = damon_dbgfs_open,
@@ -271,8 +399,9 @@ static const struct file_operations target_ids_fops = {
 
 static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
-	const char * const file_names[] = {"attrs", "target_ids"};
-	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
+	const char * const file_names[] = {"attrs", "record", "target_ids"};
+	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
+		&target_ids_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
@@ -286,6 +415,120 @@ static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 	return 0;
 }
 
+/*
+ * Flush the content in the result buffer to the result file
+ */
+static void dbgfs_flush_rbuffer(struct dbgfs_recorder *rec)
+{
+	ssize_t sz;
+	loff_t pos = 0;
+	struct file *rfile;
+
+	if (!rec->rbuf_offset)
+		return;
+
+	rfile = filp_open(rec->rfile_path,
+			O_CREAT | O_RDWR | O_APPEND | O_LARGEFILE, 0644);
+	if (IS_ERR(rfile)) {
+		pr_err("Cannot open the result file %s\n",
+				rec->rfile_path);
+		return;
+	}
+
+	while (rec->rbuf_offset) {
+		sz = kernel_write(rfile, rec->rbuf, rec->rbuf_offset, &pos);
+		if (sz < 0)
+			break;
+		rec->rbuf_offset -= sz;
+	}
+	filp_close(rfile, NULL);
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void dbgfs_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
+{
+	struct dbgfs_recorder *rec = ctx->callback.private;
+
+	if (!rec->rbuf_len || !rec->rbuf || !rec->rfile_path)
+		return;
+	if (rec->rbuf_offset + size > rec->rbuf_len)
+		dbgfs_flush_rbuffer(ctx->callback.private);
+	if (rec->rbuf_offset + size > rec->rbuf_len) {
+		pr_warn("%s: flush failed, or wrong size given(%u, %zu)\n",
+				__func__, rec->rbuf_offset, size);
+		return;
+	}
+
+	memcpy(&rec->rbuf[rec->rbuf_offset], data, size);
+	rec->rbuf_offset += size;
+}
+
+static void dbgfs_write_record_header(struct damon_ctx *ctx)
+{
+	int recfmt_ver = 2;
+
+	dbgfs_write_rbuf(ctx, "damon_recfmt_ver", 16);
+	dbgfs_write_rbuf(ctx, &recfmt_ver, sizeof(recfmt_ver));
+}
+
+static unsigned int nr_damon_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_targets = 0;
+
+	damon_for_each_target(t, ctx)
+		nr_targets++;
+
+	return nr_targets;
+}
+
+static int dbgfs_before_start(struct damon_ctx *ctx)
+{
+	dbgfs_write_record_header(ctx);
+	return 0;
+}
+
+/*
+ * Store the aggregated monitoring results to the result buffer
+ *
+ * The format for the result buffer is as below:
+ *
+ *   <time> <number of targets> <array of target infos>
+ *
+ *   target info: <id> <number of regions> <array of region infos>
+ *   region info: <start address> <end address> <nr_accesses>
+ */
+static int dbgfs_after_aggregation(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct timespec64 now;
+	unsigned int nr;
+
+	ktime_get_coarse_ts64(&now);
+
+	dbgfs_write_rbuf(c, &now, sizeof(now));
+	nr = nr_damon_targets(c);
+	dbgfs_write_rbuf(c, &nr, sizeof(nr));
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+
+		dbgfs_write_rbuf(c, &t->id, sizeof(t->id));
+		nr = damon_nr_regions(t);
+		dbgfs_write_rbuf(c, &nr, sizeof(nr));
+		damon_for_each_region(r, t) {
+			dbgfs_write_rbuf(c, &r->ar.start, sizeof(r->ar.start));
+			dbgfs_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
+			dbgfs_write_rbuf(c, &r->nr_accesses,
+					sizeof(r->nr_accesses));
+		}
+	}
+
+	return 0;
+}
+
 static void dbgfs_unlock_page_idle_lock(void)
 {
 	mutex_lock(&damon_dbgfs_lock);
@@ -298,6 +541,7 @@ static void dbgfs_unlock_page_idle_lock(void)
 
 static int dbgfs_before_terminate(struct damon_ctx *ctx)
 {
+	dbgfs_flush_rbuffer(ctx->callback.private);
 	dbgfs_unlock_page_idle_lock();
 	return 0;
 }
@@ -310,7 +554,14 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
+	if (dbgfs_set_recording(ctx, 0, "none")) {
+		damon_destroy_ctx(ctx);
+		return NULL;
+	}
+
 	damon_va_set_primitives(ctx);
+	ctx->callback.before_start = dbgfs_before_start;
+	ctx->callback.after_aggregation = dbgfs_after_aggregation;
 	ctx->callback.before_terminate = dbgfs_before_terminate;
 	return ctx;
 }
-- 
2.17.1

