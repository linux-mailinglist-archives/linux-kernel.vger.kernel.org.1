Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9891AFF68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDTBHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 21:07:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:62984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDTBHA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:07:00 -0400
IronPort-SDR: KvCo6PwjzpGzxbXMxDPOF9JtufuTdgs09RR+sttC7+2DevI5fMGqWNF/bo/l7vqyX31rgFTDK+
 httr3YdGygrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:06:59 -0700
IronPort-SDR: kg/9q1WS74O0OhHSAFZbFt+J0PP9Td0t8ZOzGffTH6vizC54AMB4iqCP4tx0VYaDf3asf+U9rm
 WqeyWypwSrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="364854985"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2020 18:06:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/7] perf util: Create source line mapping table
Date:   Mon, 20 Apr 2020 09:04:45 +0800
Message-Id: <20200420010451.24405-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420010451.24405-1-yao.jin@linux.intel.com>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, a small change in a hot function reducing the cycles of
this function, but the overall workload doesn't get faster. It is
interesting where the cycles are moved to.

What it would like is to diff before/after streams. A stream is a
callchain which is aggregated by the branch records from samples.

By browsing the hot streams, we can understand the hot code flow.
By comparing the cycles variation of same streams between old perf
data and new perf data, we can understand if the cycles are moved to
the unchanged code.

The before stream is the stream before source line changed
(e.g. streams in perf.data.old). The after stream is the stream
after source line changed (e.g. streams in perf.data).

Diffing before/after streams compares all streams (or compares top
N hot streams) between two perf data files.

If all entries of one stream in perf.data.old are fully matched with
all entries of another stream in perf.data, we think these two streams
are matched, otherwise the streams are not matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
--------------------------              --------------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

It looks that two streams are matched and we can see for the same
streams the cycles are equal and the stream hit percents are
slightly changed. That's expected in the normal range.

But that's not always true if source lines are changed in perf.data
(e.g. div.c:39 is changed). If the source line is changed, they
are different streams, we can't compare them. We just think the
stream in perf.data is a new one.

The challenge is how to identify the changed source lines. The basic
idea is to use linux command 'diff' to compare the source file A and
source file A* line by line (assume A is used in perf.data.old
and A* is updated in perf.data). Create a source line mapping table.

For example,

  Execute 'diff ./before/div.c ./after/div.c'

  25c25
  <       i = rand() % 2;
  ---
  >       i = rand() % 4;
  39c39
  <       for (i = 0; i < 2000000000; i++) {
  ---
  >       for (i = 0; i < 20000000001; i++) {

  div.c (after -> before) lines mapping:
  0 -> 0
  1 -> 1
  2 -> 2
  3 -> 3
  4 -> 4
  5 -> 5
  6 -> 6
  7 -> 7
  8 -> 8
  9 -> 9
  ...
  24 -> 24
  25 -> -1
  26 -> 26
  27 -> 27
  28 -> 28
  29 -> 29
  30 -> 30
  31 -> 31
  32 -> 32
  33 -> 33
  34 -> 34
  35 -> 35
  36 -> 36
  37 -> 37
  38 -> 38
  39 -> -1
  40 -> 40
  ...

From the table, we can easily know div.c:39 is source line changed.
(it's mapped to -1). So these two streams are not matched.

This patch can also handle the cases of new source lines insertion
and old source lines deletion. This source line mapping table is a
base for next processing for stream comparison.

This patch creates a new rblist 'srclist' to manage the source line
mapping tables. Each node contains the source line mapping table of
a before/after source file pair. The node is created on demand as
we process the samples. So it's likely we don't need to create so many
nodes.

 v2:
 ---
 Refine the code
 1. calloc -> zalloc
 2. Functions operating on a 'struct line_pair' have the
    line_pair__ prefix.
 3. Check get_range() return value.
 4. Use fgets to replace fgetc for getting the number of lines.
 5. Use path__join to generate the full path.
 6. Keep the buffer after calling getline.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/srclist.c | 555 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/srclist.h |  65 +++++
 3 files changed, 621 insertions(+)
 create mode 100644 tools/perf/util/srclist.c
 create mode 100644 tools/perf/util/srclist.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c0cf8dff694e..b9bf620b60f0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -99,6 +99,7 @@ perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
+perf-y += srclist.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/srclist.c b/tools/perf/util/srclist.c
new file mode 100644
index 000000000000..8060e4855d11
--- /dev/null
+++ b/tools/perf/util/srclist.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Manage difference of source lines
+ * Copyright (c) 2020, Intel Corporation.
+ * Author: Jin Yao
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <inttypes.h>
+#include <string.h>
+#include <strings.h>
+#include <unistd.h>
+#include <err.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <linux/zalloc.h>
+#include "strlist.h"
+#include "srclist.h"
+#include "debug.h"
+#include "path.h"
+
+enum {
+	DIFF_LINE_ADD,
+	DIFF_LINE_DEL,
+	DIFF_LINE_CHANGE
+};
+
+static void get_full_path(const char *dir, const char *rel_path,
+			  char *full_path, int size)
+{
+	if (!dir) {
+		snprintf(full_path, size, "%s", rel_path);
+		return;
+	}
+
+	path__join(full_path, size, dir, rel_path);
+}
+
+static int path__number_of_lines(char *path)
+{
+	FILE *fp;
+	char buf[4096], *p, last = 0;
+	int num = 0;
+
+	fp = fopen(path, "r");
+	if (!fp) {
+		pr_debug("Failed to open file %s\n", path);
+		return -1;
+	}
+
+	while (!feof(fp)) {
+		p = fgets(buf, sizeof(buf), fp);
+		if (!p)
+			break;
+
+		last = p[strlen(p) - 1];
+		if (last == '\n')
+			num++;
+	}
+
+	fclose(fp);
+
+	if (last != '\n' && last != 0)
+		num++;
+
+	return num;
+}
+
+static int get_digit(char *str, char **end_str, int *val)
+{
+	int v;
+	char *end;
+
+	errno = 0;
+	v = strtol(str, &end, 10);
+	if ((errno == ERANGE && (v == INT_MAX || v == INT_MIN))
+		|| (errno != 0 && v == 0)) {
+		return -1;
+	}
+
+	if (end == str)
+		return -1;
+
+	*val = v;
+	*end_str = end;
+	return 0;
+}
+
+static int get_range(char *str, int *start_val, int *end_val)
+{
+	int val, ret;
+	char *end, *next;
+
+	*start_val = -1;
+	*end_val = -1;
+
+	ret = get_digit(str, &end, &val);
+	if (ret)
+		return ret;
+
+	*start_val = val;
+
+	if (*end != '\0') {
+		next = end + 1;
+		ret = get_digit(next, &end, &val);
+		if (ret)
+			return ret;
+
+		*end_val = val;
+	}
+
+	return 0;
+}
+
+static int opr_str_idx(char *str, int len, char ch)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (str[i] == ch)
+			break;
+	}
+
+	if (i == len || i == 0 || i == len - 1)
+		return -1;
+
+	if (str[i - 1] >= '0' && str[i - 1] <= '9' &&
+	    str[i + 1] >= '0' && str[i + 1] <= '9') {
+		return i;
+	}
+
+	return -1;
+}
+
+static bool get_diff_operation(char *str, int *opr, int *b_start, int *b_end,
+			       int *a_start, int *a_end)
+{
+	int idx, len;
+
+	if (str[0] == '<' || str[0] == '>' || str[0] == '-')
+		return false;
+
+	len = strlen(str);
+
+	/*
+	 * For example,
+	 * 5,6d4
+	 * 8a7
+	 * 20,21c19
+	 */
+	idx = opr_str_idx(str, len, 'd');
+	if (idx != -1) {
+		*opr = DIFF_LINE_DEL;
+		goto exit;
+	}
+
+	idx = opr_str_idx(str, len, 'a');
+	if (idx != -1) {
+		*opr = DIFF_LINE_ADD;
+		goto exit;
+	}
+
+	idx = opr_str_idx(str, len, 'c');
+	if (idx != -1) {
+		*opr = DIFF_LINE_CHANGE;
+		goto exit;
+	}
+
+exit:
+	if (idx != -1) {
+		str[idx] = 0;
+		if (get_range(str, b_start, b_end) != 0)
+			return false;
+
+		if (get_range(&str[idx + 1], a_start, a_end) != 0)
+			return false;
+
+		return true;
+	}
+
+	return false;
+}
+
+static int line_pair__del_lines(struct line_pair *lines, int b_start, int b_end,
+				int a_start, int a_end __maybe_unused,
+				int *nr_lines, int *b_adjust)
+{
+	int i = *nr_lines;
+	bool set = false;
+
+	/*
+	 * For example, 5,6d4
+	 * It means line 5 ~ line 6 of file1 are not same as line 4 of file2
+	 * because line 5 ~ line 6 are deleted.
+	 */
+
+	if (a_start == i) {
+		lines[i].a_nr = i;
+		lines[i].b_nr = i + *b_adjust;
+		set = true;
+	}
+
+	if (b_end != -1)
+		*b_adjust += b_end - b_start + 1;
+	else
+		*b_adjust += 1;
+
+	if (!set) {
+		lines[i].a_nr = i;
+		lines[i].b_nr = i + *b_adjust;
+	}
+
+	*nr_lines = i + 1;
+	return 0;
+}
+
+static int line_pair__add_lines(struct line_pair *lines,
+				int b_start __maybe_unused,
+				int b_end __maybe_unused,
+				int a_start, int a_end, int *nr_lines,
+				int *b_adjust)
+{
+	int i = *nr_lines;
+
+	/*
+	 * For example, 8a7
+	 * It means line 8 at file1 is not same as line 7 at file2
+	 * because a new line (line 7) is inserted to file2.
+	 */
+	if (a_end != -1) {
+		for (int j = 0; j < a_end - a_start + 1; j++) {
+			lines[i].a_nr = i;
+			lines[i].b_nr = -1;
+			i++;
+		}
+		*b_adjust -= a_end - a_start + 1;
+	} else {
+		lines[i].a_nr = i;
+		lines[i].b_nr = -1;
+		i++;
+		*b_adjust -= 1;
+	}
+
+	*nr_lines = i;
+	return 0;
+}
+
+static int line_pair__change_lines(struct line_pair *lines, int b_start,
+				   int b_end, int a_start, int a_end,
+				   int *nr_lines, int *b_adjust)
+{
+	int i = *nr_lines;
+
+	/*
+	 * For example, 20,21c19
+	 * It means line20~line21 of file1 are not same as line19 of file2
+	 * since they are changed.
+	 */
+
+	if (a_end != -1) {
+		for (int j = 0; j < a_end - a_start + 1; j++) {
+			lines[i].a_nr = i;
+			lines[i].b_nr = -1;
+			i++;
+		}
+	} else {
+		lines[i].a_nr = i;
+		lines[i].b_nr = -1;
+		i++;
+	}
+
+	if (b_end != -1)
+		*b_adjust += b_end - b_start;
+
+	if (a_end != -1)
+		*b_adjust -= a_end - a_start;
+
+	*nr_lines = i;
+	return 0;
+}
+
+static int line_pair__update_lines(struct line_pair *lines, int opr,
+				   int b_start, int b_end, int a_start,
+				   int a_end, int *nr_lines, int *b_adjust)
+{
+	int i = *nr_lines;
+
+	while (i < a_start) {
+		lines[i].a_nr = i;
+		lines[i].b_nr = i + *b_adjust;
+		i++;
+	}
+
+	*nr_lines = i;
+
+	switch (opr) {
+	case DIFF_LINE_DEL:
+		line_pair__del_lines(lines, b_start, b_end, a_start, a_end,
+				     nr_lines, b_adjust);
+		break;
+
+	case DIFF_LINE_ADD:
+		line_pair__add_lines(lines, b_start, b_end, a_start, a_end,
+				     nr_lines, b_adjust);
+		break;
+
+	case DIFF_LINE_CHANGE:
+		line_pair__change_lines(lines, b_start, b_end, a_start,
+					a_end, nr_lines, b_adjust);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void line_pair__update_remaining(struct line_pair *lines, int a_num,
+					 int *nr_lines, int b_adjust)
+{
+	int i;
+
+	for (i = *nr_lines; i <= a_num; i++) {
+		lines[i].a_nr = i;
+		lines[i].b_nr = i + b_adjust;
+	}
+
+	*nr_lines = i;
+}
+
+static int build_mapping_table(FILE *fp, struct line_pair *lines,
+			       int *nr_lines, int a_num)
+{
+	char *str = NULL, *p;
+	size_t len = 0;
+	int opr, b_start, b_end, a_start, a_end, b_adjust = 0;
+
+	*nr_lines = 1;  /* First line is reserved */
+
+	while (getline(&str, &len, fp) > 0) {
+		p = strchr(str, '\n');
+		if (p)
+			*p = '\0';
+
+		pr_debug("%s\n", str);
+
+		if (!get_diff_operation(str, &opr, &b_start, &b_end,
+					&a_start, &a_end)) {
+			continue;
+		}
+
+		line_pair__update_lines(lines, opr, b_start, b_end, a_start,
+					a_end, nr_lines, &b_adjust);
+	}
+
+	line_pair__update_remaining(lines, a_num, nr_lines, b_adjust);
+
+	free(str);
+	return 0;
+}
+
+static int src_info__create_line_mapping(struct src_info *info, char *b_path,
+					 char *a_path)
+{
+	char cmd[PATH_MAX];
+	FILE *fp = NULL;
+	int ret = -1;
+
+	info->nr_lines_before = path__number_of_lines(b_path);
+	if (info->nr_lines_before == -1)
+		goto out;
+
+	info->nr_lines_after = path__number_of_lines(a_path);
+	if (info->nr_lines_after == -1)
+		goto out;
+
+	/* Reserve first line */
+	info->nr_max = info->nr_lines_before + info->nr_lines_after + 1;
+	info->lines = calloc(info->nr_max, sizeof(struct line_pair));
+	if (!info->lines) {
+		pr_err("Failed to alloc memory for lines\n");
+		goto out;
+	}
+
+	snprintf(cmd, sizeof(cmd), "diff %s %s",
+		 b_path, a_path);
+
+	pr_debug("Execute '%s'\n", cmd);
+
+	fp = popen(cmd, "r");
+	if (!fp) {
+		pr_err("Failed to execute '%s'\n", cmd);
+		goto out;
+	}
+
+	ret = build_mapping_table(fp, info->lines, &info->nr_lines,
+				  info->nr_lines_after);
+
+out:
+	if (fp)
+		fclose(fp);
+
+	return ret;
+}
+
+static void free_src_info(struct src_info *info)
+{
+	zfree(&info->rel_path);
+	zfree(&info->lines);
+}
+
+static int init_src_info(char *b_path, char *a_path, const char *rel_path,
+			 struct src_info *info)
+{
+	int ret;
+
+	info->rel_path = strdup(rel_path);
+	if (!info->rel_path)
+		return -1;
+
+	ret = src_info__create_line_mapping(info, b_path, a_path);
+	if (ret)
+		free_src_info(info);
+
+	return ret;
+}
+
+static void free_src_node(struct src_node *node)
+{
+	if (!node)
+		return;
+
+	free_src_info(&node->info);
+	free(node);
+}
+
+static struct rb_node *srclist__node_new(struct rblist *rblist,
+					 const void *entry)
+{
+	struct srclist *slist = container_of(rblist, struct srclist, rblist);
+	const char *rel_path = entry;
+	char b_path[PATH_MAX], a_path[PATH_MAX];
+	struct src_node *node;
+	int ret;
+
+	get_full_path(slist->before_dir, rel_path, b_path, PATH_MAX);
+	get_full_path(slist->after_dir, rel_path, a_path, PATH_MAX);
+
+	node = zalloc(sizeof(*node));
+	if (!node)
+		return NULL;
+
+	ret = init_src_info(b_path, a_path, rel_path, &node->info);
+	if (ret)
+		goto err;
+
+	return &node->rb_node;
+
+err:
+	free_src_node(node);
+	return NULL;
+}
+
+static void srclist__node_delete(struct rblist *rblist __maybe_unused,
+				 struct rb_node *rb_node)
+{
+	struct src_node *node = container_of(rb_node, struct src_node, rb_node);
+
+	free_src_info(&node->info);
+	free(node);
+}
+
+static int srclist__node_cmp(struct rb_node *rb_node, const void *entry)
+{
+	struct src_node *node = container_of(rb_node, struct src_node, rb_node);
+	const char *str = entry;
+
+	return strcmp(node->info.rel_path, str);
+}
+
+struct srclist *srclist__new(const char *before_dir, const char *after_dir)
+{
+	struct srclist *slist = zalloc(sizeof(*slist));
+
+	if (!slist)
+		return NULL;
+
+	rblist__init(&slist->rblist);
+	slist->rblist.node_cmp = srclist__node_cmp;
+	slist->rblist.node_new = srclist__node_new;
+	slist->rblist.node_delete = srclist__node_delete;
+
+	slist->before_dir = before_dir;
+	slist->after_dir = after_dir;
+	return slist;
+}
+
+void srclist__delete(struct srclist *slist)
+{
+	if (slist)
+		rblist__delete(&slist->rblist);
+}
+
+struct src_node *srclist__find(struct srclist *slist, char *rel_path,
+			       bool create)
+{
+	struct src_node *node = NULL;
+	struct rb_node *rb_node;
+
+	if (create)
+		rb_node = rblist__findnew(&slist->rblist, (void *)rel_path);
+	else
+		rb_node = rblist__find(&slist->rblist, (void *)rel_path);
+
+	if (rb_node)
+		node = container_of(rb_node, struct src_node, rb_node);
+
+	return node;
+}
+
+struct line_pair *srclist__line_pair(struct src_node *node, int a_nr)
+{
+	struct src_info *info = &node->info;
+
+	if (a_nr < info->nr_lines && a_nr > 0)
+		return &info->lines[a_nr];
+
+	pr_debug("Exceeds line range: nr_lines = %d, a_nr = %d\n",
+		 info->nr_lines, a_nr);
+
+	return NULL;
+}
+
+void srclist__dump(struct srclist *slist)
+{
+	struct src_node *node;
+	struct src_info *info;
+	int i;
+
+	srclist__for_each_entry(node, slist) {
+		info = &node->info;
+
+		pr_debug("%s (after -> before) lines mapping:\n",
+			 info->rel_path);
+
+		for (i = 0; i < info->nr_lines; i++) {
+			pr_debug("%d -> %d\n",
+				 info->lines[i].a_nr,
+				 info->lines[i].b_nr);
+		}
+	}
+}
diff --git a/tools/perf/util/srclist.h b/tools/perf/util/srclist.h
new file mode 100644
index 000000000000..f25b0de91a13
--- /dev/null
+++ b/tools/perf/util/srclist.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SRCLIST_H
+#define __PERF_SRCLIST_H
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include "rblist.h"
+
+struct line_pair {
+	int a_nr;	/* line nr in after.c */
+	int b_nr;	/* line nr in before.c */
+};
+
+struct src_node;
+
+struct src_info {
+	char *rel_path; /* relative path */
+	struct line_pair *lines;
+	int nr_max;
+	int nr_lines;
+	int nr_lines_before;
+	int nr_lines_after;
+};
+
+struct src_node {
+	struct rb_node rb_node;
+	struct src_info info;
+};
+
+struct srclist {
+	struct rblist rblist;
+	const char *before_dir;
+	const char *after_dir;
+};
+
+struct srclist *srclist__new(const char *before_dir, const char *after_dir);
+void srclist__delete(struct srclist *slist);
+
+struct src_node *srclist__find(struct srclist *slist, char *rel_path,
+			       bool create);
+
+struct line_pair *srclist__line_pair(struct src_node *node, int a_nr);
+void srclist__dump(struct srclist *slist);
+
+static inline struct src_node *srclist__first(struct srclist *slist)
+{
+	struct rb_node *rn = rb_first_cached(&slist->rblist.entries);
+
+	return rn ? rb_entry(rn, struct src_node, rb_node) : NULL;
+}
+
+static inline struct src_node *srclist__next(struct src_node *sn)
+{
+	struct rb_node *rn;
+
+	if (!sn)
+		return NULL;
+	rn = rb_next(&sn->rb_node);
+	return rn ? rb_entry(rn, struct src_node, rb_node) : NULL;
+}
+
+#define srclist__for_each_entry(pos, slist)	\
+	for (pos = srclist__first(slist); pos; pos = srclist__next(pos))
+
+#endif /* __PERF_SRCLIST_H */
-- 
2.17.1

