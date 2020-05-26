Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C31DD38A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgEUQ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:57:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:28574 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgEUQ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:57:33 -0400
IronPort-SDR: /TD62j7asE3N83yWUHKcw25Ni2LkaXTQ2BEXoq0P3d4LRxvSS1dZ4AHubAQAV6SncP2QY+UvPz
 YLzi740HFtMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:57:32 -0700
IronPort-SDR: RqdF6pIwNmwj2eRxUyIu8U3E3pSodnd5ySfbax65wnHVdU3X57VIgUZ+Jh4ejMDUtCOvwiFO4A
 8JFljtHzZxzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309094801"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 09:57:30 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 8/9] kallsyms: Hide layout
Date:   Thu, 21 May 2020 09:56:39 -0700
Message-Id: <20200521165641.15940-9-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521165641.15940-1-kristen@linux.intel.com>
References: <20200521165641.15940-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes /proc/kallsyms display alphabetically by symbol
name rather than sorted by address in order to hide the newly
randomized address layout.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 kernel/kallsyms.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 16c8c605f4b0..558963b275ec 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -25,6 +25,7 @@
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/compiler.h>
+#include <linux/list_sort.h>
 
 /*
  * These will be re-linked against their real values
@@ -446,6 +447,11 @@ struct kallsym_iter {
 	int show_value;
 };
 
+struct kallsyms_iter_list {
+	struct kallsym_iter iter;
+	struct list_head next;
+};
+
 int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
 			    char *type, char *name)
 {
@@ -660,6 +666,121 @@ int kallsyms_show_value(void)
 	}
 }
 
+static int sorted_show(struct seq_file *m, void *p)
+{
+	struct list_head *list = m->private;
+	struct kallsyms_iter_list *iter;
+	int rc;
+
+	if (list_empty(list))
+		return 0;
+
+	iter = list_first_entry(list, struct kallsyms_iter_list, next);
+
+	m->private = iter;
+	rc = s_show(m, p);
+	m->private = list;
+
+	list_del(&iter->next);
+	kfree(iter);
+
+	return rc;
+}
+
+static void *sorted_start(struct seq_file *m, loff_t *pos)
+{
+	return m->private;
+}
+
+static void *sorted_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct list_head *list = m->private;
+
+	(*pos)++;
+
+	if (list_empty(list))
+		return NULL;
+
+	return p;
+}
+
+static const struct seq_operations kallsyms_sorted_op = {
+	.start = sorted_start,
+	.next = sorted_next,
+	.stop = s_stop,
+	.show = sorted_show
+};
+
+static int kallsyms_list_cmp(void *priv, struct list_head *a,
+			     struct list_head *b)
+{
+	struct kallsyms_iter_list *iter_a, *iter_b;
+
+	iter_a = list_entry(a, struct kallsyms_iter_list, next);
+	iter_b = list_entry(b, struct kallsyms_iter_list, next);
+
+	return strcmp(iter_a->iter.name, iter_b->iter.name);
+}
+
+int get_all_symbol_name(void *data, const char *name, struct module *mod,
+			unsigned long addr)
+{
+	unsigned long sym_pos;
+	struct kallsyms_iter_list *node, *last;
+	struct list_head *head = (struct list_head *)data;
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	if (list_empty(head)) {
+		sym_pos = 0;
+		memset(node, 0, sizeof(*node));
+		reset_iter(&node->iter, 0);
+		node->iter.show_value = kallsyms_show_value();
+	} else {
+		last = list_first_entry(head, struct kallsyms_iter_list, next);
+		memcpy(node, last, sizeof(*node));
+		sym_pos = last->iter.pos;
+	}
+
+	INIT_LIST_HEAD(&node->next);
+	list_add(&node->next, head);
+
+	/*
+	 * update_iter returns false when at end of file
+	 * which in this case we don't care about and can
+	 * safely ignore. update_iter() will increment
+	 * the value of iter->pos, for ksymbol_core.
+	 */
+	if (sym_pos >= kallsyms_num_syms)
+		sym_pos++;
+
+	(void)update_iter(&node->iter, sym_pos);
+
+	return 0;
+}
+
+static int kallsyms_sorted_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct list_head *list;
+
+	list = __seq_open_private(file, &kallsyms_sorted_op, sizeof(*list));
+	if (!list)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(list);
+
+	ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
+	if (ret != 0)
+		return ret;
+
+	list_sort(NULL, list, kallsyms_list_cmp);
+
+	return 0;
+}
+
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/*
@@ -704,9 +825,24 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+static const struct proc_ops kallsyms_sorted_proc_ops = {
+	.proc_open = kallsyms_sorted_open,
+	.proc_read = seq_read,
+	.proc_lseek = seq_lseek,
+	.proc_release = seq_release_private,
+};
+
 static int __init kallsyms_init(void)
 {
-	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+	/*
+	 * When fine grained kaslr is enabled, we need to
+	 * print out the symbols sorted by name rather than by
+	 * by address, because this reveals the randomization order.
+	 */
+	if (!IS_ENABLED(CONFIG_FG_KASLR))
+		proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+	else
+		proc_create("kallsyms", 0444, NULL, &kallsyms_sorted_proc_ops);
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.20.1

