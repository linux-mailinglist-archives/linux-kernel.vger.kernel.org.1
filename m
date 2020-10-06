Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA9284BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgJFMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:42:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:65411 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJFMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601988130; x=1633524130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Xh/XFoPyX0qjBaIe3sAFmmh4BMprHpdZfyRo++w6HqA=;
  b=lufc+WpWrRL2YczthGSOaVeWSuJjbKOiKtxwOt/3W4enHOXA/nLL/DKr
   Mwq5V5BOvpBHEljHy8PrYmKK/JgsXQu+6GW+FFp5iTkxuXKhbQPKvD8EP
   RnxGv1m9s2OwGfP9uEG4Z42wDYtQRCxNijKbfB4qSMoPVY1nCDPuOraxU
   M=;
X-IronPort-AV: E=Sophos;i="5.77,343,1596499200"; 
   d="scan'208";a="58084516"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-76e0922c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Oct 2020 12:41:57 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-76e0922c.us-west-2.amazon.com (Postfix) with ESMTPS id 95593A7E41;
        Tue,  6 Oct 2020 12:41:54 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Oct 2020 12:41:35 +0000
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
Subject: [RFC v15 4/8] mm/damon/dbgfs: Support DAMON-based Operation Schemes
Date:   Tue, 6 Oct 2020 14:39:27 +0200
Message-ID: <20201006123931.5847-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006123931.5847-1-sjpark@amazon.com>
References: <20201006123931.5847-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D18UWA002.ant.amazon.com (10.43.160.199) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes 'damon-dbgfs' to support the data access monitoring
oriented memory management schemes.  Users can read and update the
schemes using ``<debugfs>/damon/schemes`` file.  The format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 169 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 4 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index df807ffb283e..54bdccd0af71 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -220,6 +220,159 @@ static ssize_t dbgfs_record_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damos *s;
+	int written = 0;
+	int rc;
+
+	damon_for_each_scheme(s, c) {
+		rc = scnprintf(&buf[written], len - written,
+				"%lu %lu %u %u %u %u %d\n",
+				s->min_sz_region, s->max_sz_region,
+				s->min_nr_accesses, s->max_nr_accesses,
+				s->min_age_region, s->max_age_region,
+				s->action);
+		if (!rc)
+			return -ENOMEM;
+
+		written += rc;
+	}
+	return written;
+}
+
+static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
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
+	len = sprint_schemes(ctx, kbuf, count);
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
+static void free_schemes_arr(struct damos **schemes, ssize_t nr_schemes)
+{
+	ssize_t i;
+
+	for (i = 0; i < nr_schemes; i++)
+		kfree(schemes[i]);
+	kfree(schemes);
+}
+
+static bool damos_action_valid(int action)
+{
+	switch (action) {
+	case DAMOS_WILLNEED:
+	case DAMOS_COLD:
+	case DAMOS_PAGEOUT:
+	case DAMOS_HUGEPAGE:
+	case DAMOS_NOHUGEPAGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Converts a string into an array of struct damos pointers
+ *
+ * Returns an array of struct damos pointers that converted if the conversion
+ * success, or NULL otherwise.
+ */
+static struct damos **str_to_schemes(const char *str, ssize_t len,
+				ssize_t *nr_schemes)
+{
+	struct damos *scheme, **schemes;
+	const int max_nr_schemes = 256;
+	int pos = 0, parsed, ret;
+	unsigned long min_sz, max_sz;
+	unsigned int min_nr_a, max_nr_a, min_age, max_age;
+	unsigned int action;
+
+	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
+			GFP_KERNEL);
+	if (!schemes)
+		return NULL;
+
+	*nr_schemes = 0;
+	while (pos < len && *nr_schemes < max_nr_schemes) {
+		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u%n",
+				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
+				&min_age, &max_age, &action, &parsed);
+		if (ret != 7)
+			break;
+		if (!damos_action_valid(action)) {
+			pr_err("wrong action %d\n", action);
+			goto fail;
+		}
+
+		pos += parsed;
+		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
+				min_age, max_age, action);
+		if (!scheme)
+			goto fail;
+
+		schemes[*nr_schemes] = scheme;
+		*nr_schemes += 1;
+	}
+	return schemes;
+fail:
+	free_schemes_arr(schemes, *nr_schemes);
+	return NULL;
+}
+
+static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	struct damos **schemes;
+	ssize_t nr_schemes = 0, ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	schemes = str_to_schemes(kbuf, ret, &nr_schemes);
+	if (!schemes) {
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
+	err = damon_set_schemes(ctx, schemes, nr_schemes);
+	if (err)
+		ret = err;
+	else
+		nr_schemes = 0;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	free_schemes_arr(schemes, nr_schemes);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
 #define targetid_is_pid(ctx)	\
 	(ctx->primitive.target_valid == damon_va_target_valid)
 
@@ -416,6 +569,13 @@ static const struct file_operations record_fops = {
 	.write = dbgfs_record_write,
 };
 
+static const struct file_operations schemes_fops = {
+	.owner = THIS_MODULE,
+	.open = damon_dbgfs_open,
+	.read = dbgfs_schemes_read,
+	.write = dbgfs_schemes_write,
+};
+
 static const struct file_operations target_ids_fops = {
 	.owner = THIS_MODULE,
 	.open = damon_dbgfs_open,
@@ -431,10 +591,11 @@ static const struct file_operations kdamond_pid_fops = {
 
 static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
-	const char * const file_names[] = {"attrs", "record", "target_ids",
-		"kdamond_pid"};
-	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&target_ids_fops, &kdamond_pid_fops};
+	const char * const file_names[] = {"attrs", "record", "schemes",
+		"target_ids", "kdamond_pid"};
+	const struct file_operations *fops[] = {&attrs_fops,
+		&record_fops, &schemes_fops, &target_ids_fops,
+		&kdamond_pid_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
-- 
2.17.1

