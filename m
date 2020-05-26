Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE621CF432
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgELMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 08:19:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgELMTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:32 -0400
IronPort-SDR: hrFFjpwu/1Soon8ZAhvQE/WgPfmpspeVLC/pH8LzAFkj4s0yPZSqGGppb29K2TSiN8yMF72O+I
 2/lGBgQwyTuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:32 -0700
IronPort-SDR: 9ihwqZeAiuy6Oal8JwOT7Td3Bh0oZG/rosTvy6rfec4Rw3nqUakBB2wyzHEEg2TSqao/0r/sEg
 zm5HjPf3HoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879274"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 06/15] ftrace: Add symbols for ftrace trampolines
Date:   Tue, 12 May 2020 15:19:13 +0300
Message-Id: <20200512121922.8997-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Example on x86 with CONFIG_DYNAMIC_FTRACE=y

	# echo function > /sys/kernel/debug/tracing/current_tracer
	# cat /proc/kallsyms | grep '\[__builtin__ftrace\]'
	ffffffffc0238000 t ftrace_trampoline    [__builtin__ftrace]

Note: This patch adds "__builtin__ftrace" as a module name in /proc/kallsyms for
symbols for pages allocated for ftrace's purposes, even though "__builtin__ftrace"
is not a module.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ftrace.h | 12 ++++---
 kernel/kallsyms.c      |  5 +++
 kernel/trace/ftrace.c  | 77 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index db95244a62d4..ea726ad1fa83 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -58,9 +58,6 @@ struct ftrace_direct_func;
 const char *
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym);
-int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
-			   char *type, char *name,
-			   char *module_name, int *exported);
 #else
 static inline const char *
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
@@ -68,6 +65,13 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 {
 	return NULL;
 }
+#endif
+
+#if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
+int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
+			   char *type, char *name,
+			   char *module_name, int *exported);
+#else
 static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 					 char *type, char *name,
 					 char *module_name, int *exported)
@@ -76,7 +80,6 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 }
 #endif
 
-
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
@@ -207,6 +210,7 @@ struct ftrace_ops {
 	struct ftrace_ops_hash		old_hash;
 	unsigned long			trampoline;
 	unsigned long			trampoline_size;
+	struct list_head		list;
 #endif
 };
 
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index c6cc293c0e67..834bfdc43235 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -482,6 +482,11 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	return 1;
 }
 
+/*
+ * ftrace_mod_get_kallsym() may also get symbols for pages allocated for ftrace
+ * purposes. In that case "__builtin__ftrace" is used as a module name, even
+ * though "__builtin__ftrace" is not a module.
+ */
 static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 {
 	int ret = ftrace_mod_get_kallsym(iter->pos - iter->pos_mod_end,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 041694a1eb74..9b0baeb4f0bb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2775,6 +2775,38 @@ void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 }
 
+/* List of trace_ops that have allocated trampolines */
+static LIST_HEAD(ftrace_ops_trampoline_list);
+
+static void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_add_rcu(&ops->list, &ftrace_ops_trampoline_list);
+}
+
+static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_del_rcu(&ops->list);
+}
+
+/*
+ * "__builtin__ftrace" is used as a module name in /proc/kallsyms for symbols
+ * for pages allocated for ftrace purposes, even though "__builtin__ftrace" is
+ * not a module.
+ */
+#define FTRACE_TRAMPOLINE_MOD "__builtin__ftrace"
+#define FTRACE_TRAMPOLINE_SYM "ftrace_trampoline"
+
+static void ftrace_trampoline_free(struct ftrace_ops *ops)
+{
+	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
+	    ops->trampoline)
+		ftrace_remove_trampoline_from_kallsyms(ops);
+
+	arch_ftrace_trampoline_free(ops);
+}
+
 static void ftrace_startup_enable(int command)
 {
 	if (saved_ftrace_func != ftrace_trace_function) {
@@ -2945,7 +2977,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 			synchronize_rcu_tasks();
 
  free_ops:
-		arch_ftrace_trampoline_free(ops);
+		ftrace_trampoline_free(ops);
 	}
 
 	return 0;
@@ -6188,6 +6220,27 @@ struct ftrace_mod_map {
 	unsigned int		num_funcs;
 };
 
+static int ftrace_get_trampoline_kallsym(unsigned int symnum,
+					 unsigned long *value, char *type,
+					 char *name, char *module_name,
+					 int *exported)
+{
+	struct ftrace_ops *op;
+
+	list_for_each_entry_rcu(op, &ftrace_ops_trampoline_list, list) {
+		if (!op->trampoline || symnum--)
+			continue;
+		*value = op->trampoline;
+		*type = 't';
+		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
+		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
+		*exported = 0;
+		return 0;
+	}
+
+	return -ERANGE;
+}
+
 #ifdef CONFIG_MODULES
 
 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
@@ -6524,6 +6577,7 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 {
 	struct ftrace_mod_map *mod_map;
 	struct ftrace_mod_func *mod_func;
+	int ret;
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
@@ -6550,8 +6604,10 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 		WARN_ON(1);
 		break;
 	}
+	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
+					    module_name, exported);
 	preempt_enable();
-	return -ERANGE;
+	return ret;
 }
 
 #else
@@ -6563,6 +6619,18 @@ allocate_ftrace_mod_map(struct module *mod,
 {
 	return NULL;
 }
+int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
+			   char *type, char *name, char *module_name,
+			   int *exported)
+{
+	int ret;
+
+	preempt_disable();
+	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
+					    module_name, exported);
+	preempt_enable();
+	return ret;
+}
 #endif /* CONFIG_MODULES */
 
 struct ftrace_init_func {
@@ -6743,7 +6811,12 @@ void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops)
 {
+	unsigned long trampoline = ops->trampoline;
+
 	arch_ftrace_update_trampoline(ops);
+	if (ops->trampoline && ops->trampoline != trampoline &&
+	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+		ftrace_add_trampoline_to_kallsyms(ops);
 }
 
 void ftrace_init_trace_array(struct trace_array *tr)
-- 
2.17.1

