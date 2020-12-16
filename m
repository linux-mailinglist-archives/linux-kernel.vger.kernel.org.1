Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D952DBDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLPJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:44:07 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:15709 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608111846; x=1639647846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6T3WVe6Az0tu/tWkPM96Y026XUAvJ40yYSLrebOuGng=;
  b=ZPf46Z2dMR9/fNStaWKBQz8Lf4Fn7PAD7pLVVEs8aQRUuRsyEnM/OVOU
   7w6CkFiEq9BmeAiSnImN/Zhq8iuZ08GN4U9Jal7YsGUgwN8LDNc/OLGFZ
   m5weCBZoJtulIyDohSTrhFKZ/zvNnX9S5edm3ULEvbaK+7B3l53I8NHDl
   A=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="71565066"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Dec 2020 09:43:18 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id C4B5AA1F1D;
        Wed, 16 Dec 2020 09:43:15 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:42:59 +0000
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
Subject: [RFC v10 01/13] damon/dbgfs: Allow users to set initial monitoring target regions
Date:   Wed, 16 Dec 2020 10:42:09 +0100
Message-ID: <20201216094221.11898-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-1-sjpark@amazon.com>
References: <20201216094221.11898-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.31]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Some 'damon-dbgfs' users would want to monitor only a part of the entire
virtual memory address space.  The framework users in the kernel space
could use '->init_target_regions' callback or even set the regions
inside the context struct as they want, but 'damon-dbgfs' users cannot.

For the reason, this commit introduces a new debugfs file,
'init_region'.  'damon-dbgfs' users can specify which initial monitoring
target address regions they want by writing special input to the file.
The input should describe each region in each line in below form:

    <pid> <start address> <end address>

Note that the regions will be updated to cover entire memory mapped
regions after 'regions update interval'.  If you want the regions to not
be updated after the initial setting, you could set the interval as a
very long time, say, a few decades.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 06295c986dc3..2f1ec6ebd9f0 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -492,6 +492,147 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	int written = 0;
+	int rc;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			rc = scnprintf(&buf[written], len - written,
+					"%lu %lu %lu\n",
+					t->id, r->ar.start, r->ar.end);
+			if (!rc)
+				return -ENOMEM;
+			written += rc;
+		}
+	}
+	return written;
+}
+
+static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t len;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		mutex_unlock(&ctx->kdamond_lock);
+		return -EBUSY;
+	}
+
+	len = sprint_init_regions(ctx, kbuf, count);
+	mutex_unlock(&ctx->kdamond_lock);
+	if (len < 0)
+		goto out;
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
+static int add_init_region(struct damon_ctx *c,
+			 unsigned long target_id, struct damon_addr_range *ar)
+{
+	struct damon_target *t;
+	struct damon_region *r, *prev;
+	int rc = -EINVAL;
+
+	if (ar->start >= ar->end)
+		return -EINVAL;
+
+	damon_for_each_target(t, c) {
+		if (t->id == target_id) {
+			r = damon_new_region(ar->start, ar->end);
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+			if (damon_nr_regions(t) > 1) {
+				prev = damon_prev_region(r);
+				if (prev->ar.end > r->ar.start) {
+					damon_destroy_region(r);
+					return -EINVAL;
+				}
+			}
+			rc = 0;
+		}
+	}
+	return rc;
+}
+
+static int set_init_regions(struct damon_ctx *c, const char *str, ssize_t len)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next;
+	int pos = 0, parsed, ret;
+	unsigned long target_id;
+	struct damon_addr_range ar;
+	int err;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+
+	while (pos < len) {
+		ret = sscanf(&str[pos], "%lu %lu %lu%n",
+				&target_id, &ar.start, &ar.end, &parsed);
+		if (ret != 3)
+			break;
+		err = add_init_region(c, target_id, &ar);
+		if (err)
+			goto fail;
+		pos += parsed;
+	}
+
+	return 0;
+
+fail:
+	damon_for_each_target(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+	return err;
+}
+
+static ssize_t dbgfs_init_regions_write(struct file *file,
+					  const char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = set_init_regions(ctx, kbuf, ret);
+	if (err)
+		ret = err;
+
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	kfree(kbuf);
+	return ret;
+}
+
 static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -553,6 +694,13 @@ static const struct file_operations target_ids_fops = {
 	.write = dbgfs_target_ids_write,
 };
 
+static const struct file_operations init_regions_fops = {
+	.owner = THIS_MODULE,
+	.open = damon_dbgfs_open,
+	.read = dbgfs_init_regions_read,
+	.write = dbgfs_init_regions_write,
+};
+
 static const struct file_operations kdamond_pid_fops = {
 	.owner = THIS_MODULE,
 	.open = damon_dbgfs_open,
@@ -562,9 +710,9 @@ static const struct file_operations kdamond_pid_fops = {
 static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
 	const char * const file_names[] = {"attrs", "record", "schemes",
-		"target_ids", "kdamond_pid"};
-	const struct file_operations *fops[] = {&attrs_fops,
-		&record_fops, &schemes_fops, &target_ids_fops,
+		"target_ids", "init_regions", "kdamond_pid"};
+	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
+		&schemes_fops, &target_ids_fops, &init_regions_fops,
 		&kdamond_pid_fops};
 	int i;
 
-- 
2.17.1

