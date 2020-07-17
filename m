Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FE223174
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 05:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGQDF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 23:05:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:17117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgGQDF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:05:28 -0400
IronPort-SDR: F/kbh9y0m0VllUp09RZJaILuPIAN8repIGBeXn8e0jXv6UwUxN6smfCitZslWmpXSpyDe350Ez
 HykwDM2okmQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167664217"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="167664217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:05:28 -0700
IronPort-SDR: llPTPvo+45szicgiXF4M5uxCXNLCwGfddhOBZXBqtkXt2z5LOY+h7K9IGDSiKh5LCCreyMoHIT
 JUGMVw9UvzvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="286687086"
Received: from pgerasim-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.34.31])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 20:05:21 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v4 7/7] kprobes: Flag out CONFIG_MODULES dependent code
Date:   Fri, 17 Jul 2020 06:04:21 +0300
Message-Id: <20200717030422.679972-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_MODULES dependency by flagging out the dependent code. This
allows to use kprobes in a kernel without support for loadable modules,
which could be useful for a test kernel or perhaps an embedded kernel.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/Kconfig                |  2 +-
 include/linux/module.h      | 14 +++++------
 kernel/kprobes.c            | 48 +++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c | 16 +++++++++++--
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..e3d6b6868ccb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -61,7 +61,7 @@ config OPROFILE_NMI_TIMER
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
+	depends on MODULES || ARCH_HAS_TEXT_ALLOC
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	help
diff --git a/include/linux/module.h b/include/linux/module.h
index 8850b9692b8f..22c646cff6bd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -290,6 +290,13 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 
 struct notifier_block;
 
+enum module_state {
+	MODULE_STATE_LIVE,	/* Normal state. */
+	MODULE_STATE_COMING,	/* Full formed, running module_init. */
+	MODULE_STATE_GOING,	/* Going away. */
+	MODULE_STATE_UNFORMED,	/* Still setting it up. */
+};
+
 #ifdef CONFIG_MODULES
 
 extern int modules_disabled; /* for sysctl */
@@ -305,13 +312,6 @@ struct module_use {
 	struct module *source, *target;
 };
 
-enum module_state {
-	MODULE_STATE_LIVE,	/* Normal state. */
-	MODULE_STATE_COMING,	/* Full formed, running module_init. */
-	MODULE_STATE_GOING,	/* Going away. */
-	MODULE_STATE_UNFORMED,	/* Still setting it up. */
-};
-
 struct mod_tree_node {
 	struct module *mod;
 	struct latch_tree_node node;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f73cf71ef47d..6ee7286b1f7e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1609,6 +1609,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			goto out;
 		}
 
+#ifdef CONFIG_MODULES
 		/*
 		 * If the module freed .init.text, we couldn't insert
 		 * kprobes in there.
@@ -1619,6 +1620,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
+#endif
 	}
 out:
 	preempt_enable();
@@ -2215,24 +2217,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
-/* Remove all symbols in given area from kprobe blacklist */
-static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
-{
-	struct kprobe_blacklist_entry *ent, *n;
-
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
-		if (ent->start_addr < start || ent->start_addr >= end)
-			continue;
-		list_del(&ent->list);
-		kfree(ent);
-	}
-}
-
-static void kprobe_remove_ksym_blacklist(unsigned long entry)
-{
-	kprobe_remove_area_blacklist(entry, entry + 1);
-}
-
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2275,6 +2259,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
+/* Remove all symbols in given area from kprobe blacklist */
+static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
+{
+	struct kprobe_blacklist_entry *ent, *n;
+
+	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+		if (ent->start_addr < start || ent->start_addr >= end)
+			continue;
+		list_del(&ent->list);
+		kfree(ent);
+	}
+}
+
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2320,6 +2323,15 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 		kprobe_remove_area_blacklist(start, end);
 	}
 }
+#else
+static void add_module_kprobe_blacklist(struct module *mod)
+{
+}
+
+static void remove_module_kprobe_blacklist(struct module *mod)
+{
+}
+#endif /* CONFIG_MODULES */
 
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 710ec6a6aa8f..881c998d0162 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -103,8 +103,9 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 	return !!(kprobe_gone(&tk->rp.kp));
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
-						 struct module *mod)
+						       struct module *mod)
 {
 	int len = strlen(mod->name);
 	const char *name = trace_kprobe_symbol(tk);
@@ -129,6 +130,17 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
+						       struct module *mod)
+{
+	return false;
+}
+static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
+{
+	return false;
+}
+#endif
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -688,7 +700,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
-					mod->name, ret);
+					module_name(mod), ret);
 		}
 	}
 	mutex_unlock(&event_mutex);
-- 
2.25.1

