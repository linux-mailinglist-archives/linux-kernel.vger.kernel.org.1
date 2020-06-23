Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8460205883
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgFWRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:24:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:17059 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733141AbgFWRYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:24:53 -0400
IronPort-SDR: atGShV3gLwt+VS5uizCHYfdSzzIxi+V91PC0IBkJVTqj9/vO7GrXIS0tFoMAhth6errmU7cgDa
 dfalbZnKojxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144170844"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="144170844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 10:24:53 -0700
IronPort-SDR: /JsqC+xOr9qVvIOgw4zV7dRWJkIH9XcHNCAU30RaXLM4P/9F4El+phmSfebDGSbCXB2Bc5w+VF
 bc5torReNOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="423080171"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.213.182.184])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2020 10:24:50 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 09/10] kallsyms: Hide layout
Date:   Tue, 23 Jun 2020 10:23:26 -0700
Message-Id: <20200623172327.5701-10-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623172327.5701-1-kristen@linux.intel.com>
References: <20200623172327.5701-1-kristen@linux.intel.com>
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
 kernel/kallsyms.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 16c8c605f4b0..df2b20e1b7f2 100644
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
@@ -660,6 +666,127 @@ int kallsyms_show_value(void)
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
+#if defined(CONFIG_FG_KASLR)
+/*
+ * When fine grained kaslr is enabled, we need to
+ * print out the symbols sorted by name rather than by
+ * by address, because this reveals the randomization order.
+ */
+static int kallsyms_open(struct inode *inode, struct file *file)
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
+#else
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/*
@@ -676,6 +803,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	iter->show_value = kallsyms_show_value();
 	return 0;
 }
+#endif /* CONFIG_FG_KASLR */
 
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
-- 
2.20.1

